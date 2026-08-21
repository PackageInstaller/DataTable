-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGStateCtrl.lua

local m = {
	HorizontalRPGStatePool = {}
}
local HorizontalRPGState = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGState")

function m.New(controller, stateDates)
	local obj = Clone(m)

	obj:Init(controller, stateDates)

	return obj
end

function m:Init(controller, stateDates)
	self.ObjController = controller
	self.HorizontalRPGStatePool = {}

	for i, v in pairs(stateDates) do
		local state = HorizontalRPGState.New(v, controller)

		self.HorizontalRPGStatePool[v.state] = state
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:Start()
	return
end

function m:FrameUpdate()
	if self.CurrentState then
		self.CurrentState:FrameUpdate()
	end
end

function m:ChangeState(stateKey)
	if self.CurrentState then
		if self.CurrentState.stateData.state == stateKey then
			return
		end

		self.CurrentState:Exit()
	end

	self.CurrentState = self.HorizontalRPGStatePool[stateKey]

	self.CurrentState:Enter()
end

function m:Dispose()
	self:RemoveListener()
end

return m
