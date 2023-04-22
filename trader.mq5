//+------------------------------------------------------------------+
//|                                                       trader.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

input ulong MagicNumber=101;
input int MAPeriod=30;
input ENUM_MA_METHOD MAMethod = MODE_SMA;
input int MAShift = 0;
input ENUM_APPLIED_PRICE MAPrice = PRICE_CLOSE;


input double FixedVolume = 0.01;
datetime glTimeBarOpen;
int i;
string candleType;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   glTimeBarOpen= D'1971.01.01 00:00';
//Print("Expert initialized");
   int bars=Bars(_Symbol,_Period);

   MqlRates bar[];
   ArraySetAsSeries(bar,true);
   CopyRates(_Symbol,PERIOD_CURRENT,0,bars-1,bar);

   int handle_cci = iCCI(_Symbol,PERIOD_CURRENT,13,PRICE_TYPICAL);
   int handle_MA = iMA(_Symbol,PERIOD_CURRENT,13,0,MODE_SMA,PRICE_CLOSE);
   int handle_force_index = iForce(_Symbol,PERIOD_CURRENT,13,MODE_EMA,VOLUME_TICK);
   int handle_RVI = iRVI(_Symbol,PERIOD_CURRENT,10);
   int handle_RSI = iRSI(_Symbol,PERIOD_CURRENT,14,PRICE_CLOSE);

   double cci[];
   double ma[];
   double force_index[];
   double rvi[];
   double rsi[];


   ArraySetAsSeries(cci,true);
   ArraySetAsSeries(ma,true);
   ArraySetAsSeries(force_index,true);
   ArraySetAsSeries(rvi,true);
   ArraySetAsSeries(rsi,true);

   CopyBuffer(handle_cci,0,1,bars-1,cci);
   CopyBuffer(handle_MA,0,1,bars-1,ma);
   CopyBuffer(handle_force_index,0,1,bars-1,force_index);
   CopyBuffer(handle_RVI,0,1,bars-1,rvi);
   CopyBuffer(handle_RSI,0,1,bars-1,rsi);
   datetime date_time;



//--- if the handle is not created
   if(handle_cci==INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the CCI indicator for the symbol %s/%s, error code %d",
                  Symbol(),
                  EnumToString(Period()),
                  GetLastError());
      //--- the indicator is stopped early
      return(INIT_FAILED);
     }
   if(handle_MA==INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the MA indicator for the symbol %s/%s, error code %d",
                  Symbol(),
                  EnumToString(Period()),
                  GetLastError());
      //--- the indicator is stopped early
      return(INIT_FAILED);
     }

   int Report = FileOpen("report_final",FILE_WRITE|FILE_CSV|FILE_ANSI,",",CP_ACP);
   FileWrite(Report,"datetime","open","high","low","close","tvol","spr","ccpi","ma","findex","rvi","rsi");


   for(i=1; i<(bars-1); i++)
     {
      FileWrite(Report,date_time=iTime(_Symbol,PERIOD_CURRENT,i),bar[i].open,bar[i].high,bar[i].low,bar[i].close,bar[i].tick_volume,bar[i].spread,cci[i],ma[i],force_index[i],rvi[i],rsi[i]);
     }

   FileClose(Report);





   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   bool newBar = false;
   if(glTimeBarOpen != iTime(_Symbol,PERIOD_CURRENT,0))
     {
      newBar=true;
      glTimeBarOpen = iTime(_Symbol,PERIOD_CURRENT,0);
     }

   if(newBar=true)
     {

     }


  }
//+------------------------------------------------------------------+
