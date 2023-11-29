/*
 * INF6120
 * A2023
 * TP2
 * First name     : FILL IN
 * Last name      : FILL IN
 * Permanent code : FILL IN
*/

% Importation of the content of MagicWords.pl.
:- consult('MagicWords.pl').


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


/******************************************************************************************/
/* Definitions of testing predicates.                                                     */
/******************************************************************************************/
test_1 :-
    puzzle_1(_puzzle),
    _len is 4,
    write("Puzzle:\n"),
    print_puzzle(_puzzle),
    nl,
    format("Solutions of length ~d:\n", [_len]),
    all_puzzle_solutions(_puzzle, _len, _solutions),
    print_path_list(_solutions).

test_2 :-
    rule_set_123(_rule_set),
    _len is 3,
    write("Rule set:\n"),
    print_rule_set(_rule_set),
    format("Magic words having solutions of length ~d:\n", [_len]),
    all_magic_words_of_rule_set(_rule_set, _len, _magic_words),
    print_word_list(_magic_words).



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

/******************************************************************************

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

    print_path_list( [ Chemin2,Chemin1 ] ),

    word_concatenation(word([1,2]),word([3,4]),word(Word3)),

    print_word(word(Word3)),

    rewrite_prefix_by_rule(rule(word([1, 2]), word([2,1,2])), word([1,2,1]), word(NewWord)),
    nl,

    % Affichage du résultat
    print_word(word(NewWord)),
*******************************************************************************/

    % RuleToApply = [rule(word([1,1]), word([1])), rule(word([1,2]), word([2,1,2])), rule(word([2,1]), word([]))],
    % rewrite(RuleToApply, word([1,2,1,1]), word(W2)),
    % print_word(word(W2)),


    /**RuleSet = rule_set(
            [
                rule(word([1, 1]), word([1])),
                rule(word([1, 2]), word([2, 1, 2])),
                rule(word([2, 1]), word([]))
            ]
        ),**/
    % _len is 3,
    % connecting_path(RuleSet, _len, word([1,2,1]), path(Path), word([])),
    % print_word(word(Path)).

    % Définir un ensemble de règles de réécriture pour le casse-tête
    %RuleSet1 = [rule(word([1, 1]), word([1])),
     %           rule(word([1, 2]), word([2,1,2])),
      %         rule(word([2,1]), word([]))],



    % Définir le mot initial du casse-tête
    %InitialWord = word([1, 2, 1, 1]),

    % Définir la longueur maximale souhaitée pour la solution
    %MaxLength = 5,

    %write('w'),

    %rewrite_factor_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1,2]), word(NewWord3)),

    rewrite_factor_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1,2]), Results),
    print_all_words(Results),
    nl,
    rewrite(rules([rule(word([1, 1]), word([1])), rule(word([1, 2]), word([2, 1, 2])), rule(word([2, 1]), word([]))]), word([1, 2, 1, 1, 2]), Results1),
    print_all_words(Results1).

    %print_word(word(NewWord3)),

    %rewrite_prefix_by_rule(rule(word([1, 2]), word([3,3])), word([1,2,1,1]), word(NewWord)),
    %print_word(word(NewWord)),
    %nl,
    %print_word(word(NewWord1)),
    %nl,
    %RuleToApply = [ rule(word([1,1]), word([1])), rule(word([1,2]), word([2,1,2])), rule(word([2,1]), word([])) ],
    %rewrite(RuleToApply, word([1,2,1,1]) , word(W2)),
    %print_word(word(W2)).
    %write('g').

    %rewrite(RuleSet1, word([1,2,1,1]), word(W2)),
    %write('g'),
    %print_word(word(W2)).

    % Appeler puzzle_solution pour trouver une solution au casse-tête
    %(   puzzle_solution(puzzle(RuleSet1, InitialWord), MaxLength, Solution)
    %->  write('Une solution pour le casse-tête est : '), write(Solution), nl
    %;   write('Aucune solution trouvée pour le casse-tête dans la limite de longueur donnée.'), nl
    %).











