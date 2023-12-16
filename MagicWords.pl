/*
 * INF6120
 * A2023
 * TP2
 * First name     : OSWALD
 * Last name      : ESSONGUE
 * Permanent code : ESSO16019809
*/



% Ce prédicat est vrai lorsque W est un mot et l'imprime.
print_word(word([])) :-
    write('e'),
    nl.
print_word(word(List)) :-
    print_list(List).



% Prédicat pour afficher tous les mots dans une liste.
print_all_words([]).
print_all_words([Word|Words]) :-
    print_word(Word),
    print_all_words(Words).


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
print_puzzle(puzzle(RuleSet, Word)) :-
    print_rule_set(RuleSet),
    print_word(Word).


% Ce prédicat est vrai lorsque _path est un chemin et l'imprime.
print_path( path([]) ) :-
    write('Le chemin est vide'), nl.
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
% _w2 peut être obtenu à partir de _w1 en y appliquant _rule sur l'un de ses préfixes.
rewrite_prefix_by_rule(rule(word(Prefix), word(Replacement)), word(W1), word(W2)) :-
    word_concatenation(word(Prefix), word(Suffix), word(W1)),  % Concatène Prefix et Suffix pour former W1.
    word_concatenation(word(Replacement), word(Suffix), word(W2)).  % Concatène Replacement et Suffix pour former W2.

/*
Ce prédicat applique une règle de réécriture à une position spécifiée
dans un mot. Il divise d'abord le mot en un préfixe et un suffixe
à la position donnée, applique ensuite la règle de réécriture au suffixe,
et enfin, concatène le préfixe inchangé avec le nouveau suffixe pour former le mot modifié. */
apply_rule_at_position(rule(word(Factor), word(Replacement)), word(W1), Position, word(W2)) :-
    split_at_position(W1, Position, Prefix, Suffix),
    rewrite_prefix_by_rule(rule(word(Factor), word(Replacement)), word(Suffix), word(NewSuffix)),
    word_concatenation(word(Prefix), word(NewSuffix), word(W2)).

% Prédicat auxiliaire pour diviser un mot à une position donnée
split_at_position(W1, Position, Prefix, Suffix) :-
    length(Prefix, Position),
    append(Prefix, Suffix, W1).


/*
Ce prédicat met en relation la règle _rule et les deux mots _w1 et _w2 lorsque
_w2 peut être obtenu à partir de _w1 en y appliquant _rule sur l'un de ses
facteurs.*/
rewrite_factor_by_rule(Rule, Word, Results) :-
    findall(NewW, (
        between(0, 100, Position),
        apply_rule_at_position(Rule, Word, Position, NewW)
    ), ResultsWithDuplicates),
    list_to_set(ResultsWithDuplicates, Results).



/*
Ce prédicat met en relation l'ensemble de règles _rule_set et les deux mots _w1 et
_w2 lorsque _w2 peut être obtenu à partir de _w1 en y appliquant une règle de
_rule_set sur l'un de ses facteurs.
*/
rewrite(rules([]), _, []) :- !.
rewrite(rules([Rule|Rules]), word(W1), AllRewrites) :-
    rewrite_factor_by_rule(Rule, word(W1), RewritesForRule),
    rewrite(rules(Rules), word(W1), RewritesForRest),
    append(RewritesForRule, RewritesForRest, AllRewrites).


/*
Ce prédicat met en relation l'ensemble de règles _rule_set, l'entier _len, le mot
_w1, le chemin _path et le mot _w2 lorsque _path est un chemin de longueur _len
de réécritures permettant de transformer _w1 en _w2 par le biais des règles de
réécriture de _regles.*/

% Cas de base: directement transformer W1 en un mot vide avec une règle applicable
connecting_path(rule_set(Rules), 1, word(W1), path([word(W1)]), word([])) :-
    member(rule(word(W1), word([])), Rules).

% Cas général pour construire des chemins de réécriture.
connecting_path(rule_set(Rules), Len, word(W1), path(FullPath), word(W2)) :-
    Len > 1,
    NewLen is Len - 1,
    findall(ExtendedPath,
        (
            member(Rule, Rules),
            rewrite_factor_by_rule(Rule, word(W1), Intermediates),
            member(word(Intermediate), Intermediates),
            connecting_path(rule_set(Rules), NewLen, word(Intermediate), path(Path), word(W2)),
            ExtendedPath = [word(W1)|Path]
        ),
        Paths),
    member(FullPath, Paths).


/*
Le prédicat find_all_solutions est utilisé pour trouver toutes les solutions possibles,
sous forme de chemins de réécriture, qui permettent de transformer un mot de départ (StartWord)
en un mot d'arrivée (EndWord) en utilisant un ensemble de règles de réécriture (RuleSet) et ce,
en un nombre spécifié d'étapes (Len). Il utilise findall pour collecter tous les chemins possibles
correspondant à ces critères dans la liste AllSolutions
*/
find_all_solutions(RuleSet, Len, StartWord, EndWord, AllSolutions) :-
    findall(path(Path),
        connecting_path(RuleSet, Len, word(StartWord), path(Path), word(EndWord)),
        AllSolutions).



% Ce prédicat est vrai si _solution est une solution de longueur _len pour le casse-tête _puzzle.
puzzle_solution(Puzzle, Len, AllSolutions) :-
    Puzzle = puzzle(RuleSet, word(InitialWord)),
    nl,
    find_all_solutions(RuleSet, Len, InitialWord, _, AllSolutions).




% Ce prédicat met en relation les règles _rule_1 et _rule_2 lorsque _rule_2 est
% obtenue en échangeant les deux mots constituant _rule_1.
% Ce prédicat est vrai lorsque rule_2 est obtenue en échangeant les deux mots constituant rule_1.
rule_reversion(rule(word(Word1), word(Word2)), rule(word(Word2), word(Word1))).





/*
Ce prédicat met en relation l'instance de casse-tête _puzzle, l'entier _len et la
liste de chemins _solutions lorsque l'instance de casse-tête en question possède comme
solutions de longueur _len exactement les chemins de _solutions */
all_puzzle_solutions(puzzle(RuleSet, word(InitialWord)), Len, Solutions) :-
    puzzle_solution(puzzle(RuleSet, word(InitialWord)), Len, Solutions).



% Vérifie si un mot est un mot magique.
magic_word_of_rule_set(RuleSet, Len, word(W)) :-
    find_all_solutions(RuleSet, Len, W, [], Solutions),
    Solutions \= [].



% Prédicat pour générer de manière récursive les prédécesseurs d'un seul mot.
generate_predecessors_for_word(ReversedRules, Steps, Word, Predecessors) :-
    generate_predecessors(ReversedRules, Steps, Word, Predecessors).

% Prédicat à utiliser avec foldl pour générer les prédécesseurs de plusieurs mots.
generate_predecessors_foldl(ReversedRules, Steps, Word, Acc, UpdatedAcc) :-
    generate_predecessors_for_word(ReversedRules, Steps, Word, Predecessors),
    append(Acc, Predecessors, UpdatedAcc).

/*
Le prédicat generate_predecessors est conçu pour
générer de manière récursive tous les prédécesseurs possibles
d'un mot donné en utilisant un ensemble de règles inversées */
generate_predecessors(_, 0, CurrentWord, [CurrentWord]).
generate_predecessors(ReversedRules, Steps, CurrentWord, AllPredecessors) :-
    Steps > 0,
    NewSteps is Steps - 1,
    findall(NextWord, (
        member(ReversedRule, ReversedRules),
        rewrite_factor_by_rule(ReversedRule, CurrentWord, PossibleNextWords),
        member(NextWord, PossibleNextWords)
    ), NextWords),
    foldl(generate_predecessors_foldl(ReversedRules, NewSteps), NextWords, [], AllPredecessors).


% Ce predicat renverse tous les rules dans un rule_set
reverse_rules_in_set(rule_set(Rules), ReversedRules) :-
    reverse_rules(Rules, ReversedRules).

% Ce prédicat renverse toutes les regles d'une liste
reverse_rules([], []).
reverse_rules([Rule|Tail], [ReversedRule|ReversedTail]) :-
    rule_reversion(Rule, ReversedRule),
    reverse_rules(Tail, ReversedTail).


/*Ce prédicat met en relation l'ensemble de règles _rule_set, l'entier _len et le mot
_w lorsque _w est un mot R-magique admettant une solution de longueur _len où R
est l'ensemble _rule_set*/
all_magic_words_of_rule_set(RuleSet, Len, MagicWords) :-
    reverse_rules_in_set(RuleSet, ReversedRules),
    generate_predecessors(ReversedRules, Len, word([]), AllPredecessors),
    include(magic_word_of_rule_set(RuleSet, Len), AllPredecessors, FilteredMagicWords),
    sort(FilteredMagicWords, MagicWords).