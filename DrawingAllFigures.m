%���ļ��������ǻ����ļ����������ļ���ͼƬ
%Pt_Subs = 'D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2';%��Ŵ��������ݵ�·��
Pt_Subs = 'D:\yunxia\ML\huigui �Ϲ�\result_equ7';%��Ŵ��������ݵ�·��
Nm_Vd = [];%����ļ����Ľṹ��
Fd_Subs = dir(Pt_Subs);%��ȡ�����ļ�
fL = size(Fd_Subs,1);%ͳ���ļ�����
for i = 3:fL
    Nm_Vd{i-2,1} = Fd_Subs(i).name;%������ȡ���ļ�������   
end

for i=1:1:5
    nm_vd = Nm_Vd{i,1};
    %Local = strcat('D:\yunxia\ML\�ع� �Ϲ�\resultR1toR2\',nm_vd);
    Local = strcat('D:\yunxia\ML\huigui �Ϲ�\result_equ7\',nm_vd);
    load(Local);
    R_matrix;
    %����Ӧ�ö���������R_matrix��
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
    %savename = strcat('D:\yunxia\ML\�ع� �Ϲ�\figureR1toR2\',nm_vd,'.jpeg');
    savename = strcat('D:\yunxia\ML\huigui �Ϲ�\figure_equ7\',nm_vd,'.jpeg');
    print(1,'-djpeg',savename);
end