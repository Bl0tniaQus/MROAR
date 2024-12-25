train_dirs = ["images/dzien_wiosna", "images/noc_wiosna"];
train_imds = imageDatastore(train_dirs, IncludeSubfolders=true, LabelSource="foldernames");



bag = bagOfFeatures(train_imds, PointSelection="Detector");
classifier = trainImageCategoryClassifier(train_imds, bag);
imagePath = "./test_images/test_img10.png";
image = imread(imagePath);
%image = imresize(image, [1024 576]);
prediction = predict(classifier, image);
disp("Predicted Label: " + string(prediction));