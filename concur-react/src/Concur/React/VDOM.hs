{-# LANGUAGE RankNTypes #-}
module Concur.React.VDOM where

import           GHCJS.Types            (JSString, JSVal)
import Unsafe.Coerce (unsafeCoerce)

-- import Concur.React.Attributes

type HTML = [VDOM]

data VDOM
  = VNode JSVal [VAttr] [VDOM]
  | VLeaf JSVal [VAttr]
  | VText JSString

data VAttr = VAttr
    { attrName :: JSString
    , attrValue :: Either JSVal (DOMEvent -> IO ())
    }

-- An Event object.
newtype DOMEvent = DOMEvent JSVal

vevt :: JSString -> (DOMEvent -> IO ()) -> VAttr
vevt name handler = VAttr name (Right handler)

vattr :: JSString -> JSString -> VAttr
vattr name val = VAttr name (Left $ unsafeCoerce val)

vattrData :: JSString -> JSVal -> VAttr
vattrData name val = VAttr name (Left val)

vnode :: JSVal -> [VAttr] -> [VDOM] -> VDOM
vnode = VNode

vleaf :: JSVal -> [VAttr] -> VDOM
vleaf = VLeaf

vtext :: JSString -> VDOM
vtext = VText

-- Internal representation of HTML. Here JSVal is a JS array of HTML nodes.
-- newtype HTMLNode = HTMLNode JSVal
-- type HTMLWrapper = HTMLInternal -> HTMLNode
-- type HTMLNodeName attrs = attrs -> HTMLWrapper


-- -- A React event
-- newtype ReactEvent = ReactEvent JSVal
