%Pt_Subs = 'D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2';%��Ŵ��������ݵ�·��
Pt_Subs = 'D:\yunxia\ML\huigui �Ϲ�\resultR1toR2';%��Ŵ��������ݵ�·��
Nm_Vd = [];%����ļ����Ľṹ��
Fd_Subs = dir(Pt_Subs);%��ȡ�����ļ�
fL = size(Fd_Subs,1);%ͳ���ļ�����
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%������ȡ���ļ�������   
end

for i=1:1:5
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1toR2\',nm_vd);
    datas = load(Local);
    datas = datas.R_matrix;
    datas(isnan(datas))=0;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultExcel_R1toR2\',nm_vd,'.xlsx');%��Ϊxls�ļ�
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end

for i=6:1:10
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1toR2\',nm_vd);
    datas = load(Local);
    datas = datas.R_max;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultExcel_R1toR2\',nm_vd,'.xlsx');%��Ϊxls�ļ�
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end

for i=11:1:15
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\resultR1toR2\',nm_vd);
    datas = load(Local);
    datas = datas.wave_selected;
    nm_vd = nm_vd(1:end-4);
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\resultExcel_R1toR2\',nm_vd,'.xlsx');%��Ϊxls�ļ�
    %savename(end-3:end) = [];
    %save(savename,'datas');
    xlswrite(savename,datas);
end