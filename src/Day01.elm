module Day01 exposing (input, part1, part2)


input : String
input =
    """
199
200
208
210
200
207
240
269
260
263
""" |> String.trim


part1 : String -> Int
part1 rawInput =
    rawInput
        |> getMeasurements
        |> pairWithNextMeasurement
        |> getDepthChanges
        |> countIncreases


part2 : String -> Int
part2 rawInput =
    rawInput
        |> getMeasurements
        |> sumTriplets
        |> pairWithNextMeasurement
        |> getDepthChanges
        |> countIncreases


type DepthChange
    = Increase
    | Decrease
    | NoChange


type alias Measurement =
    Int


getMeasurements : String -> List Measurement
getMeasurements rawInput =
    rawInput
        |> String.trim
        |> String.lines
        |> List.filterMap String.toInt


pairWithNextMeasurement : List Measurement -> List ( Measurement, Measurement )
pairWithNextMeasurement measurements =
    let
        offsetMeasurements =
            List.drop 1 measurements
    in
    List.map2 Tuple.pair measurements offsetMeasurements


getDepthChanges : List ( Measurement, Measurement ) -> List DepthChange
getDepthChanges pairedMeasurements =
    List.map toDepthChange pairedMeasurements


toDepthChange : ( Measurement, Measurement ) -> DepthChange
toDepthChange ( m1, m2 ) =
    if m1 < m2 then
        Increase

    else if m1 > m2 then
        Decrease

    else
        NoChange


countIncreases : List DepthChange -> Int
countIncreases depthChanges =
    List.filter (\x -> x == Increase) depthChanges
        |> List.length


sumTriplets : List Measurement -> List Measurement
sumTriplets measurements =
    measurements
        |> getTriplets
        |> List.map List.sum


getTriplets : List Measurement -> List (List Measurement)
getTriplets measurements =
    let
        offset1 =
            List.drop 1 measurements

        offset2 =
            List.drop 2 measurements
    in
    List.map3 (\x y z -> [ x, y, z ]) measurements offset1 offset2
