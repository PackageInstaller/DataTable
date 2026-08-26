-- chunkname: @modules/logic/versionactivity3_8/dianjishi/controller/DianJiShiGameController.lua

module("modules.logic.versionactivity3_8.dianjishi.controller.DianJiShiGameController", package.seeall)

local DianJiShiGameController = class("DianJiShiGameController", BaseController)

function DianJiShiGameController:posIndex2Pos(posXIndex, posYIndex, includeAreaSplit)
	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()
	local crossAreaNum_H, crossAreaNum_V = 0, 0

	if includeAreaSplit then
		crossAreaNum_H, crossAreaNum_V = DianJiShiGameModel.instance:getCrossFromStart(posXIndex, posYIndex)
	end

	local mapId = DianJiShiGameModel.instance:getMapId()
	local splitLineWidth, splintLineHeight = DianJiShiGameConfig.instance:getAreaSplitLineSize(mapId)
	local posX = (posXIndex - 1) * cellWidth + crossAreaNum_H * splitLineWidth
	local posY = -(posYIndex - 1) * cellHeight - crossAreaNum_V * splintLineHeight

	return posX, posY
end

function DianJiShiGameController:pos2PosIndex(posX, posY)
	posX = posX or 0
	posY = posY or 0

	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()
	local posXIndex = Mathf.Round(posX / cellWidth) + 1
	local posYIndex = Mathf.Round(-posY / cellHeight) + 1

	return posXIndex, posYIndex
end

function DianJiShiGameController:cellPosIndex2GlobalIndex(cellPosXIndex, cellPosYIndex, blockPosXIndex, blockPosYIndex)
	cellPosXIndex = cellPosXIndex or 0
	cellPosYIndex = cellPosYIndex or 0
	blockPosXIndex = blockPosXIndex or 0
	blockPosYIndex = blockPosYIndex or 0

	local globalPosXIndex = cellPosXIndex + blockPosXIndex - 1
	local globalPosYIndex = cellPosYIndex + blockPosYIndex - 1

	return globalPosXIndex, globalPosYIndex
end

function DianJiShiGameController:globalIndex2CellPosIndex(globalCellPosXIndex, globalCellPosYIndex, blockPosXIndex, blockPosYIndex)
	local cellPosXIndex = globalCellPosXIndex + 1 - blockPosXIndex
	local cellPosYIndex = globalCellPosYIndex + 1 - blockPosYIndex

	return cellPosXIndex, cellPosYIndex
end

function DianJiShiGameController:getBlockFilterCellList(blockInfo, posXIndex, posYIndex, filterCellList, filterAreaMap)
	if not blockInfo then
		return
	end

	local cellList = blockInfo and blockInfo.cubeList

	filterAreaMap = filterAreaMap or {}
	filterCellList = filterCellList or {}

	tabletool.clear(filterAreaMap)
	tabletool.clear(filterCellList)

	if cellList then
		for _, cellInfo in ipairs(cellList) do
			local globalPosX, globalPosY = self:cellPosIndex2GlobalIndex(cellInfo[1], cellInfo[2], posXIndex, posYIndex)

			if DianJiShiGameModel.instance:checkIndexInMap(globalPosX, globalPosY) then
				table.insert(filterCellList, cellInfo)

				local areaInfo = DianJiShiGameModel.instance:getMapAreaInfoByPos(globalPosX, globalPosY)
				local areaId = areaInfo and areaInfo.id

				filterAreaMap[areaId] = filterAreaMap[areaId] or true
			end
		end
	end

	return filterCellList, filterAreaMap
end

function DianJiShiGameController:tryPlaceCube2Map(posXIndex, posYIndex, blockInfo, isRollback)
	if not blockInfo then
		return
	end

	local canPlace = DianJiShiGameModel.instance:checkCanPlaceBlock(posXIndex, posYIndex, blockInfo)

	if not canPlace then
		if isRollback then
			DianJiShiGameModel.instance:executeCmd(DianJiShiGameEnum.OpType.Remove, nil, nil, blockInfo, isRollback)
		end

		if DianJiShiGameModel.instance:isBlockPlaceInMap(blockInfo.id) and not DianJiShiGameModel.instance:checkIndexInMap(posXIndex, posYIndex) then
			DianJiShiGameModel.instance:executeCmd(DianJiShiGameEnum.OpType.Remove, nil, nil, blockInfo, isRollback)
		end

		self:dispatchEvent(DianJiShiGameEvent.OnPlaceBlockError, blockInfo)
		self:checkAndSetGameStatus()

		return
	end

	DianJiShiGameModel.instance:executeCmd(DianJiShiGameEnum.OpType.Placed, posXIndex, posYIndex, blockInfo, isRollback)
	self:dispatchEvent(DianJiShiGameEvent.OnPlaceBlockDone, blockInfo)
	self:checkAndSetGameStatus()
end

function DianJiShiGameController:rollBack()
	local lastCmd = DianJiShiGameModel.instance:getAndRemoveLastCommand()

	if not lastCmd then
		GameFacade.showToast(ToastEnum.DianJiShiNotRollback)

		return
	end

	local preXIndex = lastCmd.preXIndex
	local preYIndex = lastCmd.preYIndex
	local blockId = lastCmd.blockId
	local blockInfo = DianJiShiGameModel.instance:getBlockInfoById(blockId)

	if not blockInfo then
		return
	end

	DianJiShiStatController.instance:addRollBackTimes()
	self:tryPlaceCube2Map(preXIndex, preYIndex, blockInfo, true)
end

function DianJiShiGameController:reset()
	DianJiShiGameModel.instance:resetInfo()
	self:dispatchEvent(DianJiShiGameEvent.OnPlaceBlockDone)
end

function DianJiShiGameController:calcMinAndMaxValue(curValue, minValue, maxValue)
	return math.min(curValue, minValue), math.max(curValue, maxValue)
end

function DianJiShiGameController:checkAndSetGameStatus()
	local waitBlockList = DianJiShiGameModel.instance:getWaitBlockInfoList()

	if waitBlockList and #waitBlockList > 0 then
		DianJiShiGameModel.instance:updateGameStatus(DianJiShiGameEnum.GameStatus.Running)

		return
	end

	local allAreaInfoList = DianJiShiGameModel.instance:getMapAreaInfoList()

	if not allAreaInfoList then
		return
	end

	for _, areaInfo in ipairs(allAreaInfoList) do
		if areaInfo.config.value ~= areaInfo.value then
			DianJiShiGameModel.instance:updateGameStatus(DianJiShiGameEnum.GameStatus.Failed)

			return
		end
	end

	DianJiShiGameModel.instance:updateGameStatus(DianJiShiGameEnum.GameStatus.Success)
end

function DianJiShiGameController:setCubeIcon(blockId, cubePosIndex, imageIcon, imageFront, isKeepVisible)
	local blockInfo = DianJiShiGameModel.instance:getBlockInfoById(blockId)

	if not blockInfo then
		return
	end

	if blockInfo.config then
		local baseIconName = blockInfo.config.icon
		local iconName = string.format("%s_1", baseIconName)

		UISpriteSetMgr.instance:setV3a8DianJiShiSprite(imageIcon, iconName, true)
		gohelper.setActive(imageFront.gameObject, (not isKeepVisible and blockInfo.status == DianJiShiGameEnum.BlockStatus.Placed or nil) and self:checkIsSameAreaFront(blockInfo.posIndex, cubePosIndex))

		local frontIconName = string.format("%s_2", baseIconName)

		UISpriteSetMgr.instance:setV3a8DianJiShiSprite(imageFront, frontIconName, true)
	end
end

function DianJiShiGameController:checkIsFrontCube(blockInfo, posIndex)
	if not blockInfo then
		return
	end

	local posXIndex = posIndex[1]
	local posYIndex = posIndex[2]
	local cubeMap = blockInfo.cubeMap
	local var_12_0

	if cubeMap then
		::label_12_0::

		var_12_0 = cubeMap[posXIndex] and not cubeMap[posXIndex][posYIndex + 1]
	end

	return var_12_0
end

function DianJiShiGameController:checkIsSameAreaFront(blockPosIndex, cubePosIndex)
	if not blockPosIndex or not cubePosIndex then
		return
	end

	local globalCubePosX, globalCubePosY = self:cellPosIndex2GlobalIndex(cubePosIndex[1], cubePosIndex[2], blockPosIndex[1], blockPosIndex[2])
	local curAreaInfo = DianJiShiGameModel.instance:getMapAreaInfoByPos(globalCubePosX, globalCubePosY)
	local frontAreaInfo = DianJiShiGameModel.instance:getMapAreaInfoByPos(globalCubePosX, globalCubePosY + 1)

	return DianJiShiGameModel.instance:checkIndexInMap(globalCubePosX, globalCubePosY + 1) and curAreaInfo == frontAreaInfo
end

function DianJiShiGameController:calcCubeShadowType(blockId, globalCubePos)
	local blockInfo = DianJiShiGameModel.instance:getBlockInfoById(blockId)

	if not blockInfo or blockInfo.status ~= DianJiShiGameEnum.BlockStatus.Placed then
		return
	end

	local globalCubePosX = globalCubePos[1]
	local globalCubePosY = globalCubePos[2]
	local isLeft = DianJiShiGameModel.instance:isNotPlacedInMapArea(globalCubePosX - 1, globalCubePosY)
	local isRight = DianJiShiGameModel.instance:isNotPlacedInMapArea(globalCubePosX + 1, globalCubePosY)
	local isBottom = DianJiShiGameModel.instance:isNotPlacedInMapArea(globalCubePosX, globalCubePosY + 1)
	local isTop = DianJiShiGameModel.instance:isNotPlacedInMapArea(globalCubePosX, globalCubePosY - 1)
	local rightShadowType = DianJiShiGameEnum.ShadowType.None

	if isRight then
		rightShadowType = isTop and DianJiShiGameEnum.ShadowType.RightCorner or DianJiShiGameEnum.ShadowType.Right_Full
	end

	return (isBottom or nil) and (isLeft and DianJiShiGameEnum.ShadowType.TopCorner or DianJiShiGameEnum.ShadowType.TopFull), rightShadowType
end

function DianJiShiGameController:getNextHelpBlockInfo()
	local allBlockList = DianJiShiGameModel.instance:getAllBlockInfoList()

	if not allBlockList then
		return
	end

	local mapId = DianJiShiGameModel.instance:getMapId()
	local nextHelpBlock, nextHelpBlockRightPos, minHelpOrder

	for _, blockInfo in ipairs(allBlockList) do
		if not nextHelpBlock or minHelpOrder > blockInfo.config.helpOrder then
			local isInRightPos, rightPos = self:checkAndGetBlockRightPos(mapId, blockInfo)

			if not isInRightPos and rightPos then
				nextHelpBlock = blockInfo
				minHelpOrder = blockInfo.config.helpOrder
				nextHelpBlockRightPos = rightPos
			end
		end
	end

	return nextHelpBlock, nextHelpBlockRightPos
end

function DianJiShiGameController:checkAndGetBlockRightPos(mapId, blockInfo)
	if not mapId or not blockInfo then
		return
	end

	local blockId = blockInfo.id
	local rightPosList = DianJiShiGameConfig.instance:getBlockRightPosList(mapId, blockInfo.id)

	if not rightPosList then
		return
	end

	local curBlockPosX = blockInfo.posIndex[1]
	local curBlockPosY = blockInfo.posIndex[2]

	if DianJiShiGameConfig.instance:isBlockInRightPos(mapId, blockId, curBlockPosX, curBlockPosY) then
		return true, blockInfo.posIndex
	end

	for _, rightPos in ipairs(rightPosList) do
		local placeCubeInfo = DianJiShiGameModel.instance:getMapPlaceCubeInfo(rightPos[1], rightPos[2])

		if not placeCubeInfo then
			return false, rightPos
		end

		local placedBlockInfo = DianJiShiGameModel.instance:getBlockInfoById(placeCubeInfo.blockId)

		if not placedBlockInfo or placedBlockInfo.config.type ~= blockInfo.config.type then
			return false, rightPos
		end
	end
end

function DianJiShiGameController:startGame(actId, episodeId, gameDataJson)
	local episodeCo = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
	local gameId = episodeCo and episodeCo.gameId
	local gameCo = DianJiShiGameConfig.instance:getGameConfig(gameId)

	if not gameCo then
		logError(string.format("奠基石小游戏配置不存在 actId = %s, episodeId = %s, gameId = %s", actId, episodeId, gameId))

		return
	end

	ViewMgr.instance:openView(ViewName.DianJiShiGameView, {
		actId = actId,
		episodeId = episodeId,
		gameId = gameId,
		gameDataJson = gameDataJson
	})

	return true
end

function DianJiShiGameController:calcMapShadowInfoList(ignoreBlockId)
	local shadowList = {}
	local cellConfigMap = DianJiShiGameModel.instance:getMapConfigDict()

	if cellConfigMap then
		for i, rowList in pairs(cellConfigMap) do
			for j, _ in pairs(rowList) do
				local shadowType = self:_calcOneCellShadowType(i, j, ignoreBlockId)

				if shadowType and shadowType ~= DianJiShiGameEnum.ShadowType.None then
					table.insert(shadowList, {
						posXIndex = i,
						posYIndex = j,
						type = shadowType
					})
				end
			end
		end
	end

	return shadowList
end

function DianJiShiGameController:_calcOneCellShadowType(posXIndex, posYIndex, ignoreBlockId)
	local placedInfo = DianJiShiGameModel.instance:getMapPlaceCubeInfo(posXIndex, posYIndex)

	if placedInfo and placedInfo.blockId ~= ignoreBlockId then
		return
	end

	local shadowType = DianJiShiGameEnum.ShadowType.None
	local leftObstacle = self:_isCreateShadow(posXIndex, posYIndex, posXIndex - 1, posYIndex, ignoreBlockId)
	local bottomObstacle = self:_isCreateShadow(posXIndex, posYIndex, posXIndex, posYIndex - 1, ignoreBlockId)
	local leftBottomObstacle = self:_isCreateShadow(posXIndex, posYIndex, posXIndex - 1, posYIndex - 1, ignoreBlockId)

	if leftObstacle and not bottomObstacle and not leftBottomObstacle then
		shadowType = DianJiShiGameEnum.ShadowType.Left
	elseif not leftObstacle and bottomObstacle and not leftBottomObstacle then
		shadowType = DianJiShiGameEnum.ShadowType.Top
	elseif leftObstacle and bottomObstacle then
		shadowType = DianJiShiGameEnum.ShadowType.LeftAndTop
	elseif not leftObstacle and leftBottomObstacle and not bottomObstacle then
		shadowType = DianJiShiGameEnum.ShadowType.LeftTop
	elseif leftObstacle and leftBottomObstacle and not bottomObstacle then
		shadowType = DianJiShiGameEnum.ShadowType.LeftAndLeftTop
	elseif not leftObstacle and bottomObstacle and leftBottomObstacle then
		shadowType = DianJiShiGameEnum.ShadowType.LeftTopAndTop
	end

	return shadowType
end

function DianJiShiGameController:_isCreateShadow(startPosX, startPosY, endPosX, endPosY, ignoreBlockId)
	local startAreaInfo = DianJiShiGameModel.instance:getMapAreaInfoByPos(startPosX, startPosY)
	local endAreaInfo = DianJiShiGameModel.instance:getMapAreaInfoByPos(endPosX, endPosY)

	if startAreaInfo ~= endAreaInfo then
		return true
	end

	local placedCubeInfo = DianJiShiGameModel.instance:getMapPlaceCubeInfo(endPosX, endPosY)
	local blockId = placedCubeInfo and placedCubeInfo.blockId
	local blockInfo = DianJiShiGameModel.instance:getBlockInfoById(blockId)

	return blockInfo and blockInfo.id ~= ignoreBlockId
end

function DianJiShiGameController:isMultiTouch()
	return UnityEngine.Input.touchCount > 1
end

DianJiShiGameController.instance = DianJiShiGameController.New()

LuaEventSystem.addEventMechanism(DianJiShiGameController.instance)

return DianJiShiGameController
