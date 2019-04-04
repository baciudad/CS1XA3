module GetPostExample exposing (main)

import Browser
import Html exposing (..)
import Html.Events as Events
import Http
import String



-- TODO adjust rootUrl as needed


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
    { get_response : String, post_response : String, error_response : String }


type Msg
    = GetResponse (Result Http.Error String) -- Http Get Response recieved
    | PostResponse (Result Http.Error String) -- Http Post Response recieved
    | GetButton -- get buttons is pressed
    | PostButton -- post button is pressed


init : () -> ( Model, Cmd Msg )
init _ =
    ( { get_response = "Waiting to make request"
      , post_response = "Waiting to make request"
      , error_response = ""
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
            [ text model.get_response
            , button [ Events.onClick GetButton ] [ text "Perform Get" ]
            ]
        , div
            []
            [ text model.post_response
            , button [ Events.onClick PostButton ] [ text "Perform Post" ]
            ]
        , div [] [ text model.error_response ]
        ]



{- -------------------------------------------------------------------------------------------
   - Update
   -   Message      | Model Attribute Updated      | Command Used
   -   ----------------------------------------------------------
   -   GetResponse  | get_ressponse,error_response | none
   -   PostResponse | post_reponse,error_response  | none
   -   GetButton    | none                         | Http.get
   -   PostButton   | none                         | Http.post
   --------------------------------------------------------------------------------------------
-}


performGet : Cmd Msg
performGet =
    Http.get
        { url = rootUrl ++ "testreq/testget/?name=Name&age=Age"
        , expect = Http.expectString GetResponse
        }


performPost : Cmd Msg
performPost =
    Http.post
        { url = rootUrl ++ "testreq/testpost/"
        , body = Http.stringBody "application/x-www-form-urlencoded" "name=Name&age=Age"
        , expect = Http.expectString PostResponse
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetResponse result ->
            case result of
                Ok val ->
                    ( { model | get_response = val, error_response = "" }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )

        PostResponse result ->
            case result of
                Ok val ->
                    ( { model | post_response = val, error_response = "" }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )

        GetButton ->
            ( model, performGet )

        PostButton ->
            ( model, performPost )



-- put error message in model.error_response (rendered in view)


handleError : Model -> Http.Error -> Model
handleError model error =
    case error of
        Http.BadUrl url ->
            { model | error_response = "bad url: " ++ url }

        Http.Timeout ->
            { model | error_response = "timeout" }

        Http.NetworkError ->
            { model | error_response = "network error" }

        Http.BadStatus i ->
            { model | error_response = "bad status " ++ String.fromInt i }

        Http.BadBody body ->
            { model | error_response = "bad body " ++ body }
