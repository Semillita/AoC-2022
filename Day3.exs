lines = String.split(File.read!("Input3.txt"), "\r\n")

listIntersections = fn(list1, list2) ->
  Set.intersection(Enum.into(list1, HashSet.new), Enum.into(list2, HashSet.new)) |> Set.to_list()
end

innerOverlap = fn(line) ->
  chars = line |> String.graphemes()
  compartmentLength = String.length(line) / 2 |> round
  comp1 = Enum.slice(chars, 0, compartmentLength)
  comp2 = Enum.slice(chars, compartmentLength, compartmentLength * 2)

  Set.intersection(Enum.into(comp1, HashSet.new), Enum.into(comp2, HashSet.new)) |> Set.to_list |> hd
end

ord = fn(char) ->
  char |> String.to_charlist |> hd
end

priority = fn(char) ->
  ord.(char) - (if (String.upcase(char) == char), do: ord.("A") - 27, else: ord.("a") - 1)
end

groupOverlap = fn(group) ->
  elf0 = String.graphemes(Enum.at(group, 0))
  elf1 = String.graphemes(Enum.at(group, 1))
  elf2 = String.graphemes(Enum.at(group, 2))

  listIntersections.(listIntersections.(elf0, elf1), elf2) |> hd
end

part1 = Enum.map(lines, innerOverlap)
        |> Enum.map(priority)
        |> Enum.sum

part2 = Enum.chunk_every(lines, 3)
        |> Enum.map(groupOverlap)
        |> Enum.map(priority)
        |> Enum.sum

IO.puts("Part 1: " <> to_string(part1))
IO.puts("Part 2: " <> to_string(part2))
