Pt_Subs_input = 'D:\yunxia\ML\huigui 老公\data for calibration\input';%存放待处理数据的路径
Nm_Vd_input = [];%存放文件名的结构体
Fd_Subs_input = dir(Pt_Subs_input);%提取所有文件
fL = size(Fd_Subs_input,1);%统计文件个数
for i = 3:fL
    Nm_Vd_input{i-2,1} = Fd_Subs_input(i).name;%单独提取出文件名属性   
end

Pt_Subs_output = 'D:\yunxia\ML\huigui 老公\data for calibration\output';%存放待处理数据的路径
Nm_Vd_output = [];%存放文件名的结构体
Fd_Subs_output = dir(Pt_Subs_output);%提取所有文件
fL = size(Fd_Subs_output,1);%统计文件个数
for i = 3:fL
    Nm_Vd_output{i-2,1} = Fd_Subs_output(i).name;%单独提取出文件名属性   
end

for i=1:1:(fL-2)
    nm_vd_output = Nm_Vd_output{i,1};
    Local_output = strcat('D:\yunxia\ML\huigui 老公\data for calibration\output\',nm_vd_output);
    datas_out = xlsread(Local_output);
    Fit_out_vector = datas_out(2,:);
    Index_noNaN = find(~isnan(Fit_out_vector));%找到非缺失的列
    Fit_out_vector = Fit_out_vector(:,Index_noNaN);
    
    nm_vd_input = Nm_Vd_input{i,1};
    Local_input = strcat('D:\yunxia\ML\huigui 老公\data for calibration\input\',nm_vd_input);
    datas = xlsread(Local_input);
    datas = datas(:,2:end);
    datas = datas(:,Index_noNaN);
    %------------第二轮筛选，剔除datas中含NaN的列
    [Index_noNaN_row,Index_noNaN_column] = find(isnan(datas));
    datas(:,unique(Index_noNaN_column)) = [];
    Fit_out_vector(:,unique(Index_noNaN_column)) = [];

    Fit_out_vector = Fit_out_vector';
    
    %----------这里我先试一下波长从350---500的----------------
    datas = datas(51:651,:);%只算400-1000
    %-----------------------------------------------
    Fit_in_vector = zeros(size(datas,2),1);
    R_matrix = zeros(size(datas,1),size(datas,1));
    wave_selected = zeros(2,1);
    R_max = 0;%这里对相关性随便令个小的值
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
    %上面求出的是一个上三角矩阵，下面把它对称的部分补齐
    for i = 1:size(R_matrix,1)
        for j = 1:i
            R_matrix(i,j,:) = R_matrix(j,i,:);
        end
    end
    R_matrix = abs(R_matrix);
    wave_selected = wave_selected + 400;
    %--------------------------------------------------------------------
    savename = strcat('D:\yunxia\ML\huigui 老公\resultR1toR2\','R_matrix',nm_vd_output);
    savename = savename(1:end-5);
    save(savename,'R_matrix');
    savename = strcat('D:\yunxia\ML\huigui 老公\resultR1toR2\','R_max',nm_vd_output);
    savename = savename(1:end-5);
    save(savename,'R_max');
    savename = strcat('D:\yunxia\ML\huigui 老公\resultR1toR2\','wave_selected',nm_vd_output);
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

% Local_output = 'D:\yunxia\ML\回归 老公\回归 老公\data for calibration\baigurang fan\白骨壤chl.xlsx';
% datas_out = xlsread(Local_output);
% Fit_out_vector = datas_out(2,:);
% Index_noNaN = find(~isnan(Fit_out_vector));%找到非缺失的列
% Fit_out_vector = Fit_out_vector(:,Index_noNaN);
% 
% 
% Local_input = 'D:\yunxia\ML\回归 老公\回归 老公\data for calibration\baigurang fan\baigurang-fan.mn.xlsx';
% datas = xlsread(Local_input);
% datas = datas(:,2:end);
% datas = datas(:,Index_noNaN);
% %------------第二轮筛选，剔除datas中含NaN的列
% [Index_noNaN_row,Index_noNaN_column] = find(isnan(datas));
% datas(:,unique(Index_noNaN_column)) = [];
% Fit_out_vector(:,unique(Index_noNaN_column)) = [];
% 
% Fit_out_vector = Fit_out_vector';
% %----------这里我先试一下波长从350---500的----------------
% %datas = datas(1:150,:);
% %-----------------------------------------------
% Fit_in_vector = zeros(size(datas,2),1);
% R_matrix = zeros(size(datas,1),size(datas,1));
% wave_selected = zeros(2,1);
% R_max = 0;%这里对相关性随便令个小的值
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