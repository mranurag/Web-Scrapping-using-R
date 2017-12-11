Group  Members:

Team – Anurag Dubey: 71722030, Divya Vidhyarthi: 71722024, Anoop Singh: 71722022




The task here is to extract the website details of restaurants from their corresponding yelp page.

Analysing sample pages revealed that we would have to navigate to another child page of  the listed restaurant in yelp in order to obtain their contact URL and mail-to information.

We took the sample dataset provided to us as the target source of information and used R language to complete the task. The logic flow of the program is as follows:
1. Browse all links from the restaurant's home page in yelp
2. From the list of browsed links, determine which one of them has the "href" attribute (this attribute redirects us to another page which has the contact information)
3. From the href attribute, navigate to the URL it specifies
4.Search for the "mailto" link to obtain the e-mail ID information

Exceptions - It has been a generic observation that at times the href attribute points to a part of the website (and not to a complete page, i.e. the domain information such as .com remains missing). The R program has been written in such a way that in case this exception occurs, then it would automatically append the website URL to make it as a complete navigable and valid site address.

Additional observations - Currently we have searched URLs of commercial businesses only (with .com domain name). An exhaustive domain name list (acquired from ICANN) can be used to make the search program more exhaustive.
