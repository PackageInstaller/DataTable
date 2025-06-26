-- chunkname: @IQIGame\\Scene\\Home\\FSM\\RPGActorState_AnimationGroup.lua

local m = class(nil, FSMState)

m.Name = Constant.RPGActorFSMState.AnimationGroup
STATE = {
	playLoop = 2,
	playEnd = 3,
	playStart = 1
}

function m:OnEnter(args)
	self.args = args

	local component = HomeModule.homeScene.room:GetComponentWithId(self.args.componentId)

	if not component then
		logError("【RPG】播放动画失败，没有找到组件 id = " .. self.args.componentId)

		return
	end

	if self.args.componentId ~= 0 then
		local componentData = WorldMapModule.GetComponentDataWithId(self.args.componentId)

		if componentData:GetCfg().Type ~= Constant.RoomComponentsType.Role then
			logError(string.format("【RPG】播放动画失败，组件 id = %s 不是可播放动画的角色类型", self.args.componentId))

			return
		end
	end

	local cfgAnimation = CfgUtil.GetCfgAnimationDataWithID(self.args.animationId)

	if not cfgAnimation then
		return
	end

	self.cfgAnimation = cfgAnimation

	local npcActor = component

	self.npcActor = npcActor
	self.state = STATE.playStart
	self.dStartTime = Time.time
	self.duration = 0

	if not LuaUtility.StrIsNullOrEmpty(cfgAnimation.Start) then
		local ani = npcActor:FindAnimation(cfgAnimation.Start)

		if not ani then
			logError(string.format("【RPG】播放动画失败，角色 id = %s,没有动画 = %s", self.args.componentId, cfgAnimation.Start))

			return
		end

		self.duration = ani.Duration

		npcActor:PlayAnimation(cfgAnimation.Start, false)
	end
end

function m:OnUpdate(deltaTime)
	if self.state == STATE.playStart and Time.time - self.dStartTime >= self.duration and not LuaUtility.StrIsNullOrEmpty(self.cfgAnimation.Loop) then
		local ani = self.npcActor:FindAnimation(self.cfgAnimation.Loop)

		if not ani then
			logError(string.format("【RPG】播放动画失败，角色 id = %s,没有动画 = %s", self.args.componentId, self.cfgAnimation.Loop))

			return
		end

		self.npcActor:PlayAnimation(self.cfgAnimation.Loop, true)

		self.state = STATE.playLoop
	end
end

function m:OnExit()
	return
end

return m
