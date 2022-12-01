-module(day1).
    -import(lists, [reverse/1]).
    -export([main/0]).
    
    main() ->
        InputFromFileAsString = read_input_file("Input1.txt"),
        Groups = split_into_groups(InputFromFileAsString),
        Sums = lists:map(fun(Group) -> group_sum(Group) end, Groups),

        io:fwrite("Part 1: ~w", [lists:max(Sums)]),

        SortedSums = reverse(lists:sort(Sums)),

        io:fwrite("\npart 2: ~w", [lists:nth(1, SortedSums) + lists:nth(2, SortedSums) + lists:nth(3, SortedSums)]),
        io:nl().

    split_into_groups(AllValues) ->
        lists:filter(fun(Value) -> Value > "" end, string:split(AllValues, "\r\n\r\n", all)).

    group_sum(ValuesAsString) -> 
        {Ignored, Sum} = lists:mapfoldl(fun(X, Sum) -> {X, X + Sum} end, 0, string_to_list_of_numbers(ValuesAsString)),
        Sum.

    string_to_list(String) ->
        lists:filter(fun(Value) -> Value > "" end, string:split(String, "\r\n", all)).
    
    read_input_file(InputFileName) ->
        {ok, InputFromFile} = file:read_file(InputFileName),
        unicode:characters_to_list(InputFromFile).

    string_to_list_of_numbers(String) ->
        lists:map(fun(S) ->
                     {Value, _} = string:to_integer(S),
                     Value
                  end,
                  string_to_list(String)).