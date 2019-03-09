Note: the developpement or open sourcing of analytical tools is still in process. This was limitted by the tight timeframe of this paper.

# 1. Facebook 

## 1.1. 3rd Party Tools

- [Lost Circles](https://lostcircles.com/): a chrome extension that reveals the inherent structure of your facebook friendship graph.  

- [Data Selfie](https://dataselfie.it/#/): a (now shutdown) project scrapes Facebook for data that is not present in the official GDPR data release. It then analyses it using [IBM Whatson](https://console.bluemix.net/catalog/?category=ai) tools.

- [PolitEcho](https://politecho.org): a chrome extension that shows you the bias of your Facebook NewsFeed. A good way to estimate and corrolate data from the official GDPR data released to you by Facebook.

## 1.2. Code Written

- [SocialNetPlot.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/Facebook/SocialNetPlot.R): an R script that converts the data scraped using the aforementioned Lost Circles app. Output then analysed further using the open source [Gephi application](https://gephi.org).

# 2. Microsoft

## 2.1. 3rd Party Tools

None found

## 2.2. Code Written

- [MicrosoftLogTimeline.R script](https://github.com/PsiPhiTheta/The-Digital-Deluge/blob/master/tools/Microsoft/MicrosoftLogTimeline.R): an R script that processes the ProductAndServiceUsage.json file that is returned from the Microsoft GDPR data request. Outputs a csv file that can be further analysed using plotting libraries of choice.

# 3. Google
