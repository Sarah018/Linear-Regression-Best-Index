%���ļ�����������һ�׵���
Pt_Subs = 'E:\yunxia\MLӦ��\�ް꺣ɣ�����ʾ�ֵ';%��Ŵ��������ݵ�·��
Nm_Vd = [];%����ļ����Ľṹ��
Fd_Subs = dir(Pt_Subs);%��ȡ�����ļ�
fL = size(Fd_Subs,1);%ͳ���ļ�����
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%������ȡ���ļ�������   
end
%һ���ļ�һ���ļ��Ĵ���
for i=1:1:(fL-2)
    %�����ȶ�ȡtxt�ļ�������������datas������
    nm_vd = Nm_Vd{i,1};
    locs = strcat('E:\yunxia\MLӦ��\�ް꺣ɣ�����ʾ�ֵ\',nm_vd);
%     ex=importdata(locs);
%     datas=ex.data;
    datas=importdata(locs);
    data = datas.data;
    diff = zeros(size(data,1),1);%���һ�׵��Ľ��
    diff(2:end,1) = data(2:end,2)-data(1:(end-1),2);
    data_result = [data,diff];
    
    savename = strcat('E:\yunxia\MLӦ��\result\�ް꺣ɣ�����ʾ�ֵ\',nm_vd,'.xls');%��Ϊxls�ļ�
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,data_result);
end
