clear all;
close all;
filename='SMPS_data_20241120';
SMPS_data = xlsread(filename);
%data = readmatrix(SMPS_data,dNperlogdp);
% Define start and end times
start_time = datetime(2024, 9, 6, 06, 05, 0); % 20240906 06:05
end_time = datetime(2024, 11, 20, 11, 40, 0);    % 220241020 

% Create the vector with a 5-minute step
x = start_time:minutes(5):end_time;

% Display the result
%disp(x);
x_diam=SMPS_data(2,1:40);
y = SMPS_data(2:58, 1:40);
% Extract the data from the first 58 rows and 40 columns


% Sum the rows for each column
y_sum = mean(y, 1);  % Summing along the first dimension (rows)

% Plot the summed data
% figure(1)
% plot(1:40, y_sum);  % x-axis represents the column indices
% xlabel('Column Index');
% ylabel('Summed Values');
% title('Summed Values for Each Column');
% grid on;

figure(1)

semilogx(x_diam, y_sum);  % Correct spelling
xlabel('Diameter (nm)');
ylabel('dN/dLogdp');
title("SMPS Size Distribution 20240905 day");
grid on;

 y = SMPS_data(59:202,1:40);
 y_sum = mean(y,1);
 figure(2)
 semilogx(x_diam, y_sum);
 xlabel('Diameter (nm)');
 ylabel('dN/dlogdp')
 title('Size DIstribution 20240905 night');
 grid on;
 
 y_next = SMPS_data(59:end, 1:40);  

% date_time_day = [];
% date_time_night = [];
% 
% for i = 1:290:length(y_next)  % Increment i by 290 in each iteration
%     % Safely access x(i) and x(i+145) without going out of bounds
%     
%         date_time_day = [date_time_day; x(1,i)];  % Append the current time
%         date_time_night = [date_time_night; x(1,i+145)];  % Append the time after 145 steps
%     
% 
% end
% 
% 
% date_time_day = [];
% date_time_night = [];
% 
% for i = 1:290:length(y_next)  % Increment i by 290 in each iteration
%     % Safely access x(i) and x(i+145) without going out of bounds
%         day=x(1,i);
%         night=x(1,i+145);
%         date_time_day = [date_time_day; day];  % Append the current time
%         date_time_night = [date_time_night; night];  % Append the time after 145 steps
%     
% end


%  for i=1:144:length(y_next)
%      y_i=y_next(i:i+144,1:40);
%      yi_mean = mean(y_i,1);
%      figure()
%      semilogx(x_diam, yi_mean);
%      xlabel('Diameter (nm)');
%      ylabel('dN/dlogdp');
%      title(['Data at night time: ', datestr(x(1,i))]);  % For datetime, use datestr
% 
%      
%      figure()
%      y_j=y_next(i+144:i+289,1:40);
%      yj_mean = mean(y_j,1);
%      semilogx(x_diam, yj_mean);
%      xlabel('Diameter (nm)');
%      ylabel('dN/dlogdp');
%      title(['Data at  day time: ', datestr(x(1,i+145))]);  % For datetime, use datestr
% 
%      
%      
%      %i=i+290;
%  end
 
 percentage = zeros(2, 40);
 percentage(1,1:40)=SMPS_data(2,1:40);
 sum_tot=sum(SMPS_data(2:end,1:40),'all','omitnan');
 
 for j=1:1:40
     diam_sum=sum(SMPS_data(3:end,j),'all','omitnan');
     percentage(2,j)=diam_sum/sum_tot;
 end
 
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage(2, 1:11))]);
 disp(["Total Percentage of aerosol in 30-80nm is", sum(percentage(2, 12:19))]);
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage(2, 19:40))]);


 
 SMPS_data_incloud=xlsread(filename, 3);
% [~, a, ~] = xlsread(filename);  % a contains text data (including dates)
% a = a(2:end, 1);  % Extract first column (skip header if present)
[~, textData, ~] = xlsread(filename, 3);  % Get text data separately
a = textData(2:end, 1);  % Extract the first column, skipping header if present


figure()
h1=semilogx(x_diam,mean(SMPS_data_incloud(1:20,1:40)));
hold on;
h2=semilogx(x_diam,mean(SMPS_data(8626:8628,1:40)));
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
set(gca, 'XScale', 'log');
grid on;
title('Size Distribution 2024-10-05,2h cloud LWC 0.17-0.43,10 m aft.cloud ');
legend([h1, h2], {'In cloud', 'Before Cloud'});
hold off;
%geom_m1=geomean(SMPS_data(8626:8628,1:40),'all','omnitnan');
mean_1a=mean(SMPS_data(8626:8628,1:40));
mean1_b=mean(SMPS_data_incloud(1:20,1:40));


figure ()
h3=semilogx(x_diam,mean(SMPS_data_incloud(21:24,1:40)));
hold on ;
h4=semilogx(x_diam,mean(SMPS_data(9762:9763,1:40)));
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
set(gca, 'XScale', 'log');
grid on;
title('Size Distribution 2024-10-10,15m cloud 5m aft.cloud LWC 0.13-0.20');
legend([h3, h4], {'In cloud', 'Before Cloud'});
hold off;
geom_m2a=geomean(SMPS_data(9762:9763,1:40),'all');
geom_m2b=geomean(SMPS_data_incloud(21:24,1:40),'all');
mean_2a=mean(SMPS_data(9762:9763,1:40));
mean_2b=mean(SMPS_data_incloud(21:24,1:40));


figure()
h5=semilogx(x_diam, mean(SMPS_data_incloud(26:1345,1:40)));
hold on;
h6=semilogx(x_diam, mean(SMPS_data(19000:19193,1:40), 'omitnan'));
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
set(gca, 'XScale', 'log');
grid on;
title('Size Distribution 2024-11-11, 4d cloud LWC 0.11-0.81 11h aft cloud');
legend([h5, h6], {'In cloud', 'Before Cloud'});
hold off;

geom_m3b=geomean(mean(SMPS_data_incloud(26:1345,1:40),'all'));
geom_3a=geomean(mean(SMPS_data(19000:19193,1:40), 'all'));
mean_3b=mean(SMPS_data_incloud(26:1345,1:40),'omitnan');
mean_3a=mean(SMPS_data(19000:19193,1:40), 'omitnan');

figure()
h7=semilogx(x_diam, mean(SMPS_data_incloud(1345:1718,1:40)));
hold on;
h8=semilogx(x_diam, mean(SMPS_data(20968:21000,1:40), 'omitnan'));
hold on;
h9=semilogx(x_diam, mean(SMPS_data(21374:21406,1:40)));
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
set(gca, 'XScale', 'log');
grid on;
title('Size Distribution 2024-11-17,2 d cloud with LWC 0.10-0.68 3.2h aft.cloud/aft.cloud');
legend([h7, h8, h9], {'In cloud', 'Before Cloud','After Cloud'});
hold off;
geom_4a=geomean(mean(SMPS_data(20968:21000,1:39),'omitnan'));
mean_4a=mean(SMPS_data(20968:21000,1:40),'omitnan');
geom_4b=geomean(mean(SMPS_data_incloud(1345:1718,1:40)));
mean_4b=mean(SMPS_data_incloud(1345:1718,1:40));
geom_4c=geomean(mean(SMPS_data(21374:21406,1:40)));
mean_4c=mean(SMPS_data(21374:21406,1:40));
figure()
h10=semilogx(x_diam, mean(SMPS_data_incloud(1718:2004,1:40)));

hold on;
h11=semilogx(x_diam, mean(SMPS_data(21442:21582,1:40)));

xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
set(gca, 'XScale', 'log');
grid on;
title('Size Distribution 2024-11-19,1d cloud with LWC 0.10-0.57 2h aft.cloud/aft.cloud');
legend([h10, h11], {'In cloud', 'Before Cloud'});
hold off;
mean_5a=mean(SMPS_data(21442:21582,1:40));
mean_5b=mean(SMPS_data_incloud(1345:1718,1:40));



 percentage_cloud = zeros(2, 40);
 percentage(1,1:40)=SMPS_data(2,1:40);
 sum_tot_cloud=sum(SMPS_data_incloud(2:end,1:40),'all','omitnan');
 
 for j=1:1:40
     diam_sum_cloud=sum(SMPS_data_incloud(3:end,j),'all','omitnan');
     percentage_cloud(2,j)=diam_sum_cloud/sum_tot_cloud;
 end
 
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage_cloud(2, 1:11))]);
 disp(["Total Percentage of aerosol in 30-80nm is", sum(percentage_cloud(2, 12:19))]);
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage_cloud(2, 19:40))]);
 
 
SMPS_data_con= 0.04879.*SMPS_data(3:end,1:40);
 percentage_con = zeros(2, 40);
 percentage_con(1,1:40)=SMPS_data(2,1:40);
 sum_tot_con=sum(SMPS_data_con(2:end,1:40),'all','omitnan');
 
 for j=1:1:40
     diam_sum_con=sum(SMPS_data_con(3:end,j),'all','omitnan');
     percentage_con(2,j)=diam_sum_con/sum_tot_con;
 end
 
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage_con(2, 1:11))]);
 disp(["Total Percentage of aerosol in 30-80nm is", sum(percentage_con(2, 12:19))]);
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage_con(2, 19:40))]);
 
 SMPS_data_incloud_con=0.04879.*SMPS_data_incloud;
 percentage_cloud_con = zeros(2,40);
 percentage_cloud_con(1,1:40)=SMPS_data(2,1:40);
 sum_tot_cloud_con=sum(SMPS_data_incloud_con,'all','omitnan');
 
 for j=1:1:40
     diam_sum_cloud_con=sum(SMPS_data_incloud_con(3:end,j),'all','omitnan');
     percentage_cloud_con(2,j)=diam_sum_cloud_con/sum_tot_cloud_con;
 end
 disp(["Cloud Percentage of aerosol Concentration in 10-30nm is", sum(percentage_cloud_con(2, 1:11))]);
 disp(["Cloud Percentage of aerosol Concentration in 30-80nm is", sum(percentage_cloud_con(2, 12:19))]);
 disp(["Cloud Percentage of aerosol COncentration in 10-30nm is", sum(percentage_cloud_con(2, 19:40))]);
 

 
 
figure()
scatter(x_diam,percentage_cloud_con(2,1:end));
 % Fit a cubic spline to the data
pp = spline(x_diam, percentage_cloud_con(2, 1:end));

% Generate fitted values over the x_diam range for smooth plotting
x_fit = linspace(min(x_diam), max(x_diam), 100);  % More points for a smooth curve
y_fit = ppval(pp, x_fit);  % Evaluate the spline at the fitted x-values

figure()
% Plot the spline fit
plot(x_fit, y_fit, 'r-', 'LineWidth', 2);  % Plot the spline as a red line

% Labeling the axes
xlabel('Diameter (nm)');
ylabel('Percentage');
title('Spline fit of the percentage of Cloud concentation');
% Optional: Add a legend
legend('Scatter Data', 'Spline Fit');

hold off; 


% Fit the spline to your data
pp = spline(x_diam, percentage_cloud_con(2, 1:end));

% Display the piecewise polynomial structure
disp(pp);
3;



x = percentage_cloud_con(1,1:40);
y=percentage_cloud_con(2,1:40);
f = fit(x.',y.','gauss3');
figure()
plot(f,x,y)
xlabel('Diameter (nm)');
ylabel('Percentage of Cloud Concentration');
title('In Cloud 3 modal Gaussian fit for Cloud Concentration');

y_1= percentage_con(2,1:40);
f_1 = fit(x.',y_1.','gauss3');
figure()
plot(f_1,x,y_1)
xlabel('Diameter (nm)');
ylabel('Percentage of Total Concentration');
title('Total 3 modal gaussian fit for Total Concentration');

mean_tot=mean(SMPS_data(1:end,1:40),'omitnan');
%GeoMean_tot1=geomean(SMPS_data,'all','omitnan');
mean_cloud=mean(SMPS_data_incloud(1:end,1:40));
GeoMean_cloud=geomean(mean_cloud);
Geo_Mean_tot=geomean(mean_tot);
figure()
plot(x_diam,mean_tot);
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
title('SMPS Total Mean Size Distribution Cartesian scale');
figure()
semilogx(x_diam,mean_tot);
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
title('SMPS Total Mean Size Distribution Semi-logx scale');


figure()
plot(x_diam,mean_cloud);
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
title('SMPS In Cloud Mean Size Distribution Cartesian scale');
figure()
semilogx(x_diam,mean_cloud);
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
title('SMPS In Cloud Mean Size Distribution Semi-logx scale');


%%%MPSS data
filename2='TROPOS_Airmodus_renwed29Okt_14Nov.xlsx';
MPSS_data=xlsread(filename2);

x_diam=SMPS_data(2,1:40);
%y = M_data(2:58, 1:40);
% Extract the data from the first 58 rows and 40 columns


% Sum the rows for each column
%y_sum = mean(y, 1);  % Summing along the first dimension (rows)

% Plot the summed data
% figure(1)
% plot(1:40, y_sum);  % x-axis represents the column indices
% xlabel('Column Index');
% ylabel('Summed Values');
% title('Summed Values for Each Column');
% grid on;

figure(1)

semilogx(x_diam, mean(MPSS_data(2:58,1:40), 'omitnan'));  % Correct spelling
xlabel('Diameter (nm)');
ylabel('dN/dLogdp');
title("MPSS Size Distribution 20240905 day");
grid on;

 %y = SMPS_data(59:202,1:40);
 %y_sum = mean(y,1);
figure(2)
semilogx(x_diam, mean(MPSS_data(59:202,1:40), 'omitnan'))
xlabel('Diameter (nm)');
ylabel('dN/dlogdp')
title('MPSS Size DIstribution 20240905 night');
grid on;

Len_mpss=length(MPSS_data(203:end,1:40));
% date_time_day_mpss = [];
% date_time_night_mpss = [];
% 
% for i = 1:290:length(Len_mpss)  % Increment i by 290 in each iteration
%     % Safely access x(i) and x(i+145) without going out of bounds
%     
%         date_time_day_mpss = [date_time_day_mpss; x(1,i)];  % Append the current time
%         date_time_night_mpss = [date_time_night_mpss; x(1,i+145)];  % Append the time after 145 steps
%     
% 
% end
% 
% 
% date_time_day = [];
% date_time_night = [];
% 
% for i = 1:290:length(y_next)  % Increment i by 290 in each iteration
%     % Safely access x(i) and x(i+145) without going out of bounds
%         day=x(1,i);
%         night=x(1,i+145);
%         date_time_day = [date_time_day; day];  % Append the current time
%         date_time_night = [date_time_night; night];  % Append the time after 145 steps
%     
% end
y_next_mpss=MPSS_data(203:end,1:40);

 for i=1:144:Len_mpss
     y_i=y_next_mpss(i:i+144,1:40);
     yi_mean = mean(y_i,1);
     figure()
     semilogx(x_diam, yi_mean);
     xlabel('Diameter (nm)');
     ylabel('dN/dlogdp');
     title(['Data at night time: ', datestr(x(1,i))]);  % For datetime, use datestr

     
     figure()
     y_i=y_next_mpss(i+144:i+289,1:40);
     yj_mean = mean(y_i,1);
     semilogx(x_diam, yj_mean);
     xlabel('Diameter (nm)');
     ylabel('dN/dlogdp');
     title(['Data at  day time: ', datestr(x(1,i+145))]);  % For datetime, use datestr

     
     
     %i=i+290;
 end
 
mean_tot_mpss=mean(SMPS_data(1:end,1:40),'omitnan');
GeoMean_tot_mpss=geomean(mean_tot_mpss);

figure()
plot(x_diam,mean_tot_mpss);
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
title('MPSS Total Mean Size Distribution Cartesian scale');
figure()
semilogx(x_diam,mean_tot_mpss);
xlabel('Diameter (nm)');
ylabel('dN/dlogdp');
title('MPSS Total Mean Size Distribution Semi-logx scale');



 percentage_tot_mpss = zeros(2, 40);
 percentage_mpss(1,1:40)=MPSS_data(2,1:40);
 sum_tot_mpss=sum(MPSS_data(2:end,1:40),'all','omitnan');
 
 for j=1:1:40
     diam_sum_mpss=sum(MPSS_data(3:end,j),'all','omitnan');
     percentage_tot_mpss(2,j)=diam_sum_mpss/sum_tot_mpss;
 end
 
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage_tot_mpss(2, 1:11))]);
 disp(["Total Percentage of aerosol in 30-80nm is", sum(percentage_tot_mpss(2, 12:19))]);
 disp(["Total Percentage of aerosol in 10-30nm is", sum(percentage_tot_mpss(2, 19:40))]);
 
 %%%GEOMETRIC DEVIATION PART
 
 Stand_Dev_SMPS_tot=std(mean_tot);
 Geo_Dev_tot=zeros(1,40);
 for i=1:1:40
     Geo_Dev_tot(1,i)=(log(mean_tot(1,i))-log(Geo_Mean_tot)).^2;
 end
 
 Geom_Dev_tot=sqrt((1/40)*sum(Geo_Dev_tot,'all'));
 
 
 Stand_Dev_SMPS_cloud=std(mean_cloud);
 Geo_Dev_cloud=zeros(1,40);
 for i=1:1:40
     Geo_Dev_cloud=(log(mean_tot(1,i))-log(GeoMean_cloud)).^2;
 end
 Geom_Dev_cloud=sqrt((1/40)*sum(Geo_Dev_cloud));
 
 
 Stand_Dev_MPSS=std(mean_tot_mpss);
 Geo_Dev_MPSS=zeros(1,40);
 for i=1:1:40
     Geo_Dev_MPSS=(log(mean_tot_mpss(1,i))-log(GeoMean_tot_mpss)).^2;
 end
 Geom_Dev_MPSS=sqrt((1/40)*sum(Geo_Dev_MPSS));
 
 
 
 %%%TOTAL CONCENTRATION PART
 SMPS_Mean_Total_Concentration=sum(mean_tot);
 SMPS_Mean_Cloud_Concentration=sum(mean_cloud);
 MPSS_Mean_Total_Concentration=sum(mean_tot_mpss);
 
 
 %%%WEIGHTEN MEAN
 SMPS_weigth_tot_mean=(mean_tot*x_diam')/sum(x_diam,'all');
 SMPS_weigth_cloud_mean=(mean_cloud*x_diam')/sum(x_diam,'all');
 MPSS_weight_mean_tot=(mean_tot_mpss*x_diam')/sum(x_diam,'all');
 
 
 w1a=weightedmean(mean_1a,x_diam);
 w1b=weightedmean(mean1_b,x_diam);
 w2a=weightedmean(mean_2a,x_diam);
 w2b=weightedmean(mean_2b,x_diam);
 w3a=weightedmean(mean_3a,x_diam);
 w3b=weightedmean(mean_3b,x_diam);
 w4a=weightedmean(mean_4a,x_diam);
 w4b=weightedmean(mean_4b,x_diam);
 w4c=weightedmean(mean_4c,x_diam);
 w5a=weightedmean(mean_5a,x_diam);
 w5b=weightedmean(mean_5b,x_diam);
 
 
 %%%HARMONIC MEAN
 SMPS_harmonic_mean=harmmean(mean_tot);
 MPSS_harmonic_mean=harmmean(mean_tot_mpss);
 
 
 %%%HOURLY AVERAGED CLOUD ANALYSIS
 
%m1=12.*mean(SMPS_data_incloud(1:20,1:40),'all');
aD1b=SMPS_data_incloud(1:20,1:40);
m1b=mean(SMPS_data_incloud(1:20,1:40),'all');
std1b=standardeviation(mean1_b,m1);%%bigger than the mean not suitable
gm1=geomean(D1b(D1b>0));
ggm1b=groupedgeometricmean(D1b,x_diam);
stdg1b=standardeviationgroupedmean(mean1_b,x_diam,ggm1b);
%ggm1b_conf=
D1a=SMPS_data(8626:8628,1:40);
m1a=mean(D1a,'all');
std1a=standardeviation(mean_1a,m1a);
gm1a=geomean(D1a(D1a>0));
ggm1a=groupedgeometricmean(D1a,x_diam);
stdg1a=standardeviationgroupedmean(mean_1a,x_diam,ggm1a);


%%3th BEFORE CLOUD EVENT
D3a=SMPS_data(19000:19193,1:40);
D3b=SMPS_data_incloud(26:1345,1:40);
ggm3a=groupedgeometricmean(mean_3a,x_diam);
stdg3a=standardeviationgroupedmean(mean_3a,x_diam,ggm3a);
S3a=size(D3a);
rws=S3a(1,1);

mm3a=[];
for i=1:12:rws
    mm3a=[mm3a;mean(D3a(i:i+11,1:end))]
    
end

ggm3a_m=[];

for i=1:1:16    
   ggm3a_m=[ggm3a_m;groupedgeometricmean((mm3a(i,1:end)),x_diam)];
   
end
       stdg3a_m=[];
for i=1:1:length(ggm3a_m)
    stdg3a_m=[stdg3a_m;standardeviationgroupedmean(mm3a(i,1:end),x_diam,ggm3a_m(i,1:end))]
        end 


       
    


%%%3d IN CLOUD EVENT
S3b=size(D3b);
rws3b=S3b(1,1);

mm3b_m=[];
for i=1:12:rws3b
mm3b_m=[mm3b_m;mean(D3b(i:i+11,1:end))]
end

ggm3b_m=[];
for i=1:1:length(mm3b_m)
    ggm3b_m=[ggm3b_m;groupedgeometricmean((mm3b_m(i,1:end)),x_diam)]
end

stdg3b_m=[];
for i=1:1:length(ggm3b_m)
    stdg3b_m=[stdg3b_m;standardeviationgroupedmean(mm3b_m(i,1:end),x_diam,ggm3b_m(i,1:end))]
end


%%%4th BEFORE CLOUD EVENT
D4b=SMPS_data_incloud(1345:1718,1:40);
D4a=SMPS_data(20968:21000,1:40);
D4c=SMPS_data(21374:21406,1:40);

%%%BEFORE CLOUD

S4a=size(D4a);
rws4a=S4a(1,1);
mm4a_m=[];
for i=1:12:rws4a
    mm4a_m=[mm4a_m;mean(D4a(i,1:end))]
end

ggm4a_m=[];
for i=1:1:length(mm4a_m)
    ggm4a_m=[ggm4a_m;groupedgeometricmean(mm4a_m(i,1:end),x_diam)]
end
stdg4a=[];
for i=1:1:length(mm4a_m)
    stdg4a_m=[stdg4a;standardeviationgroupedmean(mm4a_m(i,1:end),x_diam,ggm4a_m(i,1:end))]
end
%%%DEN YPARXEI AKRETO PLITHOS TIMON PRIN TO SYNEFO

%%%5th IN CLOUD EVENT
S4b=size(D4b);
rws4b=S4b(1,1);
mm4b_m=[];
for i=1:12:rws4b
    mm4b_m=[mm4b_m;mean(D4b(i:i+11,1:end))]
end

ggm4b_m=[];
for i=1:1:length(mm4b_m)
    ggm4b_m=[ggm4b_m;groupedgeometricmean(mm4b_m(i,1:end),x_diam)]
end
stdg4b_m=[];
for i=1:1:length(mm4b_m)
    stdg4b_m=[stdg4b_m;standardeviationgroupedmean(mm4b_m(i,1:end),x_diam,ggm4b_m(i,1:end))]
end

%%%5th AFTERCLOUD

S4c=size(D4c);
rws4c=S4c(1,1);
mm4c_m=[];
for i=1:12:rws4c
    mm4c_m=[mm4c_m;mean(D4c(i:i+11,1:end))]
end
ggm4c_m=[];
for i=1:1:length(mm4c_m)
    ggm4c_m=[ggm4c_m;groupedgeometricmean(mm4c_m(i,1:end),x_diam)]
end
stdg4c=[];
for i=1:1:length(mm4c_m)
    stdg4c=[stdg4c;standardeviationgroupedmean(mm4c_m(i,1:end),x_diam,ggm4c_m(i,1:end))]
end

%%%5th BEFORE CLOUD EVENT
D5a=SMPS_data(21442:21582,1:40);
D5b=SMPS_data_incloud(1718:2004,1:40);
S5a=size(D5a);
rws5a=S5a(1,1);
mm5a_m=[];
for i=1:12:rws5a
    mm5a_m=[mm5a_m;mean(D5a(i:i+11,1:end))]
end
ggm5a_m=[];
for i=1:1:length(mm5a_m)
    ggm5a_m=[ggm5a_m;groupedgeometricmean(mm5a_m(i,1:end),x_diam)]
end
stdg5a_m=[];
for i=1:1:length(mm5a_m)
    stdg5a_m=[stdg5a_m;standardeviationgroupedmean(mm5a_m(i,1:end),x_diam,ggm5a_m(i,1:end))]
end

S5a=size(D5a);
rws5b=S5a(1,1);
mm5b_m=[];
for i=1:12:rws5b
    mm5b_m=[mm5b_m;mean(D5b(i:i+11,1:end))]
end
ggm5b_m=[];
for i=1:1:length(mm5b_m)
    ggm5b_m=[ggm5b_m;groupedgeometricmean(mm5b_m(i,1:end),x_diam)]
end
stdg5b_m=[];
for i=1:1:length(mm5b_m)
    stdg5b_m=[stdg5b_m;standardeviationgroupedmean(mm5b_m(i,1:end),x_diam,ggm5b_m(i,1:end))]
end
 %%%LOGARITHMIC MEAN
 %L=logmean(mean_tot(1,i
 ggmTot3_m=[ggm3a_m;ggm3b_m];
 stdgTot3=[stdg3a_m;stdg3b_m];
 %writetable(ggmTot3_m,'new.txt');
 %writematrix(ggmTot3_m,'C:\Users\stauros\Desktop\Matlab data prossecing\SMPS_PVM\ggmTot3.xlsx');
 ggmTot5_m=[ggm5a_m;ggm5b_m];
 stdgTot5=[stdg5a_m;stdg5b_m];