-- chunkname: @modules/logic/room/entity/comp/RoomCritterEventItemComp.lua

module("modules.logic.room.entity.comp.RoomCritterEventItemComp", package.seeall)

local RoomCritterEventItemComp = class("RoomCritterEventItemComp", LuaCompBase)

function RoomCritterEventItemComp:ctor(entity)
	self._faithFill = 0
	self.entity = entity
	self._eventType2ResDict = {
		[CritterEnum.CritterItemEventType.HasTrainEvent] = RoomScenePreloader.ResCritterEvent.HasTrainEvent,
		[CritterEnum.CritterItemEventType.TrainEventComplete] = RoomScenePreloader.ResCritterEvent.TrainEventComplete,
		[CritterEnum.CritterItemEventType.NoMoodWork] = RoomScenePreloader.ResCritterEvent.NoMoodWork,
		[CritterEnum.CritterItemEventType.SurpriseCollect] = RoomScenePreloader.ResCritterEvent.SurpriseCollect
	}
	self._showCameraStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true
	}
	self._offsetX = 0
	self._offsetY = 0
	self._offsetZ = 0
	self._eventType2SkowKeyDict = {}

	for k, v in pairs(self._eventType2ResDict) do
		self._eventType2SkowKeyDict[k] = "critter_event_" .. k
	end
end

function RoomCritterEventItemComp:init(go)
	self.go = go
	self._goTrs = go.transform
	self._scene = GameSceneMgr.instance:getCurScene()

	self:startCheckTrainEventTask()
end

function RoomCritterEventItemComp:getMO()
	return self.entity:getMO()
end

function RoomCritterEventItemComp:addEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._characterPositionChanged, self)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushReply, self.startCheckTrainEventTask, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, self.startCheckTrainEventTask, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, self.startCheckTrainEventTask, self)
end

function RoomCritterEventItemComp:removeEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._characterPositionChanged, self)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushReply, self.startCheckTrainEventTask, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, self.startCheckTrainEventTask, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, self.startCheckTrainEventTask, self)
	TaskDispatcher.cancelTask(self._onRunCheckTrainEventTask, self)

	self._isHasCheckTrainEventTask = false
end

function RoomCritterEventItemComp:_characterPositionChanged()
	local cameraState = self._scene.camera:getCameraState()

	if self._lastCameraState ~= cameraState then
		self._lastCameraState = cameraState

		self:startCheckTrainEventTask()
	end

	self:_updateParticlePosOffset()
end

function RoomCritterEventItemComp:_refreshShowIcom()
	local eventType = self:_getShowEventType()

	self:_showByEventType(eventType)
end

function RoomCritterEventItemComp:startCheckTrainEventTask()
	if not self._isHasCheckTrainEventTask then
		self._isHasCheckTrainEventTask = true

		TaskDispatcher.runDelay(self._onRunCheckTrainEventTask, self, 0.1)
	end
end

function RoomCritterEventItemComp:_onRunCheckTrainEventTask()
	self._isHasCheckTrainEventTask = false

	self:_refreshShowIcom()
end

function RoomCritterEventItemComp:_getShowEventType()
	if not RoomController.instance:isObMode() then
		return nil
	end

	local cameraState = self._scene.camera:getCameraState()

	if not self._showCameraStateDict[cameraState] or RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return nil
	end

	local critterMO = CritterModel.instance:getCritterMOByUid(self.entity.id)

	return CritterHelper.getEventTypeByCritterMO(critterMO)
end

function RoomCritterEventItemComp:_showByEventType(eventType)
	self._curShowEventType = eventType

	local effect = self.entity.effect

	for eType, effectKey in pairs(self._eventType2SkowKeyDict) do
		effect:setActiveByKey(effectKey, eType == eventType)
	end

	local showKey = self._eventType2SkowKeyDict[eventType]

	if self._eventType2ResDict[eventType] and not effect:isHasEffectGOByKey(showKey) then
		effect:addParams({
			[showKey] = {
				res = self._eventType2ResDict[eventType]
			}
		})
		effect:refreshEffect()
	end
end

function RoomCritterEventItemComp:_updateParticlePosOffset()
	local effect = self.entity.effect
	local effectKey = self._eventType2SkowKeyDict[self._curShowEventType]

	if not effectKey or not effect:isHasEffectGOByKey(effectKey) then
		return
	end

	local headGOTrs = self.entity.critterspine:getMountheadGOTrs()

	if not headGOTrs then
		return
	end

	local x, y, z = transformhelper.getPos(headGOTrs)
	local x1, y1, z1 = transformhelper.getPos(self.entity.containerGOTrs)
	local ofx = x - x1
	local ofy = y - y1 + 0.08
	local ofz = z - z1
	local abs = 0.001

	if abs < math.abs(ofx - self._offsetX) or abs < math.abs(ofy - self._offsetY) or abs < math.abs(ofz - self._offsetZ) or self._lastInx ~= self._curShowEventType then
		self._offsetX = ofx
		self._offsetY = ofy
		self._offsetZ = ofz
		self._lastInx = self._curShowEventType

		transformhelper.setLocalPos(effect:getEffectGOTrs(effectKey), self._offsetX, 0, self._offsetZ)

		local list = effect:getComponentsByKey(effectKey, RoomEnum.ComponentName.Renderer)
		local mpb = self._scene.mapmgr:getPropertyBlock()

		mpb:Clear()
		mpb:SetVector("_ParticlePosOffset", Vector4.New(0, self._offsetY, 0, 0))

		for _, renderer in ipairs(list) do
			renderer:SetPropertyBlock(mpb)
		end
	end
end

return RoomCritterEventItemComp
