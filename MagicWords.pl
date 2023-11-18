% Ce prédicat est vrai lorsque W est un mot et l'imprime.
print_word(word([])) :-
    write('e'),
    nl.
print_word(word(List)) :-
    print_list(List).


% Prédicat auxiliaire pour imprimer les éléments d'une liste.
print_list([]) :-
    nl.  % Nouvelle ligne après la fin de la liste.


print_list([H|T]) :-
    write(H),  % Imprime l'élément de tête.
    print_list(T).  % Appel récursif avec le reste de la liste.


% Ce prédicat est vrai lorsque _lst est une liste de mots et l'imprime, avec un mot par ligne.
print_word_list([]).
print_word_list([H|T]) :-
    print_word(H),
    print_word_list(T).



% Ce prédicat est vrai lorsque _rule est une règle et l'imprime.
print_rule(rule(Word1,Word2)) :-
    print_word(Word1),
    write('->'),
    print_word(Word2).




% Ce prédicat est vrai lorsque _rule_set est un ensemble de règles et l'imprime, avec une règle par ligne.
print_rule_set(rule_set([])).
print_rule_set(rule_set([H|T])) :-
    print_rule(H),
    nl,
    print_rule_set(rule_set(T)).


% Ce prédicat est vrai lorsque le terme _puzzle est une instance de casse-tête et l'imprime.
print_puzzle(puzzle(rule_set(RULE_SET)) , word(WORD)) :-
    print_rule_set(rule_set(RULE_SET)),
    print_word(word(WORD)).
   
   
   



% Prédicat principal (main)
main :-

    % Appeler print_word avec différents mots
    % print_word(word([1, 2, 1, 1])).
    % print_word(word([1, 2, 3, 4])),
    % print_word(word([2, 1])),
    % nl,
    % print_word_list([word([1, 2, 1, 1]),word([1, 2, 3, 4]),word([2, 1])]).

    % nl,
    % print_rule(rule(word([1,2]),word([2,1,2]))).
    % nl.

    print_rule_set(rule_set(
        [rule(word([1, 1]), word([1])),
        rule(word([1, 2]), word([2, 1, 2])),
        rule(word([2, 1]), word([]))]) ),
        
    print_puzzle( puzzle( rule_set(
        [rule(word([1, 1]), word([1])),
        rule(word([1, 2]), word([2, 1, 2])),
        rule(word([2, 1]), word([]))]) ) ,  word([1, 2, 1, 1]) ).
       
    
       
   
   
   

% Exécution automatique de main au démarrage.
:- main.

