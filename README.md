# A-MULTI-EXPOSURE-IMAGE-FUSION-BASED-ON-THE-ADAPTIVE-WEIGHTS
Image fusion, dynamic range.

Most of existing methods focused on finding weight functions that assign larger weightsto the pixels in better-exposed regions. While the conventional methods
apply the same function to each of the multiexposure images, we propose a function that considers all the multi-exposure images simultaneously to reflect the
relative intensity between the images and global gradients. Specifically, we define two kinds of weight functions for this. The first is to measure the 
importance of a pixel value relative to the overall brightness and neighboring exposure images. The second is to reflect the importance of a pixel value when
it is in a range with relatively large global gradient compared to other exposures. The proposed method needs modest computational complexity owing to the 
simple weight functions, and yet it achieves visually pleasing results and gets high scores according to an image quality measure.
