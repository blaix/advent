module Day02 exposing (input, part1, part2)


input : String
input =
    """
forward 5
down 5
forward 8
up 3
down 8
forward 2
""" |> String.trim



-- TODO: Unfortunately it is time to handle navigation...
-- Otherwise elm-live will reset things to Day01.part1 whenever I make a change.
-- See: https://guide.elm-lang.org/webapps/navigation.html


part1 : String -> String
part1 rawInput =
    rawInput
        |> String.lines
        |> Debug.toString


part2 : String -> String
part2 rawInput =
    rawInput
