/******************************************************************************

                            Online Prolog Compiler.
                Code, Compile, Run and Debug Prolog program online.
Write your code in this editor and press "Run" button to execute it.

*******************************************************************************/


/******************************************************************************************/
/* Definitions of rules.                                                                  */
/******************************************************************************************/
rule_1(rule(word([1, 1]), word([1]))).
rule_2(rule(word([1, 2]), word([2, 1, 2]))).
rule_3(rule(word([2, 1]), word([]))).
rule_4(rule(word([1, 1]), word([]))).
rule_5(rule(word([2, 2]), word([]))).
rule_6(rule(word([3, 3]), word([]))).
rule_7(rule(word([1, 3]), word([3, 1]))).
rule_8(rule(word([1, 2, 1]), word([2, 1, 2]))).
rule_9(rule(word([2, 3, 2]), word([3, 2, 3]))).
rule_10(rule(word([2, 1]), word([1, 2]))).
rule_11(rule(word([1, 1, 2]), word([2, 2, 1]))).
rule_12(rule(word([1, 1, 1]), word([]))).
rule_13(rule(word([2, 2, 2]), word([]))).


/******************************************************************************************/
/* Definitions of sets of rules.                                                          */
/******************************************************************************************/
rule_set_123(rule_set([_rule_1, _rule_2, _rule_3])) :-
    rule_1(_rule_1),
    rule_2(_rule_2),
    rule_3(_rule_3).

rule_set_456789(rule_set([_rule_4, _rule_5, _rule_6, _rule_7, _rule_8, _rule_9])) :-
    rule_4(_rule_4),
    rule_5(_rule_5),
    rule_6(_rule_6),
    rule_7(_rule_7),
    rule_8(_rule_8),
    rule_9(_rule_9).

rule_set_10_11_12_13(rule_set([_rule_10, _rule_11, _rule_12, _rule_13])) :-
    rule_10(_rule_10),
    rule_11(_rule_11),
    rule_12(_rule_12),
    rule_13(_rule_13).

puzzle_2(puzzle(_rule_set, word([3, 2, 2, 1, 3, 2, 2, 3, 1, 3]))) :-
    rule_set_456789(_rule_set).

puzzle_3(puzzle(_rule_set, word([2, 2, 2, 2, 1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2]))) :-
    rule_set_10_11_12_13(_rule_set).


/******************************************************************************************/
/* Definitions of puzzles.                                                                */
/******************************************************************************************/
puzzle_1(puzzle(_rule_set, word([1, 2, 1, 1]))) :-
    rule_set_123(_rule_set).




% Ce prédicat est vrai lorsque W est un mot et l'imprime.
print_word(word([])) :-
    write('e'),
    nl.
print_word(word(List)) :-
    print_list(List).
% Prédicat pour afficher un mot.



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
%print_puzzle(puzzle(rule_set(RULE_SET)) , word(WORD)) :-
 %   print_rule_set(rule_set(RULE_SET)),
%    print_word(word(WORD)).

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
% _w2 peut être obtenu à partir de _w1 en y appliquant _rule sur l'un de ses
% préfixes.
rewrite_prefix_by_rule(rule(word(Prefix), word(Replacement)), word(W1), word(W2)) :- 
    append(Prefix, Suffix, W1),  % Trouver un préfixe de W1 qui correspond à Prefix.
    append(Replacement, Suffix, W2).  % Remplacer ce préfixe par Replacement pour obtenir W2.
    


% Ce prédicat met en relation la règle _rule et les deux mots _w1 et _w2 lorsque
% _w2 peut être obtenu à partir de _w1 en y appliquant _rule sur l'un de ses facteurs.
% Ce prédicat applique une règle sur un facteur d'un mot.
% Applique la règle sur un facteur du mot.
% Applique la règle sur tous les facteurs possibles du mot.

apply_rule_at(rule(word(Factor), word(Replacement)), Prefix, Suffix, Result) :-
    append(Factor, RestSuffix, Suffix),
    append(Replacement, RestSuffix, NewSuffix),
    append(Prefix, NewSuffix, Result).


apply_rule_at_position(rule(word(Factor), word(Replacement)), word(W1), Position, word(W2)) :-
    append(Prefix, Suffix, W1),
    length(Prefix, Position),
    append(Factor, RestSuffix, Suffix),
    append(Replacement, RestSuffix, NewSuffix),
    append(Prefix, NewSuffix, W2).


rewrite_factor_by_rule(Rule, Word, Results) :-
    findall(NewW, (
        between(0, 100, Position), 
        apply_rule_at_position(Rule, Word, Position, NewW)
    ), ResultsWithDuplicates),
    list_to_set(ResultsWithDuplicates, Results). 




% Exemple d'utilisation
% rewrite_factor_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1,2]), Results).

% Exemple d'utilisation
% rewrite_factor_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1,2]), Results).


% Exemple d'utilisation
% rewrite_factor_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1,2]), Results).



% Ce prédicat met en relation l'ensemble de règles _rule_set et les deux mots _w1 et
% _w2 lorsque _w2 peut être obtenu à partir de _w1 en y appliquant une règle de
% _rule_set sur l'un de ses facteurs.
% Vérifie si un mot peut être réécrit en utilisant une des règles dans l'ensemble.
% Collecte toutes les réécritures possibles en utilisant toutes les règles de l'ensemble.
rewrite(rules([]), _, []) :- !.
rewrite(rules([Rule|Rules]), word(W1), AllRewrites) :-
    rewrite_factor_by_rule(Rule, word(W1), RewritesForRule),
    rewrite(rules(Rules), word(W1), RewritesForRest),
    append(RewritesForRule, RewritesForRest, AllRewrites).




% Ce prédicat met en relation l'ensemble de règles _rule_set, l'entier _len, le mot
% _w1, le chemin _path et le mot _w2 lorsque _path est un chemin de longueur _len
% de réécritures permettant de transformer _w1 en _w2 par le biais des règles de
% réécriture de _regles.
% Ce prédicat est vrai lorsque Path est un chemin de longueur Len de réécritures permettant de transformer W1 en W2 par le biais des règles de réécriture de RuleSet.

%connecting_path(rule_set(Rules), Len, word(W1), [word(W1)|Path], word(W2)) :-
  %  Len > 0,
   % Len1 is Len - 1,
    %member(Rule, Rules),
    %rewrite_factor_by_rule(Rule, word(W1), [word(Intermediate)]),
    %connecting_path(rule_set(Rules), Len1, word(Intermediate), Path, word(W2)).

%connecting_path(rule_set(Rules), 1, word(W1), path([word(W1)]), word([])).

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


find_and_print_all_paths(RuleSet, Len, StartWord, EndWord) :-
    
    findall(Path, 
        connecting_path(RuleSet, Len, word(StartWord), path(Path), word(EndWord)),AllPaths),
    write('finit connect'),
    nl,
    write(AllPaths),
    nl,
    %print_path_list(AllPaths),
    write('fo').



% Ce prédicat met en relation l'instance de casse-tête _puzzle, l'entier _len et le
% chemin _solution lorsque _solution est une solution de longueur _len de l'instance
% _puzzles de casse-tête.
% puzzle_solution est vrai si Solution est une solution de longueur Len pour le casse-tête Puzzle
%puzzle_solution(puzzle(RuleSet, MotDeart), Len, Solution) :-
    % Le but est de transformer InitialWord en un mot vide (mot magique) en utilisant les règles dans RuleSet
    %connecting_path(RuleSet, Len, MotDeart, Solution, word([])).

% Ce prédicat est vrai si Solution est une solution de longueur Len pour le casse-tête Puzzle.
% Il génère des solutions et échoue si aucune solution n'est trouvée dans la limite de longueur donnée.
%puzzle_solution(puzzle(RuleSet, InitialWord), MaxLength, Solution) :-
  %  connecting_path(RuleSet, MaxLength, word(InitialWord), path(Solution), word([])),
 %   length(Solution, Length),
%    Length =< MaxLength.


% Ce prédicat est vrai si Solution est une solution de longueur MaxLength pour le casse-tête Puzzle.
%puzzle_solution(puzzle(RuleSet, InitialWord), MaxLength, Solution) :-
 %   connecting_path(RuleSet, MaxLength, word(InitialWord), path(Solution), word([])),
  %  length(Solution, Length),
   % Length =< MaxLength.
   
% Collecte tous les chemins possibles de réécriture jusqu'à un mot vide
find_all_solutions(RuleSet, Len, StartWord, EndWord, AllSolutions) :-
    findall(path(Path), 
        connecting_path(RuleSet, Len, word(StartWord), path(Path), word(EndWord)),
        AllSolutions).



% Ce prédicat est vrai si _solution est une solution de longueur _len pour le casse-tête _puzzle.
puzzle_solution(Puzzle, Len, AllSolutions) :-
    Puzzle = puzzle(RuleSet, word(InitialWord)),
    nl,
    write('oui'),
    %find_and_print_all_paths(RuleSet, Len, InitialWord, EndWord).
    find_all_solutions(RuleSet, Len, InitialWord, EndWord, AllSolutions).




% Ce prédicat met en relation les règles _rule_1 et _rule_2 lorsque _rule_2 est
% obtenue en échangeant les deux mots constituant _rule_1.
% Ce prédicat est vrai lorsque rule_2 est obtenue en échangeant les deux mots constituant rule_1.
%faire le cas ou ya vide?
rule_reversion(rule(word(Word1), word(Word2)), rule(word(Word2), word(Word1))).




% Ce prédicat met en relation l'ensemble de règles _rule_set, l'entier _len et le mot
% _w lorsque _w est un mot R-magique admettant une solution de longueur _len où R
% est l'ensemble _rule_set.
% Ce prédicat est vrai si w est un mot R-magique admettant une solution de longueur len où R est l'ensemble rule_set.
% Ce prédicat est vrai si _w est un mot R-magique admettant une solution de longueur _len.
%magic_word_of_rule_set(RuleSet, Len, word(W)) :-
    %find_and_print_all_paths(RuleSet, Len, W, []),
 %   find_all_solutions(RuleSet, Len, InitialWord, EndWord, AllSolutions),
  %  length(Path, Len).






all_puzzle_solutions(puzzle(RuleSet, word(InitialWord)), Len, Solutions) :-
    write('debut test_1'),
    puzzle_solution(puzzle(RuleSet, word(InitialWord)), Len, Solutions).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Vérifie si un mot est un mot magique.
magic_word_of_rule_set(RuleSet, Len, word(W)) :-
    find_all_solutions(RuleSet, Len, W, [], Solutions),
    Solutions \= [].

% Réversion de la règle.
rule_reversion(rule(word(Word1), word(Word2)), rule(word(Word2), word(Word1))).



% Trouve la dernière règle dans un ensemble de règles.
last_rule_in_set(RuleSet, LastRule) :-
    RuleSet = rule_set(Rules),
    last_rule(Rules, LastRule).

% Trouve la dernière règle d'une liste de règles.
last_rule([Rule], Rule).
last_rule([_|Tail], LastRule) :-
    last_rule(Tail, LastRule).


% Vérifie si un mot est un mot magique.
is_magic_word(RuleSet, Len, Word) :-
    magic_word_of_rule_set(RuleSet, Len, Word).


% Filtrez les mots pour ne garder que ceux qui sont magiques.
filter_magic_words(_, _, [], []).
filter_magic_words(RuleSet, Len, [Word | Rest], [Word | MagicWords]) :-
    magic_word_of_rule_set(RuleSet, Len, Word), !,
    filter_magic_words(RuleSet, Len, Rest, MagicWords).
filter_magic_words(RuleSet, Len, [_ | Rest], MagicWords) :-
    filter_magic_words(RuleSet, Len, Rest, MagicWords).


% Predicate to recursively generate predecessors for a single word
generate_predecessors_for_word(ReversedRules, Steps, Word, Predecessors) :-
    generate_predecessors(ReversedRules, Steps, Word, Predecessors).

% Predicate to be used with foldl to generate predecessors for multiple words
generate_predecessors_foldl(ReversedRules, Steps, Word, Acc, UpdatedAcc) :-
    generate_predecessors_for_word(ReversedRules, Steps, Word, Predecessors),
    append(Acc, Predecessors, UpdatedAcc).

% Updated generate_predecessors predicate
generate_predecessors(ReversedRules, 0, CurrentWord, [CurrentWord]).
generate_predecessors(ReversedRules, Steps, CurrentWord, AllPredecessors) :-
    Steps > 0,
    NewSteps is Steps - 1,
    findall(NextWord, (
        member(ReversedRule, ReversedRules),
        rewrite_factor_by_rule(ReversedRule, CurrentWord, PossibleNextWords),
        member(NextWord, PossibleNextWords)
    ), NextWords),
    foldl(generate_predecessors_foldl(ReversedRules, NewSteps), NextWords, [], AllPredecessors).


% Helper predicate to reverse all rules in a rule_set
reverse_rules_in_set(rule_set(Rules), ReversedRules) :-
    reverse_rules(Rules, ReversedRules).

% Helper predicate to reverse all rules in a list
reverse_rules([], []).
reverse_rules([Rule|Tail], [ReversedRule|ReversedTail]) :-
    reverse_rule(Rule, ReversedRule),
    reverse_rules(Tail, ReversedTail).

% Helper predicate to reverse a single rule
reverse_rule(rule(word(A), word(B)), rule(word(B), word(A))).



% Main predicate to find all magic words of a certain length
all_magic_words_of_rule_set(RuleSet, Len, MagicWords) :-
    % Reverse the rules
    write('hello poto'),
    reverse_rules_in_set(RuleSet, ReversedRules),
    write(ReversedRules),
    % Find all predecessors of the empty word
    generate_predecessors(ReversedRules, Len, word([]), AllPredecessors),
    % Filter out the magic words
    %write(AllPredecessors),nl,
    %include(is_magic_word(RuleSet, Len), AllPredecessors, MagicWords).
    include(is_magic_word_for_set_and_len(RuleSet, Len), AllPredecessors, FilteredMagicWords),
    sort(FilteredMagicWords, MagicWords).
    
% Prédicat d'aide pour adapter is_magic_word à include
is_magic_word_for_set_and_len(RuleSet, Len, Word) :-
    is_magic_word(RuleSet, Len, Word).








main:-
    write('Hello World'),
    
    nl,
    
    _path = path(
        [
            word([2, 1]),
            word([])
        ]
    ),
    
    
    _rule_set_test = rule_set(
        [
            rule(word([2, 1]), word([]))
        ]
    ),
    
    
    
    _test_gen_connectpath = rule_set(
        [
            rule(word([1, 1]), word([1])),
            rule(word([1, 2]), word([2, 1, 2])),
            rule(word([2, 1]), word([]))
        ]
    ),


    _puzzle_test = puzzle(
        rule_set(
            [
                rule(word([1, 1]), word([1])),
                rule(word([1, 2]), word([2, 1, 2])),
                rule(word([2, 1]), word([]))
            ]
        ),
        word([1, 2, 1, 1])
    ),

    write('test path'),
    
    nl,
    
    print_path(_path),
    
    print_word(word([1,2,1,1])),
    

    
    Path_debut = path([word([2,1])]),
    
    
    rewrite_factor_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1,2]), Results),
    print_all_words(Results),

    rewrite_factor_by_rule(rule(word([2,1]), word([])), word([2,1]), Results1),
    
    print_all_words(Results1),

    %rule_set_123(_rule_set), 
    %connecting_path(rule_set(Rules), 1, word(W1), [word(W1)], word([]))
    connecting_path(   _rule_set_test  , 1 , word([2,1]), Path_debut , word([])),
    
    write('OUII cas de base'),
    nl,
    %connecting_path(_test_gen_connectpath, 4, word([1,2,1,1]), Path_general , word([])),
    
    %print_path( Path_general ),
    

    nl,
    write('commence affichage'),
    % Exemple d'appel
    TestPaths = [
        path([word([1,2,1,1]), word([2,1,2,1,1]), word([2,1]), word([])]),
        path([word([1,2,1,1]), word([1,2,1]), word([2,1,2,1]), word([2,1]), word([])])
    ],
    
    TestPaths1 = [
        
    ],

% Appel de print_path_list avec cette liste de test
    %print_path_list(TestPaths),
    %write(TestPaths),
    
    % marche find_and_print_all_paths(_test_gen_connectpath, 4, [1,2,1,1], []),
    
    puzzle_solution(_puzzle_test, 4, AllSolutions),

    nl,
    write('letss go'),
    nl,
    write('on est ici mon gars'),
    nl,
    % Exemple d'appel
    %magic_word_of_rule_set(_test_gen_connectpath, 4, b word([1,2,1,1])),

    puzzle_1(_puzzle),
    _len is 4,
    write("Puzzle:\n"),
    print_puzzle(_puzzle),
    nl,
    format("Solutions of length ~d:\n", [_len]),
    all_puzzle_solutions(_puzzle, _len, _solutions),

    write('test write soln de path'),
    write(_solutions),
    write('ecris la'),
    nl,
    write('test liste de path'),
    nl,
    print_path_list(_solutions),
    
    nl,
    write('biien finit'),
    nl,
    
    write('debut test2'),
    nl,
    nl,
    rule_set_123(_rule_set),
    _len1 is 3,
    write("Rule set:\n"),
    print_rule_set(_rule_set),
    format("Magic words having solutions of length ~d:\n", [_len1]),
    write('hello avant'),
    all_magic_words_of_rule_set(_rule_set, _len1, _magic_words),
    write('gogogo fiiin'),nl,
    nl,nl,print_word_list(_magic_words),%write(_magic_words),
    nl,
    %last_rule_sequence(RuleSet, LastRuleSequence)
    
    write('OUII final').
    
    
    
    
    
    
:- main.
