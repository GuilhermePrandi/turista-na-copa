% Fatos
camisa(amarela).
camisa(azul).
camisa(branca).
camisa(verde).
camisa(vermelha).

nacionalidade(alemao).
nacionalidade(croata).
nacionalidade(espanhol).
nacionalidade(frances).
nacionalidade(italiano).

bebida(agua).
bebida(cafe).
bebida(cha).
bebida(cerveja).
bebida(leite).

dias(10).
dias(15).
dias(20).
dias(25).
dias(30).

idade(28).
idade(31).
idade(36).
idade(45).
idade(57).

companhia(amigo).
companhia(filho).
companhia(irma).
companhia(esposa).
companhia(namorada).

% Regras auxiliares

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X, Lista) :- last(Lista, X).
noCanto(X, [X|_]).

%X está à ao lado de Y
aoLado(X, Y, Lista) :- nextto(X, Y, Lista); nextto(Y, X, Lista).

%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X, Y, Lista) :- nth0(Ix, Lista, X), nth0(Iy, Lista, Y), Ix < Iy.

%X está à direita de Y (em qualquer posição à direita)
aDireita(X, Y, Lista) :- aEsquerda(Y, X, Lista).

% Para verificar se os atributos tem valor diferente
todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

% Estrutura: turista(Camisa, Nacionalidade, Bebida, Dias, Idade, Companhia)
solucao(Lista) :-
    Lista = [
        turista(Camiseta1, Nacionalidade1, Bebida1, Dias1, Idade1, Companhia1),
        turista(Camiseta2, Nacionalidade2, Bebida2, Dias2, Idade2, Companhia2),
        turista(Camiseta3, Nacionalidade3, Bebida3, Dias3, Idade3, Companhia3),
        turista(Camiseta4, Nacionalidade4, Bebida4, Dias4, Idade4, Companhia4),
        turista(Camiseta5, Nacionalidade5, Bebida5, Dias5, Idade5, Companhia5)
    ],

    % Regras
    % 1. Na primeira posição está quem ficará 15 dias no Brasil.
    Lista = [turista(_, _, _, 15, _, _) | _],

    % 2. O turista da camisa Verde está em algum lugar entre quem gosta de Água e o Croata, nessa ordem.
    aEsquerda(turista(_, _, agua, _, _, _), turista(verde, _, _, _, _, _), Lista),
    aEsquerda(turista(verde, _, _, _, _, _), turista(_, croata, _, _, _, _), Lista),

    % 3. O Alemão está acompanhado do Filho.
    member(turista(_, alemao, _, _, _, filho), Lista),

    % 4. O Espanhol é o turista mais velho.
    member(turista(_, espanhol, _, _, 57, _), Lista),

    % 5. O turista de 45 anos está exatamente à direita do turista de 31 anos.
    nextto(turista(_, _, _, _, 31, _), turista(_, _, _, _, 45, _), Lista),

    % 6. O Alemão está exatamente à esquerda do turista de Vermelho.
    nextto(turista(_, alemao, _, _, _, _), turista(vermelha, _, _, _, _, _), Lista),

    % 7. O turista de 36 anos está exatamente à esquerda do que gosta de Leite.
    nextto(turista(_, _, _, _, 36, _), turista(_, _, leite, _, _, _), Lista),

    % 8. O turista do meio está acompanhado do Amigo.
    Lista = [_, _, turista(_, _, _, _, _, amigo), _, _],

    % 9. O turista de Azul está ao lado do que ficará 10 dias.
    aoLado(turista(azul, _, _, _, _, _), turista(_, _, _, 10, _, _), Lista),

    % 10. O Italiano está na terceira posição.
    Lista = [_, _, turista(_, italiano, _, _, _, _), _, _],

    % 11. O Alemão está ao lado do turista que ficará 20 dias.
    aoLado(turista(_, alemao, _, _, _, _), turista(_, _, _, 20, _, _), Lista),

    % 12. O turista de 28 anos está exatamente à direita do que ficará 25 dias.
    nextto(turista(_, _, _, 25, _, _), turista(_, _, _, _, 28, _), Lista),

    % 13. O de Verde está entre o Espanhol e o de Branco, nessa ordem.
    aEsquerda(turista(_, espanhol, _, _, _, _), turista(verde, _, _, _, _, _), Lista),
    aEsquerda(turista(verde, _, _, _, _, _), turista(branca, _, _, _, _, _), Lista),

    % 14. Quem gosta de Chá está à esquerda de quem veio com o Amigo.
    aEsquerda(turista(_, _, cha, _, _, _), turista(_, _, _, _, _, amigo), Lista),

    % 15. Na última posição está o que veio com a Namorada.
    last(Lista, turista(_, _, _, _, _, namorada)),

    % 16. Quem está com a Esposa está ao lado de quem ficará 20 dias.
    aoLado(turista(_, _, _, _, _, esposa), turista(_, _, _, 20, _, _), Lista),

    % 17. O que veio com a Esposa está à esquerda de quem gosta de Leite.
    aEsquerda(turista(_, _, _, _, _, esposa), turista(_, _, leite, _, _, _), Lista),

    % 18. Camisas amarela e vermelha estão lado a lado.
    aoLado(turista(amarela, _, _, _, _, _), turista(vermelha, _, _, _, _, _), Lista),

    % 19. O turista de 31 anos veio com o Amigo.
    member(turista(_, _, _, _, 31, amigo), Lista),
    
    % 20. O turista que gosta de Café está na quinta posição.
	Lista = [_, _, _, _, turista(_, _, cafe, _, _, _)],


    % Todos diferentes
    camisa(Camiseta1), camisa(Camiseta2), camisa(Camiseta3), camisa(Camiseta4), camisa(Camiseta5),
    todosDiferentes([Camiseta1, Camiseta2, Camiseta3, Camiseta4, Camiseta5]),

    nacionalidade(Nacionalidade1), nacionalidade(Nacionalidade2), nacionalidade(Nacionalidade3), nacionalidade(Nacionalidade4), nacionalidade(Nacionalidade5),
    todosDiferentes([Nacionalidade1, Nacionalidade2, Nacionalidade3, Nacionalidade4, Nacionalidade5]),

    bebida(Bebida1), bebida(Bebida2), bebida(Bebida3), bebida(Bebida4), bebida(Bebida5),
    todosDiferentes([Bebida1, Bebida2, Bebida3, Bebida4, Bebida5]),

    dias(Dias1), dias(Dias2), dias(Dias3), dias(Dias4), dias(Dias5),
    todosDiferentes([Dias1, Dias2, Dias3, Dias4, Dias5]),

    idade(Idade1), idade(Idade2), idade(Idade3), idade(Idade4), idade(Idade5),
    todosDiferentes([Idade1, Idade2, Idade3, Idade4, Idade5]),

    companhia(Companhia1), companhia(Companhia2), companhia(Companhia3), companhia(Companhia4), companhia(Companhia5),
    todosDiferentes([Companhia1, Companhia2, Companhia3, Companhia4, Companhia5]).

