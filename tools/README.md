Note: This is a list of the tools (both written scripts & 3rd party) used in the GDPR analysis project. Development was limitted by the tight timeframe of the project.

# 1. Facebook 

## 1.1. 3rd Party Tools

- [Lost Circles](https://lostcircles.com/): a chrome extension that reveals the inherent structure of your Facebook friendship graph.  

- [Data Selfie](https://dataselfie.it/#/): a (now shutdown) project scrapes Facebook for data that is not present in the official GDPR data release. It then analyses it using [IBM Watson](https://console.bluemix.net/catalog/?category=ai) tools.

- [PolitEcho](https://politecho.org): a chrome extension that shows you the bias of your Facebook NewsFeed. A good way to estimate and corrolate data from the official GDPR data released to you by Facebook.

## 1.2. Code Written

- [SocialNetPlot.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/Facebook/SocialNetPlot.R): an R script that converts the data scraped using the aforementioned Lost Circles app. Output then analysed further using the open source [Gephi application](https://gephi.org).

# 2. Microsoft

## 2.1. 3rd Party Tools

None found yet

## 2.2. Code Written

- [MicrosoftLogTimeline.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/Microsoft/MicrosoftLogTimeline.R): an R script that processes the ProductAndServiceUsage.json file that is returned from the Microsoft GDPR data request. Outputs a csv file that can be further analysed using plotting libraries of choice.

# 3. LinkedIn

## 2.1. 3rd Party Tools

None found yet

## 2.2. Code Written

- [MessageAnalysis.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/LinkedIn/MessageAnalysis.R): an R script that processes the messages.csv file that is returned from the LinkedIn GDPR data request. Outputs an ngram model trained on cleaned data from the input. 

# 4. Google

## 4.1. 3rd Party Tools

- A great blog post by [Shirin Glander](https://github.com/ShirinG) available at: https://shiring.github.io/maps/2016/12/30/Standortverlauf_post

- [Noiszy](https://noiszy.com/): a great [chrome extension](https://chrome.google.com/webstore/detail/noiszy/immakaidhkcddagdjmedphlnamlcdcbg) that pseudo-randomly generates web traffic to corrupt google data return from GDPR requests (could be useful to analyse how well this can be done). In their words "Hiding from data collection isn't working. Instead, we can make our collected data less actionable by leaving misleading tracks, camouflaging our true behavior."


## 4.2. Code Written

- [LocationExplorer.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/Google/LocationExplorer.R): an R script that processes the location data output by the GDPR request of Google data. Returns various maps and logging statistics. Heavily inspired by the above blog post.  

# 5. Telegram

## 5.1. 3rd Party Tools

- [Telegram Official GDPR bot](https://t.me/gdprbot): a telegram bot to serve you your GDPR data in a clean, machine and human readable format. 

## 5.2. Code Written

- [MessageAnalysis.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/Telegram/MessageAnalysis.R): an R script that processes the messages.csv file, like for linkedin, returned from the Telegram GDPR data request. Outputs an ngram model trained on cleaned data from the input. 

