
train_dirs = ["images/noc_zima", "images/dzien_zima"];
test_dirs = ["images/dzien_jesien", "images/dzien_wiosna", "images/noc_jesien", "images/noc_wiosna"];
train_imds = imageDatastore(train_dirs,IncludeSubfolders=true,LabelSource="foldernames");
test_imds = imageDatastore(train_dirs,IncludeSubfolders=true,LabelSource="foldernames");

%train_imds = subset(train_imds, [1]);
%test_imds = subset(test_imds, [1]);
target = grp2idx(test_imds.Labels);
bag = bagOfFeatures(train_imds, PointSelection="Grid", gridStep=[32 32]);
classifier = trainImageCategoryClassifier(train_imds, bag);
predicted = predict(classifier, test_imds);
accuracy1 = sum(predicted==target)/length(target)*100;

bag = bagOfFeatures(train_imds, PointSelection="Grid", gridStep=[64 64]);
classifier = trainImageCategoryClassifier(train_imds, bag);
predicted = predict(classifier, test_imds);
accuracy2 = sum(predicted==target)/length(target)*100;

bag = bagOfFeatures(train_imds, PointSelection="Grid", gridStep=[32 64]);
classifier = trainImageCategoryClassifier(train_imds, bag);
predicted = predict(classifier, test_imds);
accuracy3 = sum(predicted==target)/length(target)*100;

bag = bagOfFeatures(train_imds, PointSelection="Detector")
classifier = trainImageCategoryClassifier(train_imds, bag);
predicted = predict(classifier, test_imds);
accuracy4 = sum(predicted==target)/length(target)*100;


disp("TRAIN: zima")
accuracy1
accuracy2
accuracy3
accuracy4
