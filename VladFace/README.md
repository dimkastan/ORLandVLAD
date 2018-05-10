=====================================================================================
This is a simplified and self contained demo written in Matlab, demonstrating the Vector of Locally Aggregated Descriptors method. <br>
Using ORL face database, initially, faces are represented as local intensity patches.
These patches are then used in order to train a codebook with k-means. <br>
Then, every image is encoded according to the VLAD framework by aggregating the residuals of every patch to their closest codebook elements. <br>
 
License: The code is provided freely without any restriction for research purposes.
However, in case you use the code, I would like you to add a link to this page. 
Please don't hesitate to send me any comments.<br> 
Disclaimer: The code is provided as is without any gurantee for correctness. <br>
Citation: <br>
Aggregating local descriptors into a compact image representation Herve Jegou, Matthijs Douze, Cordelia Schmid and Patrick P?rez Proc. IEEE CVPR?10, June, 2010 
=====================================================================================

Instructions<br>

-1- Run downloadORL.m first to download ORL in current directory<br>
-2- Run Vlad_face_encoding.m<br>
A plot using Classic MDS will visualize the Distance matrix between samples in three dimensions<br>
