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
%print_puzzle(puzzle(rule_set(RULE_SET)) , word(WORD)) :-
 %   print_rule_set(rule_set(RULE_SET)),
%    print_word(word(WORD)).

% Ce prédicat est vrai lorsque le terme _puzzle est une instance de casse-tête et l'imprime.
print_puzzle(puzzle(RuleSet, Word)) :-
    print_rule_set(RuleSet),
    print_word(Word).


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

% Ce prédicat met en relation les trois mots _w1, _w2 et _w3 lorsque _w3 est la concaténation de _w1 et _w2.
word_concatenation(word(Word1),word(Word2),word(Word3)) :- 
    append(Word1,Word2,Word3).



% Ce prédicat met en relation la règle _rule et les deux mots _w1 et _w2 lorsque
% _w2 peut être obtenu à partir de _w1 en y appliquant _rule sur l'un de ses
% préfixes.
rewrite_prefix_by_rule(rule(word(Prefix), word(Replacement)), word(W1), word(W2)) :- 
    append(Prefix, Suffix, W1),  % Trouver un préfixe de W1 qui correspond à Prefix.
    append(Replacement, Suffix, W2).  % Remplacer ce préfixe par Replacement pour obtenir W2.
    


% Ce prédicat met en relation la règle _rule et les deux mots _w1 et _w2 lorsque
% _w2 peut être obtenu à partir de _w1 en y appliquant _rule sur l'un de ses facteurs.
rewrite_factor_by_rule(rule(word(Factor), word(Replacement)), word(W1), word(W2)) :- 
    append(Prefix, Rest, W1),          % Trouver un préfixe de W1 et le reste.
    append(Factor, Suffix, Rest),      % Vérifier si Factor est un facteur de W1.
    append(Replacement, Suffix, NewRest), % Remplacer Factor par Replacement.
    append(Prefix, NewRest, W2).          % Obtenir le nouveau mot W2.


% Ce prédicat met en relation l'ensemble de règles _rule_set et les deux mots _w1 et
% _w2 lorsque _w2 peut être obtenu à partir de _w1 en y appliquant une règle de
% _rule_set sur l'un de ses facteurs.
% Ce prédicat est vrai lorsque w2 peut être obtenu à partir de w1 en y appliquant une règle de rule_set sur l'un de ses facteurs.
rewrite([], _, _).  % Échoue si aucune règle ne permet de faire la transformation.
rewrite([RuleToApply|_], word(W1), word(W2)) :-
    rewrite_factor_by_rule(RuleToApply, word(W1), word(W2)).
rewrite([_|RestRulesToApply], word(W1), word(W2)) :-
    rewrite(RestRulesToApply, word(W1), word(W2)).


% Ce prédicat met en relation l'ensemble de règles _rule_set, l'entier _len, le mot
% _w1, le chemin _path et le mot _w2 lorsque _path est un chemin de longueur _len
% de réécritures permettant de transformer _w1 en _w2 par le biais des règles de
% réécriture de _regles.
% Ce prédicat est vrai lorsque Path est un chemin de longueur Len de réécritures permettant de transformer W1 en W2 par le biais des règles de réécriture de RuleSet.

% Prédicat auxiliaire pour gérer la récursion et le chemin
connecting_path_helper(_, 0, word(W), PathAcc, word(W), Path) :-
    reverse(PathAcc, Path).  % Inverse l'accumulation pour obtenir le chemin dans l'ordre correct.
connecting_path_helper(RuleSet, Len, word(W1), PathAcc, word(W2), Path) :-
    Len > 0,
    member(rule(word(Factor), word(Replacement)), RuleSet),  % Sélectionne une règle de RuleSet.
    rewrite_factor_by_rule(rule(word(Factor), word(Replacement)), word(W1), word(IntermediateW)),
    NewLen is Len - 1,
    connecting_path_helper(RuleSet, NewLen, word(IntermediateW), [rule(word(Factor), word(Replacement))|PathAcc], word(W2), Path).

% Prédicat principal pour connecting_path
connecting_path(RuleSet, Len, word(W1), path(Path), word(W2)) :-
    connecting_path_helper(RuleSet, Len, word(W1), [], word(W2), Path).



% Ce prédicat met en relation l'instance de casse-tête _puzzle, l'entier _len et le
% chemin _solution lorsque _solution est une solution de longueur _len de l'instance
% _puzzles de casse-tête.
% puzzle_solution est vrai si Solution est une solution de longueur Len pour le casse-tête Puzzle
puzzle_solution(puzzle(RuleSet, MotDeart), Len, Solution) :-
    % Le but est de transformer InitialWord en un mot vide (mot magique) en utilisant les règles dans RuleSet
    connecting_path(RuleSet, Len, MotDeart, Solution, word([])).




% Ce prédicat met en relation les règles _rule_1 et _rule_2 lorsque _rule_2 est
% obtenue en échangeant les deux mots constituant _rule_1.
% Ce prédicat est vrai lorsque rule_2 est obtenue en échangeant les deux mots constituant rule_1.
rule_reversion(rule(word(Word1), word(Word2)), rule(word(Word2), word(Word1))).




% Ce prédicat met en relation l'ensemble de règles _rule_set, l'entier _len et le mot
% _w lorsque _w est un mot R-magique admettant une solution de longueur _len où R
% est l'ensemble _rule_set.
% Ce prédicat est vrai si w est un mot R-magique admettant une solution de longueur len où R est l'ensemble rule_set.
magic_word_of_rule_set(RuleSet, Len, word(W)) :-
    connecting_path(RuleSet, Len, word(W), path(Path), word([])),
    length(Path, Len).  % Vérifie que la longueur du chemin trouvé est égale à Len.




% Ce prédicat génère tous les mots possibles jusqu'à une certaine longueur.
generate_all_words(MaxLen, Words) :-
    findall(Word, between(1, MaxLen, Len), generate_word(Len, Word), Words).

% Génère un mot de longueur spécifiée.
generate_word(Len, word(Word)) :-
    length(Word, Len),
    maplist(between(0, 9), Word).  % Ici, on suppose que les "lettres" du mot sont des chiffres de 0 à 9.

% Ce prédicat est vrai lorsque MagicWords est la liste de tous les mots R-magiques pour RuleSet avec une solution de longueur Len.
all_magic_words_of_rule_set(RuleSet, Len, MagicWords) :-
    MaxWordLen is Len * 2,  % Hypothèse sur la longueur maximale des mots à générer.
    generate_all_words(MaxWordLen, AllWords),
    include(magic_word_of_rule_set_helper(RuleSet, Len), AllWords, MagicWords).

% Helper pour filtrer les mots R-magiques.
magic_word_of_rule_set_helper(RuleSet, Len, Word) :-
    magic_word_of_rule_set(RuleSet, Len, Word).


% Trouve toutes les solutions possibles pour un puzzle donné jusqu'à une certaine longueur.
all_puzzle_solutions(Puzzle, MaxLength, Solutions) :-
    findall(Solution, puzzle_solution(Puzzle, MaxLength, Solution), Solutions).




