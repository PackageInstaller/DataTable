-- chunkname: @modules/logic/room/model/map/RoomInteractionMO.lua

module("modules.logic.room.model.map.RoomInteractionMO", package.seeall)

local RoomInteractionMO = pureTable("RoomInteractionMO")

function RoomInteractionMO:init(id, interactionId, buildingUids)
	self.id = id
	self.interactionId = interactionId
	self.config = RoomConfig.instance:getCharacterInteractionConfig(self.interactionId)
	self.hasInteraction = false
	self._interactionRate = self.config.rate * 0.001
	self._buildingUids = buildingUids
	self._interactionPoint = {}

	self:_initBuildingCaramer()
end

function RoomInteractionMO:_initBuildingCaramer()
	self._buildingCameraIds = not string.nilorempty(self.config.buildingCameraIds) and string.splitToNumber(self.config.buildingCameraIds, "#") or {}
	self._buildingNodesDic = {}
	self._buildingNodeList = {}

	for i, camerCfgId in ipairs(self._buildingCameraIds) do
		local cameraCfg = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(camerCfgId)

		if not cameraCfg then
			logError(string.format("[export_角色交互]Id:%s,字段\"buildingCameraIds\"配置了[export_角色建筑交互镜头表]中不存在id:%s", self.interactionId, camerCfgId))
		end

		if cameraCfg and not string.nilorempty(cameraCfg.nodesXYZ) then
			local nodes = GameUtil.splitString2(cameraCfg.nodesXYZ, true)

			self._buildingNodesDic[camerCfgId] = nodes

			tabletool.addValues(self._buildingNodeList, nodes)
		end
	end
end

function RoomInteractionMO:isCanByRandom()
	local r = math.random()

	return r <= self._interactionRate
end

function RoomInteractionMO:getBuildingUids()
	return self._buildingUids
end

function RoomInteractionMO:getBuildingCameraIds()
	return self._buildingCameraIds
end

function RoomInteractionMO:getBuildingNodeList()
	return self._buildingNodeList
end

function RoomInteractionMO:buildingNodesByCId(cameraId)
	return self._buildingNodesDic[cameraId]
end

function RoomInteractionMO:getInteractionPointParam(buildingUid)
	return self._interactionPoint[buildingUid]
end

function RoomInteractionMO:getBuildingRangeIndexList(buildingUid)
	return RoomMapInteractionModel.instance:getBuildingRangeIndexList(buildingUid)
end

function RoomInteractionMO:getInteractionBuilingUidAndCarmeraId()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self.config.heroId)

	if not roomCharacterMO or roomCharacterMO:getCurrentInteractionId() ~= nil and roomCharacterMO:getCurrentInteractionId() ~= 0 then
		return nil
	end

	local buildingUids = self:getBuildingUids()

	if not buildingUids or #buildingUids < 1 then
		return nil
	end

	local posv3 = roomCharacterMO.currentPosition

	for i, buildingUid in ipairs(buildingUids) do
		local cameraId = self:getBuildingCameraIdByBuildingUid(buildingUid, posv3)

		if cameraId then
			return buildingUid, cameraId
		end
	end
end

function RoomInteractionMO:getBuildingCameraIdByBuildingUid(buildingUid, posv3)
	local scene = GameSceneMgr.instance:getCurScene()

	if not scene or not scene.buildingmgr then
		return nil
	end

	local buildingEntity = scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if not buildingEntity then
		logError(string.format("RoomInteractionMO:getBuildingCameraIdByBuildingUid(buildingUid,posv3) :%s", buildingUid))

		return nil
	end

	local y = posv3.y

	for cameraId, nodes in pairs(self._buildingNodesDic) do
		for i, node in ipairs(nodes) do
			local pos = buildingEntity:transformPoint(node[1], y, node[3])

			if Vector3.Distance(posv3, pos) <= RoomCharacterEnum.BuilingInteractionNodeRadius then
				return cameraId
			end
		end
	end

	return nil
end

function RoomInteractionMO:getInteractionBuilingUid()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self.config.heroId)

	if not roomCharacterMO or roomCharacterMO:getCurrentInteractionId() ~= nil and roomCharacterMO:getCurrentInteractionId() ~= 0 then
		return nil
	end

	local buildingUids = self:getBuildingUids()

	if not buildingUids or #buildingUids < 1 then
		return nil
	end

	local posv3 = roomCharacterMO.currentPosition
	local vector2 = Vector2(posv3.x, posv3.z)
	local hexPoint = HexMath.positionToRoundHex(vector2, RoomBlockEnum.BlockSize)
	local index = RoomResourceModel.instance:getIndexByXY(hexPoint.x, hexPoint.y)

	for i = 1, #buildingUids do
		local buildingUid = buildingUids[i]
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if buildingMO and (buildingMO:getCurrentInteractionId() == nil or buildingMO:getCurrentInteractionId() == 0) then
			local indexList = self:getBuildingRangeIndexList(buildingUid)

			if indexList and tabletool.indexOf(indexList, index) then
				return buildingUid
			end
		end
	end

	return nil
end

return RoomInteractionMO
