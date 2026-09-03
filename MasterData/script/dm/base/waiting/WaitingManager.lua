-- chunkname: @/tmp/or_script/lua_compile/dm/base/waiting/WaitingManager.lua

WaitingHandlerPriority = {
	kGameServer = 200,
	kRTPVPServer = 100
}
WaitingManager = class("WaitingManager", legs.Actor)

function WaitingManager:initialize()
	super.initialize(self)

	self._registerHandlers = {}
end

function WaitingManager:dispose()
	super.dispose(self)
end

function WaitingManager:isRegistered(waitingHandler)
	for index, handlerData in pairs(self._registerHandlers) do
		if handlerData.handler == waitingHandler then
			return true, index
		end
	end

	return false
end

function WaitingManager:register(waitingHandler, priority)
	local registered, index = self:isRegistered(waitingHandler)

	if registered then
		self._registerHandlers[index].priority = priority
	else
		self._registerHandlers[#self._registerHandlers + 1] = {
			handler = waitingHandler,
			priority = priority
		}
	end

	table.sort(self._registerHandlers, function(a, b)
		return a.priority < b.priority
	end)
	self:updateHandleMode()
end

function WaitingManager:unregister(waitingHandler)
	for index = #self._registerHandlers, 1, -1 do
		local handlerData = self._registerHandlers[index]

		if handlerData.handler and handlerData.handler == waitingHandler then
			handlerData.handler:setMode(WaitingHandleMode.kSilence)
			table.remove(self._registerHandlers, index)
		end
	end

	self:updateHandleMode()
end

function WaitingManager:updateHandleMode()
	for index, handlerData in pairs(self._registerHandlers) do
		if handlerData.handler then
			handlerData.handler:setMode((index == 1 or nil) and (WaitingHandleMode.kActive or WaitingHandleMode.kSilence))
		end
	end
end
