module UserPage exposing (main)

import Browser
import Browser.Navigation exposing (load)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Http
import Json.Decode as JDecode
import Json.Encode as JEncode
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
    { userInfo : String, error : String }


type Msg
    = UserInfoResponse (Result Http.Error String) -- Http Post Response Received



{- -------------------------------------------------------------------------------------------
   - Retrieve User Info On Init
   --------------------------------------------------------------------------------------------
-}


init : () -> ( Model, Cmd Msg )
init _ =
    ( { userInfo = ""
      , error = ""
      }
    , userInfoGet
    )


userInfoGet : Cmd Msg
userInfoGet =
    Http.get
        { url = rootUrl ++ "userauthapp/userinfo/"
        , expect = Http.expectString UserInfoResponse
        }



{- -------------------------------------------------------------------------------------------
   - View
   --------------------------------------------------------------------------------------------
-}


view : Model -> Html Msg
view model =
    div []
        [ text model.userInfo
        ]



{- -------------------------------------------------------------------------------------------
   - Update
   -   Sends a JSON Post with currently entered username and password upon button press
   -   Server send an Redirect Response that will automatically redirect to UserPage.html
   -   upon success
   --------------------------------------------------------------------------------------------
-}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserInfoResponse result ->
            case result of
                Ok "LoggedOut" ->
                    ( { model | error = "Error Not Logged In" }, load (rootUrl ++ "static/login.html") )

                Ok resp ->
                    ( { model | userInfo = resp }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )



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
