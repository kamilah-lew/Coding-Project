gdp_data = xlsread('gdp.xlsx')

% 3A) reate a new variable, named total business investment

total_business_investment = gdp_data(2,:) + gdp_data(3,:)


quarters = datetime([1961,01,01],'Format','yyyy/MM/dd'):calquarters(1):datetime([2023,09,30])
quarters2 = datetime([1972,01,01],'Format','yyyy/MM/dd'):calquarters(1):datetime([2023,09,30])
quarters3 = datetime([1971,01,01],'Format','yyyy/MM/dd'):calquarters(1):datetime([2023,09,30])
months = datetime(1961,01,01):calmonths(1):datetime(2023,12,31)
months2 = datetime(1972,01,01):calmonths(1):datetime(2023,12,31)
months3 = datetime(1975,01,01):calmonths(1):datetime(2023,12,31)
months4 = datetime(1971,01,01):calmonths(1):datetime(2023,12,31)

% 3B) lot Gross domestic product at market prices, Household final consumption and total business investment
GDP = gdp_data(4,:)
plot(quarters,GDP)
xlabel('Year')
ylabel('GDP')
title('Real GDP, chained 2017 dollars')

C = gdp_data(1,:)
plot(quarters, C)
xlabel('Year')
ylabel('Consumption Expenditure')
title('Household final consumption expenditure, chained 2017 dollars')

plot(quarters,total_business_investment)
xlabel('Year')
ylabel('Total Business Investment')
title ('Total Business Investment, chained 2017 dollars')

%3C calculate the year over year growth rate

grGDP = ((GDP(5:end)-GDP(1:end-4))./GDP(1:end-4))*100
plot(quarters(5:end) ,grGDP)
xlabel('Year')
ylabel('GDP')
title('YoY Real GDP, chained 2017 dollars')

grC = ((C(5:end)-C(1:end-4))./C(1:end-4))*100
plot(quarters(5:end) ,grC)
xlabel('Year')
ylabel('Consumption Expenditure')
title('YOY Household final consumption expenditure')

grTBI = ((total_business_investment(5:end)-total_business_investment(1:end-4))./total_business_investment(1:end-4))*100
plot(quarters(5:end) ,grTBI)
xlabel('Year')
ylabel('Total Business Investment')
title ('YOY Total Business Investment, chained 2017 dollars')

%3D Calculate the variance of the YoY growth rate of gross domestic product at market
prices, household final consumption and total business investmen
variance_grGDP = var(grGDP)
variance_grC = var(grC)
variance_grTBI = var(grTBI)

%3E plot the following monthly time-series
eng_data = xlsread('eng.xlsx')
cpi_data = xlsread('CPI.xlsx')
rates_data = xlsread ('rates.xlsx')
dexacus_data = xlsread ('DEXCAUS.xlsx')

PCOM = eng_data(3,:)
ENER = eng_data(4,:)
CPI = cpi_data(3,:)
CPIX = cpi_data(4,:)
RATE = rates_data(3,:)
DEXCAUS = dexacus_data(2,:)

subplot(2,2,1)
plot(months2,PCOM)
xlabel('Year')
ylabel('Comodoties')
title('Total Comodoties')

subplot(2,2,2)
plot(months2,ENER)
xlabel('Year')
ylabel('Energy')
title('Total Energy')

subplot(2,2,3)
plot(months, CPI)
xlabel('Year')
ylabel('All Items CPI')
title('Total CPI')

subplot(2,2,4)
plot (months, CPIX)
xlabel('Year')
ylabel('All Items CPI')
title('Total CPI excluding Food and Energy')

%3F Plot the following monthly time-series (as a 2x1 plot)
subplot(2,1,1)
plot(months3,RATE)
xlabel('Year')
ylabel('Overnight Rate')
title('Overnight money market financing, 7 day average 3')

subplot(2,1,2)
plot(months4,DEXCAUS)
xlabel('Year')
ylabel('Spot Rate')
title('Canadian dollar to U.S dollar spot exchange rate')

% 3G Convert all your monthly time series to quarterly
CPIM = timetable(months', CPI')
tt_CPI = retime(CPIM, 'quarterly', 'mean')
CPIQ = tt_CPI.(1)(quarters)


ENERM = timetable(months2', ENER')
tt_ENER = retime(ENERM, 'quarterly', 'mean')
ENERQ = tt_ENER.(1)(quarters)


CPIXM = timetable(months', CPIX')
tt_CPIX = retime(CPIXM, 'quarterly', 'mean')
CPIXQ = tt_CPIX.(1)(quarters)

RATEM = timetable(months3', RATE')
tt_RATE = retime(RATEM, 'quarterly', 'mean')
RATEQ = tt_RATE.(1)(quarters)

DEXCAUSM = timetable(months4', DEXCAUS')
tt_DEXCAUS = retime(DEXCAUSM, 'quarterly', 'mean')
DEXCAUSQ = tt_DEXCAUS.(1)(quarters)


PCOMM = timetable(months2', PCOM')
tt_PCOM = retime(PCOMM, 'quarterly', 'mean')
PCOMQ = tt_PCOM.(1)(quarters)

%3H calculate the year-over-year growth rate of the following time-series

grCPIQ = ((CPIQ(5:end) - CPIQ(1:end-4)) ./ CPIQ(1:end-4)) * 100
plot(quarters(5:end) ,grCPIQ)
xlabel('Year')
ylabel('All Items CPI Quarterly')
title ('Total CPI YOY')

grCPIXQ = ((CPIXQ(5:end) - CPIXQ(1:end-4)) ./ CPIXQ(1:end-4)) * 100
plot(quarters(5:end) ,grCPIXQ)
xlabel('Year')
ylabel('All Items CPI Quarterly')
title('Total CPI excluding Food and Energy YOY')

grPCOMQ = ((PCOMQ(5:end) - PCOMQ(1:end-4)) ./ PCOMQ(1:end-4)) * 100
plot(quarters2(5:end) ,grPCOMQ)
xlabel('Year')
ylabel('Comodoties Quarterly')
title('Total ComodotiesYOY')

grENERQ = ((ENERQ(5:end) - ENERQ(1:end-4)) ./ ENERQ(1:end-4)) * 100
plot(quarters2(5:end) ,grENERQ)
xlabel('Year')
ylabel('Energy Quarterly')
title('Total Energy YOY')

grDEXCAUSQ  = ((DEXCAUSQ (5:end) - DEXCAUSQ (1:end-4)) ./ DEXCAUSQ(1:end-4)) * 100
plot(quarters3(5:end) ,grDEXCAUSQ)
xlabel('Year')
ylabel('Spot Rate Quarterly')
title('Canadian dollar to U.S dollar spot exchange rate YOY')

%4A Calculate the correlation between the level of the overnight money market financing and the growth rate of GDP
grgdp_1975 = grGDP(53:end)
corrgdp_rate = corrcoef(grgdp_1975, RATEQ)

% 4B Calculate the correlation between between the level of the overnight money market financing and the growth rate of CPI
grCPI_1975 = grCPIQ(53:end)
corrcpi_rate = corrcoef(grCPI_1975, RATEQ)

% 4C Calculate the correlation between the the growth rate of DEXCAUS and the growth rate of total, all commodity prices.
grDEXCAUSQ_1972 = grDEXCAUSQ(5:end)
corrdexcaus_pcom = corrcoef(grDEXCAUSQ_1972, grPCOMQ)

% 4D Calculate the correlation between the the growth rate of DEXCAUS and the growth rate of energy prices
corrdexcaus_ENER = corrcoef(grDEXCAUSQ_1972, grENERQ)










