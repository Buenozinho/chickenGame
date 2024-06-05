:-dynamic local_duda/1.
:-dynamic duda_possui/1.
:-dynamic altar_de_sacrifício/1.
acessivel(pátio,lagoa).
acessivel(pátio,casa).
acessivel(pátio,floresta).
acessivel(pátio,galinheiro).
acessivel(pátio,terreiro_de_macumba).
acessivel(lagoa,pátio).
acessivel(casa,pátio).
acessivel(floresta,pátio).
acessivel(galinheiro,pátio).
acessivel(terreiro_de_macumba,pátio).
local_duda(pátio).
duda_possui(vazio).
altar_de_sacrifício(vazio).

% controla pra onde a duda ira se mover %
ir_para(X):- X == casa, acessivel(X,Y), not(local_duda(pátio)), not(local_duda(casa)), write("vccc precisa ir para o pátio primeiro"),nl.
ir_para(X):- X == pátio, local_duda(pátio), write("voce ja está no pátio "),nl.
ir_para(X):- X == lagoa, local_duda(lagoa), write("voce ja está na lagoa "),nl.
ir_para(X):- X == floresta, local_duda(floresta), write("voce ja está na floresta "),nl.
ir_para(X):- X == galinheiro, local_duda(galinheiro), write("voce ja está no galinheiro "),nl.
ir_para(X):- X == casa, local_duda(casa), write("voce ja está na casa "),nl.
ir_para(X):- X == terreiro_de_macumba, local_duda(terreiro_de_macumba), write("voce ja está no terreiro_de_macumba "),nl.
ir_para(X):- X == casa, acessivel(X,Y), not(duda_possui(banho)), write("voce precisa tomar banho para entrar na casa "),nl.
ir_para(X):- X == casa, acessivel(X,Y), (duda_possui(banho)), retract(local_duda(Y)),assert(local_duda(X)),write("voce está no lugar "),write(X),nl.
ir_para(X):- X \== casa, acessivel(X,Y), retract(local_duda(Y)),assert(local_duda(X)),write("voce está no lugar "),write(X),nl.
ir_para(X):- X \== casa, not(acessivel(X,Y)), write("Esse lugar e invalido "),nl.
ir_para(X):- X \== casa, not(acessivel(pátio,pátio)), write("vc precisa ir para o pátio primeiro "),nl.

% para fazer duda pegar o banho %
pegar(X):- X \== banho,X \== rede,X \== bessy,X \== faca,X \== farofa, write("Esse item não existe "),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(banho), write("voce já tomou banho "),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(rede), retract(duda_possui(rede)),assert(duda_possui(banho)),write("voce tomou banho"),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(bessy), write("voce nao pode tomar banho novamente porque a bessy vai fugir "),nl.
pegar(X):- X == banho, local_duda(lagoa), duda_possui(faca), retract(duda_possui(faca)),assert(duda_possui(banho)),write("voce tomou banho"),nl.
pegar(X):- X == banho, local_duda(lagoa), retract(duda_possui(vazio)),assert(duda_possui(banho)), write("voce tomou banho"),nl.
pegar(X):- X == banho, not(local_duda(lagoa)), write("voce precisa estar na lagoa para tomar banho "),nl.

% pegar a rede %
pegar(X):- X == rede, local_duda(casa), duda_possui(rede), write("voce já pegou a rede "),nl.
pegar(X):- X == rede, local_duda(casa), duda_possui(bessy), write("voce nao pode tomar banho novamente porque a bessy vai fugir "),nl.
pegar(X):- X == rede, local_duda(casa), duda_possui(faca), retract(duda_possui(faca)),assert(duda_possui(banho)),write("voce pegou a rede"),nl.
pegar(X):- X == rede, local_duda(casa), retract(duda_possui(banho)),assert(duda_possui(rede)), write("voce pegou a rede"),nl.
pegar(X):- X == rede, not(local_duda(casa)), write("voce precisa estar na casa para pegar a rede "),nl.

% para fazer duda pegar a bessy %
pegar(X):- X == bessy, local_duda(floresta), duda_possui(bessy), write("voce já pegou a bessy "),nl.
pegar(X):- X == bessy, local_duda(floresta), not(duda_possui(rede)), write("voce nao tem a rede "),nl.
pegar(X):- X == bessy, local_duda(floresta), retract(duda_possui(rede)),assert(duda_possui(bessy)), write("voce pegou a bessy"),nl.
pegar(X):- X == bessy, not(local_duda(floresta)), write("você precisa estar na floresta para pegar a bessy "),nl.

% para fazer duda pegar a faca %
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(banho),retract(duda_possui(banho)),assert(duda_possui(faca)), write("voce pegou a faca "),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(rede), retract(duda_possui(rede)),assert(duda_possui(faca)),write("voce pegou a faca"),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(faca), write("voce já esta com a faca "),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), duda_possui(bessy), write("voce nao pode pegar a faca porque a bessy vai fugir "),nl.
pegar(X):- X == faca, local_duda(terreiro_de_macumba), retract(duda_possui(vazio)),assert(duda_possui(faca)), write("voce pegou a faca"),nl.
pegar(X):- X == faca, not(local_duda(terreiro_de_macumba)), write("você precisa estar no terreiro de macumba para pegar a faca "),nl.

% controla o que a duda vai colocar no altar de sacrificio &
colocar(X):- X \== bessy, write("Você não pode colocar isso aqui "),nl.
colocar(X):- X == bessy, local_duda(terreiro_de_macumba),retract(duda_possui(bessy)),assert(duda_possui(vazio)),assert(altar_de_sacrifício(bessy)), write("voce colocou a bessy no altar de sacrfício "),nl.
colocar(X):- X == bessy, not(local_duda(terreiro_de_macumba)),not(duda_possui(bessy)),write("voce precisa estar no terreiro de macumba para colocar a bessy no altar"),nl.

% WOLOLO comando pra inicia o ritual %
iniciar_ritual(X):- X == wololo , not(local_duda(terreiro_de_macumba)),not(duda_possui(faca)),not(altar_de_sacrifício(bessy)),write("Todos os requisitos pro ritual não foram atendidos. Certifique-se de ter a faca, bessy no altar, e estar no terreiro."),nl.
iniciar_ritual(X):- X == wololo , local_duda(terreiro_de_macumba),not(duda_possui(faca)),not(altar_de_sacrifício(bessy)),write("Todos os requisitos pro ritual não foram atendidos. Certifique-se de ter a faca, bessy no altar, e estar no terreiro."),nl.
iniciar_ritual(X):- X == wololo , local_duda(terreiro_de_macumba),not(duda_possui(faca)),(altar_de_sacrifício(bessy)),write("Todos os requisitos pro ritual não foram atendidos. Certifique-se de ter a faca, bessy no altar, e estar no terreiro."),nl.

iniciar_ritual(X):- X == wololo , local_duda(terreiro_de_macumba),duda_possui(faca),altar_de_sacrifício(bessy),assert(duda_possui(macumba)),write("WOOOOWOOOOWOOOOOWOWWWOOWOWOWOOOO "),nl.
iniciar_ritual(X):- X \== wololo , write("Você não pronunciou as palavras corretas"), nl.

% condições pra finalizar o jogo %
finalizado :- (local_duda(terreiro_de_macumba),duda_possui(macumba)),write("você fez uma macumba braba e nisso fez o professor dar 10 no trabalho!!!!"),nl.
finalizado :- (local_duda(galinheiro),duda_possui(bessy)),write('você colocou a bessy no galinheiro'),nl.
rodar:- finalizado,write("você acabou o jogo"),nl.
rodar:- read(X), call(X),rodar.
