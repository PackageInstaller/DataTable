-- chunkname: @modules/logic/room/utils/RoomCharacterHelper.lua

module("modules.logic.room.utils.RoomCharacterHelper", package.seeall)

local RoomCharacterHelper = {}

function RoomCharacterHelper.getCharacterPosition(resourcePoint)
	return HexMath.resourcePointToPosition(resourcePoint, RoomBlockEnum.BlockSize, 0.33)
end

function RoomCharacterHelper.getCharacterPosition3D(resourcePoint, withHeight)
	local position2D = RoomCharacterHelper.getCharacterPosition(resourcePoint)
	local height = withHeight and RoomCharacterHelper.getLandHeightByRaycast(Vector3(position2D.x, 0, position2D.y)) or RoomCharacterEnum.CharacterHeightOffset

	return Vector3(position2D.x, height, position2D.y)
end

function RoomCharacterHelper.reCalculateHeight(position)
	local height = RoomCharacterHelper.getLandHeightByRaycast(Vector3(position.x, 0, position.z))

	return Vector3(position.x, height, position.z)
end

function RoomCharacterHelper.getLandHeightByAStarPath(position)
	local scene = GameSceneMgr.instance:getCurScene()

	return scene.path:getNearestNodeHeight(position)
end

function RoomCharacterHelper.getLandHeightByRaycast(position)
	local success, height = ZProj.RoomHelper.GetLandHeightByRaycast(position, SceneTag.RoomLand, 0)

	if success then
		return height
	end

	return RoomCharacterEnum.CharacterHeightOffset
end

function RoomCharacterHelper.pointListToPositionList3D(pointList, withHeight)
	if not pointList then
		return nil
	end

	local positionList = {}

	for i, point in ipairs(pointList) do
		table.insert(positionList, RoomCharacterHelper.getCharacterPosition3D(point, withHeight))
	end

	return positionList
end

function RoomCharacterHelper.positionRoundToPoint(position)
	position = Vector2(position.x, position.z)

	local roundHexPoint, direction = HexMath.positionToRoundHex(position, RoomBlockEnum.BlockSize)
	local centerPosition = HexMath.hexToPosition(roundHexPoint, RoomBlockEnum.BlockSize)
	local sqrt3 = math.sqrt(3)

	if Vector2.Distance(centerPosition, position) < RoomBlockEnum.BlockSize * sqrt3 / 6 then
		return ResourcePoint(roundHexPoint, 0)
	else
		return ResourcePoint(roundHexPoint, direction)
	end
end

function RoomCharacterHelper.canTryPlace(heroId, position, skinId)
	local hexPoint, direction = HexMath.positionToRoundHex(Vector2.New(position.x, position.z), RoomBlockEnum.BlockSize)
	local param = RoomBuildingHelper.getOccupyBuildingParam(hexPoint, true)

	if param and not param.isCanPlace then
		return false
	end

	local characterMOList = RoomCharacterModel.instance:getList()

	for i, characterMO in ipairs(characterMOList) do
		if characterMO.characterState ~= RoomCharacterEnum.CharacterState.Temp then
			if RoomCharacterHelper.isTooNear((characterMO.characterState == RoomCharacterEnum.CharacterState.Revert or nil) and RoomCharacterModel.instance:getRevertPosition(), position) and heroId ~= characterMO.heroId then
				return false
			end
		end
	end

	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if not blockMO or blockMO.blockState ~= RoomBlockEnum.BlockState.Map then
		return false
	end

	local position = RoomCharacterHelper.reCalculateHeight(position)
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local canWade = skinConfig and skinConfig.canWade > 0

	if not canWade and blockMO:getResourceId(direction) == RoomResourceEnum.ResourceId.River then
		return false
	end

	local tag = RoomCharacterHelper.getTag(canWade)

	if not ZProj.AStarPathBridge.IsWalkable(position.x, position.y, position.z, tag) then
		return false
	end

	return true
end

function RoomCharacterHelper.isTooNear(posA, posB)
	local distance = Vector2.Distance(Vector2.New(posA.x, posA.z), Vector2.New(posB.x, posB.z))

	return distance < RoomCharacterEnum.TooNearDistance
end

function RoomCharacterHelper.canConfirmPlace(heroId, position, skinId)
	return RoomCharacterHelper.canTryPlace(heroId, position, skinId)
end

function RoomCharacterHelper.canMove(resourcePoint)
	local hexPoint = resourcePoint.hexPoint
	local param = RoomBuildingHelper.getOccupyBuildingParam(hexPoint, true)

	if param and not param.isCanPlace then
		return false
	end

	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if not blockMO or blockMO.blockState ~= RoomBlockEnum.BlockState.Map then
		return false
	end

	return true
end

function RoomCharacterHelper.checkMoveStraightRule(startPosition, targetPosition, heroId, entity, isBridge)
	local targetPoint = RoomCharacterHelper.positionRoundToPoint(targetPosition)

	if not RoomCharacterHelper.canMove(targetPoint, true) then
		return false
	end

	if RoomCharacterHelper.isOtherCharacter(targetPosition, heroId) then
		return false
	end

	if not RoomCharacterHelper.checkMoveDistance(targetPosition, startPosition) then
		return false
	end

	if not RoomCharacterHelper.isMoveCameraWalkable({
		startPosition,
		targetPosition
	}, true, isBridge) then
		return false
	end

	local seeker = entity.charactermove:getSeeker()
	local pos2 = targetPosition

	if not ZProj.AStarPathBridge.IsWalkable(pos2.x, pos2.y, pos2.z, seeker:GetTag()) then
		return false
	end

	return true
end

function RoomCharacterHelper.checkMoveDistance(posA, posB)
	local offsetX = posA.x - posB.x
	local offsetZ = posA.z - posB.z
	local distance2 = offsetX * offsetX + offsetZ * offsetZ

	if distance2 > RoomBlockEnum.BlockSize * RoomBlockEnum.BlockSize * 8 then
		return false
	end

	if distance2 < RoomBlockEnum.BlockSize * RoomBlockEnum.BlockSize / 64 then
		return false
	end

	return true
end

function RoomCharacterHelper.isOtherCharacter(targetPosition, heroId)
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		if roomCharacterMO.heroId ~= heroId then
			if RoomCharacterHelper.isTooNear(roomCharacterMO.currentPosition, targetPosition) then
				return true
			end

			if RoomCharacterHelper.isTooNear(roomCharacterMO:getMoveTargetPosition(), targetPosition) then
				return true
			end
		end
	end

	return false
end

function RoomCharacterHelper.isMoveCameraWalkable(positionList, isStrict, isBridge)
	if not positionList or #positionList < 2 then
		return false
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local cameraTransform = scene.camera.camera.transform
	local cameraDirection = Vector2.Normalize(Vector2(cameraTransform.forward.x, cameraTransform.forward.z))
	local totalLength = 0

	for i = 1, #positionList - 1 do
		local startPosition = positionList[i]
		local targetPosition = positionList[i + 1]
		local offsetX = targetPosition.x - startPosition.x
		local offsetZ = targetPosition.z - startPosition.z
		local length2 = offsetX * offsetX + offsetZ * offsetZ

		if length2 > 0.0001 then
			local direction = Vector2.Normalize(Vector2.New(offsetX, offsetZ))
			local degree = RoomCharacterEnum.MoveStraightAngleLimit

			if isBridge then
				degree = RoomCharacterEnum.MoveThroughBridge
			elseif isStrict then
				degree = RoomCharacterEnum.MoveStraightAngleLimitStrict
			end

			local limit = math.cos(math.rad(90 - degree))

			if limit < Vector2.Dot(direction, cameraDirection) then
				totalLength = totalLength + math.sqrt(length2)
			elseif limit < Vector2.Dot(-direction, cameraDirection) then
				totalLength = totalLength + math.sqrt(length2)
			end

			if totalLength > 0.01 then
				return false
			end
		end
	end

	return true
end

function RoomCharacterHelper.getCanConfirmPlaceDict(heroId, skinId)
	local canConfirmPlaceDict = {}
	local mapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

	for x, dict in pairs(mapBlockMODict) do
		for y, blockMO in pairs(dict) do
			if blockMO.blockState == RoomBlockEnum.BlockState.Map then
				for direction = 0, 6 do
					local resourcePoint = ResourcePoint(HexPoint(x, y), direction)
					local position = RoomCharacterHelper.getCharacterPosition3D(resourcePoint)

					if RoomCharacterHelper.canConfirmPlace(heroId, position, skinId) then
						canConfirmPlaceDict[x] = canConfirmPlaceDict[x] or {}
						canConfirmPlaceDict[x][y] = canConfirmPlaceDict[x][y] or {}
						canConfirmPlaceDict[x][y][direction] = true
					end
				end
			end
		end
	end

	return canConfirmPlaceDict
end

function RoomCharacterHelper.getSelectPositionList()
	local positionList = {}
	local mapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

	for x, dict in pairs(mapBlockMODict) do
		for y, blockMO in pairs(dict) do
			if blockMO.blockState == RoomBlockEnum.BlockState.Map then
				local mainPosition

				for direction = 0, 6 do
					local resourcePoint = ResourcePoint(HexPoint(x, y), direction)
					local position = RoomCharacterHelper.getCharacterPosition3D(resourcePoint)

					if direction == 0 then
						mainPosition = position
					end

					table.insert(positionList, position)
				end

				local list = {}
				local offsetY = 0.64 * RoomBlockEnum.BlockSize
				local offsetX = 0.16 * RoomBlockEnum.BlockSize
				local up = Vector2(0, offsetY)
				local upLeft = Vector2(-offsetX, offsetY)
				local upRight = Vector2(offsetX, offsetY)

				table.insert(list, up)
				table.insert(list, upLeft)
				table.insert(list, upRight)

				for i = 0, 5 do
					local rotate = i * math.pi / 3

					for _, offset in ipairs(list) do
						local position = Vector3(mainPosition.x + offset.x * math.cos(rotate) - offset.y * math.sin(rotate), 0, mainPosition.z + offset.y * math.cos(rotate) + offset.x * math.sin(rotate))

						table.insert(positionList, position)
					end
				end
			end
		end
	end

	return positionList
end

function RoomCharacterHelper.getRecommendHexPoint(heroId, skinId, nearPosition)
	if not nearPosition then
		local scene = GameSceneMgr.instance:getCurScene()
		local cameraParam = scene.camera:getCameraParam()

		nearPosition = Vector2(cameraParam.focusX, cameraParam.focusY)
	end

	local nearPosition3D = RoomCharacterHelper.reCalculateHeight(Vector3.New(nearPosition.x, 0, nearPosition.y))

	if RoomCharacterHelper.canConfirmPlace(heroId, nearPosition3D, skinId) then
		local hexPoint, direction = HexMath.positionToRoundHex(nearPosition, RoomBlockEnum.BlockSize)

		return {
			distance = 0,
			hexPoint = hexPoint,
			direction = direction,
			position = nearPosition3D
		}
	end

	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local canWade = skinConfig and skinConfig.canWade > 0
	local tag = RoomCharacterHelper.getTag(canWade)
	local success, nearNodePosition = ZProj.AStarPathBridge.GetNearestNodePosition(nearPosition3D, tag, Vector3.zero)

	if success and RoomCharacterHelper.canConfirmPlace(heroId, nearNodePosition, skinId) then
		nearNodePosition = RoomCharacterHelper.reCalculateHeight(nearNodePosition)

		local nearNodeHexPoint, nearNodeDirection = HexMath.positionToRoundHex(Vector2(nearNodePosition.x, nearNodePosition.z), RoomBlockEnum.BlockSize)

		return {
			hexPoint = nearNodeHexPoint,
			direction = nearNodeDirection,
			distance = Vector2.Distance(nearNodePosition, nearPosition),
			position = nearNodePosition
		}
	end

	local selectPositionList = RoomCharacterHelper.getSelectPositionList(heroId, skinId)
	local selectIndexList = {}
	local selectDistanceList = {}

	for i, selectPosition in ipairs(selectPositionList) do
		table.insert(selectIndexList, i)
		table.insert(selectDistanceList, RoomHelper.vector3Distance2(selectPosition, nearPosition3D))
	end

	table.sort(selectIndexList, function(x, y)
		return selectDistanceList[x] < selectDistanceList[y]
	end)

	for i, selectIndex in ipairs(selectIndexList) do
		local selectPosition = selectPositionList[selectIndex]

		if RoomCharacterHelper.canConfirmPlace(heroId, selectPosition, skinId) then
			local selectHexPoint, selectDirection = HexMath.positionToRoundHex(selectPosition, RoomBlockEnum.BlockSize)

			return {
				hexPoint = selectHexPoint,
				direction = selectDirection,
				distance = Vector2.Distance(selectPosition, nearPosition),
				position = selectPosition
			}
		end
	end

	local canConfirmPlaceDict = RoomCharacterHelper.getCanConfirmPlaceDict(heroId, skinId)
	local bestParam

	for x, dict1 in pairs(canConfirmPlaceDict) do
		for y, dict2 in pairs(dict1) do
			for direction, _ in pairs(dict2) do
				local param = {}

				param.hexPoint = HexPoint(x, y)
				param.direction = direction

				local resourcePoint = ResourcePoint(param.hexPoint, param.direction)

				param.position = RoomCharacterHelper.getCharacterPosition3D(resourcePoint, true)
				param.distance = Vector2.Distance(Vector2(param.position.x, param.position.z), nearPosition)
				bestParam = not bestParam and param or RoomCharacterHelper._compareRecommendParams(bestParam, param)
			end
		end
	end

	return bestParam
end

function RoomCharacterHelper.getGuideRecommendHexPoint(heroId, skinId, refHexPoint)
	local canConfirmPlaceDict = RoomCharacterHelper.getCanConfirmPlaceDict(heroId, skinId)
	local refPosition = HexMath.hexToPosition(refHexPoint, RoomBlockEnum.BlockSize)
	local bestParam

	for x, dict1 in pairs(canConfirmPlaceDict) do
		for y, dict2 in pairs(dict1) do
			for direction, _ in pairs(dict2) do
				if x ~= refHexPoint.x or y ~= refHexPoint.y then
					local param = {}

					param.hexPoint = HexPoint(x, y)
					param.direction = direction
					param.distance = Vector2.Distance(HexMath.hexToPosition(param.hexPoint, RoomBlockEnum.BlockSize), refPosition)
					param.position = RoomCharacterHelper.getCharacterPosition3D(ResourcePoint(param.hexPoint, param.direction), true)
					param.priority = 100

					if RoomMapBuildingModel.instance:isHasBuilding(x, y) then
						param.priority = 0
					elseif RoomBuildingHelper.isInInitBuildingOccupy(param.hexPoint) then
						param.priority = 0
					end

					bestParam = not bestParam and param or RoomCharacterHelper._compareGuideRecommendParams(bestParam, param)
				end
			end
		end
	end

	return bestParam
end

function RoomCharacterHelper._compareGuideRecommendParams(paramA, paramB)
	if paramA.priority ~= paramB.priority then
		return paramA.priority > paramB.priority and paramA or paramB
	end

	return paramA.distance > paramB.distance and paramB or paramA
end

function RoomCharacterHelper._compareRecommendParams(paramA, paramB)
	return paramA.distance > paramB.distance and paramB or paramA
end

function RoomCharacterHelper.getNeedRemoveCount()
	local maxCount = RoomCharacterModel.instance:getMaxCharacterCount()
	local currentCount = RoomCharacterModel.instance:getConfirmCharacterCount()

	if maxCount < currentCount then
		return currentCount - maxCount
	end

	return 0
end

function RoomCharacterHelper.offsetForwardNearPosition(position, roomCharacterMO)
	local scene = GameSceneMgr.instance:getCurScene()
	local characterEntity = scene.charactermgr:getCharacterEntity(roomCharacterMO.id, SceneTag.RoomCharacter)
	local lookDir = characterEntity.characterspine:getLookDir()
	local cameraTransform = scene.camera.camera.transform
	local direction = Vector2.Normalize(Vector2(cameraTransform.right.x, cameraTransform.right.z))

	if lookDir == SpineLookDir.Left then
		direction = -direction
	end

	position = position + direction * RoomBlockEnum.BlockSize * math.sqrt(3) / 2

	return position
end

function RoomCharacterHelper.getTag(canWade)
	local wadeIndex = RoomEnum.AStarLayerTag.Water
	local rchTag = bit.bxor(bit.bnot(0), bit.lshift(1, RoomEnum.AStarLayerTag.NoWalkRoad))

	if canWade then
		return rchTag
	else
		return bit.bxor(rchTag, bit.lshift(1, wadeIndex))
	end
end

function RoomCharacterHelper.getRandomPosition()
	local mapBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	if mapBlockMOList and #mapBlockMOList > 0 then
		local randomBlockMO = mapBlockMOList[math.random(1, #mapBlockMOList)]
		local resourcePoint = ResourcePoint(randomBlockMO.hexPoint, math.random(0, 6))

		return RoomCharacterHelper.getCharacterPosition3D(resourcePoint, false)
	end
end

function RoomCharacterHelper.checkCharacterAnimalInteraction(heroId)
	local config
	local configList = lua_room_character_interaction.configList

	for i, one in ipairs(configList) do
		if one.heroId == heroId and one.behaviour == RoomCharacterEnum.InteractionType.Animal then
			config = one

			break
		end
	end

	if not config then
		return false
	end

	return RoomCharacterHelper.checkInteractionValid(config)
end

function RoomCharacterHelper.checkInteractionValid(config)
	if not config then
		return false
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.heroId)

	if not roomCharacterMO or roomCharacterMO.characterState ~= RoomCharacterEnum.CharacterState.Map and not roomCharacterMO:getCurrentInteractionId() then
		return false
	end

	if config.relateHeroId ~= 0 then
		local relateRoomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.relateHeroId)

		if not relateRoomCharacterMO or relateRoomCharacterMO.characterState ~= RoomCharacterEnum.CharacterState.Map and not relateRoomCharacterMO:getCurrentInteractionId() then
			return false
		end
	end

	if config.buildingId ~= 0 then
		local hasBuilding = false
		local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

		for i, buildingMO in ipairs(buildingMOList) do
			if buildingMO.buildingId == config.buildingId and buildingMO.buildingState == RoomBuildingEnum.BuildingState.Map and not buildingMO:getCurrentInteractionId() then
				hasBuilding = true

				break
			end
		end

		if not hasBuilding then
			return false
		end
	end

	if math.random() >= config.rate / 1000 then
		return false
	end

	if config.faithDialog and config.behaviour == RoomCharacterEnum.InteractionType.Dialog and config.faithDialog > 0 then
		local heroMO = HeroModel.instance:getByHeroId(config.heroId)

		if heroMO then
			local faithPer = HeroConfig.instance:getFaithPercent(heroMO.faith)
			local faith = faithPer[1] * 1000

			if faith < config.faithDialog then
				return false
			end
		end
	end

	return true
end

function RoomCharacterHelper.isInDialogInteraction()
	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	return playingInteractionParam and playingInteractionParam.behaviour == RoomCharacterEnum.InteractionType.Dialog
end

function RoomCharacterHelper.interactionIsDialogWithSelect(interactionId)
	local interactionConfig = RoomConfig.instance:getCharacterInteractionConfig(interactionId)

	if interactionConfig.behaviour ~= RoomCharacterEnum.InteractionType.Dialog then
		return false
	end

	local dialogId = interactionConfig.dialogId
	local stepId = 0

	while true do
		stepId = stepId + 1

		local dialogConfig = RoomConfig.instance:getCharacterDialogConfig(dialogId, stepId)

		if not dialogConfig then
			break
		end

		if not string.nilorempty(dialogConfig.selectIds) then
			return true
		end
	end

	return false
end

function RoomCharacterHelper.isCharacterBlock(blockPosition, positionList)
	if not positionList then
		return false
	end

	local mainCamera = CameraMgr.instance:getMainCameraGO()
	local cameraPosition = mainCamera.transform.position
	local blockDistance = Vector3.Distance(blockPosition, cameraPosition)

	for i, position in ipairs(positionList) do
		local distance = Vector3.Distance(position, cameraPosition)

		if blockDistance < distance then
			return true
		end
	end

	return false
end

function RoomCharacterHelper.getAllBlockMeshRendererList(hexPointList, excludeBuildingUid)
	local scene = GameSceneMgr.instance:getCurScene()
	local entityList = {}
	local meshRendererListTable = {}

	if hexPointList then
		local hexDict = {}

		for _, p in ipairs(hexPointList) do
			hexDict[p.x] = hexDict[p.x] or {}
			hexDict[p.x][p.y] = true
		end

		local function isHexInDict(p)
			if p then
				return hexDict[p.x] and hexDict[p.x][p.y]
			end
		end

		local mapTags = {
			SceneTag.RoomMapBlock,
			SceneTag.RoomEmptyBlock
		}

		for _, t in ipairs(mapTags) do
			local dict = scene.mapmgr:getTagUnitDict(t)

			if dict then
				for _, entity in pairs(dict) do
					local mo = entity:getMO()

					if mo and mo.hexPoint and isHexInDict(mo.hexPoint) then
						table.insert(entityList, entity)
					end
				end
			end
		end

		local buildTags = {
			SceneTag.RoomBuilding,
			SceneTag.RoomInitBuilding,
			SceneTag.RoomPartBuilding
		}

		for _, t in ipairs(buildTags) do
			local dict = scene.buildingmgr:getTagUnitDict(t)

			if dict then
				for _, entity in pairs(dict) do
					if t == SceneTag.RoomBuilding then
						local mo = entity:getMO()

						if mo and mo.buildingUid ~= excludeBuildingUid and isHexInDict(mo.hexPoint) then
							table.insert(entityList, entity)
						end
					else
						table.insert(entityList, entity)
					end
				end
			end
		end
	else
		LuaUtil.insertDict(entityList, scene.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))
		LuaUtil.insertDict(entityList, scene.mapmgr:getTagUnitDict(SceneTag.RoomEmptyBlock))
		LuaUtil.insertDict(entityList, scene.buildingmgr:getTagUnitDict(SceneTag.RoomBuilding))
		LuaUtil.insertDict(entityList, scene.buildingmgr:getTagUnitDict(SceneTag.RoomInitBuilding))
		LuaUtil.insertDict(entityList, scene.buildingmgr:getTagUnitDict(SceneTag.RoomPartBuilding))
	end

	for _, entity in ipairs(entityList) do
		tabletool.addValues(meshRendererListTable, entity:getCharacterMeshRendererList())
	end

	return meshRendererListTable
end

function RoomCharacterHelper.getAllBlockCharacterGOList()
	local scene = GameSceneMgr.instance:getCurScene()
	local goList = {}
	local characterEntityDict = scene.charactermgr:getRoomCharacterEntityDict()

	for id, entity in pairs(characterEntityDict) do
		local go = entity.characterspine:getCharacterGO()

		if go then
			table.insert(goList, go)
		end
	end

	return goList
end

local _BoundsMinSize = {
	z = 0,
	x = 0,
	y = 0
}
local _BoundsMaxSize = {
	z = 0,
	x = 0,
	y = 0
}

function RoomCharacterHelper.isBlockCharacter(rayList, lengthList, meshBounds)
	if rayList and #rayList > 0 then
		local extents = meshBounds.extents
		local center = meshBounds.center

		if center.y + extents.y < 0.2 then
			return false
		end

		local boundsMin = _BoundsMinSize
		local boundsMax = _BoundsMaxSize
		local centerX, centerY, centerZ = RoomBendingHelper.worldToBendingXYZ(center, true)

		boundsMin.x = centerX - extents.x
		boundsMin.y = centerY - extents.y - 0.2
		boundsMin.z = centerZ - extents.z
		boundsMax.x = centerX + extents.x
		boundsMax.y = centerY + extents.y + 0.2
		boundsMax.z = centerZ + extents.z

		for i = 1, #rayList do
			if RoomCharacterHelper.testAABB(rayList[i], lengthList[i], boundsMin, boundsMax) then
				return true
			end
		end
	end

	return false
end

local _testAABBKeys = {
	"x",
	"y",
	"z"
}

function RoomCharacterHelper.testAABB(ray, length, boundsMin, boundsMax)
	local tmin = 0
	local tmax = length
	local keys = _testAABBKeys
	local rayDirection = ray.direction
	local rayOirigin = ray.origin

	for _, key in ipairs(keys) do
		if math.abs(rayDirection[key]) < 0.01 then
			if rayOirigin[key] < boundsMin[key] or rayOirigin[key] > boundsMax[key] then
				return false
			end
		else
			local invDir = 1 / rayDirection[key]
			local t1 = (boundsMin[key] - rayOirigin[key]) * invDir
			local t2 = (boundsMax[key] - rayOirigin[key]) * invDir

			if t2 < t1 then
				t2 = t1
				t1 = t2
			end

			if tmin < t1 then
				tmin = t1
			end

			if t2 < tmax then
				tmax = t2
			end

			if tmax < tmin then
				return false
			end
		end
	end

	return true
end

function RoomCharacterHelper.getBridgePositions(nearPosition)
	local bridgePositions = {}
	local scene = GameSceneMgr.instance:getCurScene()
	local bridgeGameObjects = {}
	local entityList = {}

	LuaUtil.insertDict(entityList, scene.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))

	for i, entity in ipairs(entityList) do
		tabletool.addValues(bridgeGameObjects, entity:getGameObjectListByName("characterPathPoint"))
	end

	for i, bridgeGameObject in ipairs(bridgeGameObjects) do
		local bridgePosition = bridgeGameObject.transform.position

		if RoomCharacterHelper.checkMoveDistance(nearPosition, bridgePosition) then
			table.insert(bridgePositions, bridgePosition)
		end
	end

	return bridgePositions
end

function RoomCharacterHelper.getCharacterFaithFill(roomCharacterMO)
	if roomCharacterMO.currentFaith <= 0 then
		return 0
	end

	local maxMinute = CommonConfig.instance:getConstNum(ConstEnum.RoomCharacterFaithTotalMinute)

	return roomCharacterMO.currentMinute / maxMinute
end

function RoomCharacterHelper.getCharacterInteractionId(heroId)
	for i, config in ipairs(lua_room_character_interaction.configList) do
		if config.heroId == heroId and config.behaviour == RoomCharacterEnum.InteractionType.Dialog and config.relateHeroId == 0 then
			return config.id
		end
	end
end

function RoomCharacterHelper.getIdleAnimStateName(heroId)
	return RoomCharacterEnum.CharacterIdleAnimReplaceName[heroId] or RoomCharacterEnum.CharacterAnimStateName.Idle
end

function RoomCharacterHelper.getAnimStateName(moveState, heroId)
	if moveState == RoomCharacterEnum.CharacterMoveState.Idle then
		return RoomCharacterHelper.getIdleAnimStateName(heroId)
	end

	return RoomCharacterEnum.CharacterAnimState[moveState]
end

function RoomCharacterHelper.getNextAnimStateName(moveState, animStateName)
	local result
	local animList = RoomCharacterEnum.CharacterNextAnimNameDict[moveState]

	if animList then
		result = animList[animStateName]

		if not animList[animStateName] and RoomCharacterEnum.LoopAnimState[animStateName] then
			result = animStateName
		end
	end

	return result
end

function RoomCharacterHelper.getSpinePointPath(pointName)
	if string.nilorempty(pointName) or pointName == "mountroot" then
		return "mountroot"
	end

	return "mountroot/" .. pointName
end

function RoomCharacterHelper.hasWaterNodeNear(position, nearDistance)
	local posX = position.x
	local posZ = position.z
	local tempDistance = (nearDistance + RoomBlockEnum.BlockSize)^2
	local emptyBlockPositions = RoomCharacterModel.instance:getEmptyBlockPositions()

	for i, emptyPosition in ipairs(emptyBlockPositions) do
		if tempDistance >= (emptyPosition.x - posX)^2 + (emptyPosition.y - posZ)^2 then
			return true
		end
	end

	tempDistance = nearDistance^2

	local waterNodePositions = RoomCharacterModel.instance:getWaterNodePositions()

	for i, waterNodePosition in ipairs(waterNodePositions) do
		if tempDistance >= (waterNodePosition.x - posX)^2 + (waterNodePosition.z - posZ)^2 then
			return true
		end
	end

	return false
end

return RoomCharacterHelper
