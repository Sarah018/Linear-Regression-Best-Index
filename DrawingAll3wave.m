%���ļ��������ǻ����ļ����������ļ���ͼƬ
%Pt_Subs = 'D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2';%��Ŵ��������ݵ�·��
Pt_Subs = 'D:\yunxia\ML\huigui �Ϲ�\resultR1proR2';%��Ŵ��������ݵ�·��
Nm_Vd = [];%����ļ����Ľṹ��
Fd_Subs = dir(Pt_Subs);%��ȡ�����ļ�
fL = size(Fd_Subs,1);%ͳ���ļ�����
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%������ȡ���ļ�������   
end

for i=1:1:5
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1proR2\',nm_vd);
    load(Local);
    R_matrix;
    R_matrix = abs(R_matrix);
    %����Ӧ�ö���������R_matrix��
    nm_vd_wave = Nm_Vd{i+10,1};
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1proR2\',nm_vd_wave);
    load(Local);
    wave_selected;

    i_max = wave_selected(1);
    j_max = wave_selected(2);
    k_max = wave_selected(3);
    wave_max = [i_max j_max k_max]-400;
    for j = 1:3
        R_matrix_figure = zeros(1000,1000);
        if j==1
            R_matrix_figure(400:1000,400:1000) = R_matrix(wave_max(j),:,:);
        elseif j==2
            R_matrix_figure(400:1000,400:1000) = R_matrix(:,wave_max(j),:);
        else
            R_matrix_figure(400:1000,400:1000) = R_matrix(:,:,wave_max(j));
        end
        % x = [1:size(datas,1)];
        % y = [1:size(datas,1)];
        x = [1:1000];
        y = [1:1000];
        rgb = pcolor(x,y,R_matrix_figure);
        colorbar
        set(rgb, 'LineStyle','none');
        axis([400 1000 400 1000]);
        nm_vd = nm_vd(1:end-4);
        %savename = strcat('D:\yunxia\ML\�ع� �Ϲ�\figureR1toR2\',nm_vd,'.jpeg');
        savename = strcat('D:\yunxia\ML\huigui �Ϲ�\figureR1proR2\',nm_vd,num2str(j),'.jpeg');
        print(1,'-djpeg',savename);
        %��ÿ���ļ���Ӧ���������ֵ������Ӧ�ľ����Ϊexcel
        R_matrix_excel = zeros(601,601);
        if j==1
            R_matrix_excel(:,:) = R_matrix(wave_max(j),:,:);
        elseif j==2
            R_matrix_excel(:,:) = R_matrix(:,wave_max(j),:);
        else
            R_matrix_excel(:,:) = R_matrix(:,:,wave_max(j));
        end
        
        
        savename2 = strcat('D:\yunxia\ML\huigui �Ϲ�\resultExcel_R1proR2\',nm_vd,num2str(j),'.xlsx');%��Ϊxls�ļ�
        %savename(end-3:end) = [];
        %save(savename,'datas');
        xlswrite(savename2,R_matrix_excel);
    end
end

for i=6:1:10
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1proR2\',nm_vd);
    datas = load(Local);
    datas = datas.R_max;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultExcel_R1proR2\',nm_vd,'.xlsx');%��Ϊxls�ļ�
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end

for i=11:1:15
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1proR2\',nm_vd);
    datas = load(Local);
    datas = datas.wave_selected;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultExcel_R1proR2\',nm_vd,'.xlsx');%��Ϊxls�ļ�
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end