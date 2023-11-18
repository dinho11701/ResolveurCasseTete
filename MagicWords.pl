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
    
    
% Ce prédicat est vrai lorsque _path est un chemin et l'imprime.
print_path( path([]) ).
print_path( path(LST) ) :-
    print_word_list(LST).
    


% Ce prédicat est vrai lorsque _lst est une liste de chemins et l'imprime, avec un chemin par ligne.
print_path_list([]).
print_path_list([H|T]) :-
    print_path(H),
    nl,
    print_path_list(T).
    % print_path(path(T)).
    




    
   
   
   

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


    
    /******************************************************************************
    print_rule_set(rule_set(
        [rule(word([1, 1]), word([1])),
        rule(word([1, 2]), word([2, 1, 2])),
        rule(word([2, 1]), word([]))]) ),
        
    print_puzzle( puzzle( rule_set(
        [rule(word([1, 1]), word([1])),
        rule(word([1, 2]), word([2, 1, 2])),
        rule(word([2, 1]), word([]))]) ) ,  word([1, 2, 1, 1]) ),
    
    nl,
    
    print_path( path([
            word([1, 2, 1, 1]),
            word([1, 2, 1]),
            word([2, 1, 2, 1]),
            word([2, 1]),
            word([])
        ]) ),
        
    nl,

*******************************************************************************/
    
    
    
    print_path( path([]) ),
        
    nl,
    
    Chemin1 = path([
            word([1, 2, 1, 1]),
            word([1, 2, 1]),
            word([2, 1, 2, 1]),
            word([2, 1]),
            word([])
        ]),
    
    Chemin2 = path([
            word([1,2,3]),
            word([4,5,6]),
            word([7,8,9]),
            word([])
        ]),

    print_path_list( [ Chemin2,Chemin1 ] ).
    
    
   
   
   

% Exécution automatique de main au démarrage.
:- main.

