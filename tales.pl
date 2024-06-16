:- use_module(library(random)).
:- use_module(library(lists)).

:- dynamic(hero/3).
:- dynamic(evil_organization/2).
:- dynamic(city_state/2).
:- dynamic(new_hero/1).
:- dynamic(mission_outcome/1).

random_facts_and_rules :-
    random_hero(HeroFName, HeroLName),
    random_evil_organization(Organization),
    random_city_state(City, State),
    random_new_hero(NewHero),
    random_mission_outcome(Outcome),

    assertz(hero(HeroFName, 'Shadow', HeroLName)),
    assertz(evil_organization(Organization, 'eternal darkness')),
    assertz(city_state(City, State)),
    assertz(new_hero(NewHero)),
    assertz(mission_outcome(Outcome)).

options(heroes_fname, [jack, john, jane]).
options(heroes_lname, [smith, doe, roe]).
options(evil_organizations, [black_oracle, shadow_hand, red_hand]).
options(city_states, [(sentinel_city, 'chaos and order'), (nova_city, 'turmoil'), (ironburg, 'strife')]).
options(new_hero_roles, ['a new champion', 'the chosen one', 'the unexpected hero']).
options(mission_outcomes, [success, failure, unknown]).

random_select(List, Element) :-
    length(List, Length),
    random(0, Length, Index),
    nth0(Index, List, Element).

random_hero(HeroFName, HeroLName) :-
    options(heroes_fname, FirstNames),
    options(heroes_lname, LastNames),
    random_select(FirstNames, HeroFName),
    random_select(LastNames, HeroLName).

random_evil_organization(Organization) :-
    options(evil_organizations, Organizations),
    random_select(Organizations, Organization).

random_city_state(City, State) :-
    options(city_states, CityStates),
    random_select(CityStates, (City, State)).

random_new_hero(NewHero) :-
    options(new_hero_roles, NewHeroRoles),
    random_select(NewHeroRoles, NewHero).

random_mission_outcome(Outcome) :-
    options(mission_outcomes, Outcomes),
    random_select(Outcomes, Outcome).

concat_strings([], '').
concat_strings([H|T], Result) :-
    concat_strings(T, Rest),
    atom_concat(H, Rest, Result).

generate_prologue(Tale) :-
    random_facts_and_rules,
    hero(Name, Alias, Surname),
    evil_organization(EvilOrg, EvilGoal),
    city_state(City, State),
    new_hero(NewHero),
    mission_outcome(Outcome),

    concat_strings(['In the neon glow of ', City, ', a sprawling metropolis teetering on the edge of ', State, ', ', Name, ' "', Alias, '" stood as the last bastion of hope. '], P1),
    concat_strings([P1, 'The cityscape flickered beneath the smoggy night as ', Name, ' embarked on their most perilous mission yet. '], P2),
    concat_strings([P2, 'Rumors of the ', EvilOrg, '—a sinister organization intent on plunging the city into ', EvilGoal, '—had reached a fever pitch. '], P3),
    concat_strings([P3, 'Navigating through the labyrinthine subway tunnels, ', Name, ' confronted the', EvilOrg, '\'s leaders in their subterranean lair. '], P4),
    concat_strings([P4, 'A fierce battle ensued, but despite their legendary skill and bravery, the dark sorcery of the ', EvilOrg, ' overwhelmed them. '], P5),
    concat_strings([P5, 'As they fell, the grim realization of their ', Outcome, ' hit them. ', City, ' was now vulnerable, and with their last breath, he sent a silent plea for ', NewHero, ' to rise.\n\n'], P6),

    concat_strings([P6, 'The next morning, the city awoke to the devastating news: ', Name, ' "', Surname, '" was no more. '], P7),
    concat_strings([P7, 'Amidst the sorrow and fear, a new resolve began to stir in the hearts of its citizens. '], P8),
    concat_strings([P8, City, ' needed ', NewHero, ' to stand against the encroaching darkness. '], P9),
    concat_strings([P9, 'Somewhere in the neon jungle, the call to adventure awaited ', NewHero, '. '], P10),
    concat_strings([P10, 'The legacy of the ', Alias, ' would endure, passed to a new generation. Now, it is your turn to pick up the mantle, to fight the darkness, and to become the hero ', City, ' desperately needs. '], P11),
    concat_strings([P11, 'Your journey begins now.\n'], Tale),

    retract(hero(_, _, _)),
    retract(evil_organization(_, _)),
    retract(city_state(_, _)),
    retract(new_hero(_)),
    retract(mission_outcome(_)).

:- initialization(randomize).

init(Tale) :-
    generate_prologue(Tale).