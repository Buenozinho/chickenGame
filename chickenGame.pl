:-dynamic local_duda/1.
:-dynamic duda_possui/1.
:-dynamic altar_de_sacrif�cio/1.
acessivel(p�tio,lagoa).
acessivel(p�tio,casa).
acessivel(p�tio,floresta).
acessivel(p�tio,galinheiro).
acessivel(p�tio,terreiro_de_macumba).
acessivel(lagoa,p�tio).
acessivel(casa,p�tio).
acessivel(floresta,p�tio).
acessivel(galinheiro,p�tio).
acessivel(terreiro_de_macumba,p�tio).
local_duda(p�tio).
duda_possui(vazio).
altar_de_sacrif�cio(vazio).

% controla pra onde a duda ira se mover %
ir_para(X):- X == casa, acessivel(X,Y), not(local_duda(p�tio)), not(local_duda(casa)), write("vccc precisa ir para o p�tio primeiro"),nl.
ir_para(X):- X == p�tio, local_duda(p�tio), write("voce ja est� no p�tio "),nl.
ir_para(X):- X == lagoa, local_duda(lagoa), write("voce ja est� na lagoa "),nl.
ir_para(X):- X == floresta, local_duda(floresta), write("voce ja est� na floresta "),nl.
ir_para(X):- X == galinheiro, local_duda(galinheiro), write("voce ja est� no galinheiro "),nl.
ir_para(X):- X == casa, local_duda(casa), write("voce ja est� na casa "),nl.
ir_para(X):- X == terreiro_de_macumba, local_duda(terreiro_de_macumba), write("voce ja est� no terreiro_de_macumba "),nl.
ir_para(X):- X == casa, acessivel(X,Y), not(duda_possui(banho)), write("voce precisa tomar banho para entrar na casa "),nl.
ir_para(X):- X == casa, acessivel(X,Y), (duda_possui(banho)), retract(local_duda(Y)),assert(local_duda(X)),write("voce est� no lugar "),write(X),nl.
ir_para(X):- X \== casa, acessivel(X,Y), retract(local_duda(Y)),assert(local_duda(X)),write("voce est� no lugar "),write(X),nl.
ir_para(X):- X \== casa, not(acessivel(X,Y)), write("Esse lugar e invalido "),nl.
ir_para(X):- X \== casa, not(acessivel(p�tio,p�tio)), write("vc precisa ir para o p�tio primeiro "),nl.

% para fazer duda pegar o banho %
pegar(X):- X \== banho,X \== rede,X \== bessy,X \== faca,X \== farofa, write("Esse item n�o existe "),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(banho), write("voce j� tomou banho "),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(rede), retract(duda_possui(rede)),assert(duda_possui(banho)),write("voce tomou banho"),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(bessy), write("voce nao pode tomar banho novamente porque a bessy vai fugir "),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(faca), retract(duda_possui(faca)),assert(duda_possui(banho)),write("voce tomou banho"),nl.
pegar(X):- X == banho, local_duda(lagoa), retract(duda_possui(vazio)),assert(duda_possui(banho)), write("voce tomou banho"),nl.
pegar(X):- X == banho, not(local_duda(lagoa)), write("voce precisa estar na lagoa para tomar banho "),nl.

% pegar a rede %
pegar(X):- X == rede, local_duda(casa), duda_possui(rede), write("voce j� pegou a rede "),nl.
pegar(X):- X == rede, local_duda(casa), duda_possui(bessy), write("voce nao pode tomar banho novamente porque a bessy vai fugir "),nl.
pegar(X):- X == rede, local_duda(casa), duda_possui(faca), retract(duda_possui(faca)),assert(duda_possui(banho)),write("voce pegou a rede"),nl.
pegar(X):- X == rede, local_duda(casa), retract(duda_possui(banho)),assert(duda_possui(rede)), write("voce pegou a rede"),nl.
pegar(X):- X == rede, not(local_duda(casa)), write("voce precisa estar na casa para pegar a rede "),nl.

% para fazer duda pegar a bessy %
pegar(X):- X == bessy, local_duda(floresta), duda_possui(bessy), write("voce j� pegou a bessy "),nl.
pegar(X):- X == bessy, local_duda(floresta), not(duda_possui(rede)), write("voce nao tem a rede "),nl.
pegar(X):- X == bessy, local_duda(floresta), retract(duda_possui(rede)),assert(duda_possui(bessy)), write("voce pegou a bessy"),nl.
pegar(X):- X == bessy, not(local_duda(floresta)), write("voc� precisa estar na floresta para pegar a bessy "),nl.

% para fazer duda pegar a faca %
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(banho),retract(duda_possui(banho)),assert(duda_possui(faca)), write("voce pegou a faca "),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(rede), retract(duda_possui(rede)),assert(duda_possui(faca)),write("voce pegou a faca"),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(faca), write("voce j� esta com a faca "),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(bessy), write("voce nao pode pegar a faca porque a bessy vai fugir "),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), retract(duda_possui(vazio)),assert(duda_possui(faca)), write("voce pegou a faca"),nl.
pegar(X):- X == faca, not(local_duda(terreiro_de_macumba)), write("voc� precisa estar no terreiro de macumba para pegar a faca "),nl.

% controla o que a duda vai colocar no altar de sacrificio &
colocar(X):- X \== bessy, write("Voc� n�o pode colocar isso aqui "),nl.
colocar(X):- X == bessy, local_duda(terreiro_de_macumba),retract(duda_possui(bessy)),assert(duda_possui(vazio)),assert(altar_de_sacrif�cio(bessy)), write("voce colocou a bessy no altar de sacrf�cio "),nl.
colocar(X):- X == bessy, not(local_duda(terreiro_de_macumba)),not(duda_possui(bessy)),write("voce precisa estar no terreiro de macumba para colocar a bessy no altar"),nl.

% WOLOLO comando pra inicia o ritual %
iniciar_ritual(X):- X == wololo , not(local_duda(terreiro_de_macumba)),not(duda_possui(faca)),not(altar_de_sacrif�cio(bessy)),write("Todos os requisitos pro ritual n�o foram atendidos. Certifique-se de ter a faca, bessy no altar, e estar no terreiro."),nl.
iniciar_ritual(X):- X == wololo , local_duda(terreiro_de_macumba),not(duda_possui(faca)),not(altar_de_sacrif�cio(bessy)),write("Todos os requisitos pro ritual n�o foram atendidos. Certifique-se de ter a faca, bessy no altar, e estar no terreiro."),nl.
iniciar_ritual(X):- X == wololo , local_duda(terreiro_de_macumba),not(duda_possui(faca)),(altar_de_sacrif�cio(bessy)),write("Todos os requisitos pro ritual n�o foram atendidos. Certifique-se de ter a faca, bessy no altar, e estar no terreiro."),nl.

iniciar_ritual(X):- X == wololo , local_duda(terreiro_de_macumba),duda_possui(faca),altar_de_sacrif�cio(bessy),assert(duda_possui(macumba)),write("WOOOOWOOOOWOOOOOWOWWWOOWOWOWOOOO "),nl.
iniciar_ritual(X):- X \== wololo , write("Voc� n�o pronunciou as palavras corretas"), nl.

% condi��es pra finalizar o jogo %
finalizado :- (local_duda(terreiro_de_macumba),duda_possui(macumba)),write("voc� fez uma macumba braba e nisso fez o professor dar 10 no trabalho!!!!"),nl.
finalizado :- (local_duda(galinheiro),duda_possui(bessy)),write('voc� colocou a bessy no galinheiro'),nl.
rodar:- finalizado,write("voc� acabou o jogo"),nl.
rodar:- read(X), call(X),rodar.
