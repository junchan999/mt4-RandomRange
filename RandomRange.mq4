//+------------------------------------------------------------------+
//|                                                  RandomRange.mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#property version   "1.00"
#property strict

//--- input parameters
input double   Lots = 0.01;
input double   StopLossPips = 50.0;
input double   TakeProfitPips = 50.0;
input int      MagicBuy = 123;
input int      MagicSell = 456;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
//---
    
//---
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//---
    
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
//---
    if (Volume[0] > 1) {
        return;
    }
    
    int pos = getPosCount();
    int ticket;
    
    if (pos == 0) {
        double takeprofit = TakeProfitPips * Point;
        if (Digits == 3 || Digits == 5) {
            takeprofit *= 10;
        }
        double stoploss = StopLossPips * Point;
        if (Digits == 3 || Digits == 5) {
            stoploss *= 10;
        }
        
        if (MathRand() % 10 == 0) {
            // buy
            ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, 0, Ask - stoploss, Ask + takeprofit, NULL, MagicBuy, 0, clrBlue);
        } else if (MathRand() % 10 == 0) {
            // sell
            ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, 0, Bid + stoploss, Bid + takeprofit, NULL, MagicSell, 0, clrRed);
        }
    }
}
//+------------------------------------------------------------------+

int getPosCount() {
    int pos = 0;
    int orders_total = OrdersTotal();
  
    for (int order = 0; order < orders_total; order++) {
        if (OrderSelect(order, SELECT_BY_POS) == false) {
            continue;
        }
        
        int order_magic_number = OrderMagicNumber();
        if (order_magic_number == MagicBuy || order_magic_number == MagicSell) {
            pos++;
        }
    }
    
    return pos;
}
