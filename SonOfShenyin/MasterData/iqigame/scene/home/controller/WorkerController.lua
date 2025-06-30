-- chunkname: @IQIGame\\Scene\\Home\\Controller\\WorkerController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local Controller = Clone(ActorController)

Controller.isSpeaking = false

function Controller:__OnInit()
	self.state = HomeLandConstant.RoomWorkActorState.Idle
	self.isSpeaking = false

	self:__OnControllerReady()
end

function Controller:__GetActor()
	return self.actor
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnSpeakEnd(_actorCid)
		if _actorCid ~= self.actor.actorCid then
			return
		end

		self:__OnSpeakEnd()
	end
end

function Controller:__OnAddListeners()
	EventDispatcher.AddEventListener(EventID.HomeWorkActorEndSpeak, self.__delegateOnSpeakEnd)
end

function Controller:__OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.HomeWorkActorEndSpeak, self.__delegateOnSpeakEnd)
end

function Controller:__OnDispose()
	return
end

function Controller:__OnFrameUpdate()
	if self.state == HomeLandConstant.RoomWorkActorState.Moving then
		self:__OnWalkUpdate()
	end

	self:__TryEnterSpeakState()
end

function Controller:OnStartWork()
	if self:__GetActor().moveData ~= nil then
		self:__EnterMoveState()
	else
		self:__EnterWorkingState()
	end
end

function Controller:__EnterWorkingState()
	self.actor:PlayAnimation("H_work_1", true)

	self.state = HomeLandConstant.RoomWorkActorState.Working
end

function Controller:__EnterMoveState()
	local moveData = self:__GetActor().moveData

	self:__SetFlip(moveData.beginPos, moveData.endPos)
	self.actor:PlayAnimation("H_move", true)

	self.state = HomeLandConstant.RoomWorkActorState.Moving
end

function Controller:__OnWalkUpdate()
	local moveData = self:__GetActor().moveData
	local moveDir = Vector3.Normalize(moveData.beginPos - moveData.endPos)
	local pos = Vector3.Scale(moveDir, moveData.speed)

	self.actor.skinEntityGo.transform.localPosition = self.actor.skinEntityGo.transform.localPosition - pos

	if moveData:IsMoveEnd(self.actor.skinEntityGo.transform.localPosition) then
		moveData:UpdateNextPoint()
		self:__SetFlip(moveData.beginPos, moveData.endPos)
	end
end

function Controller:__SetFlip(localPoint, targetPoint)
	if localPoint.x > targetPoint.x then
		self:__GetActor():SetFlipX(false)
	elseif localPoint.x < targetPoint.x then
		self:__GetActor():SetFlipX(true)
	end
end

function Controller:__TryEnterSpeakState()
	if self.isSpeaking then
		return
	end

	local speakData = self:__GetActor().speakData

	if speakData == nil then
		return
	end

	local canSpeak, speakCid = speakData:TryExecute()

	if not canSpeak then
		return
	end

	self:__EnterSpeakState(speakCid)
end

function Controller:__EnterSpeakState(speakCid)
	self.isSpeaking = true

	EventDispatcher.Dispatch(EventID.HomeWorkActorStartSpeak, self.actor.actorCid, speakCid)
end

function Controller:__OnSpeakEnd()
	self.isSpeaking = false
end

return Controller
