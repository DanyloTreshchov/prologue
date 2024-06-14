:- use_module(library(lists)).

    character(alice).
    character(bob).
    character(cathy).

    loves(alice, bob).
    loves(bob, cathy).

    generate_tale(X, Y, Tale) :-
        character(X),
        character(Y),
        loves(X, Y),
        atom_concat('Once upon a time, ', X, Part1),
        atom_concat(Part1, ' loved ', Part2),
        atom_concat(Part2, Y, Part3),
        atom_concat(Part3, '.', Tale).

    init(Tale) :- 
        generate_tale(alice, bob, Tale).