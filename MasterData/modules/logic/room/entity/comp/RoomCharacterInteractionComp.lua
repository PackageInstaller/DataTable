-- chunkname: @modules/logic/room/entity/comp/RoomCharacterInteractionComp.lua

module("modules.logic.room.entity.comp.RoomCharacterInteractionComp", package.seeall)

local RoomCharacterInteractionComp = class("RoomCharacterInteractionComp", LuaCompBase)

function RoomCharacterInteractionComp:ctor(entity)
	self._faithFill = 0
	self.entity = entity
	self._effectKeyResDict = {
		[RoomEnum.EffectKey.CharacterFaithMaxKey] = RoomScenePreloader.ResCharacterFaithMax,
		[RoomEnum.EffectKey.CharacterFaithFullKey] = RoomScenePreloader.ResCharacterFaithFull,
		[RoomEnum.EffectKey.CharacterFaithNormalKey] = RoomScenePreloader.ResCharacterFaithNormal,
		[RoomEnum.EffectKey.CharacterChatKey] = RoomScenePreloader.ResCharacterChat
	}
	self._showCameraStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true
	}
	self._offsetX = 0
	self._offsetY = 0
	self._offsetZ = 0
	self._effectKeyInxDict = {}

	local inx = 0

	for k, v in pairs(self._effectKeyResDict) do
		self._effectKeyInxDict[k] = inx
		inx = inx + 1
	end
end

function RoomCharacterInteractionComp:init(go)
	self.go = go
	self._goTrs = go.transform
	self._scene = GameSceneMgr.instance:getCurScene()

	self:_refreshShowIcom()
end

function RoomCharacterInteractionComp:getMO()
	return self.entity:getMO()
end

function RoomCharacterInteractionComp:addEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._characterPositionChanged, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, self.startCheckEventTask, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, self.startCheckEventTask, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterCanConfirm, self.startCheckEventTask, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, self.startCheckEventTask, self)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, self.startCheckEventTask, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, self.startCheckEventTask, self)
end

function RoomCharacterInteractionComp:removeEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._characterPositionChanged, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, self.startCheckEventTask, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, self.startCheckEventTask, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterCanConfirm, self.startCheckEventTask, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, self.startCheckEventTask, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, self.startCheckEventTask, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, self.startCheckEventTask, self)

	self._isHasCheckEventTask = false

	TaskDispatcher.cancelTask(self._onRunCheckEventTask, self)
end

function RoomCharacterInteractionComp:_characterPositionChanged()
	local cameraState = self._scene.camera:getCameraState()

	if self._lastCameraState ~= cameraState then
		self._lastCameraState = cameraState

		self:startCheckEventTask()
	end

	self:_updateParticlePosOffset()
end

function RoomCharacterInteractionComp:startCheckEventTask()
	if not self._isHasCheckEventTask then
		self._isHasCheckEventTask = true

		TaskDispatcher.runDelay(self._onRunCheckEventTask, self, 0.1)
	end
end

function RoomCharacterInteractionComp:_onRunCheckEventTask()
	self._isHasCheckEventTask = false

	self:_refreshShowIcom()
end

function RoomCharacterInteractionComp:_refreshShowIcom()
	local showKey = self:_getShowEffectKey()

	self:_showByKey(showKey)
	self:_upateFaithFill()
end

function RoomCharacterInteractionComp:_getShowEffectKey()
	if not RoomController.instance:isObMode() then
		return nil
	end

	local cameraState = self._scene.camera:getCameraState()

	if not self._showCameraStateDict[cameraState] or RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return nil
	end

	local roomCharacterMO = self:getMO()

	if not roomCharacterMO or roomCharacterMO:isTrainSourceState() then
		return
	end

	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if tempCharacterMO and tempCharacterMO.id == roomCharacterMO.id then
		if RoomCharacterController.instance:isCharacterFaithFull(roomCharacterMO.heroId) then
			return RoomEnum.EffectKey.CharacterFaithMaxKey
		end

		return
	end

	local currentInteractionId = roomCharacterMO:getCurrentInteractionId()

	if currentInteractionId then
		local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

		if not playingInteractionParam then
			return RoomEnum.EffectKey.CharacterChatKey
		end
	else
		if RoomCharacterController.instance:isCharacterFaithFull(roomCharacterMO.heroId) then
			if RoomCharacterModel.instance:isShowFaithFull(roomCharacterMO.heroId) then
				return RoomEnum.EffectKey.CharacterFaithMaxKey
			end

			return nil
		end

		local faithFill = RoomCharacterHelper.getCharacterFaithFill(roomCharacterMO)

		if faithFill >= 1 then
			return RoomEnum.EffectKey.CharacterFaithFullKey
		elseif faithFill > 0 then
			self._faithFill = faithFill

			return RoomEnum.EffectKey.CharacterFaithNormalKey
		end
	end
end

function RoomCharacterInteractionComp:_showByKey(showKey)
	self._curShowKey = showKey

	local effect = self.entity.effect

	for key, res in pairs(self._effectKeyResDict) do
		effect:setActiveByKey(key, showKey == key)
	end

	if self._effectKeyResDict[showKey] and not effect:isHasEffectGOByKey(showKey) then
		effect:addParams({
			[showKey] = {
				res = self._effectKeyResDict[showKey]
			}
		})
		effect:refreshEffect()
	end
end

function RoomCharacterInteractionComp:_upateFaithFill()
	if self._isLastFaithFill == self._faithFill then
		return
	end

	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(RoomEnum.EffectKey.CharacterFaithNormalKey) then
		self._isLastFaithFill = self._faithFill

		local list = effect:getComponentsByPath(RoomEnum.EffectKey.CharacterFaithNormalKey, RoomEnum.ComponentName.Renderer, "mesh/faith_process")
		local mpb = self._scene.mapmgr:getPropertyBlock()

		mpb:Clear()

		local y = Mathf.Lerp(-0.53, -0.7, self._faithFill)

		mpb:SetVector("_UVOffset", Vector4.New(0, y, 0, 0))
		mpb:SetVector("_ParticlePosOffset", Vector4.New(0, self._offsetY, 0, 0))

		for _, renderer in ipairs(list) do
			renderer:SetPropertyBlock(mpb)
		end

		transformhelper.setLocalPos(effect:getEffectGOTrs(RoomEnum.EffectKey.CharacterFaithNormalKey), self._offsetX, 0, self._offsetZ)
	end
end

function RoomCharacterInteractionComp:_updateParticlePosOffset()
	local effect = self.entity.effect

	if not self._effectKeyResDict[self._curShowKey] or not effect:isHasEffectGOByKey(self._curShowKey) then
		return
	end

	local headGOTrs = self.entity.characterspine:getMountheadGOTrs()

	if not headGOTrs then
		return
	end

	local x, y, z = transformhelper.getPos(headGOTrs)
	local x1, y1, z1 = transformhelper.getPos(self.entity.containerGOTrs)
	local ofx = x - x1
	local ofy = y - y1 + 0.08
	local ofz = z - z1
	local abs = 0.001

	if abs < math.abs(ofx - self._offsetX) or abs < math.abs(ofy - self._offsetY) or abs < math.abs(ofz - self._offsetZ) or self._lastInx ~= self._effectKeyInxDict[self._curShowKey] then
		self._offsetX = ofx
		self._offsetY = ofy
		self._offsetZ = ofz
		self._lastInx = self._effectKeyInxDict[self._curShowKey]

		transformhelper.setLocalPos(effect:getEffectGOTrs(self._curShowKey), self._offsetX, 0, self._offsetZ)

		local list = effect:getComponentsByPath(self._curShowKey, RoomEnum.ComponentName.Renderer, "mesh")
		local mpb = self._scene.mapmgr:getPropertyBlock()

		mpb:Clear()
		mpb:SetVector("_ParticlePosOffset", Vector4.New(0, self._offsetY, 0, 0))

		for _, renderer in ipairs(list) do
			renderer:SetPropertyBlock(mpb)
		end

		if self._curShowKey == RoomEnum.EffectKey.CharacterFaithNormalKey then
			self._isLastFaithFill = -1

			self:_upateFaithFill()
		end
	end
end

return RoomCharacterInteractionComp
