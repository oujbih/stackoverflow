library(randomForest)

model_rf_fines<- readRDS(file = paste0("rf1.rds"))
model_rf_gros<- readRDS(file = paste0("rf2.rds"))
#grid------
grid_input_test = expand.grid(
  "Poste" ="P1",
  "Qualité" ="BTNBA",
  "CPT_2500" =13.83,
  "CPT400" = 46.04,
  "CPT160" =15.12,
  "CPT125" =5.9,
  "CPT40"=15.09,
  "CPT_40"=4.02,
  "retart"=0,
  "dure"=0,
  'Débit_CV004'=seq(1300,1400,10),
  "Dilution_SB002"=seq(334.68,400,10),
  "Arrosage_Crible_SC003"=seq(250,300,10),
  "Dilution_HP14"=1200,
  "Dilution_HP15"=631.1,
  "Dilution_HP18"=500,
  "Dilution_HP19"=seq(760.47,800,10),
  "Pression_PK12"=c(0.59,0.4),
  "Pression_PK13"=c(0.8,0.7),
  "Pression_PK14"=c(0.8,0.9,0.99,1),
  "Pression_PK16"=c(0.5),
  "Pression_PK18"=c(0.4,0.5)
  
)

#levels correction ----
levels(grid_input_test$Qualité) = model_rf_fines$forest$xlevels$Qualité
levels(grid_input_test$Poste) = model_rf_fines$forest$xlevels$Poste

for(i in 1:nrow(grid_input_test)){
  #fines
  print("----------------------------")
  print(i)
  print(paste0('Fines       :', predict(object = model_rf_fines,newdata = grid_input_test[i,]) ))
  #gros
  print(paste0('Gros        :',predict(object = model_rf_gros,newdata = grid_input_test[i,]) ))
  if(predict(object = model_rf_gros,newdata = grid_input_test[i,])<=10){break}
}

