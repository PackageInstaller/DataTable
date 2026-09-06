-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NumberPuzzleGameMapCtrl.lua

module("logic.extensions.numberpuzzlegame.view.data.NumberPuzzleGameMapCtrl", package.seeall)

local NumberPuzzleGameMapCtrl = class("NumberPuzzleGameMapCtrl")

function NumberPuzzleGameMapCtrl:ctor(mapId)
	self._mapId = mapId
	self._mapMoOfRun = NumberPuzzleGameMapMo.New()
	self._motionMoPoolCtrl = NPGMotionMoPoolCtrl.New()
	self._mapData = NumberPuzzleGameConfig.instance:getNpgMapData(self._mapId)
	self._gridCfg = NumberPuzzleGameConfig.instance:getNpgGridCfg(self._mapId)
	self._maxGridId = self._gridCfg[#self._gridCfg].gridId
	self._initRandomCount = self._mapData.initRandomCount or {}
	self._eachRandomCount = self._mapData.eachRandomCount or {
		1
	}
	self._maxMotionRecordCount = 50
end

function NumberPuzzleGameMapCtrl:onReset()
	self._motionMoPoolCtrl:onReset()

	self._curRecordId = 0

	self:_resetMapOfRun()
end

function NumberPuzzleGameMapCtrl:onDestroy()
	return
end

function NumberPuzzleGameMapCtrl:_resetMapOfRun()
	local gridMap = {}
	local rowCount, colCount = 0, 0
	local rowArr = string.split(self._mapData.buildStr, "#")

	for y, col in ipairs(rowArr) do
		local colArr = string.split(col, ",")

		colCount = Mathf.Max(colCount, #colArr)

		for x, gridId in ipairs(colArr) do
			gridMap[x] = gridMap[x] or {}
			gridMap[x][y] = checknumber(gridId)
		end
	end

	self._mapMoOfRun:onReset(#rowArr, colCount)

	for x = 1, colCount do
		for y = 1, #rowArr do
			self._mapMoOfRun:setGridId(x, y, gridMap[x][y])
		end
	end

	if #self._initRandomCount >= 1 then
		local randomGrids = self:getRandomGrids(self._initRandomCount[Mathf.Random(1, #self._initRandomCount)])

		for idx, v in ipairs(randomGrids) do
			local gridIndex, gridId = v[1], v[2]
			local x, y = self._mapMoOfRun:getGridCoord(gridIndex)

			self._mapMoOfRun:setGridId(x, y, gridId)
		end
	end
end

function NumberPuzzleGameMapCtrl:mergeMap(toward)
	local startX, endX, deltaX = 0, 0, 0
	local startY, endY, deltaY = 0, 0, 0
	local minX, maxX = 1, self._mapMoOfRun:getColCount()
	local minY, maxY = 1, self._mapMoOfRun:getRowCount()

	if toward == NPGEnum.ToUp then
		endX = maxX
		startX = minX
		endY = minY
		startY = maxY
	elseif toward == NPGEnum.ToDown then
		endX = maxX
		startX = minX
		endY = maxY
		startY = minY
	elseif toward == NPGEnum.ToLeft then
		endX = maxX
		startX = minX
		endY = maxY
		startY = minY
	elseif toward == NPGEnum.ToRight then
		endX = minX
		startX = maxX
		endY = maxY
		startY = minY
	end

	deltaX = startX <= endX and 1 or -1
	deltaY = startY <= endY and 1 or -1

	local formBeforeGridId, formAfterGridId = 0, 0
	local toBeforeGridId, toAfterGridId = 0, 0
	local formX, formY = 0, 0
	local toX, toY = 0, 0
	local formGridIndex, toGridIndex = 0, 0
	local curX, curY = 0, 0
	local nextX, nextY, nextGridIndex = 0, 0, 0
	local isHaveMove = false
	local motionList = {}
	local hitGridIndexList = {}

	for x = startX, endX, deltaX do
		for y = startY, endY, deltaY do
			formY = y
			formX = x
			curY = y
			curX = x
			formBeforeGridId = self:getGridId(x, y)

			if not self:isEmptyGridByCor(x, y) then
				local ii = 0

				while true do
					nextGridIndex = self._mapMoOfRun:getGridIndex(curX + toward.x, curY + toward.y)
					toBeforeGridId = self:getGridId(curX + toward.x, curY + toward.y)

					if self:isEmptyGridByCor(curX + toward.x, curY + toward.y) then
						if self:isOverBoundary(curX + toward.x, curY + toward.y) then
							break
						else
							curY = curY + toward.y
							curX = curX + toward.x
						end
					else
						if self:isCanMerge(formBeforeGridId, toBeforeGridId) and table.indexof(hitGridIndexList, nextGridIndex) == false then
							curY = curY + toward.y
							curX = curX + toward.x
						end

						break
					end

					ii = ii + 1

					if ii >= 1000 then
						printError("超标while，请检查")

						break
					end
				end

				toY = curY
				toX = curX
				formGridIndex = self._mapMoOfRun:getGridIndex(formX, formY)
				toGridIndex = self._mapMoOfRun:getGridIndex(curX, toY)
				toBeforeGridId = self:getGridId(curX, toY)

				local unGridId = NPGEnum.ResultCode_UniversalGridId

				if formGridIndex ~= toGridIndex and (formBeforeGridId ~= unGridId or toBeforeGridId ~= unGridId) then
					toBeforeGridId = self:getGridId(toX, toY)

					local motionType = self:isCanMerge(formBeforeGridId, toBeforeGridId) and NPGEnum.Motion_Merge or NPGEnum.Motion_Move

					if motionType == NPGEnum.Motion_Merge then
						self:setGridId(formX, formY, NPGEnum.ResultCode_EmptyGridId)

						local baseGridId = toBeforeGridId - 1

						if formBeforeGridId ~= unGridId and toBeforeGridId ~= unGridId then
							baseGridId = formBeforeGridId
						elseif formBeforeGridId == unGridId and toBeforeGridId ~= unGridId then
							baseGridId = toBeforeGridId
						elseif formBeforeGridId ~= unGridId and toBeforeGridId == unGridId then
							baseGridId = formBeforeGridId
						else
							printError("错误：万能牌不能和万能牌合并")
						end

						self:setGridId(toX, toY, baseGridId + 1)
						table.insert(hitGridIndexList, toGridIndex)
					elseif motionType == NPGEnum.Motion_Move then
						self:setGridId(formX, formY, NPGEnum.ResultCode_EmptyGridId)
						self:setGridId(toX, toY, formBeforeGridId)
					end

					formAfterGridId = self:getGridId(formX, formY)
					toAfterGridId = self:getGridId(toX, toY)

					local motion = {}

					if motionType == NPGEnum.Motion_Merge then
						motion[1] = motionType
						motion[2] = {
							formGridIndex,
							toGridIndex,
							formBeforeGridId,
							toAfterGridId
						}
					elseif motionType == NPGEnum.Motion_Move then
						motion[1] = motionType
						motion[2] = {
							formGridIndex,
							toGridIndex
						}
					end

					table.insert(motionList, motion)

					isHaveMove = true
				end
			end
		end
	end

	if (isHaveMove or self._mapMoOfRun:getEntityGridCount() <= 0) and #self._eachRandomCount >= 1 then
		local randomGrids = self:getRandomGrids(self._eachRandomCount[Mathf.Random(1, #self._eachRandomCount)])

		for idx, v in ipairs(randomGrids) do
			local gridIndex, gridId = v[1], v[2]
			local x, y = self._mapMoOfRun:getGridCoord(gridIndex)

			self._mapMoOfRun:setGridId(x, y, gridId)

			local motion = {}

			motion[1] = NPGEnum.Motion_Create
			motion[2] = {
				gridIndex,
				gridId
			}

			table.insert(motionList, motion)
		end
	end

	local recordId = 0

	if #motionList > 0 then
		recordId = self:nextRecord()

		for _, motion in ipairs(motionList) do
			self:addMotionRecordParam(recordId, motion[1], GameUtil.unpack10(motion[2] or {}))
		end
	end

	return recordId
end

function NumberPuzzleGameMapCtrl:queueMap(isReverse)
	isReverse = checkbool(isReverse)

	local beforeQueue = {}
	local tempQueue = {}
	local afterQueue = {}
	local gridCount = self._mapMoOfRun:getGridCount()
	local rowCount = self._mapMoOfRun:getRowCount()
	local colCount = self._mapMoOfRun:getColCount()
	local gridId = 0

	for gridIndex = 1, gridCount do
		table.insert(beforeQueue, (self:getGridId(self._mapMoOfRun:getGridCoord(gridIndex))))
	end

	for gridIndex, gridId in ipairs(beforeQueue) do
		if not self:isEmptyGridById(gridId) then
			table.insert(tempQueue, gridId)
		end
	end

	if isReverse then
		table.sort(tempQueue, function(a, b)
			return b < a
		end)
	else
		table.sort(tempQueue, function(a, b)
			return a < b
		end)
	end

	for gridIndex = 1, gridCount do
		if tempQueue[gridIndex] == nil then
			tempQueue[gridIndex] = NPGEnum.ResultCode_EmptyGridId
		end
	end

	local startX, endX, deltaX = 0, 0, 0
	local curIdx = isReverse and gridCount or 1
	local idxDelta = isReverse and -1 or 1

	for y = 1, rowCount do
		if y % 2 == 1 then
			deltaX = 1
			endX = colCount
			startX = 1
		else
			deltaX = -1
			endX = 1
			startX = colCount
		end

		for x = startX, endX, deltaX do
			afterQueue[self._mapMoOfRun:getGridIndex(x, y)] = tempQueue[curIdx]
			curIdx = curIdx + idxDelta
		end
	end

	local isHaveDifferent = false
	local beforeGridId, afterGridId = 0, 0

	for gridIndex = 1, gridCount do
		if beforeQueue[gridIndex] ~= afterQueue[gridIndex] then
			isHaveDifferent = true

			break
		end
	end

	local recordId = 0

	if isHaveDifferent then
		local x, y = 0, 0

		for gridIndex = 1, gridCount do
			local var_6_0, var_6_1 = self._mapMoOfRun:getGridCoord(gridIndex)

			gridId = afterQueue[gridIndex]

			self:setGridId(var_6_0, var_6_1, afterQueue[gridIndex])
		end

		recordId = self:nextRecord()

		self:addMotionRecordParamOfQueue(recordId, beforeQueue, afterQueue, isReverse)
	end

	return recordId
end

function NumberPuzzleGameMapCtrl:universalMap()
	local emptyGridIndexList = {}
	local gridCount = self._mapMoOfRun:getGridCount()

	for gridIndex = 1, gridCount do
		if self:isEmptyGridByCor(self._mapMoOfRun:getGridCoord(gridIndex)) then
			table.insert(emptyGridIndexList, gridIndex)
		end
	end

	local recordId = 0

	if #emptyGridIndexList > 0 then
		local randomIdx = Mathf.Random(1, #emptyGridIndexList)
		local gridIndex = emptyGridIndexList[randomIdx]
		local x, y = self._mapMoOfRun:getGridCoord(gridIndex)
		local universalGridId = NPGEnum.ResultCode_UniversalGridId

		self:setGridId(x, y, universalGridId)

		recordId = self:nextRecord()

		self:addMotionRecordParamOfUniversalCard(recordId, gridIndex, universalGridId)
	end

	return recordId
end

function NumberPuzzleGameMapCtrl:knockMap(step)
	local gridIndexListMap = self:getGridIndexListMap()
	local curStep = 0
	local gridIndexList = {}

	for gridId = 1, self._maxGridId do
		if step <= curStep then
			break
		end

		if gridIndexListMap[gridId] and #gridIndexListMap[gridId] > 0 then
			table.insertto(gridIndexList, gridIndexListMap[gridId])

			curStep = curStep + 1
		end
	end

	local recordId = 0

	if #gridIndexList > 0 then
		local x, y = 0, 0

		for _, gridIndex in ipairs(gridIndexList) do
			local var_10_0, var_10_1 = self._mapMoOfRun:getGridCoord(gridIndex)

			self:setGridId(var_10_0, var_10_1, NPGEnum.ResultCode_EmptyGridId)
		end

		recordId = self:nextRecord()

		self:addMotionRecordParamOfKnock(recordId, gridIndexList)
	end

	return recordId
end

function NumberPuzzleGameMapCtrl:addRadomGrid(count)
	local motionList = {}
	local randomGrids = self:getRandomGrids(count)

	for idx, v in ipairs(randomGrids) do
		local gridIndex, gridId = v[1], v[2]
		local x, y = self._mapMoOfRun:getGridCoord(gridIndex)

		self._mapMoOfRun:setGridId(x, y, gridId)

		local motion = {}

		motion[1] = NPGEnum.Motion_Create
		motion[2] = {
			gridIndex,
			gridId
		}

		table.insert(motionList, motion)
	end

	local recordId = 0

	if #motionList > 0 then
		recordId = self:nextRecord()

		for _, motion in ipairs(motionList) do
			self:addMotionRecordParam(recordId, motion[1], GameUtil.unpack10(motion[2] or {}))
		end
	end

	return recordId
end

function NumberPuzzleGameMapCtrl:isHaveAir()
	local rowCount = self._mapMoOfRun:getRowCount()
	local colCount = self._mapMoOfRun:getColCount()
	local curGridId, tarGridId = 0, 0

	for x = 1, colCount do
		for y = 1, rowCount do
			if self:isEmptyGridByCor(x, y) and not self:isOverBoundary(x, y) then
				return true
			end

			curGridId = self:getGridId(x, y)

			for _, toward in ipairs(NPGEnum.TowardList) do
				if self:isCanMerge(curGridId, (self:getGridId(x + toward.x, y + toward.y))) then
					return true
				end
			end
		end
	end

	return false
end

function NumberPuzzleGameMapCtrl:isHaveEmptyGrid()
	return self._mapMoOfRun:getEmptyGridCount() > 0
end

function NumberPuzzleGameMapCtrl:getDifferentGridIdCount()
	local count = 0
	local gridIndexListMap = self:getGridIndexListMap()

	for gridId = 1, self._maxGridId do
		if gridIndexListMap[gridId] and #gridIndexListMap[gridId] > 0 then
			count = count + 1
		end
	end

	return count
end

function NumberPuzzleGameMapCtrl:getGridIndexListMap()
	local gridIndexListMap = {}
	local gridCount = self._mapMoOfRun:getGridCount()
	local gridId = 0

	for gridIndex = 1, gridCount do
		gridId = self:getGridId(self._mapMoOfRun:getGridCoord(gridIndex))

		if gridId ~= NPGEnum.ResultCode_EmptyGridId then
			gridIndexListMap[gridId] = gridIndexListMap[gridId] or {}

			table.insert(gridIndexListMap[gridId], gridIndex)
		end
	end

	return gridIndexListMap
end

function NumberPuzzleGameMapCtrl:getRandomGrids(count)
	local randomGrids = {}

	if self:isHaveEmptyGrid() then
		local maxGridId = self._mapMoOfRun:getMaxGridId()
		local emptyGridIndexList = {}

		for gridIndex = 1, self._mapMoOfRun:getGridCount() do
			local x, y = self._mapMoOfRun:getGridCoord(gridIndex)

			if self:isEmptyGridByCor(x, y) then
				table.insert(emptyGridIndexList, gridIndex)
			end
		end

		for i = 1, count do
			local randomIdx = Mathf.Random(1, #emptyGridIndexList)
			local gridIndex = emptyGridIndexList[randomIdx]
			local idx = Mathf.Random(6, 7)
			local randomGridId = Mathf.Clamp(maxGridId - idx, 1, self._maxGridId)

			table.insert(randomGrids, {
				gridIndex,
				randomGridId
			})
		end
	end

	return randomGrids
end

function NumberPuzzleGameMapCtrl:isCanMerge(curGridId, tarGridId)
	return not self:isEmptyGridById(curGridId) and not self:isEmptyGridById(tarGridId) and (curGridId == tarGridId or curGridId == NPGEnum.ResultCode_UniversalGridId or tarGridId == NPGEnum.ResultCode_UniversalGridId)
end

function NumberPuzzleGameMapCtrl:isEmptyGridByCor(x, y)
	return self:isEmptyGridById(self:getGridId(x, y))
end

function NumberPuzzleGameMapCtrl:isEmptyGridById(gridId)
	return gridId == NPGEnum.ResultCode_EmptyGridId
end

function NumberPuzzleGameMapCtrl:isOverBoundary(x, y)
	if x < 1 or x > self._mapMoOfRun:getColCount() or y < 1 or y > self._mapMoOfRun:getRowCount() then
		return true
	end

	return false
end

function NumberPuzzleGameMapCtrl:getGridId(x, y)
	return self._mapMoOfRun:getGridId(x, y)
end

function NumberPuzzleGameMapCtrl:setGridId(x, y, gridId)
	self._mapMoOfRun:setGridId(x, y, Mathf.Min(gridId, self._maxGridId))
end

function NumberPuzzleGameMapCtrl:getCurRecordId()
	return self._curRecordId
end

function NumberPuzzleGameMapCtrl:getLastRecordId()
	return (self._curRecordId - 1 - 1) % self._maxMotionRecordCount + 1
end

function NumberPuzzleGameMapCtrl:setCurRecordId(recordId)
	self._curRecordId = recordId
end

function NumberPuzzleGameMapCtrl:getMotionRecord(recordId)
	return self._motionMoPoolCtrl:getMotionRecord(recordId)
end

function NumberPuzzleGameMapCtrl:nextRecord()
	local nextRecordId = (self._curRecordId + 1 - 1) % self._maxMotionRecordCount + 1

	self._motionMoPoolCtrl:clearMotionRecord(nextRecordId)

	self._curRecordId = nextRecordId

	return self._curRecordId
end

function NumberPuzzleGameMapCtrl:getMaxMotionRecordCount(recordId)
	return self._maxMotionRecordCount
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfMove(recordId, formGridIndex, toGridIndex)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_Move, formGridIndex, toGridIndex)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfMerge(recordId, formGridIndex, toGridIndex, formBeforeGridId, toAfterGridId)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_Merge, formGridIndex, toGridIndex, formBeforeGridId, toAfterGridId)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfCreate(recordId, gridIndex, gridId)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_Create, gridIndex, gridId)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfDestroy(recordId, gridIndex, gridId)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_Destroy, gridIndex, gridId)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfQueue(recordId, beforeQueue, afterQueue, isReverse)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_Queue, beforeQueue, afterQueue, isReverse)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfKnock(recordId, gridIndexList)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_Knock, gridIndexList)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParamOfUniversalCard(recordId, gridIndex, gridId)
	self:addMotionRecordParam(recordId, NPGEnum.Motion_UniversalCard, gridIndex, gridId)
end

function NumberPuzzleGameMapCtrl:addMotionRecordParam(recordId, motionType, ...)
	local motionCount = self._motionMoPoolCtrl:getMotionCount(recordId)
	local mo = self._motionMoPoolCtrl:getMotionMo(recordId, motionCount + 1)

	mo:setParam(motionType, {
		...
	})
end

return NumberPuzzleGameMapCtrl
