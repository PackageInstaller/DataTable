-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/room/ArcadeNormalRoom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.room.ArcadeNormalRoom", package.seeall)

local ArcadeNormalRoom = class("ArcadeNormalRoom", ArcadeBaseRoom)

function ArcadeNormalRoom:onCtor()
	return
end

function ArcadeNormalRoom:onEnter()
	return
end

function ArcadeNormalRoom:onInitEntities()
	self._curWaveIndex = 0
	self._monsterGroupList = self:_getInitMonsterGroups()
	self._extraMonsterWaveDict = self:_getExtraMonsterWaveDict(#self._monsterGroupList)
	self._waveIntervalList = ArcadeConfig.instance:getWaveInterval(self.id)
	self._spMonsterWaveDict = ArcadeConfig.instance:getSpMonsterWaveDict(self.id)

	local allInitEntityDataList = {}

	self:_fillInitMonsterData(allInitEntityDataList)
	self:_fillNextWaveMonsterGroupData(allInitEntityDataList)
	ArcadeGameController.instance:tryAddEntityList(allInitEntityDataList, true, true, self._initEntitiesFinished, self)
end

function ArcadeNormalRoom:_fillInitMonsterData(refDataList)
	local monsterGroupList = ArcadeConfig.instance:getRoomInitMonsterGroupList(self.id)

	if not monsterGroupList or #monsterGroupList <= 0 then
		return
	end

	local randomIndex = math.random(#monsterGroupList)
	local groupId = monsterGroupList[randomIndex]

	for row = 1, ArcadeGameEnum.Const.RoomSize do
		local rowCfg = ArcadeConfig.instance:getMonsterGroupRowCfg(groupId, row)

		if rowCfg then
			for col = 1, ArcadeGameEnum.Const.RoomSize do
				local monsterId = rowCfg[string.format("%s%s", ArcadeGameEnum.Const.MonsterGroupColName, col)]

				if monsterId and monsterId ~= 0 then
					local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(monsterId)

					refDataList[#refDataList + 1] = {
						entityType = ArcadeGameEnum.EntityType.Monster,
						id = monsterId,
						x = col,
						y = row,
						sizeX = sizeX,
						sizeY = sizeY
					}
				end
			end
		end
	end
end

function ArcadeNormalRoom:loadNextWaveMonster()
	if self._monsterGroupList then
		if not #self._monsterGroupList then
			local groupCount = 0

			if not self._curWaveIndex or groupCount <= self._curWaveIndex then
				return
			end

			local addEntityDataList = {}

			self:_fillNextWaveMonsterGroupData(addEntityDataList)
			ArcadeGameController.instance:tryAddEntityList(addEntityDataList, true, true)
		end
	end
end

function ArcadeNormalRoom:_fillAllMonsterGroupData(refDataList)
	local maxOccupyRow = ArcadeGameEnum.Const.RoomSize
	local initMonsterGroups = self:_getInitMonsterGroups()
	local initMonsterGroupCount = #initMonsterGroups

	if initMonsterGroupCount > 0 then
		local waveInterval = ArcadeConfig.instance:getWaveInterval(self.id)
		local extraMonsterWaveDict = self:_getExtraMonsterWaveDict(initMonsterGroupCount)
		local spMonsterWaveDict = ArcadeConfig.instance:getSpMonsterWaveDict(self.id)

		for i, groupId in ipairs(initMonsterGroups) do
			local occupyGridDict = {}
			local beginRow = maxOccupyRow + (waveInterval[i] or 0)

			maxOccupyRow = self:_addInitMonsterGroups(refDataList, groupId, beginRow, occupyGridDict)

			local extraMonsterCount = extraMonsterWaveDict[i]

			maxOccupyRow = self:_addExtraMonsterData(refDataList, groupId, occupyGridDict, extraMonsterCount, beginRow, maxOccupyRow)

			local spMonsterData = spMonsterWaveDict[i]

			maxOccupyRow = self:_addSpMonsterData(refDataList, spMonsterData, maxOccupyRow)
		end
	else
		local totalExtraMonsterCount = ArcadeGameModel.instance:getExtraMonsterCount()

		maxOccupyRow = self:_addExtraMonsterData(refDataList, nil, nil, totalExtraMonsterCount, maxOccupyRow, maxOccupyRow)
	end

	return maxOccupyRow
end

function ArcadeNormalRoom:_fillNextWaveMonsterGroupData(refDataList)
	if not self._curWaveIndex then
		return
	end

	local maxOccupyRow = ArcadeGameEnum.Const.RoomSize
	local nextWaveIndex = self._curWaveIndex + 1

	if self._monsterGroupList then
		if self._monsterGroupList then
			local occupyGridDict = {}
			local beginRow = maxOccupyRow + (self._waveIntervalList[nextWaveIndex] or 0)

			maxOccupyRow = self:_addInitMonsterGroups(refDataList, self._monsterGroupList, beginRow, occupyGridDict)

			local extraMonsterCount = self._extraMonsterWaveDict[nextWaveIndex]

			maxOccupyRow = self:_addExtraMonsterData(refDataList, self._monsterGroupList, occupyGridDict, extraMonsterCount, beginRow, maxOccupyRow)

			local spMonsterData = self._spMonsterWaveDict[nextWaveIndex]

			maxOccupyRow = self:_addSpMonsterData(refDataList, spMonsterData, maxOccupyRow)
		elseif self._curWaveIndex <= 0 then
			local totalExtraMonsterCount = ArcadeGameModel.instance:getExtraMonsterCount()

			maxOccupyRow = self:_addExtraMonsterData(refDataList, nil, nil, totalExtraMonsterCount, maxOccupyRow, maxOccupyRow)
		end

		if self._monsterGroupList then
			if not #self._monsterGroupList then
				local groupCount = 0

				if groupCount <= nextWaveIndex then
					self:_fillInitPortalData(refDataList, (maxOccupyRow or ArcadeGameEnum.Const.RoomSize) + 1)
				end

				self._curWaveIndex = nextWaveIndex
			end
		end
	end
end

function ArcadeNormalRoom:_getInitMonsterGroups()
	local result = {}
	local dropMethod = ArcadeConfig.instance:getDropMethod(self.id)
	local allMonsterGroups = ArcadeConfig.instance:getMonsterGroups(self.id)
	local monsterWave = ArcadeConfig.instance:getMonsterWaves(self.id)

	if string.nilorempty(dropMethod) or #allMonsterGroups <= 0 or not monsterWave or monsterWave <= 0 then
		return result
	end

	local isRandom = dropMethod == ArcadeGameEnum.RoomDropMethodType.Random

	for i = 1, monsterWave do
		local groupId

		if isRandom then
			local groupCount = #allMonsterGroups

			if groupCount > 0 then
				local pickIndex = math.random(groupCount)

				groupId = allMonsterGroups[pickIndex]

				table.remove(allMonsterGroups, pickIndex)
			end
		else
			groupId = allMonsterGroups[i]
		end

		if not groupId then
			break
		end

		result[i] = groupId
	end

	return result
end

function ArcadeNormalRoom:_getExtraMonsterWaveDict(initMonsterGroupCount)
	local result = {}

	if not initMonsterGroupCount or initMonsterGroupCount <= 0 then
		return result
	end

	local averageCount = 0
	local extraCountDict = {}
	local totalExtraMonsterCount = ArcadeGameModel.instance:getExtraMonsterCount()

	if totalExtraMonsterCount > 0 then
		averageCount = math.floor(totalExtraMonsterCount / initMonsterGroupCount)

		local remainder = totalExtraMonsterCount % initMonsterGroupCount
		local randomGroupIndexList = ArcadeGameHelper.getUniqueRandomNumbers(1, initMonsterGroupCount, remainder)

		for _, groupIndex in ipairs(randomGroupIndexList) do
			extraCountDict[groupIndex] = true
		end
	end

	for i = 1, initMonsterGroupCount do
		result[i] = averageCount + (extraCountDict[i] and 1 or 0)
	end

	return result
end

function ArcadeNormalRoom:_addInitMonsterGroups(refDataList, groupId, beginRow, refOccupyGridDict)
	local roomSize = ArcadeGameEnum.Const.RoomSize
	local newMonsterDataList = {}

	for row = 1, roomSize do
		local rowCfg = ArcadeConfig.instance:getMonsterGroupRowCfg(groupId, row)

		if rowCfg then
			local y = row + beginRow

			for col = 1, roomSize do
				local monsterId = rowCfg[string.format("%s%s", ArcadeGameEnum.Const.MonsterGroupColName, col)]

				if monsterId and monsterId ~= 0 then
					local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(monsterId)

					newMonsterDataList[#newMonsterDataList + 1] = {
						entityType = ArcadeGameEnum.EntityType.Monster,
						id = monsterId,
						x = col,
						y = y,
						sizeX = sizeX,
						sizeY = sizeY,
						extraParam = {
							groupId = groupId
						}
					}
				end
			end
		end
	end

	local occupyRow = beginRow

	for _, monsterData in ipairs(newMonsterDataList) do
		local x = monsterData.x
		local y = monsterData.y
		local sizeX = monsterData.sizeX
		local sizeY = monsterData.sizeY

		for i = x, x + sizeX - 1 do
			for j = y, y + sizeY - 1 do
				local occupyGridId = ArcadeGameHelper.getGridId(i, j)

				refOccupyGridDict[occupyGridId] = true
				occupyRow = math.max(occupyRow, j)
			end
		end

		refDataList[#refDataList + 1] = monsterData
	end

	local newOccupyRowCount = occupyRow - beginRow

	return beginRow + math.max(newOccupyRowCount, roomSize)
end

function ArcadeNormalRoom:_addExtraMonsterData(refDataList, groupId, occupyGridDict, count, beginRow, maxOccupyRow)
	if not count or count <= 0 then
		return maxOccupyRow
	end

	local newMonsterDataList = {}
	local roomSize = ArcadeGameEnum.Const.RoomSize
	local extraMonsterId = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.ExtraMonsterId, true)
	local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(extraMonsterId)

	if sizeX > 1 or sizeY > 1 then
		logError(string.format("ArcadeNormalRoom:_addExtraMonsterData error, extra monster:%s size over", extraMonsterId))

		return maxOccupyRow
	end

	local remainCount = count

	if occupyGridDict and beginRow < maxOccupyRow then
		local spaceGridList = {}

		for row = beginRow + 1, maxOccupyRow do
			for col = 1, roomSize do
				local gridId = ArcadeGameHelper.getGridId(col, row)
				local isOccupied = occupyGridDict[gridId]

				if not isOccupied then
					spaceGridList[#spaceGridList + 1] = {
						x = col,
						y = row
					}
				end
			end
		end

		local randomGridList = ArcadeGameHelper.getUniqueRandomNumbers(1, #spaceGridList, count)

		for _, index in ipairs(randomGridList) do
			local gridData = spaceGridList[index]

			newMonsterDataList[#newMonsterDataList + 1] = {
				entityType = ArcadeGameEnum.EntityType.Monster,
				id = extraMonsterId,
				x = gridData.x,
				y = gridData.y,
				sizeX = sizeX,
				sizeY = sizeY,
				extraParam = {
					groupId = groupId
				}
			}
		end

		remainCount = math.max(0, count - #randomGridList)
	end

	local remainCol = 1
	local remainRow = maxOccupyRow + 1

	for _ = 1, remainCount do
		if roomSize < remainCol then
			remainCol = 1
			remainRow = remainRow + 1
		end

		newMonsterDataList[#newMonsterDataList + 1] = {
			entityType = ArcadeGameEnum.EntityType.Monster,
			id = extraMonsterId,
			x = remainCol,
			y = remainRow,
			sizeX = sizeX,
			sizeY = sizeY,
			extraParam = {
				groupId = groupId
			}
		}
		remainCol = remainCol + 1
	end

	local occupyRow = beginRow

	for _, monsterData in ipairs(newMonsterDataList) do
		local y = monsterData.y

		for j = y, y + sizeY - 1 do
			occupyRow = math.max(occupyRow, j)
		end

		refDataList[#refDataList + 1] = monsterData
	end

	local newOccupyRowCount = occupyRow - beginRow
	local newMaxOccupyRow = beginRow + newOccupyRowCount

	return math.max(newMaxOccupyRow, maxOccupyRow or 0)
end

function ArcadeNormalRoom:_addSpMonsterData(refDataList, spMonsterData, beginRow)
	local maxOccupyRow = beginRow

	if spMonsterData then
		local isHit = ArcadeGameHelper.isProbabilityHit(spMonsterData.probability, ArcadeGameEnum.Const.MaxGenerateMonsterProbability)

		if isHit then
			local roomSize = ArcadeGameEnum.Const.RoomSize
			local spMonsterId = spMonsterData.monsterId
			local count = spMonsterData.count
			local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(spMonsterId)

			if roomSize < count * sizeX then
				logError(string.format("ArcadeNormalRoom:_addSpMonsterData warn, spMonster count:%s sizeX:%s over room x size", count, sizeX))

				count = math.floor(roomSize / count)
			end

			local xList = ArcadeGameHelper.getUniqueRandomNumbers(sizeX, roomSize - sizeX + 1, count)

			for i = 1, count do
				local x = xList[i]

				if x then
					refDataList[#refDataList + 1] = {
						entityType = ArcadeGameEnum.EntityType.Monster,
						id = spMonsterId,
						x = x,
						y = maxOccupyRow + 1,
						sizeX = sizeX,
						sizeY = sizeY
					}
				end
			end

			maxOccupyRow = maxOccupyRow + sizeY
		end
	end

	return maxOccupyRow
end

function ArcadeNormalRoom:_fillInitPortalData(refDataList, row)
	local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()
	local portalCount = #portalIdList
	local portalColList = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.PortalDefaultCol, true, "#")
	local colCount = #portalColList
	local usePortalColList = portalColList

	if colCount < portalCount then
		logError(string.format("ArcadeNormalRoom:_fillInitPortalData error, col not enough, roomId:%s portal:%s col:%s", self.id, portalCount, colCount))
	elseif portalCount < colCount then
		usePortalColList = {}

		local randomIndexList = ArcadeGameHelper.getUniqueRandomNumbers(1, colCount, portalCount)

		for _, index in ipairs(randomIndexList) do
			usePortalColList[#usePortalColList + 1] = portalColList[index]
		end
	end

	for i, portalId in ipairs(portalIdList) do
		local col = usePortalColList[i]

		if col then
			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(portalId)

			refDataList[#refDataList + 1] = {
				entityType = ArcadeGameEnum.EntityType.Portal,
				id = portalId,
				x = col,
				y = row,
				sizeX = sizeX,
				sizeY = sizeY
			}
		end
	end
end

function ArcadeNormalRoom:onExit()
	self:onClear()
end

function ArcadeNormalRoom:onClear()
	self._curWaveIndex = nil
	self._monsterGroupList = nil
	self._extraMonsterWaveDict = nil
	self._waveIntervalList = nil
	self._spMonsterWaveDict = nil
end

return ArcadeNormalRoom
