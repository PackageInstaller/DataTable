-- chunkname: @modules/logic/scene/room/comp/RoomSceneCameraFOVBlockComp.lua

module("modules.logic.scene.room.comp.RoomSceneCameraFOVBlockComp", package.seeall)

local RoomSceneCameraFOVBlockComp = class("RoomSceneCameraFOVBlockComp", BaseSceneComp)
local _BLOCK_TYP = {
	Building = 2,
	Hero = 1,
	Vehicle = 3
}
local _KEY_WORLD = {
	_SCREENCOORD = "_SCREENCOORD"
}
local Shader = UnityEngine.Shader
local ShaderIDMap = {
	alphaThreshold = Shader.PropertyToID("_AlphaThreshold")
}

function RoomSceneCameraFOVBlockComp:ctor(scene)
	RoomSceneCameraFOVBlockComp.super.ctor(self, scene)

	self._v3PoolList = {}
	self._meshReaderBoundsCacheDict = {}
end

function RoomSceneCameraFOVBlockComp:onInit()
	return
end

function RoomSceneCameraFOVBlockComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	TaskDispatcher.runRepeat(self._onUpdate, self, 0.1)

	self._buildingPosListMap = nil
end

function RoomSceneCameraFOVBlockComp:_onUpdate()
	if RoomController.instance:isEditMode() then
		return
	end

	self:_updateEntityFovBlock()
end

function RoomSceneCameraFOVBlockComp:_checkIsNeedUpdateBlock()
	local playingInteractionParam = self:_getPlayingInteractionParam()

	if playingInteractionParam then
		if self._isCameraChange then
			return true
		end
	elseif not self._lastOpenNum or self._lastOpenNum == 0 then
		return true
	end

	return false
end

function RoomSceneCameraFOVBlockComp:_updateEntityFovBlock()
	local playingInteractionParam, blockType = self:_getPlayingInteractionParam()

	if not playingInteractionParam and (not self._lastOpenNum or self._lastOpenNum == 0) then
		return
	end

	self._lastOpenNum = 0

	local scene = GameSceneMgr.instance:getCurScene()
	local hexPointList, curBuildingUid = self:_getHexPointList(playingInteractionParam, blockType)
	local meshRendererList = RoomCharacterHelper.getAllBlockMeshRendererList(hexPointList, curBuildingUid)
	local meshInstanceIdList = {}

	for i, meshRenderer in ipairs(meshRendererList) do
		table.insert(meshInstanceIdList, meshRenderer:GetInstanceID())
	end

	local mpb
	local keyword = _KEY_WORLD._SCREENCOORD
	local alphaThresholdID = ShaderIDMap.alphaThreshold
	local blockMeshRendererInstanceIdDict = self:_getBlockMeshRendererDict(meshRendererList, meshInstanceIdList)

	if not self._lastMeshReaderDic then
		local lastMeshReaderDic = {}
		local curMeshReaderDic = {}

		self._lastMeshReaderDic = curMeshReaderDic

		for i, meshRenderer in ipairs(meshRendererList) do
			local instanceId = meshInstanceIdList[i]
			local blockValue = blockMeshRendererInstanceIdDict[instanceId]

			if blockValue and blockValue > 0 then
				self._lastOpenNum = self._lastOpenNum + 1

				if not lastMeshReaderDic[instanceId] or lastMeshReaderDic[instanceId].blockValue ~= blockValue then
					if not mpb then
						mpb = scene.mapmgr:getPropertyBlock()

						mpb:Clear()
						mpb:SetFloat(alphaThresholdID, blockValue)
					end

					MaterialReplaceHelper.SetRendererKeyworld(meshRenderer, keyword, true)
					meshRenderer:SetPropertyBlock(mpb)
				end

				curMeshReaderDic[instanceId] = {
					meshRenderer = meshRenderer,
					blockValue = blockValue
				}
			end
		end

		for instanceId, data in pairs(lastMeshReaderDic) do
			if not curMeshReaderDic[instanceId] then
				MaterialReplaceHelper.SetRendererKeyworld(data.meshRenderer, keyword, false)
				data.meshRenderer:SetPropertyBlock(nil)
			end

			for dataKey, _ in pairs(data) do
				rawset(data, dataKey, nil)
			end

			rawset(lastMeshReaderDic, instanceId, nil)
		end
	end
end

function RoomSceneCameraFOVBlockComp:_getHexPointList(playingInteractionParam, blockType)
	if not playingInteractionParam or not blockType then
		return
	end

	local hexPointList, curBuildingUid, worldHexPointList

	if blockType == _BLOCK_TYP.Building then
		local pointList, buildingHexPoint
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(playingInteractionParam)

		if buildingMO then
			pointList = RoomMapModel.instance:getBuildingPointList(buildingMO.buildingId, buildingMO.rotate)
			buildingHexPoint = buildingMO.hexPoint
		end

		if pointList and buildingHexPoint then
			worldHexPointList = {}

			for i = 1, #pointList do
				worldHexPointList[i] = buildingHexPoint + pointList[i]
			end

			curBuildingUid = playingInteractionParam
		end
	elseif blockType == _BLOCK_TYP.Vehicle or blockType == _BLOCK_TYP.Hero then
		local goTrs

		if blockType == _BLOCK_TYP.Vehicle then
			local vehicleEntity = self._scene.vehiclemgr:getVehicleEntity(playingInteractionParam)

			goTrs = vehicleEntity and vehicleEntity.goTrs
		elseif blockType == _BLOCK_TYP.Hero then
			local characterEntity = self._scene.charactermgr:getCharacterEntity(playingInteractionParam.heroId, SceneTag.RoomCharacter)

			goTrs = characterEntity and characterEntity.goTrs
		end

		if not gohelper.isNil(goTrs) then
			local x, _, z = transformhelper.getPos(goTrs)
			local hexX, hexY = HexMath.posXYToRoundHexYX(x, z, RoomBlockEnum.BlockSize)

			worldHexPointList = {
				HexPoint.New(hexX, hexY)
			}
		end
	else
		logError(string.format("RoomSceneCameraFOVBlockComp:_getHexPointList unknow type:%s", tostring(blockType)))
	end

	if worldHexPointList then
		hexPointList = {}

		local range = 1
		local dict = {}

		for _, worldPoint in ipairs(worldHexPointList) do
			local rangList = worldPoint:inRanges(range)

			for _, p in ipairs(rangList) do
				local x = p.x
				local y = p.y

				if not dict[x] or not dict[x][y] then
					hexPointList[#hexPointList + 1] = p
					dict[x] = dict[x] or {}
					dict[x][y] = true
				end
			end
		end
	end

	return hexPointList, curBuildingUid
end

local _EmptyIstanceIdDict = {}

function RoomSceneCameraFOVBlockComp:_getBlockMeshRendererDict(meshRendererList, meshInstanceIdList)
	if not RoomController.instance:isObMode() then
		return _EmptyIstanceIdDict
	end

	local playingInteractionParam, blockTypeId = self:_getPlayingInteractionParam()

	if not playingInteractionParam then
		return _EmptyIstanceIdDict
	end

	local posList = {}

	self:_addBlockPositionById(blockTypeId, playingInteractionParam, posList)

	if #meshRendererList <= 0 or #posList <= 0 then
		return _EmptyIstanceIdDict
	end

	local cameraPosition = self._scene.camera:getCameraPosition()
	local rayList = {}
	local distanceList = {}

	for i, pos in pairs(posList) do
		local characterPosition = RoomBendingHelper.worldToBendingSimple(pos)
		local distance = Vector3.Distance(cameraPosition, characterPosition)
		local direction = Vector3.Normalize(characterPosition - cameraPosition)
		local ray = Ray(direction, cameraPosition)

		table.insert(rayList, ray)
		table.insert(distanceList, distance)
	end

	self:_pushVector3List(posList)

	local buildingUid

	if _BLOCK_TYP.Hero == blockTypeId then
		buildingUid = playingInteractionParam.buildingUid
	elseif _BLOCK_TYP.Building == blockTypeId then
		buildingUid = playingInteractionParam
	end

	self._blockMeshRendererInstanceIdDict = self._blockMeshRendererInstanceIdDict or {}

	local blockMeshRendererInstanceIdDict = self._blockMeshRendererInstanceIdDict
	local bounsCacheDict = self._meshReaderBoundsCacheDict

	if #rayList > 0 then
		local dic = {}

		self:_addBuildingMeshRendererIdDict(buildingUid, dic)

		for j, meshRenderer in ipairs(meshRendererList) do
			local instanceId = meshInstanceIdList[j]
			local boundsParam = bounsCacheDict[instanceId]

			if not boundsParam then
				local bounds = meshRenderer.bounds

				boundsParam = {
					bounds = bounds,
					extents = bounds.extents,
					center = bounds.center
				}
				bounsCacheDict[instanceId] = boundsParam
			end

			blockMeshRendererInstanceIdDict[instanceId] = not dic[instanceId] and RoomCharacterHelper.isBlockCharacter(rayList, distanceList, boundsParam) and 0.6 or 0
		end

		for idx, tb in ipairs(rayList) do
			rawset(rayList, idx, nil)
		end
	end

	return blockMeshRendererInstanceIdDict
end

function RoomSceneCameraFOVBlockComp:_addBlockPositionById(blockTypeId, param, posList)
	self._blockTypeFuncMap = self._blockTypeFuncMap or {
		[_BLOCK_TYP.Hero] = self._addHeroPosFunc,
		[_BLOCK_TYP.Building] = self._addBuildingPosFunc,
		[_BLOCK_TYP.Vehicle] = self._addVehiclePosFunc
	}

	local func = self._blockTypeFuncMap[blockTypeId]

	if func then
		func(self, param, posList)
	end
end

function RoomSceneCameraFOVBlockComp:_addVehiclePosFunc(vehicleUid, posList)
	local entity = self._scene.vehiclemgr:getVehicleEntity(vehicleUid)

	if entity then
		local x, y, z = transformhelper.getPos(entity.goTrs)

		table.insert(posList, self:_popVector3(x, y, z))

		local fx, fy, fz = entity.cameraFollowTargetComp:getPositionXYZ()

		table.insert(posList, self:_popVector3(fx, fy, fz))
	end
end

function RoomSceneCameraFOVBlockComp:_popVector3(x, y, z)
	local v3
	local len = #self._v3PoolList

	if len > 0 then
		table.remove(self._v3PoolList, len)
		self._v3PoolList[len]:Set(x, y, z)

		return self._v3PoolList[len]
	end

	return Vector3(x, y, z)
end

function RoomSceneCameraFOVBlockComp:_pushVector3List(v3List)
	for _, ve3 in ipairs(v3List) do
		table.insert(self._v3PoolList, ve3)
	end
end

function RoomSceneCameraFOVBlockComp:_addBuildingPosFunc(buildingUid, posList)
	self._buildingPosListMap = self._buildingPosListMap or {}

	local bPosList = self._buildingPosListMap[buildingUid]

	if not bPosList then
		bPosList = {}
		self._buildingPosListMap[buildingUid] = bPosList

		local entity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

		if entity then
			local bodyGO = entity:getBodyGO()

			if bodyGO then
				local x, y, z = transformhelper.getPos(bodyGO.transform)

				table.insert(bPosList, self:_popVector3(x, y, z))
			end
		end

		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if buildingMO then
			::label_13_0::

			local pointList = RoomMapModel.instance:getBuildingPointList(buildingMO.buildingId, buildingMO.rotate)

			if pointList and buildingMO then
				for _, point in ipairs(pointList) do
					local tX, tZ = HexMath.hexXYToPosXY(point.x + buildingMO.hexPoint.x, point.y + buildingMO.hexPoint.y, RoomBlockEnum.BlockSize)

					table.insert(bPosList, self:_popVector3(tX, 0.11, tZ))
				end
			end
		end
	end

	tabletool.addValues(posList, bPosList)
end

function RoomSceneCameraFOVBlockComp:_addHeroPosFunc(param, posList)
	self:_addCharacterPosById(param.heroId, posList)
	self:_addCharacterPosById(param.relateHeroId, posList)
end

function RoomSceneCameraFOVBlockComp:_addCharacterPosById(heroId, posList)
	local characterEntity = self._scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

	if characterEntity then
		local x, y, z = transformhelper.getPos(characterEntity.goTrs)

		table.insert(posList, self:_popVector3(x, y, z))
	end
end

function RoomSceneCameraFOVBlockComp:_addBuildingMeshRendererIdDict(buildingUid, dic)
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)
	local meshRendererList = buildingEntity and buildingEntity:getCharacterMeshRendererList()

	if meshRendererList then
		for j, meshRenderer in ipairs(meshRendererList) do
			dic[meshRenderer:GetInstanceID()] = true
		end
	end
end

function RoomSceneCameraFOVBlockComp:_getPlayingInteractionParam()
	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	if playingInteractionParam == nil then
		playingInteractionParam = RoomCritterController.instance:getPlayingInteractionParam()
	end

	if playingInteractionParam == nil then
		local cameraState = self._scene.camera:getCameraState()

		if self._lookCaneraState == cameraState then
			return self._lookEntityUid, self._lookLockType
		end
	end

	return playingInteractionParam, _BLOCK_TYP.Hero
end

function RoomSceneCameraFOVBlockComp:setLookBuildingUid(cameraState, lookBuildingUid)
	if self._buildingPosListMap and lookBuildingUid then
		self._buildingPosListMap[lookBuildingUid] = nil
	end

	self:_setLookEntityUid(cameraState, lookBuildingUid, _BLOCK_TYP.Building)
end

function RoomSceneCameraFOVBlockComp:setLookVehicleUid(cameraState, lookVehicleUid)
	self:_setLookEntityUid(cameraState, lookVehicleUid, _BLOCK_TYP.Vehicle)
end

function RoomSceneCameraFOVBlockComp:clearLookParam()
	self:_setLookEntityUid(nil, nil, nil)
end

function RoomSceneCameraFOVBlockComp:_setLookEntityUid(cameraState, lookEntityUid, lockType)
	self._lookCaneraState = cameraState
	self._lookEntityUid = lookEntityUid
	self._lookLockType = lockType
end

function RoomSceneCameraFOVBlockComp:onSceneClose()
	TaskDispatcher.cancelTask(self._onUpdate, self)
	self:_setLookEntityUid(nil, nil, nil)

	local boundsDict = self._meshReaderBoundsCacheDict

	for idx, tb in pairs(boundsDict) do
		for tbKey, tbV in pairs(tb) do
			rawset(tb, tbKey, nil)
		end

		rawset(boundsDict, idx, nil)
	end

	if self._lastMeshReaderDic then
		for instanceId, data in pairs(self._lastMeshReaderDic) do
			for dataKey, _ in pairs(data) do
				rawset(data, dataKey, nil)
			end

			rawset(self._lastMeshReaderDic, instanceId, nil)
		end
	end
end

return RoomSceneCameraFOVBlockComp
