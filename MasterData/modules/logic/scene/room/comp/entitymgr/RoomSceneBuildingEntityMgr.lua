-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomSceneBuildingEntityMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomSceneBuildingEntityMgr", package.seeall)

local RoomSceneBuildingEntityMgr = class("RoomSceneBuildingEntityMgr", BaseSceneUnitMgr)

function RoomSceneBuildingEntityMgr:onInit()
	return
end

function RoomSceneBuildingEntityMgr:init(sceneId, levelId)
	self._scene = self:getCurScene()

	self:_spawnInitBuilding()
	self:_spawnPartBuilding()

	local mapBuildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i, mo in ipairs(mapBuildingMOList) do
		if mo.buildingType ~= RoomBuildingEnum.BuildingType.Transport then
			self:spawnMapBuilding(mo)
		end
	end

	local count = RoomConfig.instance:getMaxBuildingOccupyNum()

	for i = 1, count do
		self:spawnMapBuildingOccupy(i)
	end
end

function RoomSceneBuildingEntityMgr:_spawnInitBuilding()
	local isInFishing = FishingModel.instance:isInFishing()

	if isInFishing then
		return
	end

	local initBuildingEntity = self:getUnit(SceneTag.RoomInitBuilding, 0)

	if not initBuildingEntity then
		local initbuildingRoot = self._scene.go.initbuildingRoot
		local mainGO = gohelper.findChild(initbuildingRoot, "main")
		local go = gohelper.create3d(mainGO, "initbuilding")

		initBuildingEntity = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomInitBuildingEntity, 0)

		self:addUnit(initBuildingEntity)
		gohelper.addChild(mainGO, go)
		transformhelper.setLocalPos(go.transform, 0, 0, 0)

		self._initBuildingGO = go
	end

	initBuildingEntity:refreshBuilding()
end

function RoomSceneBuildingEntityMgr:_spawnPartBuilding()
	local isInFishing = FishingModel.instance:isInFishing()

	if isInFishing then
		return
	end

	self._partBuildingGODict = self._partBuildingGODict or {}

	for i, partConfig in ipairs(lua_production_part.configList) do
		local partId = partConfig.id
		local partBuildingEntity = self:getUnit(SceneTag.RoomPartBuilding, partId)

		if not partBuildingEntity then
			local partGO = self:getPartContainerGO(partId)
			local go = gohelper.create3d(partGO, "partbuilding")

			partBuildingEntity = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomPartBuildingEntity, partId)

			self:addUnit(partBuildingEntity)
			gohelper.addChild(partGO, go)
			transformhelper.setLocalPos(go.transform, 0, 0, 0)

			self._partBuildingGODict[partId] = go
		end

		partBuildingEntity:refreshBuilding()
	end
end

function RoomSceneBuildingEntityMgr:spawnMapBuilding(mapBuildingMO)
	local buildingRoot = self._scene.go.buildingRoot
	local hexPoint = mapBuildingMO.hexPoint

	if not hexPoint then
		logError("RoomSceneBuildingEntityMgr: 没有位置信息")

		return
	end

	local position = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)
	local buildingEntity = self:getBuildingEntity(mapBuildingMO.id, SceneTag.RoomBuilding)

	if not buildingEntity then
		local buildingGO = gohelper.create3d(buildingRoot, RoomResHelper.getBlockName(hexPoint))

		buildingEntity = MonoHelper.addNoUpdateLuaComOnceToGo(buildingGO, RoomBuildingEntity, mapBuildingMO.id)

		self:addUnit(buildingEntity)
		gohelper.addChild(buildingRoot, buildingGO)
	end

	buildingEntity:setLocalPos(position.x, 0, position.y)
	buildingEntity:refreshBuilding()
	buildingEntity:refreshRotation()

	return buildingEntity
end

function RoomSceneBuildingEntityMgr:spawnMapBuildingOccupy(id)
	local buildingEntity = self:getBuildingOccupy(id)

	if not buildingEntity then
		local buildingRoot = self._scene.go.buildingRoot
		local go = gohelper.create3d(buildingRoot, "BuildingOccupy_" .. id)

		gohelper.addChild(buildingRoot, go)

		buildingEntity = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomBuildingOccupyEntity, id)

		self:addUnit(buildingEntity)
	end

	return buildingEntity
end

function RoomSceneBuildingEntityMgr:onSwitchMode()
	local entityDic = self:getMapBuildingEntityDict()

	if entityDic then
		local tRoomMapBuildingModel = RoomMapBuildingModel.instance
		local tempSceneTag = SceneTag.RoomBuilding
		local removeIds = {}

		for unitId, entity in pairs(entityDic) do
			if not tRoomMapBuildingModel:getBuildingMOById(unitId) then
				table.insert(removeIds, unitId)
			end
		end

		for i = 1, #removeIds do
			self:removeUnit(tempSceneTag, removeIds[i])
		end
	end

	local isInFishing = FishingModel.instance:isInFishing()

	if isInFishing then
		self:removeUnits(SceneTag.RoomInitBuilding)
		self:removeUnits(SceneTag.RoomPartBuilding)
	end
end

function RoomSceneBuildingEntityMgr:getBuildingOccupy(id)
	return self:getUnit(RoomBuildingOccupyEntity:getTag(), id)
end

function RoomSceneBuildingEntityMgr:refreshAllBlockEntity()
	local entityDict = self:getTagUnitDict(SceneTag.RoomBuilding)

	if entityDict then
		for _, buildingEntity in pairs(entityDict) do
			local buildingMO = buildingEntity:getMO()
			local position = HexMath.hexToPosition(buildingMO.hexPoint, RoomBlockEnum.BlockSize)

			buildingEntity:setLocalPos(position.x, 0, position.y)
			buildingEntity:refreshBuilding()
			buildingEntity:refreshRotation()
		end
	end
end

function RoomSceneBuildingEntityMgr:moveTo(entity, hexPoint)
	local position = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

	entity:setLocalPos(position.x, 0, position.y)
end

function RoomSceneBuildingEntityMgr:destroyBuilding(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function RoomSceneBuildingEntityMgr:getBuildingEntity(id, sceneTag)
	local tagEntitys = (not sceneTag or sceneTag == SceneTag.RoomBuilding) and self:getTagUnitDict(SceneTag.RoomBuilding)

	return tagEntitys and tagEntitys[id]
end

function RoomSceneBuildingEntityMgr:changeBuildingEntityId(id, changeId)
	if id and id ~= changeId then
		local tagUnitDict = self:getMapBuildingEntityDict()

		if tagUnitDict and tagUnitDict[id] and not tagUnitDict[changeId] then
			local builingEntity = tagUnitDict[id]

			tagUnitDict[changeId] = builingEntity
			tagUnitDict[id] = nil

			builingEntity:setEntityId(changeId)
		end
	end
end

function RoomSceneBuildingEntityMgr:getMapBuildingEntityDict()
	return self._tagUnitDict[SceneTag.RoomBuilding]
end

function RoomSceneBuildingEntityMgr:getInitBuildingGO()
	return self._initBuildingGO
end

function RoomSceneBuildingEntityMgr:getPartBuildingGO(partId)
	return self._partBuildingGODict and self._partBuildingGODict[partId]
end

function RoomSceneBuildingEntityMgr:getPartContainerGO(partId)
	if self._scene then
		return self._scene.go:getPartGOById(partId)
	end
end

function RoomSceneBuildingEntityMgr:onSceneClose()
	RoomSceneBuildingEntityMgr.super.onSceneClose(self)

	self._initBuildingGO = nil
	self._partBuildingGODict = nil
end

return RoomSceneBuildingEntityMgr
