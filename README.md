# FAERS

## Introduction

This document describes the web application [FDA Adverse Event Reporting System Data Reviewer](https://stomioka.shinyapps.io/FAERS/).

The data from FAERS are pulled from FAERS database using Elasticsearch-based API. The API can be used not only for FAERS but drug labels, recall data as well as devices and foods. 

The FDA Adverse Event Reporting System (FAERS) is a database that contains adverse event reports, medication error reports and product quality complaints resulting in adverse events that were submitted to FDA. The database is designed to support the FDA's post-marketing safety surveillance program for drug and therapeutic biologic products. The informatic structure of the FAERS database adheres to the international safety reporting guidance issued by the International Conference on Harmonisation (ICH E2B). Adverse events and medication errors are coded using terms in the Medical Dictionary for Regulatory Activities (MedDRA) terminology.


## How does FDA use the information in FAERS?

FAERS is a useful tool for FDA for activities such as looking for new safety concerns that might be related to a marketed product, evaluating a manufacturer's compliance to reporting regulations and responding to outside requests for information. The reports in FAERS are evaluated by clinical reviewers, in the Center for Drug Evaluation and Research (CDER) and the Center for Biologics Evaluation and Research (CBER), to monitor the safety of products after they are approved by FDA. 
 If a potential safety concern is identified in FAERS, further evaluation is performed. Further evaluation might include conducting studies using other large databases, such as those available in the Sentinel System. Based on an evaluation of the potential safety concern, FDA may take regulatory action(s) to improve product safety and protect the public health, such as updating a product’s labeling information, restricting the use of the drug, communicating new safety information to the public, or, in rare cases, removing a product from the market.   

## Does FAERS data have limitations?

 - There is no certainty that the reported event (adverse event or medication error) was due to the product. FDA does not require that a causal relationship between a product and event be proven, and reports do not always contain enough detail to properly evaluate an event. 
- FDA does not receive reports for every adverse event or medication error that occurs with a product. Many factors can influence whether an event will be reported, such as the time a product has been marketed and publicity about an event. 
- There are also duplicate reports where the same report was submitted by a consumer and by the sponsor. Therefore, FAERS data cannot be used to calculate the incidence of an adverse event or medication error in the U.S. population. 

## The app

The web application, [FDA Adverse Event Reporting System Data Reviewer](https://stomioka.shinyapps.io/FAERS/), that I developed has limitation.

It only provides a fraction of data in the FAERS. The app can be further enhanced to provide more data and visualization.
The API has 1000 records limit. Therefore, the app may not show all the records in the FAERS. When the number of records of the table is 1000, the table is mostlikely displaying the first 1000 records of the database search results.

## Future work

The web application could include more data point and data visualizations. FAERS returns error when the search does not have any results. This would stop execution of the rest of the search in the loop. It can be addressed.
