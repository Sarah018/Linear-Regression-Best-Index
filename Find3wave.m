%���ļ���������ѡ��3�����Σ��ǵ�ʽ��   �������������
%���ļ�����������һ�׵���
% Pt_Subs = 'E:\yunxia\MLӦ��\�ް꺣ɣ�����ʾ�ֵ';%��Ŵ��������ݵ�·��
% Nm_Vd = [];%����ļ����Ľṹ��
% Fd_Subs = dir(Pt_Subs);%��ȡ�����ļ�
% fL = size(Fd_Subs,1);%ͳ���ļ�����
% for i = 3:fL
%     Nm_Vd{i-2,1} = Fd_Subs(i).name;%������ȡ���ļ�������   
% end
% %һ���ļ�һ���ļ��Ĵ���
% for i=1:1:(fL-2)
%     %�����ȶ�ȡtxt�ļ�������������datas������
%     nm_vd = Nm_Vd{i,1};
%     locs = strcat('E:\yunxia\MLӦ��\�ް꺣ɣ�����ʾ�ֵ\',nm_vd);
% %     ex=importdata(locs);
% %     datas=ex.data;
%     datas=importdata(locs);
%     data = datas.data;
%     diff = zeros(size(data,1),1);%���һ�׵��Ľ��
%     diff(2:end,1) = data(2:end,2)-data(1:(end-1),2);
%     data_result = [data,diff];
%     
%     savename = strcat('E:\yunxia\MLӦ��\result\�ް꺣ɣ�����ʾ�ֵ\',nm_vd,'.xls');%��Ϊxls�ļ�
%     %savename(end-3:end) = [];
%     %save(savename,'datas');
%     xlswrite(savename,data_result);
% end



Local_output = 'D:\yunxia\ML\�ع� �Ϲ�\�ع� �Ϲ�\data for calibration\baigurang fan\�׹���chl.xlsx';
datas_out = xlsread(Local_output);
Fit_out_vector = datas_out(2,:);
Index_noNaN = find(~isnan(Fit_out_vector));%�ҵ���ȱʧ����
Fit_out_vector = Fit_out_vector(:,Index_noNaN);
Fit_out_vector = Fit_out_vector';

Local_input = 'D:\yunxia\ML\�ع� �Ϲ�\�ع� �Ϲ�\data for calibration\baigurang fan\baigurang-fan.mn.xlsx';
datas = xlsread(Local_input);
datas = datas(:,2:end);
datas = datas(:,Index_noNaN);
%----------����������һ�²�����350---500��----------------
datas = datas(1:150,:);
%-----------------------------------------------
Fit_in_vector = zeros(size(datas,2),1);
R_matrix = zeros(size(datas,1),size(datas,1),size(datas,1));
wave_selected = zeros(3,1);
R_min = 1e4;%�������������������ֵ
for i = 1:1:size(datas,1)
    i
    tic
    for j = i+1:1:size(datas,1)
        for k = j+1:1:size(datas,1)
            Fit_in_vector = (datas(i,:) - datas(j,:))./(datas(i,:) - datas(k,:));%computing according ()
            Fit_in_vector = Fit_in_vector';
            %[R,P] = corrcoef(Fit_in_vector,Fit_out_vector);
            [R,P] = corr(Fit_in_vector,Fit_out_vector, 'type' , 'Spearman');
            R_matrix(i,j,k) = R;
            if abs(R) < abs(R_min)
                R_min  = R;
                wave_selected = [i;j;k];
            end
        end
    end
    toc
end
save('R_matrix','R_matrix');
save('R_min','R_min');
x = [1:150];
y = [1:150];
rgb = pcolor(x,y,R_matrix(:,:,142));
colorbar
set(rgb, 'LineStyle','none');