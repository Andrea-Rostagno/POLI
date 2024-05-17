#### #### #### #### #### #### #### ####

####        Gianluca Mastrantonio
####        corso di Probabilit+ e Statistica
####        Codice R su "Introduzione al corso e Distribuzioni"
####        Vers 1.0.0
#### #### #### #### #### #### #### ####

library(datasets)
library(catdata)
library(dslabs)
library(mvtnorm)
library(patchwork)
library(paletteer)
library(tidyverse)
#install.packages("paletteer")
# se un pacchetto non è installato usare
# il comando install.packages("nomepacchetto")

#### #### #### ####
#### Chunk datasets
#### #### #### ####

# vediamo alcuni dataset contenenti osservazioni su di un campione
# e facciamo qualche statistica descrittiva

#### Data Morley -  misurazione della velocit\`a della luce ####
?morley
data(morley)
summary(morley)

# alcuni plot
plot(morley$Speed, ylab="Velocita")
plot(density(morley$Speed))
hist(morley$Speed, freq=F)
lines(density(morley$Speed),  col=2, lwd = 2)
# il valore vero è (299) 792


boxplot(morley$Speed)

#### Data nhtemp -  misurazione delle temperatura media annuale in New Haven, dal 1912 al 1971 ####
?nhtemp
data(nhtemp)
summary(nhtemp)

# alcuni plot
plot(nhtemp, ylab="temperatura")
plot(density(nhtemp))
boxplot(nhtemp)
hist(nhtemp, freq=F)
lines(density(nhtemp),  col=2, lwd = 2)


# possiamo anche analizzare trasformazioni
# come le differenze del primo ordine
diff_temp = diff(nhtemp) # equivalente a diff_temp = nhtemp[-1]-nhtemp[-length(nhtemp)]
plot(diff_temp, ylab="diff temperatura")
plot(density(diff_temp))
boxplot(diff_temp)


#### Data discoveries - numero di importanti scoperte ####
?discoveries
data(discoveries)
summary(discoveries)

# alcuni plot
plot(discoveries, ylab="Scoperte")
barplot(table(discoveries))
hist(discoveries, breaks = (0:(max(discoveries)+1))-0.5, freq=F)
boxplot(discoveries)


#### Data sleep -  effetto di due farmaci per il sonno su 10 pazienti
?sleep
data(sleep)
summary(sleep)

# plot generale
plot(sleep[,1], ylab="Sleep", col=sleep$ID, pch=c(10,20)[sleep$group], cex=3)
# plot differenze per paziente
plot(sleep[1:10,1]-sleep[11:20,1],col=sleep$ID[1:10], pch=20, cex=3)
abline(h = 0)

#### Data Birth - informazioni su nascite in francia tra il 1990 e 2004
?birth
data(birth)
summary(birth)

table(birth$Sex)
table(birth$Cesarean)

#### Data brexit_polls -  previsioni di voto per la brexit
?brexit_polls
data(brexit_polls)
dim(brexit_polls)
summary(brexit_polls)

# calcoliamo le intenzioni di voto (ci sono degli errori di approssimazione)
leave = brexit_polls$samplesize*brexit_polls$leave
remain = brexit_polls$samplesize*brexit_polls$remain
undecided = brexit_polls$samplesize*brexit_polls$undecided
#brexit_polls$leave+brexit_polls$remain+brexit_polls$undecided

#### #### #### ####
#### Chunk statistiche campionarie
#### #### #### ####

# vediamo al funzione di ripartizione empirica di una beta(1,3)
# con diversi valori di n

# simuliamo dalla beta
x1 = rbeta(10,1,3)
x2 = rbeta(50,1,3)
x3 = rbeta(100,1,3)



# cacoliamo le funzioni di ripartizioni empiriche su xseq
xseq= seq(0,1, by=0.001)
ec1 = ecdf(x1)(xseq)
ec2 = ecdf(x2)(xseq)
ec3 = ecdf(x3)(xseq)


# facciamone il plot sui valori xseq

#pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni/ecdf.pdf")
plot(xseq,ec1, type="s", lwd=2, col=2, xlab="X", ylab="ecdf")
lines(xseq,ec2, type="s", col=3, lwd=2)
lines(xseq,ec3, type="s", col=4, lwd=2)
lines(xseq, pbeta(xseq,1,3), type="s", col=1, lwd=2)
legend("bottomright", c("True","n=10","n=50","n=100"), col=1:4, lwd=3, cex=2)
#dev.off()

# #
# xseq= seq(0,1, by=0.001)
# plot(xseq,dnorm(xseq), type="l", lwd=3, xlab="Y",ylab = "density" )
# lines(xseq,dt(xseq,1), col=2, lwd=3)
# lines(xseq,dt(xseq,20), col=2, lwd=3)
# lines(xseq,dt(xseq,80), col=3, lwd=3)

#### #### #### ####
#### Chunk Simulazioni
#### #### #### ####

# seed
# se setto il seme sempre allo stesso valore, ottengo sempre lo stesso numero
set.seed(1000)
rnorm(1,0,1)
set.seed(1000)
rnorm(1,0,1)
set.seed(1000)
rnorm(1,0,1)

# se lo setto solo uan volta, ottengo numeri diversi
set.seed(1000)
rnorm(1,0,1)
rnorm(1,0,1)
rnorm(1,0,1)

###
# verifichiamo che la media campionaria tende alla media vera
set.seed(1000)
# Caso Poisson
nel = 20000
x = rpois(nel,5)
m = cumsum(x)/(1:nel)
plot(m, type="l")

# Caso Gamma
nel = 20000
x = rgamma(nel,1,1)
m = cumsum(x)/(1:nel)
plot(m, type="l")

# vediamo la legge dei grandi numeri
# per una variabile aleatoria Uniforme discreta
# su (1,2,3,4,5,6)
S = seq(from = 1, to = 6, length = 200)
par(cex.main = 1.5, cex.axis = 1.2, cex.lab = 1.5)
plot(1:200, S, type = "n", xlab = "$n$", ylab = "$(X_1+\\cdots+X_n)/n$")
for (s in 1:100)
{
  lines(1:500, cumsum(sample(1:6, 500,replace = TRUE))/1:500, col = rgb(0, 0, 0, alpha = 0.3))
}
