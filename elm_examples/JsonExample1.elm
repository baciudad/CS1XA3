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


type alias Model = { counter : Int, label : String }

modelEncode : Model -> JEncode.Value
modelEncode model = 
    JEncode.object 
        [ ( "counter", JEncode.int model.counter )
         ,( "label", JEncode.string model label)    
        ]

modelDecode : JDecode.Decoder model
modelDecode = JDecode.map2 model
                        (JDecode.field "counter" JDecode.int)
                        (JDecode.field "label" JDecide.string)

postModel model = Http.post {
                    url = rootUrl ++ "testjson/"
                ,   body = Http.jsonBody (modelEncode model)
                ,   expect = Http.expectJson GotJSON
                }   

update msg model = case msg of
                        GotJSON result -> case result of
                                                Ok newModel ->
                                                Err err -> 