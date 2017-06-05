FILENAME REFFILE '/folders/myshortcuts/My_SAS/Project 04_Retail Analysis_Dataset.xlsx';

PROC IMPORT DATAFILE=REFFILE /*importing the dataset from retail analysis_dataset from file location*/
	DBMS=XLSX
	OUT=WORK.Retail;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.Retail; RUN;


%web_open_table(WORK.Retail);

libname mylib '/folders/myshortcuts/My_SAS';  

data mylib.retaildata; /*to create a library retaildata under mylib*/
set retail;
run;

Proc Means Data=mylib.retaildata;   /*to perform descriptive statistics on the dataset*/
Run;

Proc Means Data=mylib.retaildata N Mean Std Min Max Median Mode p25 p75;  /*to perform median mode and quantile operations on the dataset*/
Run;

Proc freq Data=mylib.retaildata;   /*to find the frequency statistics of the dataset*/
Tables Products ;
run;

Proc Univariate Data=mylib.retaildata;    /*to examine the distribution of data*/
class products;
var profit;
var sales;
var quantity;
Histogram profit;
Histogram sales;
Histogram quantity;
run;

Proc Reg data=mylib.retaildata; /*performing regression to check significance of independent variable with dependent variable sales*/
model sales=quantity;
model sales=discount;  
model sales=profit;
model sales=shipping_cost;
run;

Proc Reg data=mylib.retaildata;
model sales = quantity discount profit shipping_cost;
run;

DATA sales_computation;      /*computation in variable_computation dataset and output in print dataset*/
  SET mylib.retaildata;
  Sales_log = LOG(sales);      /* log base e */
  Sales_exp = EXP(sales);      /* e raised to the power */
  pow = 2;
  Sales_sq = sales ** pow ;    /* square of value*/
  pow = 3;                     
  Sales_cube = sales ** pow;   /*cube of value*/
RUN;
 
PROC PRINT DATA=sales_computation;
  VAR sales sales_log sales_exp sales_sq sales_cube;
RUN;  

DATA quantity_computation;
  SET mylib.retaildata;
  Q_log = LOG(quantity);      /* log base e */
  Q_exp = EXP(quantity);      /* e raised to the power */
  pow = 2;
  Q_sq = quantity ** pow ;    /* square of value*/
  pow = 3;
  Q_cube = quantity ** pow;   /*cube of value*/
RUN;
 
PROC PRINT DATA=quantity_computation;
  VAR quantity q_log q_exp q_sq q_cube;
RUN;  

DATA discount_computation;
  SET mylib.retaildata;
  Dis_log = LOG(discount);      /* log base e */
  Dis_exp = EXP(discount);      /* e raised to the power */
  pow = 2;
  Dis_sq = discount ** pow ;    /* square of value*/
  pow = 3;
  Dis_cube = discount ** pow;   /*cube of value*/
RUN;
 
PROC PRINT DATA=discount_computation;
  VAR discount dis_log dis_exp dis_sq dis_cube;
RUN;  

DATA profit_computation;
  SET mylib.retaildata;
  Profit_log = LOG(profit);      /* log base e */
  Profit_exp = EXP(profit);      /* e raised to the power */
  pow = 2;
  Profit_sq = profit ** pow ;    /* square of value*/
  pow = 3;
  Profit_cube = profit ** pow;   /*cube of value*/
RUN;
 
PROC PRINT DATA=profit_computation;
  VAR profit profit_log profit_exp profit_sq profit_cube;
RUN;  

DATA shippingcost_computation;
  SET mylib.retaildata;
  Ship_log = LOG(shipping_cost);      /* log base e */
  Ship_exp = EXP(shipping_cost);      /* e raised to the power */
  pow = 2;
  Ship_sq = shipping_cost ** pow ;    /* square of value*/
  pow = 3;
  Ship_cube = shipping_cost ** pow;   /*cube of value*/
RUN;
 
PROC PRINT DATA=shippingcost_computation;
  VAR shipping_cost ship_log ship_exp ship_sq ship_cube;
RUN;  