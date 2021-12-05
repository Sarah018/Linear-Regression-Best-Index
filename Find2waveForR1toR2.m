Pt_Subs_input = 'D:\yunxia\ML\huigui �Ϲ�\data for calibration\input';%��Ŵ��������ݵ�·��
Nm_Vd_input = [];%����ļ����Ľṹ��
Fd_Subs_input = dir(Pt_Subs_input);%��ȡ�����ļ�
fL = size(Fd_Subs_input,1);%ͳ���ļ�����
for i = 3:fL
    Nm_Vd_input{i-2,1} = Fd_Subs_input(i).name;%������ȡ���ļ�������   
end

Pt_Subs_output = 'D:\yunxia\ML\huigui �Ϲ�\data for calibration\output';%��Ŵ��������ݵ�·��
Nm_Vd_output = [];%����ļ����Ľṹ��
Fd_Subs_output = dir(Pt_Subs_output);%��ȡ�����ļ�
fL = size(Fd_Subs_output,1);%ͳ���ļ�����
for i = 3:fL
    Nm_Vd_output{i-2,1} = Fd_Subs_output(i).name;%������ȡ���ļ�������   
end

for i=1:1:(fL-2)
    nm_vd_output = Nm_Vd_output{i,1};
    Local_output = strcat('D:\yunxia\ML\huigui �Ϲ�\data for calibration\output\',nm_vd_output);
    datas_out = xlsread(Local_output);
    Fit_out_vector = datas_out(2,:);
    Index_noNaN = find(~isnan(Fit_out_vector));%�ҵ���ȱʧ����
    Fit_out_vector = Fit_out_vector(:,Index_noNaN);
    
    nm_vd_input = Nm_Vd_input{i,1};
    Local_input = strcat('D:\yunxia\ML\huigui �Ϲ�\data for calibration\input\',nm_vd_input);
    datas = xlsread(Local_input);
    datas = datas(:,2:end);
    datas = datas(:,Index_noNaN);
    %------------�ڶ���ɸѡ���޳�datas�к�NaN����
    [Index_noNaN_row,Index_noNaN_column] = find(isnan(datas));
    datas(:,unique(Index_noNaN_column)) = [];
    Fit_out_vector(:,unique(Index_noNaN_column)) = [];

    Fit_out_vector = Fit_out_vector';
    
    %----------����������һ�²�����350---500��----------------
    datas = datas(51:651,:);%ֻ��400-1000
    %-----------------------------------------------
    Fit_in_vector = zeros(size(datas,2),1);
    R_matrix = zeros(size(datas,1),size(datas,1));
    wave_selected = zeros(2,1);
    R_max = 0;%����������������С��ֵ
    for i = 1:1:size(datas,1)
        i
        tic
        for j = i:1:size(datas,1)
                %Fit_in_vector = (datas(i,:) - datas(j,:))./(datas(i,:) - datas(k,:));%computing according ()
                Fit_in_vector = datas(i,:)./datas(j,:);
               % Fit_in_vector = (datas(i,:) - datas(j,:))./(datas(i,:) + datas(j,:));
                Fit_in_vector = Fit_in_vector';
                %[R,P] = corrcoef(Fit_in_vector,Fit_out_vector);
                [R,P] = corr(Fit_in_vector,Fit_out_vector, 'type' , 'Spearman');
                R_matrix(i,j) = R;
                if abs(R) > abs(R_max)
                    R_max  = R;
                    wave_selected = [i;j];
                end
        end
        toc
    end
    %�����������һ�������Ǿ�����������ԳƵĲ��ֲ���
    for i = 1:size(R_matrix,1)
        for j = 1:i
            R_matrix(i,j,:) = R_matrix(j,i,:);
        end
    end
    R_matrix = abs(R_matrix);
    wave_selected = wave_selected + 400;
    %--------------------------------------------------------------------
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1toR2\','R_matrix',nm_vd_output);
    savename = savename(1:end-5);
    save(savename,'R_matrix');
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1toR2\','R_max',nm_vd_output);
    savename = savename(1:end-5);
    save(savename,'R_max');
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1toR2\','wave_selected',nm_vd_output);
    savename = savename(1:end-5);
    save(savename,'wave_selected');
    %------------producing figure------------------
%     R_matrix_figure = zeros(2500,2500);
%     R_matrix_figure(350:2500,350:2500) = abs(R_matrix);
%     % x = [1:size(datas,1)];
%     % y = [1:size(datas,1)];
%     x = [1:2500];
%     y = [1:2500];
%     rgb = pcolor(x,y,R_matrix_figure);
%     colorbar
%     set(rgb, 'LineStyle','none');
%     axis([350 2500 350 2500]);
    
end

% Local_output = 'D:\yunxia\ML\�ع� �Ϲ�\�ع� �Ϲ�\data for calibration\baigurang fan\�׹���chl.xlsx';
% datas_out = xlsread(Local_output);
% Fit_out_vector = datas_out(2,:);
% Index_noNaN = find(~isnan(Fit_out_vector));%�ҵ���ȱʧ����
% Fit_out_vector = Fit_out_vector(:,Index_noNaN);
% 
% 
% Local_input = 'D:\yunxia\ML\�ع� �Ϲ�\�ع� �Ϲ�\data for calibration\baigurang fan\baigurang-fan.mn.xlsx';
% datas = xlsread(Local_input);
% datas = datas(:,2:end);
% datas = datas(:,Index_noNaN);
% %------------�ڶ���ɸѡ���޳�datas�к�NaN����
% [Index_noNaN_row,Index_noNaN_column] = find(isnan(datas));
% datas(:,unique(Index_noNaN_column)) = [];
% Fit_out_vector(:,unique(Index_noNaN_column)) = [];
% 
% Fit_out_vector = Fit_out_vector';
% %----------����������һ�²�����350---500��----------------
% %datas = datas(1:150,:);
% %-----------------------------------------------
% Fit_in_vector = zeros(size(datas,2),1);
% R_matrix = zeros(size(datas,1),size(datas,1));
% wave_selected = zeros(2,1);
% R_max = 0;%����������������С��ֵ
% for i = 1:1:size(datas,1)
%     i
%     tic
%     for j = 1:1:size(datas,1)
%             %Fit_in_vector = (datas(i,:) - datas(j,:))./(datas(i,:) - datas(k,:));%computing according ()
%             Fit_in_vector = datas(i,:)./datas(j,:);
%             Fit_in_vector = Fit_in_vector';
%             %[R,P] = corrcoef(Fit_in_vector,Fit_out_vector);
%             [R,P] = corr(Fit_in_vector,Fit_out_vector, 'type' , 'Spearman');
%             R_matrix(i,j) = R;
%             if abs(R) > abs(R_max)
%                 R_max  = R;
%                 wave_selected = [i;j];
%             end
%     end
%     toc
% end
% save('R_matrix_R1toR2','R_matrix');
% save('R_max_R1toR2','R_max');
% %------------producing figure------------------
% R_matrix_figure = zeros(2500,2500);
% R_matrix_figure(350:2500,350:2500) = abs(R_matrix);
% % x = [1:size(datas,1)];
% % y = [1:size(datas,1)];
% x = [1:2500];
% y = [1:2500];
% rgb = pcolor(x,y,R_matrix_figure);
% colorbar
% set(rgb, 'LineStyle','none');
% axis([350 2500 350 2500]);