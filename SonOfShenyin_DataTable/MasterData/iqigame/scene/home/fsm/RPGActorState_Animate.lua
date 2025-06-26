-- chunkname: @IQIGame\\Scene\\Home\\FSM\\RPGActorState_Animate.lua

local m = class(nil, FSMState)

m.Name = Constant.RPGActorFSMState.Animate

function m:OnEnter(args)
	self.args = args

	local actor = args.actor

	actor:PlayAnimation(args.actionParam[1], true)

	self.dStartTime = Time.time
	self.duration = tonumber(args.actionParam[2])
end

function m:OnUpdate(deltaTime)
	if Time.time - self.dStartTime >= self.duration then
		self.args.actor.controller:RandomStartAI()
	end
end

function m:OnExit()
	return
end

return m
