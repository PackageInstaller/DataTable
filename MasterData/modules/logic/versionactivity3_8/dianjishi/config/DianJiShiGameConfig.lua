-- chunkname: @modules/logic/versionactivity3_8/dianjishi/config/DianJiShiGameConfig.lua

module("modules.logic.versionactivity3_8.dianjishi.config.DianJiShiGameConfig", package.seeall)

local DianJiShiGameConfig = class("DianJiShiGameConfig", BaseConfig)

function DianJiShiGameConfig:reqConfigNames()
	return {
		"activity220_dianjishi_game",
		"activity220_dianjishi_map",
		"activity220_dianjishi_block"
	}
end

function DianJiShiGameConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_dianjishi_map" then
		self:_onLoadMapConfig(configTable)
	elseif configName == "activity220_dianjishi_block" then
		self:_onLoadBlockConfig(configTable)
	end
end

function DianJiShiGameConfig:_onLoadMapConfig(configTable)
	self._allMapAreaDict = {}
	self._allMapAreaCellList = {}

	for _, mapCo in ipairs(configTable.configList) do
		local mapId = mapCo.mapId
		local areaId = mapCo.id

		if self._allMapAreaDict then
			local mapAreaList = self._allMapAreaDict[mapId]

			if not self._allMapAreaDict then
				mapAreaList = {}
				self._allMapAreaDict[mapId] = self._allMapAreaDict
			end

			self._allMapAreaCellList[mapId] = self._allMapAreaCellList[mapId] or {}
			self._allMapAreaCellList[mapId][areaId] = GameUtil.splitString2(mapCo.position, true)

			table.insert(self._allMapAreaDict, mapCo)
		end
	end
end

function DianJiShiGameConfig:_onLoadBlockConfig(configTable)
	self._allBlockDict = {}
	self._allBlockCubeDict = {}
	self._allBlockRightPosDict = {}
	self._allBlockRightPosList = {}

	for _, blockCo in ipairs(configTable.configList) do
		local mapId = blockCo.mapId
		local blockId = blockCo.id

		if self._allBlockCubeDict then
			local mapBlockDict = self._allBlockCubeDict[mapId]

			if self._allBlockRightPosDict then
				local mapBlockRightDict = self._allBlockRightPosDict[mapId]

				if self._allBlockRightPosList then
					local mapBlockRightList = self._allBlockRightPosList[mapId]

					if not self._allBlockCubeDict then
						mapBlockDict = {}
						self._allBlockCubeDict[mapId] = self._allBlockCubeDict
					end

					if not mapBlockRightDict then
						mapBlockRightDict = {}
						mapBlockRightList = {}
						self._allBlockRightPosDict[mapId] = mapBlockRightDict
						self._allBlockRightPosList[mapId] = mapBlockRightList
					end

					local _tempShapeList = GameUtil.splitString2(blockCo.shape, true)
					local shapeList = {}
					local shapeDict = {}
					local minPosX, minPosY, maxPosX, maxPosY = 100, 100, -100, -100

					for _, tempShapeInfo in ipairs(_tempShapeList) do
						table.insert(shapeList, tempShapeInfo)

						local posX = tempShapeInfo[1]
						local posY = tempShapeInfo[2]

						shapeDict[posX] = shapeDict[posX] or {}
						shapeDict[posX][posY] = true
						minPosX = math.min(minPosX, posX)
						minPosY = math.min(minPosY, posY)
						maxPosX = math.max(maxPosX, posX)
						maxPosY = math.max(maxPosY, posY)
					end

					self._allBlockCubeDict[blockId] = {
						list = shapeList,
						dict = shapeDict,
						size = {
							maxPosX - minPosX + 1,
							maxPosY - minPosY + 1
						}
					}

					local blockType = blockCo.type

					if not string.nilorempty(blockCo.rightPos) then
						local rightPos = string.splitToNumber(blockCo.rightPos, "#")

						if rightPos then
							if not rightPos[1] then
								local rightPosX = 0

								if rightPos then
									if not rightPos[2] then
										local rightPosY = 0

										mapBlockRightDict[blockType] = mapBlockRightDict[blockType] or {}
										mapBlockRightDict[blockType][rightPosX] = mapBlockRightDict[blockType][rightPosX] or {}
										mapBlockRightDict[blockType][rightPosX][rightPosY] = true
										mapBlockRightList[blockType] = mapBlockRightList[blockType] or {}

										table.insert(mapBlockRightList[blockType], rightPos)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function DianJiShiGameConfig:getMapBlockList(mapId)
	return lua_activity220_dianjishi_block.configDict[mapId]
end

function DianJiShiGameConfig:getBlockCo(mapId, blockId)
	local mapBlockDict = lua_activity220_dianjishi_block.configDict[mapId]

	return mapBlockDict and mapBlockDict[blockId]
end

function DianJiShiGameConfig:getBlockShapeList(mapId, blockId)
	if self._allBlockCubeDict then
		local mapBlockDict = self._allBlockCubeDict[mapId]
		local config = mapBlockDict and mapBlockDict[blockId]

		return config and config.list
	end
end

function DianJiShiGameConfig:getBlockShapeMap(mapId, blockId)
	if self._allBlockCubeDict then
		local mapBlockDict = self._allBlockCubeDict[mapId]
		local config = mapBlockDict and mapBlockDict[blockId]

		return config and config.dict
	end
end

function DianJiShiGameConfig:getBlockSize(mapId, blockId)
	if self._allBlockCubeDict then
		local mapBlockDict = self._allBlockCubeDict[mapId]
		local config = mapBlockDict and mapBlockDict[blockId]

		return config and config.size
	end
end

function DianJiShiGameConfig:getMapAreaList(mapId)
	return self._allMapAreaDict and self._allMapAreaDict[mapId]
end

function DianJiShiGameConfig:getMapAreaCellList(mapId, areaId)
	if self._allMapAreaCellList then
		return self._allMapAreaCellList and self._allMapAreaCellList[areaId]
	end
end

function DianJiShiGameConfig:getGameConfig(gameId)
	return lua_activity220_dianjishi_game.configDict[gameId]
end

function DianJiShiGameConfig:getAreaSplitLineSize(mapId)
	self._areaSplitLineSizeMap = self._areaSplitLineSizeMap or {}

	if self._areaSplitLineSizeMap then
		local lineSize = self._areaSplitLineSizeMap[mapId]

		if not lineSize then
			local mapCo = self:getGameConfig(mapId)

			lineSize = string.splitToNumber((mapCo or nil) and (mapCo.areaSplitSize or ""), "#")
			self._areaSplitLineSizeMap[mapId] = lineSize
		end

		local width = lineSize and lineSize[1]
		local height = lineSize and lineSize[2]

		return width or 0, height or 0
	end
end

function DianJiShiGameConfig:getBlockRightPosDict(mapId, blockId)
	local blockCo = self:getBlockCo(mapId, blockId)
	local blockType = blockCo and blockCo.type

	if not blockType then
		return
	end

	if self._allBlockRightPosDict then
		local rightPosDict = self._allBlockRightPosDict[mapId]

		return rightPosDict and rightPosDict[blockType]
	end
end

function DianJiShiGameConfig:getBlockRightPosList(mapId, blockId)
	local blockCo = self:getBlockCo(mapId, blockId)
	local blockType = blockCo and blockCo.type

	if not blockType then
		return
	end

	if self._allBlockRightPosList then
		local rightPosList = self._allBlockRightPosList[mapId]

		return rightPosList and rightPosList[blockType]
	end
end

function DianJiShiGameConfig:isBlockInRightPos(mapId, blockId, blockPosX, blockPosY)
	local rightPosDict = self:getBlockRightPosDict(mapId, blockId)
	local var_16_0

	if rightPosDict then
		::label_16_0::

		var_16_0 = rightPosDict[blockPosX] and rightPosDict[blockPosX][blockPosY] == true
	end

	return var_16_0
end

DianJiShiGameConfig.instance = DianJiShiGameConfig.New()

return DianJiShiGameConfig
