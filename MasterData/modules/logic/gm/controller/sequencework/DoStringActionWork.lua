-- chunkname: @modules/logic/gm/controller/sequencework/DoStringActionWork.lua

module("modules.logic.gm.controller.sequencework.DoStringActionWork", package.seeall)

local DoStringActionWork = class("DoStringActionWork", BaseWork)

function DoStringActionWork:ctor(actionStr)
	self._actionStr = actionStr
end

function DoStringActionWork:onStart(context)
	local func = loadstring(self._actionStr)

	if func then
		func()
	end

	self:onDone(true)
end

return DoStringActionWork
