-- chunkname: @IQIGame\\Scene\\Home\\Actor\\WorkerActor.lua

local HomeActorMoveData = require("IQIGame/Module/Home/HomeActorMoveData")
local HomeActorRandomSpeakData = require("IQIGame/Module/Home/HomeActorRandomSpeakData")
local SpineActor = require("IQIGame/Scene/Home/Actor/SpineActor")
local WorkerActor = Clone(SpineActor)

WorkerActor.moveData = nil
WorkerActor.speakData = nil
WorkerActor.entityCid = 0
WorkerActor.UIMountTrans = nil

function WorkerActor:__OnInit()
	local skinConfig = SkinModule.GetHeroDefaultSkinCfg(self.actorCid)

	self.entityCid = skinConfig.HomeEntityID

	self:__SpineActor_LoadSpine(self.entityCid)

	local min = HomeLandConstant.RoomWorkActorSpeakIntervalFloatTime * -1
	local max = HomeLandConstant.RoomWorkActorSpeakIntervalFloatTime
	local speakIntervalTime = HomeLandConstant.RoomWorkActorSpeakIntervalTime + math.random(min, max)

	self.speakData = HomeActorRandomSpeakData.New(self.actorCid, speakIntervalTime)
end

function WorkerActor:__GetLayerName()
	return "StoryNPC"
end

function WorkerActor:GetSceneActorType()
	return Constant.HomeSceneActorType.WorkActor
end

function WorkerActor:__OnInitSpine(gameObject)
	self:__SpineActor_InitSpine(gameObject)

	self.boxCollider.isTrigger = true
	self.UIMountTrans = gameObject.transform:Find("Ui")

	self:__OnActorPrepareReady()
end

function WorkerActor:__OnDispose()
	EventDispatcher.Dispatch(EventID.HomeWorkActorExitRoom, self.actorCid)
	self:__SpineActor_OnDispose()

	if self.moveData ~= nil then
		self.moveData:Dispose()

		self.moveData = nil
	end
end

function WorkerActor:SetWorkPointIndex(index)
	self.workPointIndex = index
end

function WorkerActor:Mount(parentTrans)
	local position = Vector3.zero
	local movePointRoot = parentTrans:Find("MovePoints")

	if movePointRoot ~= nil then
		movePointRoot.gameObject:SetActive(false)

		self.moveData = HomeActorMoveData.New(movePointRoot)
		position = self.moveData.beginPos
	end

	self.skinEntityGo.transform.parent = parentTrans
	self.skinEntityGo.transform.localPosition = position
	self.skinEntityGo.transform.localScale = Vector3.one

	local elementEntityConfig = CfgElementEntityTable[self.entityCid]

	self:SetFlipX(elementEntityConfig.IsPrefabFaceToRight)
	self.controller:OnStartWork()
end

return WorkerActor
