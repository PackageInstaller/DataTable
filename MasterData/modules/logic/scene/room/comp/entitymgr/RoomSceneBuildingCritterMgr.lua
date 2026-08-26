-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneBuildingCritterMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneBuildingCritterMgr", package.seeall)

local RoomSceneBuildingCritterMgr = class("RoomSceneBuildingCritterMgr", BaseSceneUnitMgr)

function RoomSceneBuildingCritterMgr:onInit()
	return
end

function RoomSceneBuildingCritterMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	self:addEventListeners()
	self:refreshAllCritterEntities()
end

function RoomSceneBuildingCritterMgr:addEventListeners()
	if self._isInitAddEvent then
		return
	end

	self._isInitAddEvent = true

	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureInfoUpdate, self._startRefreshAllTask, self)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, self._startRefreshAllTask, self)
	ManufactureController.instance:registerCallback(ManufactureEvent.CritterWorkInfoChange, self._startRefreshAllTask, self)
	CritterController.instance:registerCallback(CritterEvent.CritterBuildingChangeRestingCritter, self._startRefreshAllTask, self)
end

function RoomSceneBuildingCritterMgr:removeEventListeners()
	if not self._isInitAddEvent then
		return
	end

	self._isInitAddEvent = false

	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureInfoUpdate, self._startRefreshAllTask, self)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, self._startRefreshAllTask, self)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.CritterWorkInfoChange, self._startRefreshAllTask, self)
	CritterController.instance:unregisterCallback(CritterEvent.CritterBuildingChangeRestingCritter, self._startRefreshAllTask, self)
end

function RoomSceneBuildingCritterMgr:_startRefreshAllTask()
	if not self._isHasWaitRefreshAllTask then
		self._isHasWaitRefreshAllTask = true

		TaskDispatcher.runDelay(self._onRunRefreshAllTask, self, 0.1)
	end
end

function RoomSceneBuildingCritterMgr:_stopRefreshAllTask()
	if self._isHasWaitRefreshAllTask then
		self._isHasWaitRefreshAllTask = false

		TaskDispatcher.cancelTask(self._onRunRefreshAllTask, self)
	end
end

function RoomSceneBuildingCritterMgr:_onRunRefreshAllTask()
	self._isHasWaitRefreshAllTask = false

	self:refreshAllCritterEntities()
end

function RoomSceneBuildingCritterMgr:refreshAllCritterEntities()
	local gameMode = RoomModel.instance:getGameMode()
	local isShowBuildingCritter = gameMode == RoomEnum.GameMode.Ob
	local destroyCritterList = {}
	local critterEntityDict = self:getRoomCritterEntityDict()
	local tRoomCritterModel = RoomCritterModel.instance

	for _, critterEntity in pairs(critterEntityDict) do
		local stayBuildingUid, stayBuildingSlotId

		if isShowBuildingCritter then
			local roomCritterMO = tRoomCritterModel:getCritterMOById(critterEntity.id)

			if roomCritterMO then
				stayBuildingUid, stayBuildingSlotId = roomCritterMO:getStayBuilding()
			end
		end

		if stayBuildingUid and stayBuildingSlotId then
			local buildingEntity = self._scene.buildingmgr:getBuildingEntity(stayBuildingUid, SceneTag.RoomBuilding)

			if buildingEntity then
				local critterPointGO = buildingEntity:getCritterPoint(stayBuildingSlotId)

				if not gohelper.isNil(critterPointGO) then
					local x, y, z = transformhelper.getPos(critterPointGO.transform)

					critterEntity:setLocalPos(x, y, z)
					critterEntity.critterspine:refreshAnimState()
				end
			end
		else
			destroyCritterList[#destroyCritterList + 1] = critterEntity
		end
	end

	for _, critterEntity in ipairs(destroyCritterList) do
		self:destroyCritter(critterEntity)
	end

	if isShowBuildingCritter then
		local buildingCritterMOList = tRoomCritterModel:getRoomBuildingCritterList() or {}

		for _, mo in ipairs(buildingCritterMOList) do
			local critterUid = mo:getId()
			local critterEntity = self:getCritterEntity(critterUid)

			if not critterEntity then
				self:spawnRoomCritter(mo)
			end
		end
	end
end

function RoomSceneBuildingCritterMgr:spawnRoomCritter(roomCritterMO)
	local isObMode = RoomController.instance:isObMode()
	local isVisitMode = RoomController.instance:isVisitMode()

	if not isObMode and not isVisitMode or not roomCritterMO then
		return
	end

	local stayBuildingUid, stayBuildingSlotId = roomCritterMO:getStayBuilding()

	if not stayBuildingUid or not stayBuildingSlotId then
		return
	end

	local critterRoot = self._scene.go.critterRoot
	local critterGO = gohelper.create3d(critterRoot, string.format("%s", roomCritterMO.id))
	local critterEntity = MonoHelper.addNoUpdateLuaComOnceToGo(critterGO, RoomCritterEntity, roomCritterMO.id)
	local currentPosition = {
		z = 0,
		x = 0,
		y = 0
	}
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(stayBuildingUid, SceneTag.RoomBuilding)

	if buildingEntity then
		local critterPointGO = buildingEntity:getCritterPoint(stayBuildingSlotId)

		if not gohelper.isNil(critterPointGO) then
			local x, y, z = transformhelper.getPos(critterPointGO.transform)

			currentPosition.x = x
			currentPosition.y = y
			currentPosition.z = z
		else
			logError(string.format("RoomSceneBuildingCritterMgr:spawnRoomCritter error, no critter point, buildingUid:%s,index:%s", stayBuildingUid, stayBuildingSlotId + 1))
		end
	end

	critterEntity:setLocalPos(currentPosition.x, currentPosition.y, currentPosition.z)

	local isRestingCritter = roomCritterMO:isRestingCritter()

	if isRestingCritter then
		critterEntity.critterspine:setScale(CritterEnum.CritterScaleInSeatSlot)
	end

	self:addUnit(critterEntity)
	gohelper.addChild(critterRoot, critterGO)

	return critterEntity
end

function RoomSceneBuildingCritterMgr:refreshAllCritterEntityPos()
	if not self._scene then
		return
	end

	local critterEntityDict = self:getRoomCritterEntityDict()

	for _, critterEntity in pairs(critterEntityDict) do
		local roomCritterMO = critterEntity:getMO()
		local stayBuildingUid, stayBuildingSlotId

		if roomCritterMO then
			stayBuildingUid, stayBuildingSlotId = roomCritterMO:getStayBuilding()
		end

		if not stayBuildingUid or not stayBuildingSlotId then
			return
		end

		local buildingEntity = self._scene.buildingmgr:getBuildingEntity(stayBuildingUid, SceneTag.RoomBuilding)
		local critterPointGO = buildingEntity and buildingEntity:getCritterPoint(stayBuildingSlotId)

		if gohelper.isNil(critterPointGO) then
			return
		end

		local x, y, z = transformhelper.getPos(critterPointGO.transform)

		critterEntity:setLocalPos(x, y, z)
	end
end

function RoomSceneBuildingCritterMgr:refreshCritterPosByBuilding(buildingUid)
	if not self._scene then
		return
	end

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if not buildingEntity or not buildingMO then
		return
	end

	local critterDict
	local isManufacture = ManufactureConfig.instance:isManufactureBuilding(buildingMO.buildingId)

	if isManufacture then
		local manufactureInfo = ManufactureModel.instance:getManufactureMOById(buildingUid)

		critterDict = manufactureInfo and manufactureInfo:getSlot2CritterDict()
	else
		local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(buildingUid)

		critterDict = critterBuildingInfo and critterBuildingInfo:getSeatSlot2CritterDict()
	end

	if not critterDict then
		return
	end

	for slotId, critterUid in pairs(critterDict) do
		local critterEntity = self:getCritterEntity(critterUid)
		local critterPointGO = buildingEntity:getCritterPoint(slotId)

		if not critterEntity or gohelper.isNil(critterPointGO) then
			return
		end

		local x, y, z = transformhelper.getPos(critterPointGO.transform)

		critterEntity:setLocalPos(x, y, z)
	end
end

function RoomSceneBuildingCritterMgr:destroyCritter(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function RoomSceneBuildingCritterMgr:_onUpdate()
	return
end

function RoomSceneBuildingCritterMgr:getCritterEntity(id, sceneTag)
	local tagEntityDict = (not sceneTag or sceneTag == SceneTag.RoomCharacter) and self:getTagUnitDict(SceneTag.RoomCharacter)

	return tagEntityDict and tagEntityDict[id]
end

function RoomSceneBuildingCritterMgr:getRoomCritterEntityDict()
	return self._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function RoomSceneBuildingCritterMgr:onSceneClose()
	RoomSceneBuildingCritterMgr.super.onSceneClose(self)
	self:removeEventListeners()
	self:_stopRefreshAllTask()
end

return RoomSceneBuildingCritterMgr
