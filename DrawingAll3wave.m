%该文件的作用是画出文件夹下所有文件的图片
%Pt_Subs = 'D:\yunxia\ML\回归 老公\resultR1toR2';%存放待处理数据的路径
Pt_Subs = 'D:\yunxia\ML\huigui 老公\resultR1proR2';%存放待处理数据的路径
Nm_Vd = [];%存放文件名的结构体
Fd_Subs = dir(Pt_Subs);%提取所有文件
fL = size(Fd_Subs,1);%统计文件个数
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%单独提取出文件名属性   
end

for i=1:1:5
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1proR2\',nm_vd);
    load(Local);
    R_matrix;
    R_matrix = abs(R_matrix);
    %这里应该读进来就是R_matrix了
    nm_vd_wave = Nm_Vd{i+10,1};
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1proR2\',nm_vd_wave);
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
        %savename = strcat('D:\yunxia\ML\回归 老公\figureR1toR2\',nm_vd,'.jpeg');
        savename = strcat('D:\yunxia\ML\huigui 老公\figureR1proR2\',nm_vd,num2str(j),'.jpeg');
        print(1,'-djpeg',savename);
        %将每个文件对应的三个最大值波长对应的矩阵存为excel
        R_matrix_excel = zeros(601,601);
        if j==1
            R_matrix_excel(:,:) = R_matrix(wave_max(j),:,:);
        elseif j==2
            R_matrix_excel(:,:) = R_matrix(:,wave_max(j),:);
        else
            R_matrix_excel(:,:) = R_matrix(:,:,wave_max(j));
        end
        
        
        savename2 = strcat('D:\yunxia\ML\huigui 老公\resultExcel_R1proR2\',nm_vd,num2str(j),'.xlsx');%存为xls文件
        %savename(end-3:end) = [];
        %save(savename,'datas');
        xlswrite(savename2,R_matrix_excel);
    end
end

for i=6:1:10
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1proR2\',nm_vd);
    datas = load(Local);
    datas = datas.R_max;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui 老公\resultExcel_R1proR2\',nm_vd,'.xlsx');%存为xls文件
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end

for i=11:1:15
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1proR2\',nm_vd);
    datas = load(Local);
    datas = datas.wave_selected;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui 老公\resultExcel_R1proR2\',nm_vd,'.xlsx');%存为xls文件
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end