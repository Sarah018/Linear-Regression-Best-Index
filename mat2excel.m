%Pt_Subs = 'D:\yunxia\ML\回归 老公\resultR1toR2';%存放待处理数据的路径
Pt_Subs = 'D:\yunxia\ML\huigui 老公\resultR1toR2';%存放待处理数据的路径
Nm_Vd = [];%存放文件名的结构体
Fd_Subs = dir(Pt_Subs);%提取所有文件
fL = size(Fd_Subs,1);%统计文件个数
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%单独提取出文件名属性   
end

for i=1:1:5
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1toR2\',nm_vd);
    datas = load(Local);
    datas = datas.R_matrix;
    datas(isnan(datas))=0;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui 老公\resultExcel_R1toR2\',nm_vd,'.xlsx');%存为xls文件
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end

for i=6:1:10
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1toR2\',nm_vd);
    datas = load(Local);
    datas = datas.R_max;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui 老公\resultExcel_R1toR2\',nm_vd,'.xlsx');%存为xls文件
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end

for i=11:1:15
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\回归 老公\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui 老公\resultR1toR2\',nm_vd);
    datas = load(Local);
    datas = datas.wave_selected;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui 老公\resultExcel_R1toR2\',nm_vd,'.xlsx');%存为xls文件
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end