%该文件的作用是画出文件夹下所有文件的图片
%Pt_Subs = 'D:\yunxia\ML\回归 老公\resultR1toR2';%存放待处理数据的路径
Pt_Subs = 'D:\yunxia\ML\huigui 老公\result_equ7';%存放待处理数据的路径
Nm_Vd = [];%存放文件名的结构体
Fd_Subs = dir(Pt_Subs);%提取所有文件
fL = size(Fd_Subs,1);%统计文件个数
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%单独提取出文件名属性   
end

for i=1:1:5
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\result_equ7\',nm_vd);
    load(Local);
    R_matrix;
    %这里应该读进来就是R_matrix了
    R_matrix_figure = zeros(1000,1000);
    R_matrix_figure(400:1000,400:1000) = abs(R_matrix);
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
    savename = strcat('D:\yunxia\ML\huigui 老公\figure_equ7\',nm_vd,'.jpeg');
    print(1,'-djpeg',savename);
end