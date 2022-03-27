# Web-Scraping-with-Selenium
Web Scraping and extraction of information from multiple web pages for estimize.com

The open web-based platform Estimize, provides the most accurate financial estimates, by crowdsourcing earnings and macroeconomic estimates from over 100,000 contributors across the globe. Estimize collects opinions from a diverse mix of buy-side, independent, and sell-side investment professionals, along with amateur analysts, independent investors, and academics, while maintaining the highest quality data through advanced behavioral and statistical algorithms. As such, Estimize consensus can be more accurate than the Wall Street consensus and provides incremental information for forecasting earnings and for measuring the market expectation of earnings.
Our primary objective was to build a dataset to store the Earnings per Share (EPS) estimation information. The key features included company specific information pertaining to company’s name, the sector and industry each company belonged to and the number of followers each company had. We were also concerned about the information on EPS estimation provided by the individual analysts on Estimize. Necessary attributes for this segment were the reported Earnings, Estimize consensus and Wall Street Consensus. Lastly, we accumulated information on Estimize’s contributors, important features being analyst name, roles, stocks covered and scored estimates among others.
In order to gather the requisite features, we scraped the data from Estimize.com across the four quarters of the year 2019. After undergoing the rigorous web scraping process, we created a database on EPS estimation that also supported querying and extraction of relevant information.
