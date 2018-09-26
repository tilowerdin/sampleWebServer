import Html exposing (..)
import Html.Events exposing (..)
import Random
import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Tuple exposing (first, second)
import Task
import Process


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFaces : (Int, Int)
  , count : Float
  }


init : (Model, Cmd Msg)
init =
  (Model (1,1) 0, generateDice)



-- UPDATE


type Msg
  = Roll
  | NewFace (Int,Int)
  | Next ()


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ({model | count = 0}, generateDice)

    NewFace (newFaces) ->
      ({ model | dieFaces = newFaces
               , count = model.count + 1}
      , if model.count >= 5 then Cmd.none else flipAround model.count)

    Next () -> (model, generateDice)

flipAround count = 
  Task.perform Next (Process.sleep (count * 100))

generateDice =
  Random.generate 
    NewFace 
    (Random.pair (Random.int 1 6) (Random.int 1 6))

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div [Html.Attributes.align "center"]
--    [ h1 [] [ text (toString model.dieFace) ]
    [ showSvg (first model.dieFaces)
    , br [] []
    , showSvg (second model.dieFaces)
    , br [] []
    , button [ Html.Attributes.height 200, Html.Attributes.width 200, onClick Roll ] [ Html.text "Roll" ]
    ]

showSvg : Int -> Html Msg
showSvg i =
  svg 
    [ Svg.Attributes.width "120"
    , Svg.Attributes.height "120"
    , viewBox "0 0 120 120" ]
    (circleList i)

rad = "10"

circleList : Int -> List (Svg Msg)
circleList i =
  case i of
    1 -> [ circle [ cx "60", cy "60", r rad ] [] ]
    2 -> [ circle [ cx "30", cy "90", r rad ] []
         , circle [ cx "90", cy "30", r rad ] []
         ]
    3 -> [ circle [ cx "90", cy "90", r rad ] []
         , circle [ cx "60", cy "60", r rad ] []
         , circle [ cx "30", cy "30", r rad ] []
         ]
    4 -> [ circle [ cx "30", cy "30", r rad ] []
         , circle [ cx "90", cy "30", r rad ] []
         , circle [ cx "30", cy "90", r rad ] []
         , circle [ cx "90", cy "90", r rad ] []
         ]
    5 -> [ circle [ cx "30", cy "30", r rad ] []
         , circle [ cx "90", cy "30", r rad ] []
         , circle [ cx "30", cy "90", r rad ] []
         , circle [ cx "90", cy "90", r rad ] []
         , circle [ cx "60", cy "60", r rad ] []
         ]
    6 -> [ circle [ cx "30", cy "30", r rad ] []
         , circle [ cx "90", cy "30", r rad ] []
         , circle [ cx "30", cy "90", r rad ] []
         , circle [ cx "90", cy "90", r rad ] []
         , circle [ cx "30", cy "60", r rad ] []
         , circle [ cx "90", cy "60", r rad ] []
         ]
    _ -> []

showImage : Int -> Html Msg
showImage dieFace =
  div [  ]
    [ img [ src ("img/dieFace" 
                ++ toString (dieFace) 
                ++ ".jpg") ] []
    ]
