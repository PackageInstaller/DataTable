-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/URLContext.lua

URLContext = class("URLContext", objectlua.Object, _M)

URLContext:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function URLContext:initialize()
	super.initialize(self)
end

function URLContext:dispatch(event)
	local eventDispatcher = self:getEventDispatcher()

	if eventDispatcher ~= nil then
		return eventDispatcher:dispatchEvent(event)
	end
end
