#Importing necessary Libraries
library("EBImage")
library("keras")

#Reading Images
setwd("/Users/My PC/Desktop/Images")
pics <- c("b1.jpg","b2.jpg","b3.jpg","b4.jpg","b5.jpg","b6.jpg","c1.jpg","c2.jpg","c3.jpg","c4.jpg","c5.jpg","c6.jpg","p1.jpg","p2.jpg","p3.jpg","p4.jpg","p5.jpg","p6.jpg")
mypic <- list()

for (i in 1:18) {mypic[[i]] <- readImage(pics[i])}

#Exploring the images
display(mypic[[18]])
summary(mypic[[5]])
str(mypic)

#Resizing the Images
for (i in 1:18) {mypic[[i]] <- resize(mypic[[i]],200,200)}
str(mypic)

#Reshaping the Images
for (i in 1:18) {mypic[[i]] <- array_reshape(mypic[[i]],c(200,200,3))}
str(mypic)

#Row Binding
trainx <- NULL
for (i in 1:5) {trainx <- rbind(trainx, mypic[[i]])}
for (i in 7:11) {trainx <- rbind(trainx, mypic[[i]])}
for (i in 13:17) {trainx <- rbind(trainx, mypic[[i]])}
str(trainx)

testx <- rbind(mypic[[6]], mypic[[12]], mypic[[18]])
trainy <- c(0,0,0,0,0,1,1,1,1,1,2,2,2,2,2)
testy <- c(0,1,2)

#One Hot Encoding
trainlabels <- to_categorical(trainy)
testlabels <- to_categorical(testy)

#Modelling
model <- keras_model_sequential()
model %>% 
          layer_dense(units=256, activation = "relu",input_shape = c(120000)) %>%
          layer_dense(units=128, activation = "relu") %>%
          layer_dense(units=3, activation = "softmax")
summary(model)

#Compiling
model %>%
          compile(loss= 'categorical_crossentropy', optimizer_rmsprop(), metrics=c('accuracy'))

#Fitting the Model
history <- model %>%
           fit(trainx,trainlabels,epochs=30,batch_size=32,validation_split=0.2)

#Evaluation and Prediction on Training Data
model %>% evaluate(trainx, trainlabels)
pred <- model %>% predict_classes(trainx)
table(Predicted = pred, Actual = trainy)
prob <- model %>% predict_proba(trainx)
cbind(prob,Predicted=pred,Actual=trainy)

#Evaluation and Prediction on Test data
model %>% evaluate(testx, testlabels)
pred <- model %>% predict_classes(testx)
table(Predicted = pred, Actual = testy)
prob <- model %>% predict_proba(testx)
cbind(prob,Predicted=pred,Actual=testy)