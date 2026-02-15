// -----------------------------------------------------------
// SNR* Tool for ImageJ
// Copyright (c) 2026 Motohiro TABUCHI
// Released under the MIT License
// Covariance-based SNR estimation
// Requires two observed images acquired under identical conditions
// For research use only
// Requires ImageJ 1.53 or later
// Version: 1.0
// Year: 2026
// Author: Motohiro TABUCHI
// -----------------------------------------------------------

requires("1.53");

macro "SNR* Action Tool - C000T0d12ST8d09NTcd09RTf909*" {
//SNR estimation
//Folder preperation
showMessage("Select Open Folder");
openDir=getDirectory("Choose a Directory");
list=getFileList(openDir);

if(list.length != 2){
    exit("Folder must contain exactly 2 images.");
}

var b;
var c;
var b_average = 0;
var c_average = 0;
var n_average = 0;
var sig = 0;
var noise = 0;
var snr = 0;

//initialize ROI Manager
roiCount = roiManager("count");
if(roiCount > 0){
	roiManager("Deselect");
	roiManager("Delete");
}

//processing all images existing in this folder
for (s=0; s<list.length; s++){
	
	open(openDir+list[s]);

	//processing after 1st image
	if(s != 0){
		roiManager("Select", 0);
	}

	//waiting until clicking OK
	waitForUser("Set ROI, then click \"OK\".");

	//1st image processing and registration of ROI
	if(s == 0){
		roiManager("Add");
	}

	//ROI imformation save
	//getStatistics(area, mean, min, max, std);

	Roi.getContainedPoints(xpoints,ypoints);

	p = lengthOf(xpoints);
	a = newArray(p);	//print(lengthOf(xpoints),lengthOf(ypoints),p);waitForUser("test, test \"OK\".");
	average = 0;
			
					for(i=0;i<p;i++){

						a[i] = getPixel(xpoints[i],ypoints[i]);
			
						average += a[i]/p;
			
					}
	
	if(s == 0){
			
			b = a;
			b_average = average;
		
	}
	
	
	if(s != 0){		

			c = a;
			c_average = average;
		
	}
	
	close();

}


	for(i=0;i<p;i++){

			n_average += (b[i]-c[i])/p;
	
	}


	for(i=0;i<p;i++){
			
			sig += ((b[i] - b_average)*(c[i] - c_average))/p;
			noise += (b[i] - c[i] - n_average)*(b[i] - c[i] - n_average)/p;
	
	}	
	
	snr = 10*Math.log10(sig/(noise/2));

	print("SNR* : " + d2s(snr,3) + " [dB]");
	print("area : " + p + "[pixels]");
	print("covariance of images : " + sig );
	print("variance of noise : " + noise/2 );




}






