//+------------------------------------------------------------------+
//|                                                     listener.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

string GetImpulse(){
string cookie=NULL,headers; 
   char post[],result[]; 
   int res; 
//--- to enable access to the server, you should add URL "https://www.google.com/finance" 
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"): 
   string url="http://localhost/controller"; 
//--- Reset the last error code 
   ResetLastError(); 
//--- Loading a html page from Google Finance 
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection 
   res=WebRequest("GET",url,cookie,NULL,timeout,post,0,result,headers); 
//--- Checking errors 
   if(res==-1) 
     { 
      Print("Error in WebRequest. Error code  =",GetLastError()); 
      //--- Perhaps the URL is not listed, display a message about the necessity to add the address 
      MessageBox("Add the address '"+url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION); 
     } 
   else 
     { 
   Alert(CharArrayToString(result));
     } 

return NULL;
}

string GetTimeFrame(int lPeriod)
   {
      switch(lPeriod)
      {
      case 1: return("M1");
      case 5: return("M5");
      case 15: return("M15"); 
      case 30: return("M30");
      case 60: return("H1");
      case 240: return("H4");
      case 1440: return("D1");
      case 10080: return("W1"); 
      case 43200: return("MN1"); 
      }
   return NULL;
   }

void insertCandles(datetime start, datetime end){



while (start!=end){
start = start + Period()*60;
string cookie=NULL,headers; 
   char post[],result[]; 
   int res; 
//--- to enable access to the server, you should add URL "https://www.google.com/finance" 
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"): 
   string url="http://localhost/insertcandle"; 
   
   double open = iOpen(Symbol(), GetTimeFrame(Period()), iBarShift(Symbol(),GetTimeFrame(Period()),start));
   double close = iClose(Symbol(), GetTimeFrame(Period()), iBarShift(Symbol(),GetTimeFrame(Period()),start));
   double high = iHigh(Symbol(), GetTimeFrame(Period()), iBarShift(Symbol(),GetTimeFrame(Period()),start));
   double low = iLow(Symbol(), GetTimeFrame(Period()), iBarShift(Symbol(),GetTimeFrame(Period()),start));
   
   url=url+"?"+"interval="+GetTimeFrame(Period())+"&symbol="+Symbol()+"&low="+low+"&high="+high+"&close="+close+"&open="+open;
   
//--- Reset the last error code 
   ResetLastError(); 
//--- Loading a html page from Google Finance 
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection 
   res=WebRequest("GET",url,cookie,NULL,timeout,post,0,result,headers); 
//--- Checking errors 
   if(res==-1) 
     { 
      Print("Error in WebRequest. Error code  =",GetLastError()); 
      //--- Perhaps the URL is not listed, display a message about the necessity to add the address 
      MessageBox("Add the address '"+url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION); 
     } 
}
}

int OnInit()
  {
  
   string cookie=NULL,headers; 
   char post[],result[]; 
   int res; 
//--- to enable access to the server, you should add URL "https://www.google.com/finance" 
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"): 
   string url="http://localhost/test"; 
//--- Reset the last error code 
   ResetLastError(); 
//--- Loading a html page from Google Finance 
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection 
   res=WebRequest("GET",url,cookie,NULL,timeout,post,0,result,headers); 
//--- Checking errors 
   if(res==-1) 
     { 
      Print("Error in WebRequest. Error code  =",GetLastError()); 
      //--- Perhaps the URL is not listed, display a message about the necessity to add the address 
      MessageBox("Add the address '"+url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION); 
     } 
   else 
     { 
   Alert(CharArrayToString(result));
     } 
//---
   
//---
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
//---
   
  }
//+------------------------------------------------------------------+
void OnStart(){
GetImpulse();


}