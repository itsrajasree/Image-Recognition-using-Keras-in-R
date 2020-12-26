# Image-Recognition-using-Keras-in-R
In this project, Classification and recognition of images using the Keras from Tensorflow package is performed in R programming.

In this project, we will train a neural network model to classify images of vehicles, like MotorBikes, Cars and Planes.

1.Data Preprocessing
Initially the libraries necessary for neural networks and processing images are loaded and the images required are loaded into the program

i.Resizing and reshaping
In this stage, the images that are having different size and shape are converted into same size and shape.

ii.Row Binding 
Row binding function is used to combine all the data together in a single dataframe.

iii.Encoding
Encoding  is the process of replacing the different levels of a variable with dummy numbers. OneHot encoding is used in this case.

2.Modelling
The model have 2 hidden layers with 256 neurons and 128 neurons and an output layer. Then the model is compiled with categorical_crossentropy as loss, optimzer_rmsprop() as optimizer and accuracy as the metrics. The model is fitted with 30 iterations and 20% validation data. 

3.Interpretation
The accuracy score and loss value are obtained for both the training data and test data. Also the confusion matrix is used for evaluatinng the performance of the model. 
