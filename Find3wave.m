%该文件的作用是选出3个波段，是的式子   与输出相关性最高
%该文件的作用是求一阶导数
% Pt_Subs = 'E:\yunxia\ML应用\无瓣海桑反射率均值';%存放待处理数据的路径
% Nm_Vd = [];%存放文件名的结构体
% Fd_Subs = dir(Pt_Subs);%提取所有文件
% fL = size(Fd_Subs,1);%统计文件个数
% for i = 3:fL
%     Nm_Vd{i-2,1} = Fd_Subs(i).name;%单独提取出文件名属性   
% end
% %一个文件一个文件的处理
% for i=1:1:(fL-2)
%     %下面先读取txt文件，将结果存放在datas矩阵里
%     nm_vd = Nm_Vd{i,1};
%     locs = strcat('E:\yunxia\ML应用\无瓣海桑反射率均值\',nm_vd);
% %     ex=importdata(locs);
% %     datas=ex.data;
%     datas=importdata(locs);
%     data = datas.data;
%     diff = zeros(size(data,1),1);%存放一阶导的结果
%     diff(2:end,1) = data(2:end,2)-data(1:(end-1),2);
%     data_result = [data,diff];
%     
%     savename = strcat('E:\yunxia\ML应用\result\无瓣海桑反射率均值\',nm_vd,'.xls');%存为xls文件
%     %savename(end-3:end) = [];
%     %save(savename,'datas');
%     xlswrite(savename,data_result);
% end



Local_output = 'D:\yunxia\ML\回归 老公\回归 老公\data for calibration\baigurang fan\白骨壤chl.xlsx';
datas_out = xlsread(Local_output);
Fit_out_vector = datas_out(2,:);
Index_noNaN = find(~isnan(Fit_out_vector));%找到非缺失的列
Fit_out_vector = Fit_out_vector(:,Index_noNaN);
Fit_out_vector = Fit_out_vector';

Local_input = 'D:\yunxia\ML\回归 老公\回归 老公\data for calibration\baigurang fan\baigurang-fan.mn.xlsx';
datas = xlsread(Local_input);
datas = datas(:,2:end);
datas = datas(:,Index_noNaN);
%----------这里我先试一下波长从350---500的----------------
datas = datas(1:150,:);
%-----------------------------------------------
Fit_in_vector = zeros(size(datas,2),1);
R_matrix = zeros(size(datas,1),size(datas,1),size(datas,1));
wave_selected = zeros(3,1);
R_min = 1e4;%这里对相关性随便令个大的值
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