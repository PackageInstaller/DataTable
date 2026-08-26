-- chunkname: @modules/logic/versionactivity3_8/dianjishi/model/DianJiShiGameModel.lua

module("modules.logic.versionactivity3_8.dianjishi.model.DianJiShiGameModel", package.seeall)

local DianJiShiGameModel = class("DianJiShiGameModel", BaseModel)

function DianJiShiGameModel:initGame(mapId)
	self._mapId = mapId
	self._guieBlockInfo = nil
	self._lastAreaTagPath = nil
	self._isDraging = false
	self._cmdList = {}

	self:setIsDraging(false)
	self:_initMapConfig()
	self:_initBlockConfig()
	self:updateGameStatus(DianJiShiGameEnum.GameStatus.Running)
end

function DianJiShiGameModel:resetInfo()
	self:initGame(self._mapId)
end

function DianJiShiGameModel:getMapId()
	return self._mapId
end

function DianJiShiGameModel:_initMapConfig()
	self._crossInfoDict = {}
	self._mapConfigMap = {}
	self._mapConfigList = {}
	self._mapAreaInfoList = {}
	self._mapAreaInfoDict = {}
	self._minMapXIndex, self._minMapYIndex = 100, 100
	self._maxMapXIndex, self._maxMapYIndex = -100, -100

	local mapAreaList = DianJiShiGameConfig.instance:getMapAreaList(self._mapId)

	if mapAreaList then
		for _, areaCo in ipairs(mapAreaList) do
			local cellList = DianJiShiGameConfig.instance:getMapAreaCellList(self._mapId, areaCo.id)
			local minAreaXIndex, minAreaYIndex = 100, 100
			local maxAreaXIndex, maxAreaYIndex = -100, -100

			if cellList then
				for _, cellCo in ipairs(cellList) do
					local posXIndex, posYIndex = self:_processOneMapCellCo(areaCo, cellCo)

					minAreaXIndex, maxAreaXIndex = DianJiShiGameController.instance:calcMinAndMaxValue(posXIndex, minAreaXIndex, maxAreaXIndex)
					minAreaYIndex, maxAreaYIndex = DianJiShiGameController.instance:calcMinAndMaxValue(posYIndex, minAreaYIndex, maxAreaYIndex)
				end
			end

			local areaInfo = {
				value = 0,
				id = areaCo.id,
				config = areaCo,
				minXIndex = minAreaXIndex,
				minYIndex = minAreaYIndex,
				maxXIndex = maxAreaXIndex,
				maxYIndex = maxAreaYIndex
			}

			self._mapAreaInfoDict[areaInfo.id] = areaInfo

			table.insert(self._mapAreaInfoList, areaInfo)
		end
	end

	if self._mapAreaInfoList then
		self._mapAreaInfoNum = #self._mapAreaInfoList or 0
	end
end

function DianJiShiGameModel:_processOneMapCellCo(areaCo, cellCo)
	if not cellCo[1] then
		if not cellCo[2] then
			local posYIndex = 0

			self._mapConfigMap[cellCo[1]] = self._mapConfigMap[cellCo[1]] or {}
			self._mapConfigMap[cellCo[1]][posYIndex] = {
				posIndex = cellCo,
				areaCo = areaCo
			}
			self._minMapXIndex, self._maxMapXIndex = DianJiShiGameController.instance:calcMinAndMaxValue(cellCo[1], self._minMapXIndex, self._maxMapXIndex)
			self._minMapYIndex, self._maxMapYIndex = DianJiShiGameController.instance:calcMinAndMaxValue(posYIndex, self._minMapYIndex, self._maxMapYIndex)

			return cellCo[1], posYIndex
		end
	end
end

function DianJiShiGameModel:_initBlockConfig()
	self._allBlockInfoMap = {}
	self._allBlockInfoList = {}
	self._placeCubeMap = {}
	self._placeCubeList = {}
	self._placeBlockIdMap = {}
	self._waitBlockList = {}
	self._typeBlockList = {}
	self._typeBlockMap = {}

	local blockCoList = DianJiShiGameConfig.instance:getMapBlockList(self._mapId)

	if not blockCoList then
		return
	end

	for _, blockCo in ipairs(blockCoList) do
		local cubeMap = DianJiShiGameConfig.instance:getBlockShapeMap(self._mapId, blockCo.id)
		local cubeList = DianJiShiGameConfig.instance:getBlockShapeList(self._mapId, blockCo.id)
		local size = DianJiShiGameConfig.instance:getBlockSize(self._mapId, blockCo.id)
		local blockInfo = {
			config = blockCo,
			id = blockCo.id,
			posIndex = {
				-1,
				-1
			},
			status = DianJiShiGameEnum.BlockStatus.Wait,
			cubeMap = cubeMap,
			cubeList = cubeList,
			rightPos = string.splitToNumber(blockCo.rightPos, "#"),
			size = size
		}

		self._allBlockInfoMap[blockCo.id] = blockInfo

		table.insert(self._allBlockInfoList, blockInfo)
		table.insert(self._waitBlockList, blockInfo)

		local type = blockCo.type
		local typeBlockList = self._typeBlockMap[type]

		if not typeBlockList then
			typeBlockList = {}
			self._typeBlockMap[type] = typeBlockList

			table.insert(self._typeBlockList, typeBlockList)
		end

		table.insert(typeBlockList, blockInfo)
	end

	table.sort(self._typeBlockList, self._compressWaitBlockSortFunc)
end

function DianJiShiGameModel:getPlaceCubeInfoList()
	return self._placeCubeList
end

function DianJiShiGameModel:getCellSize()
	local size = DianJiShiGameEnum.MapCellSize
	local width = size and size[1]
	local height = size and size[2]

	return width or 0, height or 0
end

function DianJiShiGameModel:getWaitBlockInfoList()
	return self._waitBlockList
end

function DianJiShiGameModel:getAllTypeBlockList()
	return self._typeBlockList
end

function DianJiShiGameModel._compressWaitBlockSortFunc(aBlockList, bBlockList)
	local aFirstBlock = aBlockList and aBlockList[1]
	local bFirstBlock = bBlockList and bBlockList[1]
	local aConfig = aFirstBlock and aFirstBlock.config
	local bConfig = bFirstBlock and bFirstBlock.config
	local aType = aConfig and aConfig.type
	local bType = bConfig and bConfig.type

	if aType ~= bType then
		return aType < bType
	end

	return aConfig.id < bConfig.id
end

function DianJiShiGameModel:getAllBlockInfoList()
	return self._allBlockInfoList
end

function DianJiShiGameModel:getBlockInfoById(blockId)
	if not blockId then
		return
	end

	return self._allBlockInfoMap and self._allBlockInfoMap[blockId]
end

function DianJiShiGameModel:checkCanPlaceBlock(posXIndex, posYIndex, blockInfo)
	local cubeList = blockInfo and blockInfo.cubeList

	if not cubeList then
		return
	end

	for _, cubeCo in ipairs(cubeList) do
		local cubePosXIndex, cubePosYIndex = DianJiShiGameController.instance:cellPosIndex2GlobalIndex(cubeCo[1], cubeCo[2], posXIndex, posYIndex)

		if not self:checkIndexInMap(cubePosXIndex, cubePosYIndex) then
			return
		end

		local placeCubeInfo = self:getMapPlaceCubeInfo(cubePosXIndex, cubePosYIndex)

		if placeCubeInfo and placeCubeInfo.blockId ~= blockInfo.id then
			return
		end
	end

	return true
end

function DianJiShiGameModel:checkIndexInMap(posXIndex, posYIndex)
	if self._mapConfigMap then
		return self._mapConfigMap and self._mapConfigMap[posYIndex] ~= nil
	end
end

function DianJiShiGameModel:getMapConfigDict()
	return self._mapConfigMap
end

function DianJiShiGameModel:getMapPlaceCubeInfo(posXIndex, posYIndex)
	if self._placeCubeMap then
		return self._placeCubeMap and self._placeCubeMap[posYIndex]
	end
end

function DianJiShiGameModel:executeCmd(cmdType, posXIndex, posYIndex, blockInfo, isRollback)
	if not isRollback then
		local cmdInfo = {
			cmdType = cmdType,
			blockId = blockInfo.id,
			targetXIndex = posXIndex,
			targetYIndex = posYIndex,
			preXIndex = blockInfo.posIndex[1],
			preYIndex = blockInfo.posIndex[2]
		}

		table.insert(self._cmdList, cmdInfo)
	end

	if cmdType == DianJiShiGameEnum.OpType.Placed then
		return self:placeBlock2TargetPos(posXIndex, posYIndex, blockInfo)
	elseif cmdType == DianJiShiGameEnum.OpType.Remove then
		return self:removeBlockFromMap(blockInfo)
	end
end

function DianJiShiGameModel:placeBlock2TargetPos(posXIndex, posYIndex, blockInfo)
	if not blockInfo then
		return
	end

	self:removeBlockFromMap(blockInfo)

	self._placeBlockIdMap[blockInfo.id] = true

	tabletool.removeValue(self._waitBlockList, blockInfo)

	blockInfo.status = DianJiShiGameEnum.BlockStatus.Placed

	self:_updateBlockPosIndex(blockInfo, posXIndex, posYIndex)

	local blockCo = blockInfo and blockInfo.config
	local cubeList = blockInfo and blockInfo.cubeList

	if cubeList then
		local calcAreaIdMap = {}

		for _, cubeCo in ipairs(cubeList) do
			local cubePosXIndex, cubePosYIndex = DianJiShiGameController.instance:cellPosIndex2GlobalIndex(cubeCo[1], cubeCo[2], posXIndex, posYIndex)
			local cubeInfo = {
				blockId = blockInfo.id,
				posIndex = {
					cubePosXIndex,
					cubePosYIndex
				}
			}

			self._placeCubeMap[cubePosXIndex] = self._placeCubeMap[cubePosXIndex] or {}
			self._placeCubeMap[cubePosXIndex][cubePosYIndex] = cubeInfo

			table.insert(self._placeCubeList, cubeInfo)

			local areaInfo = self:getMapAreaInfoByPos(cubePosXIndex, cubePosYIndex)

			if areaInfo and not calcAreaIdMap[areaInfo.id] then
				if not blockCo.value then
					local blockValue = 0

					areaInfo.value = areaInfo.value + blockValue
					calcAreaIdMap[areaInfo.id] = true
				end
			end
		end
	end
end

function DianJiShiGameModel:removeBlockFromMap(blockInfo)
	if not blockInfo or not self._placeBlockIdMap[blockInfo.id] then
		return
	end

	blockInfo.status = DianJiShiGameEnum.BlockStatus.Wait

	if blockInfo.posIndex then
		if not blockInfo.posIndex[1] then
			local posXIndex = 0

			if blockInfo.posIndex then
				if not blockInfo.posIndex[2] then
					local posYIndex = 0

					self:_updateBlockPosIndex(blockInfo)

					local cubeList = blockInfo and blockInfo.cubeList

					if not cubeList then
						return
					end

					local blockCo = blockInfo.config
					local calcAreaIdMap = {}

					for _, cubeCo in ipairs(cubeList) do
						local cubePosXIndex, cubePosYIndex = DianJiShiGameController.instance:cellPosIndex2GlobalIndex(cubeCo[1], cubeCo[2], posXIndex, posYIndex)
						local placeCubeList = self._placeCubeMap[cubePosXIndex]
						local cubeInfo = placeCubeList and placeCubeList[cubePosYIndex]

						if cubeInfo then
							tabletool.removeValue(self._placeCubeList, cubeInfo)

							self._placeCubeMap[cubePosXIndex][cubePosYIndex] = nil

							local areaInfo = self:getMapAreaInfoByPos(cubePosXIndex, cubePosYIndex)

							if areaInfo and not calcAreaIdMap[areaInfo.id] then
								if blockCo then
									if not blockCo.value then
										local blockValue = 0

										areaInfo.value = areaInfo.value - blockValue
										calcAreaIdMap[areaInfo.id] = true
									end
								end
							end
						end
					end

					table.insert(self._waitBlockList, blockInfo)

					self._placeBlockIdMap[blockInfo.id] = nil
				end
			end
		end
	end
end

function DianJiShiGameModel:_updateBlockPosIndex(blockInfo, posXIndex, posYIndex)
	if not blockInfo then
		return
	end

	posXIndex = posXIndex or -1
	posYIndex = posYIndex or -1
	blockInfo.posIndex = blockInfo.posIndex or {}
	blockInfo.posIndex[1] = posXIndex
	blockInfo.posIndex[2] = posYIndex
end

function DianJiShiGameModel:isBlockPlaceInMap(blockId)
	return self._placeBlockIdMap and self._placeBlockIdMap[blockId] == true
end

function DianJiShiGameModel:getMapIndexRange()
	return self._minMapXIndex, self._minMapYIndex, self._maxMapXIndex, self._maxMapYIndex
end

function DianJiShiGameModel:getAndRemoveLastCommand()
	if self._cmdList then
		if not #self._cmdList then
			local cmdNum = 0

			return self._cmdList and table.remove(self._cmdList, cmdNum)
		end
	end
end

function DianJiShiGameModel:isCanRollback()
	return self._cmdList and #self._cmdList > 0
end

function DianJiShiGameModel:getMapAreaInfoList()
	return self._mapAreaInfoList
end

function DianJiShiGameModel:getPassMapAreaInfoNum()
	local passNum = 0

	if self._mapAreaInfoList then
		for _, areaInfo in ipairs(self._mapAreaInfoList) do
			local areaCo = areaInfo and areaInfo.config

			if areaCo then
				if not areaCo.value then
					local areaValue = 0

					if areaInfo.value == areaValue then
						passNum = passNum + 1
					end
				end
			end
		end
	end

	return passNum
end

function DianJiShiGameModel:getMapAreaInfoNum()
	return self._mapAreaInfoNum or 0
end

function DianJiShiGameModel:getMapAreaInfoByPos(posX, posY)
	if self._mapConfigMap then
		local row = self._mapConfigMap[posX]
		local cellCo = row and row[posY]

		if not cellCo then
			return
		end

		local areaCo = cellCo.areaCo
		local areaId = areaCo and areaCo.id

		return self._mapAreaInfoDict and self._mapAreaInfoDict[areaId]
	end
end

function DianJiShiGameModel:isNotPlacedInMapArea(posX, posY)
	return self:checkIndexInMap(posX, posY) and not self:getMapPlaceCubeInfo(posX, posY)
end

function DianJiShiGameModel:updateGameStatus(newStatus)
	if self._status == newStatus then
		return
	end

	self._status = newStatus

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnUpdateGameStatus)
end

function DianJiShiGameModel:getGameStatus()
	return self._status
end

function DianJiShiGameModel:getCrossFromStart(posXIndex, posYIndex)
	self._crossInfoDict = self._crossInfoDict or {}

	if self._crossInfoDict[posXIndex] then
		local crossInfo = self._crossInfoDict[posXIndex][posYIndex]
		local crossAreaNum_H = crossInfo and crossInfo.crossAreaNum_H
		local crossAreaNum_V = crossInfo and crossInfo.crossAreaNum_V

		if not crossInfo then
			crossAreaNum_H, crossAreaNum_V = self:_calcCrossFromStart(posXIndex, posYIndex)

			local var_33_1 = {}

			var_33_1.crossAreaNum_H = crossAreaNum_H
			var_33_1.crossAreaNum_V = crossAreaNum_V
			crossInfo = var_33_1
			self._crossInfoDict[posXIndex] = self._crossInfoDict[posXIndex] or {}
			self._crossInfoDict[posXIndex][posYIndex] = crossInfo
		end

		return crossAreaNum_H, crossAreaNum_V
	end
end

function DianJiShiGameModel:_calcCrossFromStart(posXIndex, posYIndex)
	local crossAreaNum_H = self:_calcAllCrossFromStartOneDir(posXIndex, posYIndex, true)
	local crossAreaNum_V = self:_calcAllCrossFromStartOneDir(posXIndex, posYIndex, false)

	return crossAreaNum_H, crossAreaNum_V
end

function DianJiShiGameModel:_calcAllCrossFromStartOneDir(posXIndex, posYIndex, isHorizontal)
	local maxCrossNum = 1

	if isHorizontal then
		if not self._minMapXIndex then
			local startXIndex = self._minMapYIndex
			local endXIndex = isHorizontal and posXIndex or posYIndex

			if isHorizontal then
				if not self._minMapYIndex then
					local startYIndex = self._minMapXIndex

					if isHorizontal then
						if not self._maxMapYIndex then
							local endYIndex = self._maxMapXIndex

							for i = startXIndex, endXIndex do
								for j = startYIndex, endYIndex do
									local curXIndex = isHorizontal and i or j
									local curYIndex = isHorizontal and j or i

									if isHorizontal then
										if not (curXIndex - 1) then
											local frontXIndex = curXIndex
											local frontYIndex = isHorizontal and curYIndex or curYIndex - 1
											local frontCell = self:getMapAreaInfoByPos(frontXIndex, frontYIndex)
											local curCell = self:getMapAreaInfoByPos(curXIndex, curYIndex)

											if frontCell and curCell and frontCell ~= curCell then
												maxCrossNum = maxCrossNum + 1

												break
											end
										end
									end
								end
							end

							return maxCrossNum
						end
					end
				end
			end
		end
	end
end

function DianJiShiGameModel:setIsDraging(isDraging)
	self._isDraging = isDraging
end

function DianJiShiGameModel:isDraging()
	return self._isDraging
end

function DianJiShiGameModel:recordCurGuideBlock(blockInfo)
	self._guieBlockInfo = blockInfo
end

function DianJiShiGameModel:getCurGuideBlock()
	return self._guieBlockInfo
end

function DianJiShiGameModel:recordLastUpdateAreaTagPath(tagPath)
	self._lastAreaTagPath = tagPath
end

function DianJiShiGameModel:getLastUpdateAreaTagPath()
	return self._lastAreaTagPath
end

DianJiShiGameModel.instance = DianJiShiGameModel.New()

return DianJiShiGameModel
