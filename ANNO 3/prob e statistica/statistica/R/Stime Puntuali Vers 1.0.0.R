#### #### #### #### #### #### #### ####
####        Gianluca Mastrantonio
####        corso di Probabilit� e Statistica
####        Codice R su "Stime Puntuali" Vers 1.0.0
#### #### #### #### #### #### #### ####

DIR = "/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/Stima Puntuale/"
library(datasets)
library(catdata)
library(dslabs)
library(mvtnorm)
library(patchwork)
library(paletteer)
library(tidyverse)


#### #### #### #### #### ####
#### Chunk Metodo Momenti
#### #### #### #### #### ####

# prendiamo il dataset Morley e vediamo se
# il metodo dei momenti da buoni stimatori

?morley
data(morley)

# assumiamo una distribuzione normale
# le stime dei momenti dei parametri sono
# mu_hat = sum x_i/n
# sigma2_hat = sum (x_i- mu_hat)/n

mu_hat      = mean(morley$Speed)
sigma2_hat  = sum((morley$Speed-mu_hat)^2)/length(morley$Speed)

# plot
xseq = seq(min(morley$Speed),max(morley$Speed), length.out=100)

hist(morley$Speed, freq=F)
lines(density(morley$Speed), lwd=2)
# densità normal con parametri stimati
lines(xseq, dnorm(xseq,mu_hat,sigma2_hat^0.5 ), col=2, lwd=3)


## ipotizziamo invece che i dati siano Gamma
# le stime dei momenti dei parametri sono
# a_hat = (sum x_i/n)^2/(sum (x_i- x_bar)/n)
# b_hat = (sum x_i/n)/(sum (x_i- x_bar)/n)

a_hat = mean(morley$Speed)^2/( sum((morley$Speed-mean(morley$Speed))^2)/length(morley$Speed)  )
b_hat = mean(morley$Speed)/( sum((morley$Speed-mean(morley$Speed))^2)/length(morley$Speed)  )

hist(morley$Speed, freq=F)
lines(density(morley$Speed), lwd=2)
# densità gamma con parametri stimati
# ?dgamma
lines(xseq, dgamma(xseq,shape=a_hat,rate = b_hat ), col=3, lwd=3)

# mettiamo insieme le due stime
hist(morley$Speed, freq=F)
lines(density(morley$Speed), lwd=2)
# densità normal con parametri stimati
lines(xseq, dnorm(xseq,mu_hat,sigma2_hat^0.5 ), col=2, lwd=3)
lines(xseq, dgamma(xseq,shape=a_hat,rate = b_hat ), col=3, lwd=3)
legend("topleft", c("normale","gamma"), col=2:3, lwd=2)

# testiamo anche la soluzione esponenziale
# anche se non è adatta a questi dati
# lo stimatore è lambda_hat = 1/x_bar

lambda_hat = 1/mean(morley$Speed)

hist(morley$Speed, freq=F)
lines(density(morley$Speed), lwd=2)
# densità esponenziale con parametri stimati
lines(xseq, dexp(xseq,lambda_hat), col=2, lwd=3)

# un caso in cui l'esponenziale potrebbe essere utile
# e se fossimo interessati al solo valore assoluto
# della differenze di temperature
# negli anni

data(nhtemp)
diff_temp = abs(diff(nhtemp)) # equivalente a diff_temp = nhtemp[-1]-nhtemp[-length(nhtemp)]

lambda_hat_temp = 1/mean(diff_temp)
xseq_temp = seq(0,max(diff_temp), length.out=100)
hist(diff_temp, freq=F, ylim=c(0,1))
lines(density(diff_temp), lwd=2)
# densità esponenziale con parametri stimati
lines(xseq_temp, dexp(xseq_temp,lambda_hat_temp), col=2, lwd=3)


#### #### #### #### #### ####
#### Chunk massima verosimiglianza
#### #### #### #### #### ####

##### Caso normale
# similiamo dei dati da una Normale
n = 100
mu = 10
sigma2=1

x = rnorm(n,mu, sigma2^0.5)

# facciamo un instogramma
hist(x, freq=F, ylim=c(0,0.5))
# gli aggiungiamo la stima di densità
lines(density(x))
# e la densità vera
lines(seq(0,50, by=0.2),dnorm(seq(0,50, by=0.2),mu, sigma2^0.5), col=2)
# e mettere i punti osservati
points(x,rep(0,n), pch=1, cex=1.5)

## stimiamo la media con la (log)-massimaverosimiglianza
muvec = seq(0,20, by=0.01)
Veros = data.frame(mu=muvec, densi = NA )
for(i in 1:length(muvec))
{
  mutest = Veros[i,1]
  Veros[i,2] = (sum(dnorm(x,mutest, sigma2^0.5, log=T)))
}
plot(Veros[,1],Veros[,2], type="l")
# oppure la verosimiglianza
plot(Veros[,1],exp(Veros[,2]), type="l")
# troviamo il dove viene raggiunto il massimo
Veros[which.max(Veros[,2]),1]
# e vediamo che è molto vicino al valore vero.


# Vediamo come si calcola la verosimiglianza per particolari valori di mu
#provate anceh mutest = 10, 11, o 20
mutest = 9

# questo vi fa vedere quanto vale la densità di goni singola osservazione
# se i dati provenissero veramente da una normal con quella media.
VecDensity = dnorm(x,mutest, sigma2^0.5, log=F)
# e facciamo il plot
par(mfrow=c(1,2))
plot(seq(0,20, by=0.2),dnorm(seq(0,20, by=0.2),mutest, sigma2^0.5), col=1, type="l")
points(x,rep(0,n), pch=1, cex=1.5)
plot(VecDensity, main="Valori della densità univariata")

#### #### #### #### #### ####
#### Chunk verosimiglianza N(mu, sigma2)
#### #### #### #### #### ####

x = rnorm(1000,2,1)

muvec = seq(-0,4, length=200)
sigma2vec = seq(0.1,2, length=100)
MatLike = matrix(NA, nrow = length(muvec), ncol = length(sigma2vec))
for(imu in 1:length(muvec))
{
	for(is  in 1:length(sigma2vec))
	{
		mutest = muvec[imu]
		sigma2test = sigma2vec[is]
		MatLike[imu, is] = sum(dnorm(x,mutest,sigma2test^0.5, log=T ))
		
		
	}	
}
bb = quantile(c(MatLike), probs= seq(0,1,length.out=22))
image(muvec, sigma2vec, MatLike,breaks = bb , col = rev(terrain.colors(length(bb)-1)))
abline(h = 1)
abline(h = 2)


plot(muvec,MatLike[,3])
lines(muvec,MatLike[,1], col=2)
lines(muvec,MatLike[,2], col=3)
MatLike[,1]/MatLike[,3]

plot(sigma2vec,MatLike[100,], type="l")
lines(sigma2vec,MatLike[2,], col=2)
lines(sigma2vec,MatLike[30,], col=3)
MatLike[1,]/MatLike[3,]

#plot(MatLike[60,])

#### #### #### #### #### ####
#### Chunk ottimizzazione della massima verosimiglianza
#### #### #### #### #### ####

# ipotizziamo di avere dati da una N(mu,1) e di voler
# trovare lo stimatore di massima verosimiglianza di
# mu numericamente

# simuliamo idati da una normale con media 1
x = rnorm(1000,10,1)
# dobbiamo definire una funzione che calcola la log-verosimiglianza per un dato valore di mu
# la funzione optim che useremo chiede una funzione da minimizzare,
# quindi cambiamo il segno della log-verosimiglianza
logver = function(mu)
{
  return(-sum( dnorm(x,mu,1, log=T) ))
}

optim(0,logver)
# come vedete la soluzione è molto vicina al valore vero

### Esempio 2
# riprendiamo il dataset birth
data(birth)
summary(birth)

# assumiamo l'altezza dei bambini alla nascita sia
# G(a,b) e troviamo gli stimatori di a e b

# come prima dobbiamo definire la funzione che calcola la lo-verosimiglianza,
# e, siccome optim funziona megli quando le variabili sono in R, invece di a e b massimizziamo
# per log(a) e log(b)

logver = function(par)
{
  return(sum( -dgamma(birth$Height, shape=exp(par[1]), rate = exp(par[2]), log=T))   )
}

par_op = optim(c(0,0),logver)
a = exp(par_op$par[1])
b = exp(par_op$par[2])

# verifichiamo se i risultati hanno senso
# e conforntiamoli anche con lo stimatore dei
# momenti

a_hat_mom = mean(birth$Height)^2/( sum((birth$Height-mean(birth$Height))^2)/length(birth$Height)  )
b_hat_mom = mean(birth$Height)/( sum((birth$Height-mean(birth$Height))^2)/length(birth$Height)  )


seqx = seq(min(birth$Height), max(birth$Height), length.out=100)
hist(birth$Height, freq=F)
lines(density(birth$Height), col=1, lwd=3)
lines(seqx,dgamma(seqx,shape=a, rate=b), col=2, lwd=3)
lines(seqx,dgamma(seqx,shape=a_hat_mom, rate=b_hat_mom), col=3, lwd=3)

# lo stimatore dei momenti e MLE sono molto simile,
# ma con delle differenze
# Quello che si vede è anche che la gamma non riesce
# a modellare bene i dati
