-- chunkname: @IQIGame\\Scene\\Home\\Controller\\NpcController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local AStartMoveControllerClass = require("IQIGame/Scene/Home/AStart/AStartMoveController")
local m = Clone(ActorController)
local saunterStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_Saunter")
local animateStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_Animate")
local animationGroupStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_AnimationGroup")
local chatStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_Chat")
local idleStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_Idle")

function m:__OnInit()
	self:InitAction()
	self:InitFSM()
	self.actor.actorComponent.triggerEnterEvent:AddListener(self.onCollisionEnterEvent)
	self.actor.actorComponent.triggerExitEvent:AddListener(self.onCollisionEXitEvent)

	self.autoMoveController = AStartMoveControllerClass.New(self.actor.skinEntityGo, self.actor)

	local componentData = WorldMapModule.GetComponentDataWithId(self.actor.componentId)

	if not LuaUtility.StrIsNullOrEmpty(componentData:GetCfg().ActionMove) then
		self.normalMoveAnimation = componentData:GetCfg().ActionMove
	else
		self.normalMoveAnimation = "H_move"
	end

	if not LuaUtility.StrIsNullOrEmpty(componentData:GetCfg().ActionIdle) then
		self.normalIdleAnimation = componentData:GetCfg().ActionIdle
	else
		self.normalIdleAnimation = "H_stay"
	end

	self.autoMoveController:SetWalkingAnimateName(self.normalMoveAnimation)
	self.autoMoveController:SetIdleAnimateName(componentData:GetCfg().ActionIdle)
	self.actor:PlayAnimation(self.normalIdleAnimation, true)
	self.actor:SetFlipX(not componentData:GetCfg().IsToLeft)
	self:__OnControllerReady()
end

function m:__OnInitEventDelegate()
	function self.onCollisionEnterEvent(actorCom)
		self:onCollisionEnter(actorCom)
	end

	function self.onCollisionEXitEvent(actorCom)
		self:OnCollisionExit(actorCom)
	end
end

function m:__OnAddListeners()
	return
end

function m:__OnRemoveListeners()
	return
end

function m:__OnDispose()
	self.actor.actorComponent.triggerEnterEvent:RemoveListener(self.onCollisionEnterEvent)
	self.actor.actorComponent.triggerExitEvent:RemoveListener(self.onCollisionEXitEvent)
	FSMModule.RemoveFsm(self.fsm)
end

function m:onCollisionEnter(actorCom)
	WorldMapModule.OnActorInteractPlayer(self.actor)
end

function m:OnCollisionExit(actorCom)
	WorldMapModule.OnACtorDisInteractPlayer(self.actor)
end

function m:InitAction()
	self.haveTag = false

	local componentData = WorldMapModule.GetComponentDataWithId(self.actor.componentId)
	local actionList = componentData:GetActionList()
	local topTag

	for _, v in pairs(actionList) do
		local cfgAction = v:GetCfg()

		if v:CheckIsActiveTag() then
			if not topTag then
				topTag = cfgAction.IconType
			elseif topTag > cfgAction.IconType then
				topTag = cfgAction.IconType
			end
		end
	end

	if topTag then
		local actor = HomeModule.GetRoomComponentWithId(self.actor.componentId)

		EventDispatcher.Dispatch(EventID.MainUI_ShowNpcTagEvent, actor:GetTagMountPoint(), topTag, self.actor:GetComponentId())

		self.haveTag = true
		self.tagType = topTag
	end
end

function m:InitFSM()
	if not self.fsm then
		self.fsm = FSMModule.CreateFsm(Constant.FSMType.RPGActorFSM, {
			actor = self.actor
		})
	end

	self.fsm:AddState(chatStateClass())
	self.fsm:AddState(animationGroupStateClass())
	self.fsm:AddState(idleStateClass())

	local componentData = WorldMapModule.GetComponentDataWithId(self.actor.componentId)
	local aiGroupId = componentData:GetCfg().AiGroupId

	if not aiGroupId or aiGroupId == 0 then
		return
	end

	local aiGroup = CfgUtil.GetCfgAiGroupDataWithID(aiGroupId)
	local len = #aiGroup.ActionType

	for i = 1, len do
		if aiGroup.ActionType[i] == Constant.RPGAIActionType.Saunter then
			self.fsm:AddState(saunterStateClass())
		elseif aiGroup.ActionType[i] == Constant.RPGAIActionType.Animate then
			self.fsm:AddState(animateStateClass())
		end
	end
end

function m:ChangeStateByName(stateName, args)
	if not self.fsm then
		return
	end

	self.fsm:ChangeStateByName(stateName, args)
end

function m:RandomStartAI()
	local componentData = WorldMapModule.GetComponentDataWithId(self.actor.componentId)
	local aiGroupId = componentData:GetCfg().AiGroupId

	if not aiGroupId or aiGroupId == 0 then
		return
	end

	local aiGroup = CfgUtil.GetCfgAiGroupDataWithID(aiGroupId)
	local len = #aiGroup.ActionType
	local n = math.random(1, len)

	if aiGroup.ActionType[n] == Constant.RPGAIActionType.Saunter then
		local arg = {}

		arg.actor = self.actor
		arg.actionParam = aiGroup.ActionParam[n]

		self.fsm:ChangeStateByName(Constant.RPGActorFSMState.Saunter, arg)
	elseif aiGroup.ActionType[n] == Constant.RPGAIActionType.Animate then
		local arg = {}

		arg.actor = self.actor
		arg.actionParam = aiGroup.ActionParam[n]

		self.fsm:ChangeStateByName(Constant.RPGActorFSMState.Animate, arg)
	end
end

return m
