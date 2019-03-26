import Browser
import Html exposing (..)
import Html 
import Html.Attributes exposing (..)
import Html.Events as Events
import Http


-- MAIN

rootUrl = "http://mac1xa3.ca/e/baciudad/"


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , postResponse : String
  , errorResponse : String
  }



-- UPDATE


type Msg
  = Name String
  | Password String
  | PostResponse (Result Http.Error String)
  | PostButton
  
init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = ""
      , password = ""
      , postResponse = "Waiting to make request"
      , errorResponse = ""
      }
    , Cmd.none
    )
    
view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , button [ Events.onClick PostButton ] [ text "Submit" ]
    , viewValidation model
    ]
  
performPost : Cmd Msg
performPost =
    Http.post
        { url = rootUrl ++ "lab07/"
        , body = Http.stringBody "application/x-www-form-urlencoded" "name=Model.Name&password=model.Password"
        , expect = Http.expectString PostResponse
        }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Name name ->
      ({ model | name = name }, Cmd.none)

    Password password ->
      ({ model | password = password }, Cmd.none)

    PostResponse result -> 
      case result of
                Ok val ->
                    ( { model | postResponse = val, errorResponse = "" }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )
                    
    PostButton -> ( model, performPost )


-- VIEW

handleError : Model -> Http.Error -> Model
handleError model error =
    case error of
        Http.BadUrl url ->
            { model | errorResponse = "bad url: " ++ url }

        Http.Timeout ->
            { model | errorResponse = "timeout" }

        Http.NetworkError ->
            { model | errorResponse = "network error" }

        Http.BadStatus i ->
            { model | errorResponse = "bad status " ++ String.fromInt i }

        Http.BadBody body ->
            { model | errorResponse = "bad body " ++ body }


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, Events.onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password /= "" then
    div [ style "color" "blue" ] [ text model.postResponse ]
  else
    div [ style "color" "blue" ] [ text model.postResponse ]
