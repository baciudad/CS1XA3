import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main = 
 Browser.sandbox { init = init, update = update, view = view }

-- Model 
type alias Model = {wordOne : String, wordTwo : String}
type Msg = ChangeOne String
         | ChangeTwo String

init : Model
init = { wordOne = "", wordTwo = ""}

-- View
view : Model -> Html Msg
view model = 
    div [] 
    [
          input [ placeholder "String 1", value model.wordOne, onInput ChangeOne ] []
        , input [ placeholder "String 2", value model.wordTwo, onInput ChangeTwo ] []
        , div [] [text model.wordOne, text " : ", text model.wordTwo]
    ]

-- Update
update : Msg -> Model -> Model
update msg model = 
    case msg of
        ChangeOne newString -> { model | wordOne = newString }
        ChangeTwo newString -> { model | wordTwo = newString }