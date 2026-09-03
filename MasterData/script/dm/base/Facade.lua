-- chunkname: @/tmp/or_script/lua_compile/dm/base/Facade.lua

Facade = class("Facade", legs.Actor, _M)

function Facade:mapEventListener(dispatcher, type, target, listener, useCapture, priority)
	local eventMap = self:getEventMap()

	eventMap:mapListener(dispatcher, type, target, listener, useCapture, priority)
end

function Facade:unmapEventListener(dispatcher, type, target, listener, useCapture)
	if self._eventMap ~= nil then
		self._eventMap:unmapListener(dispatcher, type, target, listener, useCapture)
	end
end
