-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/StoryEvents.lua

module("story", package.seeall)

TouchEvent = class("TouchEvent", Event)

TouchEvent:has("_cCTouch", {
	is = "r"
})
TouchEvent:has("_cCEvent", {
	is = "r"
})

function TouchEvent:initialize(type, touch, event, data)
	super.initialize(self, type, data)

	self._cCTouch = touch
	self._cCEvent = event
end
