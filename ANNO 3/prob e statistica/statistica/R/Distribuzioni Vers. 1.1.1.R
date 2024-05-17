#### #### #### #### #### #### #### ####
####        Gianluca Mastrantonio
####        corso di Probabilit+ e Statistica
####        Codice R su "Introduzione al corso e Distribuzioni"
####        Vers 1.1.1
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
#### Chunk comandi sulle distribuzioni
#### #### #### ####

# ci sono dei comandi standard su R per ottenere il calcolo
# della densità/probabilità (d), comulata (p), quantile (q)  e ottenere dei
# valori da una distribuzione prefissata (r)
# per esempio, per una normale possiamo usare
# dnorm(), pnorm(), qnorm(), rnorm()
?dnorm
# per l'esponenziale dexp(), pexp(), qexp(), rexp()
?dexp
# per la poisson dpois(), ppois(), qpois(), rpois()
?dpois


# I comandi qui sotto e fino alla fine di questo chunk del codice servono solo a far vedere cosa
# calcolano queste funzioni nel caso di una normale standard.
# Lanciateli e vedete la figura che producono

z_scores <- seq(-4, 4, by = 0.01)
mu <- 0
sd <- 1


#Functions
##Using `dnorm` and `pnorm` to setup the "skeleton" of related plots.
normal_dists <- list(`dnorm()` = ~ dnorm(., mu, sd),
  `rnorm()` = ~ dnorm(., mu, sd),
  `pnorm()` = ~ pnorm(., mu, sd),
  `qnorm()` = ~ pnorm(., mu, sd))

##Apply functions to data and parameter combinations
df <- tibble(z_scores, mu, sd) %>%
  mutate_at(.vars = vars(z_scores), .funs = normal_dists) %>%
  #"Lengthen" the data
  pivot_longer(cols = -c(z_scores, mu, sd), names_to = "func",
    values_to = "prob") %>%
  #Categorize based on shape of distribution -- need to split up the dataframe
  # for plotting later.
  mutate(distribution = ifelse(func == "pnorm()" | func == "qnorm()",
    "Cumulative probability", "Probability density"))

##Split up the data into different pieces that can then be added to a plot.
###Probabilitiy density distrubitions
df_pdf <- df %>%
  filter(distribution == "Probability density") %>%
  rename(`Probabilitiy density` = prob)

###Cumulative density distributions
df_cdf <- df %>%
  filter(distribution == "Cumulative probability") %>%
  rename(`Cumulative probability` = prob)

###dnorm segments
  #Need to make lines that represent examples of how values are mapped -- there
  # is probably a better way to do this, but quick and dirty is fine for now.
df_dnorm <- tibble(z_start.line_1 = c(-1.5, -0.75, 0.5),
  pd_start.line_1 = 0) %>%
  mutate(z_end.line_1 = z_start.line_1,
    pd_end.line_1 = dnorm(z_end.line_1, mu, sd),
    z_start.line_2 = z_end.line_1,
    pd_start.line_2 = pd_end.line_1,
    z_end.line_2 = min(z_scores),
    pd_end.line_2 = pd_start.line_2,
    id = 1:n()) %>%
  pivot_longer(-id) %>%
  separate(name, into = c("source", "line"), sep = "\\.") %>%
  pivot_wider(id_cols = c(id, line), names_from = source) %>%
  mutate(func = "dnorm()",
    size = ifelse(line == "line_1", 0, 0.03))

###rnorm segments
  #Make it reproducible
set.seed(20200209)
df_rnorm <- tibble(z_start = rnorm(10, mu, sd)) %>%
  mutate(pd_start = dnorm(z_start, mu, sd),
    z_end = z_start,
    pd_end = 0,
    func = "rnorm()")

###pnorm segments
df_pnorm <- tibble(z_start.line_1 = c(-1.5, -0.75, 0.5),
  pd_start.line_1 = 0) %>%
  mutate(z_end.line_1 = z_start.line_1,
    pd_end.line_1 = pnorm(z_end.line_1, mu, sd),
    z_start.line_2 = z_end.line_1,
    pd_start.line_2 = pd_end.line_1,
    z_end.line_2 = min(z_scores),
    pd_end.line_2 = pd_start.line_2,
    id = 1:n()) %>%
  pivot_longer(-id) %>%
  separate(name, into = c("source", "line"), sep = "\\.") %>%
  pivot_wider(id_cols = c(id, line), names_from = source) %>%
  mutate(func = "pnorm()",
    size = ifelse(line == "line_1", 0, 0.03))

###qnorm segments
df_qnorm <- tibble(z_start.line_1 = min(z_scores),
  pd_start.line_1 = c(0.1, 0.45, 0.85)) %>%
  mutate(z_end.line_1 = qnorm(pd_start.line_1),
    pd_end.line_1 = pd_start.line_1,
    z_start.line_2 = z_end.line_1,
    pd_start.line_2 = pd_end.line_1,
    z_end.line_2 = z_end.line_1,
    pd_end.line_2 = 0,
    id = 1:n()) %>%
  pivot_longer(-id) %>%
  separate(name, into = c("source", "line"), sep = "\\.") %>%
  pivot_wider(id_cols = c(id, line), names_from = source) %>%
  mutate(func = "qnorm()",
    size = ifelse(line == "line_1", 0, 0.03))

    cp <- paletteer_d("ggsci::default_locuszoom", 4, )
    names(cp) <- c("dnorm()", "rnorm()", "pnorm()", "qnorm()")

    ##Probabilitiy density
    p_pdf <- df_pdf %>%
      ggplot(aes(z_scores, `Probabilitiy density`)) +
      geom_segment(data = df_dnorm,
        aes(z_start, pd_start, xend = z_end, yend = pd_end),
        arrow = arrow(length = unit(df_dnorm$size, "npc"), type = "closed"),
        size = 0.8, color = cp["dnorm()"]) +
      geom_segment(data = df_rnorm,
        aes(z_start, pd_start, xend = z_end, yend = pd_end),
        arrow = arrow(length = unit(0.03, "npc"), type = "closed"),
        size = 0.8, color = cp["rnorm()"]) +
      geom_line(size = 0.6) +
      facet_wrap(~ func, nrow = 1) +
      theme_bw() +
      theme(panel.grid = element_blank(),
        axis.title.x = element_blank(),
        strip.background = element_blank(),
        text = element_text(family = "serif", size = 14)) +
      scale_y_continuous(expand = expand_scale(c(0, 0.05))) +
      scale_x_continuous(expand = c(0.01, 0))

    ##Cumulative probability
    p_cdf <- df_cdf %>%
      ggplot(aes(z_scores, `Cumulative probability`)) +
      geom_hline(yintercept = 0, color = "grey") +
      geom_segment(data = df_pnorm,
        aes(z_start, pd_start, xend = z_end, yend = pd_end),
        arrow = arrow(length = unit(df_dnorm$size, "npc"), type = "closed"),
        size = 0.8, color = cp["pnorm()"]) +
      geom_segment(data = df_qnorm,
        aes(z_start, pd_start, xend = z_end, yend = pd_end),
        arrow = arrow(length = unit(df_qnorm$size, "npc"), type = "closed"),
        size = 0.8, color = cp["qnorm()"]) +
      geom_line(size = 0.6) +
      facet_wrap(~ func, nrow = 1) +
      labs(x = "z-score/quantiles") +
      theme_bw() +
      theme(panel.grid = element_blank(),
        strip.background = element_blank(),
        text = element_text(family = "serif", size = 14)) +
      scale_x_continuous(expand = c(0.01, 0))

    ##Combine the plots
    p_pdf + p_cdf + plot_layout(ncol = 1)
#### #### #### ####
#### Chunk normale
#### #### #### ####

#### plottiamo densità e funzione di ripartizione
?dnorm

# decidiamo dove valutare la densit�
xseq = seq(-10,10,length=100)

# densit�
plot(xseq , dnorm(xseq, 0,1), type="l")

# plottiamo la densit� della trasformazione Y = mu + sigma X e
# Z = a+bY
# insieme a quella di X
mu    = 0.2
sigma = 2   ## potete testare vari valori
a     = 2   ## di mu, sigma, a, b
b     = 1.5
plot(xseq, dnorm(xseq, 0,1), type="l", ylab = "density")
lines(xseq, dnorm(xseq,mu,sigma), col=2)
lines(xseq, dnorm(xseq,a+b*mu,b*sigma), col=3)


#### #### #### ####
#### Chunk normale multivariata
#### #### #### ####

# vediamo come è fatta una (x,y)' ~ N(mu, Sigma)
mu      = matrix(c(0,2), ncol=1)
Sigma   = matrix(c(1,0.8,0.8,1.2), ncol=2)

# valutiamo la normale su una griglia di valori x e y
nel  = 100
xseq = seq(-3,3,length.out=nel)
yseq = seq(-1,5,length.out=nel)

Dens = matrix(NA, ncol= nel,nrow=nel)
for(i in 1:nel)
{
    for(j in 1:nel)
    {
        Dens[i,j] = dmvnorm(c(xseq[i],yseq[j]),mu, Sigma)
    }
}

##pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni/MultiNorm.#pdf")
image(Dens, x=xseq, y = yseq, asp=1)
contour(Dens, add=T, x=xseq, y = yseq)
##dev.off()

# vediamo le distribuzioni condizionate di x|y
#pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni e campioni/MultiNormCond.pdf")
plot(0,0, xlim= range(xseq), ylim=c(0, 0.64), type="n", ylab="density", xlab="X")
h = 0
ss = seq(20,nel-20, by=10)
for(i in ss)
{
    h = h+1
    lines(xseq,Dens[,i]/sum(Dens[,i]*(xseq[2]-xseq[1])), col=h, lwd=2)
}
legend("topright", paste("y=",round(yseq[ss],2),sep=""), col=1:length(ss), lwd=2)
#dev.off()
# in questa figura ogni "campana" è una distribuzione condizionata di x|y

# settando il valore di y, potrete calcolare la distribuzione condizionata di X|Y=yseq[i]
i = 50
plot(xseq,Dens[,i]/sum(Dens[,i]*(xseq[2]-xseq[1])), main=paste("Distribuzione di X|Y=", round(yseq[i],5),sep=""), type="l")
# provate a vedere cosa succede se definite Sigma come matrice diagonale

#### #### #### ####
#### Chunk chi-quadro
#### #### #### ####

# mostriamo alcune densità della chi-quadro
xseq = seq(0,10, length.out=100)
par = 1:5
##pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni/Chi.#pdf")
plot(xseq,dchisq(xseq,1), type="l", lwd=3, xlab="Y",ylab = "density" )
for(i in par)
{
    lines(xseq,dchisq(xseq,i), type="l", col=i, lwd=3)
}
legend("topright", paste("n=",par,sep=""), col=1:length(par), lwd=3, cex=2)
##dev.off()


#### #### #### ####
#### Chunk T di Student
#### #### #### ####

# mostriamo alcune densità della T di Student
xseq = seq(-10,10, length.out=100)
par = seq(1,5, by=1)
#pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni/Tstudent.#pdf")
plot(xseq,dt(xseq,max(par)), type="l", lwd=3, xlab="Y",ylab = "density" )
h = 0
for(i in par)
{
    h = h+1
    lines(xseq,dt(xseq,i), type="l", col=h, lwd=3)
}
legend("topright", paste("n=",par,sep=""), col=1:length(par), lwd=3, cex=2)
#dev.off()


#pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni e campioni/TstudentNorm.pdf")
plot(xseq,dnorm(xseq), type="l", lwd=3, xlab="Y",ylab = "density" )
lines(xseq,dt(xseq,1), col=2, lwd=3)
lines(xseq,dt(xseq,20), col=3, lwd=3)
lines(xseq,dt(xseq,80), col=4, lwd=3)
legend("topright", c("N(0,1)","T(1)","T(20)","T(80)"), col=1:4, lwd=3, cex=2)
#dev.off()


#### #### #### ####
#### Chunk F di Fisher Snedecor
#### #### #### ####

# mostriamo alcune densità della F di Fisher Snedecor
xseq = seq(0,10, length.out=100)
##pdf("/Users/gianlucamastrantonio/Dropbox (Politecnico di Torino Staff)/didattica/Probabilita e Statistica/dispense/distribuzioni/Ffisher.#pdf")
plot(xseq,df(xseq,1,1), type="l", lwd=3, xlab="Y",ylab = "density" )
lines(xseq,df(xseq,1,10), type="l", col=2, lwd=3)
lines(xseq,df(xseq,10,1), type="l", col=3, lwd=3)
lines(xseq,df(xseq,10,10), type="l", col=4, lwd=3)
legend("topright", c("n1=1 n2=1","n1=1 n2=10","n1=10 n2=1","n1=10 n2=10"), col=1:4, lwd=3, cex=2)
##dev.off()
