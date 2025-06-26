-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_PlayAnimation.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	local component = HomeModule.GetRoomComponentWithId(self.args.actorId)

	if not component then
		logError(string.format("【RPG】播放动画失败，没有找到组件 id = %s", self.args.actorId))

		return
	end

	if self.args.actorId ~= 0 then
		local componentData = WorldMapModule.GetComponentDataWithId(self.args.actorId)

		if componentData:GetCfg().Type ~= Constant.RoomComponentsType.Role then
			logError(string.format("【RPG】播放动画失败，组件 id = %s 不是可播放动画的角色类型", self.args.actorId))

			return
		end
	end

	local animationId = tonumber(self.args.animationId)

	if not animationId then
		logError("【RPG】播放动画失败，没有动画组id")

		return
	end

	self.npcActor = component

	local args = {}

	args.componentId = self.args.actorId
	args.animationId = animationId

	self.npcActor.controller:ChangeStateByName(Constant.RPGActorFSMState.AnimationGroup, args)

	self.dStartTime = Time.time
end

function m:OnUpdate()
	if self.isComplete then
		return
	end

	if not self.dStartTime then
		return
	end

	if Time.time - self.dStartTime >= self.args.duration then
		self.isComplete = true
	end
end

function m:OnSkip()
	local cfgAnimationGroup = CfgUtil.GetCfgAnimationDataWithID(self.args.animationId)

	if cfgAnimationGroup.Start then
		self.npcActor:PlayAnimation(cfgAnimationGroup.Start, false)
	end

	if cfgAnimationGroup.Loop then
		self.npcActor:PlayAnimation(cfgAnimationGroup.Loop, true)
	end

	if cfgAnimationGroup.End then
		self.npcActor:PlayAnimation(cfgAnimationGroup.End, false)
	end

	self.isComplete = true
end

return m
