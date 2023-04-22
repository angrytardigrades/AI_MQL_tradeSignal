# AI_MQL_tradeSignal
This is proejct where you can extract data from MetaTrader platform via MQL expert advisor and then feed it into Python - SKlearn mod.el and then train a RandomForestClassifier model to decide if we should create a position or not

1- Open MetaTrader and run the expert advisor (trader) on your prefered symbol , and this expert advisor will export the information of each bar ( based on your timeframe)
2- Use the exported CSV file and load it into Python model , follow my code and traion the model and then test it.

Note: this is not for trade purpose although the result is still very nice , but this code and project is only to demonstrate in a very un-tuned way just to show how machine learning can be used for decision making and in this example to open a position in a financial market
