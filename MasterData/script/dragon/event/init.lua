-- chunkname: @/tmp/or_script/lua_compile/dragon/event/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "Event")
require(__PACKAGE__ .. "EventListeners")
require(__PACKAGE__ .. "EventDispatcher")
require(__PACKAGE__ .. "NodeEventDispatcher")

_G.Event = event.Event
_G.EventPhase = event.EventPhase
_G.EventDispatcher = event.EventDispatcher
