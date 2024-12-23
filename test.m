train_dirs = ["images/noc_jesien", "images/noc_wiosna", "images/noc_zima"];
test_dirs = ["images/dzien_jesien", "images/dzien_wiosna", "images/dzien_zima"];
train_imds = imageDatastore(train_dirs, IncludeSubfolders=true, LabelSource="foldernames");
test_imds = imageDatastore(test_dirs, IncludeSubfolders=true, LabelSource="foldernames");

%bag = bagOfFeatures(train_imds, PointSelection="Detector");
%classifier = trainImageCategoryClassifier(train_imds, bag);
predicted = predict(classifier, test_imds)
true_labels = grp2idx(test_imds.Labels)
mismatches = find(predicted ~= true_labels);


confusionchart(true_labels,predicted);

output_file = "mismatched_predictions.txt";
fid = fopen(output_file, "w");
if fid == -1
    error("Failed to open file for writing.");
end
fprintf(fid, "Mismatched predictions:\n");
for i = 1:length(mismatches)
    image_path = strrep(test_imds.Files{mismatches(i)}, '\\', '/');
    fprintf(fid, "Image: %s | True Label: %s | Predicted Label: %s\n", ...
            image_path, ...
            string(true_labels(mismatches(i))), ...
            string(classifier.Labels(predicted(mismatches(i)))));
end
fclose(fid);
disp("Mismatched predictions:");
for i = 1:length(mismatches)
    image_path = strrep(test_imds.Files{mismatches(i)}, '\\', '/');
    fprintf("Image: %s | True Label: %s | Predicted Label: %s\n", ...
            image_path, ...
            string(true_labels(mismatches(i))), ...
            string(classifier.Labels(predicted(mismatches(i)))));
end
