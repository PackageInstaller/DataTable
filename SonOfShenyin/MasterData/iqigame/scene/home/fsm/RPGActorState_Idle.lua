-- chunkname: @IQIGame\\Scene\\Home\\FSM\\RPGActorState_Idle.lua

local m = class(nil, FSMState)

m.Name = Constant.RPGActorFSMState.Idle

function m:OnEnter(args)
	self.args = args
end

function m:OnUpdate(deltaTime)
	return
end

function m:OnExit()
	return
end

return m
