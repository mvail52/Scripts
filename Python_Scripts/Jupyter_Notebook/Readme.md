# Jupyter_Notebook
I used Jupyter Notebook in grad school for a lot of projects. It made it very easy to share code with my instructors, classmates, and be able to isolate sections for testing. Since grad school, I have continued to use it for testing testing blocks of code or data analytics. At the time of me publishing this you could install Anaconda which includes Juptyer Notebooks from the following link: https://www.anaconda.com/distribution/

### ClassTree.ipynb
This was created to build a classification tree based on a data set. If you want to use this for a dataset you will need to adjust the X and Y to fit the number of columns. This file also splits the data into a 80/20, 80% is used to train the data and 20% is used to test it. Last, there was a couple of tests that failed when coming back. When I tested the same dataset in R I did not receive any, this was caused because python over classified my data. This is important to note because there was a bug found in python with using predictive analytics review the article below. While my issue was not caused by the bug, testing against other languages can help ensure that you’re getting proper results.


***future improvements*** 
I might come back around later an implement something that will look for user input have them set which columns to use as variables, or automatically set them based on file format. 

***Articles***
https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/?fbclid=IwAR0rvUh6WNU6_QGhAPR-KK9cCOG2ntN9NRDVLShzvsvOQKhPus3CV4Yp1_4
