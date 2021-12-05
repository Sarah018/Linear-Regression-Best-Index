%该文件的作用是求一阶导数
Pt_Subs = 'E:\yunxia\ML应用\无瓣海桑反射率均值';%存放待处理数据的路径
Nm_Vd = [];%存放文件名的结构体
Fd_Subs = dir(Pt_Subs);%提取所有文件
fL = size(Fd_Subs,1);%统计文件个数
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%单独提取出文件名属性   
end
%一个文件一个文件的处理
for i=1:1:(fL-2)
    %下面先读取txt文件，将结果存放在datas矩阵里
    nm_vd = Nm_Vd{i,1};
    locs = strcat('E:\yunxia\ML应用\无瓣海桑反射率均值\',nm_vd);
%     ex=importdata(locs);
%     datas=ex.data;
    datas=importdata(locs);
    data = datas.data;
    diff = zeros(size(data,1),1);%存放一阶导的结果
    diff(2:end,1) = data(2:end,2)-data(1:(end-1),2);
    data_result = [data,diff];
    
    savename = strcat('E:\yunxia\ML应用\result\无瓣海桑反射率均值\',nm_vd,'.xls');%存为xls文件
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,data_result);
end
