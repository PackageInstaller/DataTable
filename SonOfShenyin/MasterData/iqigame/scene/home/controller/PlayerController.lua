-- chunkname: @IQIGame\\Scene\\Home\\Controller\\PlayerController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local Controller = Clone(ActorController)
local AStartMoveControllerClass = require("IQIGame/Scene/Home/AStart/AStartMoveController")
local chatStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_Chat")
local animationGroupStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_AnimationGroup")

function Controller:__OnInit()
	self.actor.actorComponent.CollisionEnterEvent:AddListener(self.__delegateOnCollisionEnterEvent)
	self.actor.actorComponent.CollisionExitEvent:AddListener(self.__delegateOnCollisionExitEvent)

	self.actor.actorComponent.isEnabledPosShow = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.PlayerPosShow) == "true"
	self.autoMoveController = AStartMoveControllerClass.New(self.actor.skinEntityGo, self.actor)
	self.normalIdleAnimation = "S_stay"
	self.normalMoveAnimation = "S_move"

	self.autoMoveController:SetWalkingAnimateName(self.normalMoveAnimation)
	self.autoMoveController:SetIdleAnimateName(self.normalIdleAnimation)

	self.moveSpeed = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.RPGPlayerMoveSpeed)[1] / 100
	self.runSpeed = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.RPGPlayerMoveSpeed)[2] / 100

	self.actor:PlayAnimation(self.normalIdleAnimation, true)
	self:__OnControllerReady()
	self:InitFSM()
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnJoystickMoveStart()
		self:__OnJoystickMoveStart()
	end

	function self.__delegateOnJoystickMove(_direction)
		self:__OnJoystickMove(_direction)
	end

	function self.__delegateOnJoystickMoveEnd()
		self:__OnJoystickMoveEnd()
	end

	function self.__delegateOnCollisionEnterEvent(_actorCom)
		self:OnCollisionEnterEvent(_actorCom)
	end

	function self.__delegateOnCollisionExitEvent(_actorCom)
		self:OnCollisionExitEvent(_actorCom)
	end
end

function Controller:__OnAddListeners()
	EventDispatcher.AddEventListener(EventID.JoystickMoveStart, self.__delegateOnJoystickMoveStart)
	EventDispatcher.AddEventListener(EventID.JoystickMove, self.__delegateOnJoystickMove)
	EventDispatcher.AddEventListener(EventID.JoystickMoveEnd, self.__delegateOnJoystickMoveEnd)
end

function Controller:__OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.JoystickMoveStart, self.__delegateOnJoystickMoveStart)
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, self.__delegateOnJoystickMove)
	EventDispatcher.RemoveEventListener(EventID.JoystickMoveEnd, self.__delegateOnJoystickMoveEnd)
end

function Controller:__OnDispose()
	self:__StopRunSound()
	self.actor.actorComponent.CollisionEnterEvent:RemoveListener(self.__delegateOnCollisionEnterEvent)
	self.actor.actorComponent.CollisionExitEvent:RemoveListener(self.__delegateOnCollisionExitEvent)
	FSMModule.RemoveFsm(self.fsm)
end

function Controller:__OnJoystickMoveStart()
	self.actor:PlayAnimation(HomeLandApi.PlayerMoveAnimName, true)
end

function Controller:__OnJoystickMove(direction)
	if direction.x == 0 then
		return
	end

	if math.abs(direction.x) >= 0.5 or math.abs(direction.y) >= 0.5 then
		if not self.isRun then
			self.isRun = true

			self.actor:PlayAnimation(HomeLandApi.PlayerRunAnimaName, true)
			EventDispatcher.Dispatch(EventID.UpdateHomePlayerMoveSpeed, self.runSpeed)

			self.runSoundSerialId = LuaUtility.PlaySoundWithID(22000020)
		end
	elseif self.isRun then
		self.isRun = false

		self.actor:PlayAnimation(HomeLandApi.PlayerMoveAnimName, true)
		self:__StopRunSound()
		EventDispatcher.Dispatch(EventID.UpdateHomePlayerMoveSpeed, self.moveSpeed)
	end

	self.actor:SetFlipX(direction.x > 0)
end

function Controller:__OnJoystickMoveEnd()
	self.actor:PlayAnimation("S_stay", true)
	self:__StopRunSound()
end

function Controller:__StopRunSound()
	if self.runSoundSerialId == nil then
		return
	end

	if self.runSoundSerialId == 0 then
		return
	end

	LuaUtility.StopSoundWithSerialId(self.runSoundSerialId)

	self.runSoundSerialId = 0
end

function Controller:OnCollisionEnterEvent(actorCom)
	EventDispatcher.Dispatch(EventID.HomePlayerActorCollisionPartEnterEvent, actorCom)
end

function Controller:OnCollisionExitEvent(actorCom)
	EventDispatcher.Dispatch(EventID.HomePlayerActorCollisionPartExitEvent, actorCom)
end

function Controller:InitFSM()
	if not self.fsm then
		self.fsm = FSMModule.CreateFsm(Constant.FSMType.RPGActorFSM, {
			actor = self.actor
		})
	end

	self.fsm:AddState(chatStateClass())
	self.fsm:AddState(animationGroupStateClass())
end

function Controller:ChangeStateByName(stateName, args)
	if not self.fsm then
		return
	end

	self.fsm:ChangeStateByName(stateName, args)
end

return Controller
