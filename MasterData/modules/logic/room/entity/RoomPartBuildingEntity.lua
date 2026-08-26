-- chunkname: @modules/logic/room/entity/RoomPartBuildingEntity.lua

module("modules.logic.room.entity.RoomPartBuildingEntity", package.seeall)

local RoomPartBuildingEntity = class("RoomPartBuildingEntity", RoomBaseEntity)

function RoomPartBuildingEntity:ctor(entityId)
	RoomPartBuildingEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
	self._isWorking = nil
end

function RoomPartBuildingEntity:getTag()
	return SceneTag.RoomPartBuilding
end

function RoomPartBuildingEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO

	RoomPartBuildingEntity.super.init(self, go)

	self._scene = GameSceneMgr.instance:getCurScene()

	self:_refreshWorkingState()
end

function RoomPartBuildingEntity:initComponents()
	self:addComp("effect", RoomEffectComp)

	if RoomController.instance:isObMode() then
		self:addComp("collider", RoomColliderComp)
		self:addComp("atmosphere", RoomAtmosphereComp)
	end

	self:addComp("nightlight", RoomNightLightComp)
	self:addComp("skin", RoomInitBuildingSkinComp)
	self:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
end

function RoomPartBuildingEntity:onStart()
	RoomPartBuildingEntity.super.onStart(self)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, self.refreshBuilding, self)
	RoomController.instance:registerCallback(RoomEvent.ProduceLineLevelUp, self.refreshBuilding, self)
	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, self._refreshWorkingState, self)
	RoomController.instance:registerCallback(RoomEvent.OnLateInitDone, self._onLateInitDone, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, self._characterListShowChanged, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._onSwithMode, self)
end

function RoomPartBuildingEntity:_onLateInitDone()
	self._lateInitDone = true

	self:_refreshAudio()
end

function RoomPartBuildingEntity:refreshBuilding(alphaThreshold, alphaThresholdValue)
	local res = self:_getPartBuildingRes()

	if string.nilorempty(res) then
		self.effect:removeParams({
			RoomEnum.EffectKey.BuildingGOKey
		})
	else
		self.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				pathfinding = true,
				res = res,
				alphaThreshold = alphaThreshold,
				alphaThresholdValue = alphaThresholdValue
			}
		})
	end

	self.effect:refreshEffect()
	self:_refreshMaxLevel()
	self:_refreshAudio()
end

function RoomPartBuildingEntity:_levelUp()
	self:refreshBuilding()
end

function RoomPartBuildingEntity:onEffectRebuild()
	self:_refreshWorkingEffect()
	self:_refreshAudio()
end

function RoomPartBuildingEntity:tweenAlphaThreshold(from, to, duration, finishCb, finishCbObj)
	if not self.alphaThresholdComp then
		return
	end

	self.alphaThresholdComp:tweenAlphaThreshold(from, to, duration, finishCb, finishCbObj)
end

function RoomPartBuildingEntity:_characterListShowChanged(isShow)
	self:setEnable(not RoomController.instance:isEditMode() and not isShow)
end

function RoomPartBuildingEntity:_onSwithMode()
	self:setEnable(not RoomController.instance:isEditMode())
end

function RoomPartBuildingEntity:setEnable(isEnable)
	if self.collider then
		self.collider:setEnable(isEnable and true or false)
	end
end

function RoomPartBuildingEntity:_getPartBuildingRes()
	local result
	local showSkinId = RoomSkinModel.instance:getShowSkin(self.id)
	local isDefaultRoomSkin = RoomSkinModel.instance:isDefaultRoomSkin(self.id, showSkinId)

	if isDefaultRoomSkin then
		result = RoomInitBuildingHelper.getModelPath(self.id)
	else
		local modelPath = RoomConfig.instance:getRoomSkinModelPath(showSkinId)

		result = modelPath or RoomSkinModel.instance:getEquipRoomSkin(self.id)
	end

	return result
end

function RoomPartBuildingEntity:_refreshWorkingState()
	local isWorking = RoomProductionHelper.isPartWorking(self.id)

	if self._isWorking == false and isWorking == true then
		self:_playChangeAudio()
	end

	self._isWorking = isWorking

	self:_refreshWorkingEffect()
	self:_refreshAudio()
end

function RoomPartBuildingEntity:_playChangeAudio()
	local partConfig = RoomConfig.instance:getProductionPartConfig(self.id)

	if partConfig.changeAudio ~= 0 then
		AudioMgr.instance:trigger(partConfig.changeAudio, self.go)
	end
end

function RoomPartBuildingEntity:_refreshWorkingEffect()
	local goJob = self.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EffectPath.PartWorkingPath)
	local goFull = self.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EffectPath.PartFullPath)

	if goJob then
		gohelper.setActive(goJob, self._isWorking)
	end

	if goFull then
		gohelper.setActive(goFull, not self._isWorking)
	end
end

function RoomPartBuildingEntity:beforeDestroy()
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, self.refreshBuilding, self)
	RoomController.instance:unregisterCallback(RoomEvent.ProduceLineLevelUp, self.refreshBuilding, self)
	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, self._refreshWorkingState, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnLateInitDone, self._onLateInitDone, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, self._characterListShowChanged, self)
	RoomController.instance:unregisterCallback(self._onSwithMode, self)

	for _, comp in ipairs(self._compList) do
		if comp.beforeDestroy then
			comp:beforeDestroy()
		end
	end

	self._lateInitDone = nil

	self:_stopAudio()
end

function RoomPartBuildingEntity:getCharacterMeshRendererList()
	return self.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

function RoomPartBuildingEntity:_refreshMaxLevel()
	local partConfig = RoomConfig.instance:getProductionPartConfig(self.id)

	if not partConfig then
		self._maxLevel = 0

		return
	end

	local lineIds = partConfig.productionLines
	local maxLevel = 0

	for i, lineId in ipairs(lineIds) do
		local level = 0

		if RoomController.instance:isVisitMode() then
			local otherLineLevelDict = RoomMapModel.instance:getOtherLineLevelDict()

			level = otherLineLevelDict[lineId] or 0
		elseif RoomController.instance:isDebugMode() then
			maxLevel = 1

			break
		else
			local lineMO = RoomProductionModel.instance:getLineMO(lineId)

			level = lineMO and lineMO.level or 0
		end

		if maxLevel < level then
			maxLevel = level
		end
	end

	self._maxLevel = maxLevel
end

function RoomPartBuildingEntity:_refreshAudio()
	if not self._lateInitDone then
		return
	end

	local res = self:_getPartBuildingRes()

	if string.nilorempty(res) then
		self:_stopAudio()

		return
	end

	if not self._maxLevel or self._maxLevel <= 0 then
		self:_stopAudio()

		return
	end

	local emitter = ZProj.AudioEmitter.Get(self.go)
	local partConfig = RoomConfig.instance:getProductionPartConfig(self.id)

	if partConfig.audio ~= 0 then
		if self._audioId ~= partConfig.audio then
			emitter:Emitter(partConfig.audio)

			self._audioId = partConfig.audio
		end

		if emitter.playingId > 0 then
			local value = 0

			if self._isWorking then
				value = RoomProductionHelper.getSkinLevel(self.id, self._maxLevel)
			end

			value = math.min(value, 3)

			AudioMgr.instance:setRTPCValueByPlayingID(AudioMgr.instance:getIdFromString(AudioEnum.RoomRTPC.HomePivotRank), value, emitter.playingId)
		end
	end
end

function RoomPartBuildingEntity:_stopAudio()
	local emitter = ZProj.AudioEmitter.Get(self.go)

	if emitter.playingId > 0 then
		AudioMgr.instance:stopPlayingID(emitter.playingId)
	end

	self._audioId = nil
end

return RoomPartBuildingEntity
