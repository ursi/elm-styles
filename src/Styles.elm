module Styles exposing (..)

import Css as C exposing (..)
import Css.Functions as CF exposing (..)
import Css.Global as G exposing (..)
import FoldIdentity as F
import Html.Styled as H exposing (Html)


idC : Declaration
idC =
    C.batch []


doubleCenter : Declaration
doubleCenter =
    C.batch
        [ display "flex"
        , justifyContent "center"
        , alignItems "center"
        ]


stack : Declaration
stack =
    C.batch
        [ display "flex"
        , flexDirection "column"
        ]


fillWindow : Statement
fillWindow =
    G.batch
        [ html [ height "100%" ]
        , body
            [ height "100%"
            , margin "0"
            ]
        ]


spaceBetween : String -> Declaration
spaceBetween =
    adjacent << List.singleton << marginTop


spaceBetweenChildren : String -> Declaration
spaceBetweenChildren space =
    children
        [ marginTop space
        , firstChild [ marginTop "0" ]
        ]


topLeft : Declaration
topLeft =
    C.batch
        [ position "absolute"
        , top "0"
        , left "0"
        ]


topRight : Declaration
topRight =
    C.batch
        [ position "absolute"
        , top "0"
        , right "0"
        ]


bottomLeft : Declaration
bottomLeft =
    C.batch
        [ position "absolute"
        , bottom "0"
        , left "0"
        ]


bottomRight : Declaration
bottomRight =
    C.batch
        [ position "absolute"
        , bottom "0"
        , right "0"
        ]


popupBlur :
    String
    -> Float
    -> Float
    ->
        { global : Bool -> Statement
        , local : Declaration
        }
popupBlur name pixels duration =
    { global =
        \showPopup ->
            G.batch
                [ keyframes "blur"
                    [ ( "from", [ filter <| blur <| px pixels ] )
                    , ( "to", [ filter "none" ] )
                    ]
                , body
                    [ children
                        [ F.map idC
                            (\_ ->
                                filter <| blur <| px pixels
                            )
                            (F.bool showPopup)
                        , transitionJ [ "filter", ms duration ]
                        ]
                    ]
                ]
    , local =
        C.batch
            [ animationJ [ ms duration, name ]
            , filter "none"
            ]
    }
