module JsonExample exposing (main)

import Browser
import Html exposing (..)
import Html.Events as Events
import Http
import Json.Decode as JDecode
import Json.Encode as JEncode
import String

rootUrl =
    "http://localhost:8000/e/macid/"



-- rootUrl = "https://mac1xa3.ca/e/macid/"


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }



{- -------------------------------------------------------------------------------------------
   - Model
   --------------------------------------------------------------------------------------------
-}


type alias Model =
    { name : String, age : Int, error : String }


type Msg
    = JSONResponse (Result Http.Error Model) -- Http Post JSON Response recieved
    | ButtonPressed -- Button Pressed


init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = "No one"
      , age = 0
      , error = ""
      }
    , Cmd.none
    )



{- -------------------------------------------------------------------------------------------
   - View
   -   Model Attributes Used:
   -        model.get_response
   -        model.post_response
   -        model.error_repsonse
   -   Messages Used:
   -        onClick GetButton
   -        onClick PostButton
   --------------------------------------------------------------------------------------------
-}


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text <| "Hello my name is " ++ model.name ++ " and I'm " ++ String.fromInt model.age
            , button [ Events.onClick ButtonPressed ] [ text "Get Name and Age" ]
            ]
        , div [] [ text model.error ]
        ]



{- -------------------------------------------------------------------------------------------
   - JSON Encode/Decode
   -   modelEncoder turns a model into a JSON value that can be used with Http.jsonBody
   -   modelDecoder is used by Http.expectJson to parse a JSON body into a Model
   --------------------------------------------------------------------------------------------
-}


modelEncoder : Model -> JEncode.Value
modelEncoder model =
    JEncode.object
        [ ( "name"
          , JEncode.string model.name
          )
        , ( "age"
          , JEncode.int model.age
          )
        , ( "error"
          , JEncode.string model.error
          )
        ]


modelDecoder : JDecode.Decoder Model
modelDecoder =
    JDecode.map3 Model
        (JDecode.field "name" JDecode.string)
        (JDecode.field "age" JDecode.int)
        (JDecode.field "error" JDecode.string)


sendJsonPost : Model -> Cmd Msg
sendJsonPost model =
    Http.post
        { url = rootUrl ++ "testjson/"
        , body = Http.jsonBody <| modelEncoder model
        , expect = Http.expectJson JSONResponse modelDecoder
        }



{- -------------------------------------------------------------------------------------------
   - Update
   -   JSONResponse updates the entire model with the JSON object given by the server
   -   ButtonPressed sends a Http Post using a JSON encoded current model
   --------------------------------------------------------------------------------------------
-}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JSONResponse result ->
            case result of
                Ok newModel ->
                    ( newModel, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )

        ButtonPressed ->
            ( model, sendJsonPost model )



-- put error message in model.error_response (rendered in view)


handleError : Model -> Http.Error -> Model
handleError model error =
    case error of
        Http.BadUrl url ->
            { model | error = "bad url: " ++ url }

        Http.Timeout ->
            { model | error = "timeout" }

        Http.NetworkError ->
            { model | error = "network error" }

        Http.BadStatus i ->
            { model | error = "bad status " ++ String.fromInt i }

        Http.BadBody body ->
            { model | error = "bad body " ++ body }
