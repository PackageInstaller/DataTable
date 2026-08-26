-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LocalEliminateChessModel.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LocalEliminateChessModel", package.seeall)

local LocalEliminateChessModel = class("LocalEliminateChessModel")
local Direction = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
		y = 0
	}
}
local Direction2 = {
	{
		x = 0,
		y = 1
	},
	{
		x = 0,
		y = -1
	}
}

function LocalEliminateChessModel:ctor()
	self._changePoints = {}
	self._tempEliminateCheckResults = {}
	self._weights = {
		1,
		1,
		1,
		1
	}
end

function LocalEliminateChessModel:initByData(data)
	math.randomseed(os.time())

	if self.cells == nil then
		self.cells = {}
	end

	self._row = #data

	for i = 1, #data do
		if self.cells[i] == nil then
			self.cells[i] = {}
		end

		local row = data[i]

		self._col = #row

		for j = 1, #row do
			local cell = self.cells[i][j]
			local id = row[j]

			if cell == nil then
				cell = self:createNewCell(i, j, EliminateEnum_2_7.ChessState.Normal, id)
			else
				self:initCell(cell, i, j, EliminateEnum_2_7.ChessState.Normal, id)
			end

			cell:setStartXY(i, self._col + 1)
			cell:setXY(i, j)
		end
	end

	self._initData = data
end

function LocalEliminateChessModel:getInitData()
	return self._initData
end

function LocalEliminateChessModel:getAllCell()
	return self.cells
end

function LocalEliminateChessModel:getCell(x, y)
	if self.cells == nil or self.cells[x] == nil then
		return nil
	end

	return self.cells[x][y]
end

function LocalEliminateChessModel:getCellRowAndCol()
	return self._row, self._col
end

function LocalEliminateChessModel:setEliminateDieEffect(dieEffect)
	self._dieEffect = dieEffect
end

function LocalEliminateChessModel:getEliminateDieEffect()
	return self._dieEffect
end

function LocalEliminateChessModel:randomCell()
	if isDebugBuild then
		self:printInfo("打乱棋盘前:")
	end

	local changeData = {}
	local tempData = {}

	for i = 1, self._col do
		for j = 1, self._row do
			if self:_canEx(i, j) then
				table.insert(tempData, i)
				table.insert(tempData, j)
			end
		end
	end

	local allIndex = math.floor(#tempData / 2)
	local usedIndex = {}
	local changeIndex1, changeIndex2

	while allIndex > #usedIndex do
		local index = math.random(1, allIndex)
		local isUsed = false

		for i = 1, #usedIndex do
			if usedIndex[i] == index then
				isUsed = true

				break
			end
		end

		if not isUsed then
			table.insert(usedIndex, index)

			if changeIndex1 == nil then
				changeIndex1 = index
			elseif changeIndex2 == nil then
				changeIndex2 = index
			end

			if changeIndex2 ~= nil and changeIndex1 ~= nil then
				local x = tempData[changeIndex1 * 2 - 1]
				local y = tempData[changeIndex1 * 2]
				local changeX = tempData[changeIndex2 * 2 - 1]
				local changeY = tempData[changeIndex2 * 2]

				table.insert(changeData, x)
				table.insert(changeData, y)
				table.insert(changeData, changeX)
				table.insert(changeData, changeY)
				self:addChangePoints(x, y)
				self:addChangePoints(changeX, changeY)
				self:_exchangeCell(x, y, changeX, changeY)

				changeIndex1 = nil
				changeIndex2 = nil
			end
		end
	end

	if isDebugBuild then
		self:printInfo("打乱棋盘后:")
	end

	return changeData
end

function LocalEliminateChessModel:_canEx(x, y)
	local cell = self.cells[x][y]

	if cell == nil then
		return false
	end

	return cell.id ~= -1 and not cell:haveStatus(EliminateEnum_2_7.ChessState.Frost) and cell.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone
end

function LocalEliminateChessModel:resetCreateWeight()
	self._weights = {
		1,
		1,
		1,
		1
	}
end

function LocalEliminateChessModel:changeCreateWeight(chessType, value)
	local index

	for i = 1, #EliminateEnum_2_7.AllChessType do
		local value = EliminateEnum_2_7.AllChessType[i]

		if value == chessType then
			index = i
		end
	end

	if index ~= nil then
		self._weights[index] = self._weights[index] * value
	end
end

function LocalEliminateChessModel:changeCellState(x, y, status)
	if self.cells == nil or self.cells[x] == nil or self.cells[x][y] == nil then
		return
	end

	local cell = self.cells[x][y]

	cell:addStatus(status)

	if isDebugBuild then
		self:printInfo("改变状态: ")
	end
end

function LocalEliminateChessModel:changeCellId(x, y, newEliminateId)
	if self.cells == nil or self.cells[x][y] == nil then
		return nil
	end

	local cell = self.cells[x][y]

	cell:setChessId(newEliminateId)
	cell:setStatus(EliminateEnum_2_7.ChessState.Normal)

	if isDebugBuild then
		self:printInfo("改变棋子类型：")
	end

	return cell
end

function LocalEliminateChessModel:exchangeCell(pos1X, pos1Y, pos2X, pos2Y, isExchangeCell)
	if isDebugBuild then
		self:printInfo("交换前: ")
	end

	if isExchangeCell then
		self:_exchangeCell(pos1X, pos1Y, pos2X, pos2Y)
	end

	self:addChangePoints(pos1X, pos1Y)
	self:addChangePoints(pos2X, pos2Y)

	if isDebugBuild then
		self:printInfo("交换后")
	end

	if not self:check(false, true) then
		if isExchangeCell then
			self:_exchangeCell(pos2X, pos2Y, pos1X, pos1Y)
		end

		if isDebugBuild then
			self:printInfo("还原")
		end

		return false
	end

	return true
end

function LocalEliminateChessModel:eliminateCross(x, y)
	local eliminateSet = {}
	local needAdd = true

	local function addCheck(x1, y1)
		needAdd = true

		local count = #eliminateSet / 2

		for i = 1, count do
			local tempX = eliminateSet[i * 2 - 1]
			local tempY = eliminateSet[i * 2]

			if tempX == x1 and tempY == y1 then
				needAdd = false

				break
			end
		end

		if needAdd then
			table.insert(eliminateSet, x1)
			table.insert(eliminateSet, y1)
		end
	end

	for i = 1, self._row do
		local cell = self.cells[i][y]

		if cell.id ~= EliminateEnum_2_7.InvalidId and cell:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
			addCheck(i, y)
		end
	end

	for i = 1, self._col do
		local cell = self.cells[x][i]

		if cell.id ~= EliminateEnum_2_7.InvalidId and cell:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
			addCheck(x, i)
		end
	end

	local count = #eliminateSet / 2

	for i = 1, count do
		local endX = eliminateSet[i * 2 - 1]
		local endY = eliminateSet[i * 2]
		local eliminatePoints = {}

		table.insert(eliminatePoints, {
			x = endX,
			y = endY
		})

		local result = {
			eliminatePoints = eliminatePoints,
			eliminateType = EliminateEnum_2_7.eliminateType.base,
			eliminateX = x,
			eliminateY = y,
			skillEffect = LengZhou6Enum.SkillEffect.EliminationCross
		}

		table.insert(self._tempEliminateCheckResults, result)
	end

	self:setEliminateDieEffect(LengZhou6Enum.SkillEffect.EliminationCross)
end

function LocalEliminateChessModel:eliminateRange(x, y, range)
	range = (range - 1) / 2

	for i = -range, range do
		for j = -range, range do
			local newX = x + i
			local newY = y + j

			if newX > 0 and newX <= self._row and newY > 0 and newY <= self._col then
				local cell = self.cells[newX][newY]

				if cell.id ~= EliminateEnum_2_7.InvalidId then
					local eliminatePoints = {}

					table.insert(eliminatePoints, {
						x = newX,
						y = newY
					})

					local result = {
						eliminatePoints = eliminatePoints,
						eliminateType = EliminateEnum_2_7.eliminateType.base,
						eliminateX = x,
						eliminateY = y,
						skillEffect = LengZhou6Enum.SkillEffect.EliminationRange
					}

					table.insert(self._tempEliminateCheckResults, result)
				end
			end
		end
	end

	self:setEliminateDieEffect(LengZhou6Enum.SkillEffect.EliminationRange)
end

function LocalEliminateChessModel:checkEliminate()
	if self._eliminateCount == nil then
		self:setEliminateCount(1)
	else
		self:setEliminateCount(self._eliminateCount + 1)
	end

	self:AddEliminateRecord()
	self:eliminate()

	if isDebugBuild then
		self:printInfo("消除处理后")
	end

	self:tidyUp()

	if isDebugBuild then
		self:printInfo("整理处理后")
	end

	self:fill()

	if isDebugBuild then
		self:printInfo("填充处理后")
		self:printInfo("消除次数：" .. self._eliminateCount .. "次")
	end
end

function LocalEliminateChessModel:eliminate()
	if #self._tempEliminateCheckResults <= 0 then
		return
	end

	local recordData = self:getCurEliminateRecordData()
	local recordShowData = self:getEliminateRecordShowData()

	for i = 1, #self._tempEliminateCheckResults do
		local result = self._tempEliminateCheckResults[i]
		local newCellStatus = result.newCellStatus
		local eliminateX = result.eliminateX
		local eliminateY = result.eliminateY
		local eliminatePoints = result.eliminatePoints
		local eliminateType = result.eliminateType
		local skillEffect = result.skillEffect
		local spIsCreate = false
		local eliminateCell = self.cells[eliminateX][eliminateY]
		local haveSpState = eliminateCell:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill)

		if eliminatePoints ~= nil then
			local eliminateId
			local normalCellCount = 0
			local specialCellCount = 0

			for j = 1, #result.eliminatePoints do
				local x = result.eliminatePoints[j].x
				local y = result.eliminatePoints[j].y
				local cell = self.cells[x][y]

				eliminateId = cell:getEliminateID()

				if cell:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill) then
					specialCellCount = specialCellCount + 1
				end

				normalCellCount = normalCellCount + 1

				if not cell:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
					local needDie = true
					local needSpCreate = false

					if newCellStatus ~= nil and newCellStatus == EliminateEnum_2_7.ChessState.SpecialSkill and (not haveSpState or eliminateX ~= x or y ~= eliminateY) and not spIsCreate then
						needSpCreate = true
						needDie = false
					end

					if needSpCreate and not spIsCreate then
						cell:addStatus(EliminateEnum_2_7.ChessState.SpecialSkill)
						recordShowData:addChangeType(x, y, EliminateEnum_2_7.ChessState.Normal)
						self:addChangePoints(x, y)

						spIsCreate = true
					end

					if needDie then
						cell:setStatus(EliminateEnum_2_7.ChessState.Die)
						cell:setChessId(EliminateEnum_2_7.InvalidId)
						recordShowData:addEliminate(x, y, skillEffect)
					end
				else
					cell:setStatus(EliminateEnum_2_7.ChessState.Normal)
					recordShowData:addChangeType(x, y, EliminateEnum_2_7.ChessState.Frost)
				end
			end

			if eliminateId ~= nil then
				recordData:setEliminateType(eliminateId, eliminateType, normalCellCount, specialCellCount)
			end
		end
	end

	tabletool.clear(self._tempEliminateCheckResults)
end

function LocalEliminateChessModel:tidyUp()
	local recordShowData = self:getEliminateRecordShowData()

	for i = 1, self._row do
		for j = 1, self._col do
			local cell = self.cells[i][j]

			if cell:haveStatus(EliminateEnum_2_7.ChessState.Die) then
				local nextIndex = self:findNextStartIndex(j + 1, i, self._row)

				if nextIndex ~= -1 then
					self:_exchangeCell(i, j, i, nextIndex)
					self:addChangePoints(i, j)
					self:addChangePoints(i, nextIndex)
					recordShowData:addMove(i, nextIndex, i, j)
				end
			end
		end
	end
end

function LocalEliminateChessModel:findNextStartIndex(start, i, row)
	for k = start, row do
		local cell = self.cells[i][k]
		local status = cell and cell:getStatus()

		if status and cell:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
			break
		end

		if status and not cell:haveStatus(EliminateEnum_2_7.ChessState.Frost) and not cell:haveStatus(EliminateEnum_2_7.ChessState.Die) then
			return k
		end
	end

	return -1
end

function LocalEliminateChessModel:fill()
	local recordShowData = self:getEliminateRecordShowData()

	for i = 1, self._row do
		for j = 1, self._col do
			local cell = self.cells[i][j]
			local status = cell and cell:getStatus()

			if cell:haveStatus(EliminateEnum_2_7.ChessState.Die) then
				local specialIndex = self:findNextSpecialIndex(j + 1, i, self._row)

				if specialIndex == -1 then
					local model = self:createNewCell(i, j, EliminateEnum_2_7.ChessState.Normal)

					model:setStartXY(i, self._row + 1)
					self:addChangePoints(i, j)
					recordShowData:addNew(i, j)
				end
			end
		end
	end
end

function LocalEliminateChessModel:findNextSpecialIndex(start, i, row)
	for k = start, row do
		local cell = self.cells[i][k]
		local status = cell and cell:getStatus()

		if status and cell:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
			return k
		end
	end

	return -1
end

function LocalEliminateChessModel:check(clearChangePoint, onlyCheck)
	if self._changePoints ~= nil and #self._changePoints > 0 then
		local tempSet = {}

		for i = 1, #self._changePoints / 2 do
			local x = self._changePoints[i * 2 - 1]
			local y = self._changePoints[i * 2]
			local result = self:checkPoint(x, y)

			if result and #result.eliminatePoints >= 3 then
				tempSet[x .. "_" .. y] = result
			end
		end

		local needDelete = {}

		for key, data in pairs(tempSet) do
			for i = 1, #data.eliminatePoints do
				local x = data.eliminatePoints[i].x
				local y = data.eliminatePoints[i].y

				if x ~= data.eliminateX or y ~= data.eliminateY then
					local tempKey = x .. "_" .. y
					local needSkip = false

					for j = 1, #needDelete do
						local deleteKey = needDelete[j]

						if tempKey == deleteKey or key == deleteKey then
							needSkip = true

							break
						end
					end

					if not needSkip then
						local tempData = tempSet[tempKey]

						if tempData ~= nil and #tempData.eliminatePoints <= #data.eliminatePoints then
							table.insert(needDelete, tempKey)
						end
					end
				end
			end
		end

		for _, v in pairs(needDelete) do
			tempSet[v] = nil
		end

		for _, result in pairs(tempSet) do
			if self:canAddResult(result) then
				table.insert(self._tempEliminateCheckResults, result)
			end
		end
	end

	if clearChangePoint then
		tabletool.clear(self._changePoints)
	end

	if #self._tempEliminateCheckResults > 0 then
		if onlyCheck then
			tabletool.clear(self._tempEliminateCheckResults)
		end

		return true
	end

	return false
end

function LocalEliminateChessModel:canAddResult(result)
	local needAdd = true

	for i = 1, #self._tempEliminateCheckResults do
		local data = self._tempEliminateCheckResults[i]
		local eliminatePoints = data.eliminatePoints
		local resultPoints = result.eliminatePoints

		if #eliminatePoints == #resultPoints then
			local isSame = true

			for j = 1, #eliminatePoints do
				local eliminatePoint = eliminatePoints[j]
				local resultPoint = resultPoints[j]

				if eliminatePoint.x ~= resultPoint.x or eliminatePoint.y ~= resultPoint.y then
					isSame = false

					break
				end
			end

			if isSame then
				needAdd = false

				break
			end
		end
	end

	return needAdd
end

function LocalEliminateChessModel:createNewCell(posX, posY, status, id)
	local model = EliminateChessCellMO.New()

	self:initCell(model, posX, posY, status, id)

	return model
end

function LocalEliminateChessModel:initCell(model, posX, posY, status, id)
	if id == nil then
		model:setChessId(self:getRandomId())
	else
		model:setChessId(id)
	end

	model:setXY(posX, posY)
	model:setStatus(status and status or EliminateEnum_2_7.ChessState.Normal)

	self.cells[posX][posY] = model
end

function LocalEliminateChessModel:getRandomId()
	local fixId = LocalEliminateChessUtils.getFixDropId()

	if fixId ~= nil then
		return fixId
	end

	self._weights = self._weights or {
		1,
		1,
		1,
		1
	}

	local index = EliminateModelUtils.getRandomNumberByWeight(self._weights)

	return EliminateEnum_2_7.AllChessID[index]
end

function LocalEliminateChessModel:_exchangeCell(pos1X, pos1Y, pos2X, pos2Y)
	if self.cells == nil or self.cells[pos1X] == nil or self.cells[pos2X] == nil then
		return
	end

	local tmpModel = self.cells[pos1X][pos1Y]

	self.cells[pos1X][pos1Y] = self.cells[pos2X][pos2Y]

	self.cells[pos1X][pos1Y]:setXY(pos1X, pos1Y)
	self.cells[pos1X][pos1Y]:setStartXY(pos2X, pos2Y)

	self.cells[pos2X][pos2Y] = tmpModel

	self.cells[pos2X][pos2Y]:setXY(pos2X, pos2Y)
	self.cells[pos2X][pos2Y]:setStartXY(pos1X, pos1Y)
end

function LocalEliminateChessModel:checkPoint(x, y)
	local rowResult = self:checkWithDirection(x, y, Direction, self._row, self._col)
	local colResult = self:checkWithDirection(x, y, Direction2, self._row, self._col)
	local eliminatePoints = {}
	local newCellStatus
	local eliminateType = EliminateEnum_2_7.eliminateType.three

	if #rowResult >= 5 or #colResult >= 5 then
		newCellStatus = EliminateEnum_2_7.ChessState.SpecialSkill
		eliminateType = EliminateEnum_2_7.eliminateType.five
	elseif #rowResult >= 3 and #colResult >= 3 then
		newCellStatus = EliminateEnum_2_7.ChessState.SpecialSkill
		eliminateType = EliminateEnum_2_7.eliminateType.cross
	elseif #rowResult >= 4 then
		newCellStatus = EliminateEnum_2_7.ChessState.SpecialSkill
		eliminateType = EliminateEnum_2_7.eliminateType.four
	elseif #colResult >= 4 then
		newCellStatus = EliminateEnum_2_7.ChessState.SpecialSkill
		eliminateType = EliminateEnum_2_7.eliminateType.four
	end

	if #rowResult >= 3 then
		eliminatePoints = rowResult
	end

	if #colResult >= 3 then
		eliminatePoints = EliminateModelUtils.mergePointArray(eliminatePoints, colResult)
	end

	return {
		eliminatePoints = eliminatePoints,
		newCellStatus = newCellStatus,
		oldCellStatus = self.cells[x][y]:getStatus(),
		eliminateX = x,
		eliminateY = y,
		eliminateType = eliminateType,
		skillEffect = LengZhou6Enum.NormalEliminateEffect
	}
end

function LocalEliminateChessModel:checkWithDirection(x, y, direction, numRows, numCols)
	local queue = {}
	local vis = {}

	vis[x + y * numCols] = true

	table.insert(queue, {
		x = x,
		y = y
	})

	local front = 1

	while front <= #queue do
		local point = queue[front]

		x = point.x
		y = point.y

		local cellModel = self.cells[point.x][point.y]

		front = front + 1

		if not cellModel then
			-- block empty
		else
			for i = 1, #direction do
				local tmpX = x + direction[i].x
				local tmpY = y + direction[i].y

				if tmpX < 1 or numRows < tmpX or tmpY < 1 or numCols < tmpY or vis[tmpX + tmpY * numCols] or self.cells[tmpX] == nil or self.cells[tmpX][tmpY] == nil then
					-- block empty
				elseif cellModel.id == self.cells[tmpX][tmpY].id and cellModel.id ~= EliminateEnum_2_7.InvalidId and cellModel.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
					vis[tmpX + tmpY * numCols] = true

					table.insert(queue, {
						x = tmpX,
						y = tmpY
					})
				end
			end
		end
	end

	return queue
end

function LocalEliminateChessModel:getAllEliminateIdPos(eliminateId)
	local result = {}

	for i = 1, self._row do
		for j = 1, self._col do
			local cell = self:getCell(i, j)

			if cell.id == eliminateId then
				table.insert(result, {
					x = i,
					y = j
				})
			end
		end
	end

	return result
end

function LocalEliminateChessModel:canEliminate()
	if self.cells == nil then
		return nil
	end

	return LocalEliminateChessUtils.instance.canEliminate(self.cells, self._row, self._col)
end

function LocalEliminateChessModel:createInitMoveState()
	local data = LocalEliminateChessUtils.instance.generateUnsolvableBoard(EliminateEnum_2_7.MaxRow, EliminateEnum_2_7.MaxCol)

	self:initByData(data)
end

function LocalEliminateChessModel:addChangePoints(x, y)
	if self._changePoints == nil then
		self._changePoints = {}
	end

	table.insert(self._changePoints, x)
	table.insert(self._changePoints, y)
end

function LocalEliminateChessModel:printInfo(title)
	if isDebugBuild then
		local info = "\n"

		for j = self._row, 1, -1 do
			local printStr = ""

			for i = 1, self._col do
				local cell = self.cells[i][j]
				local status = cell:getStatus()
				local value = 0

				for k = 1, #status do
					value = value + status[k]
				end

				printStr = printStr .. cell.id .. "[" .. value .. "]" .. " "
			end

			info = info .. printStr .. "\n"
		end

		logNormal((title and title or "") .. info)
	end
end

function LocalEliminateChessModel:recordSpEffect(x, y, effect)
	if self._chessEffect == nil then
		self._chessEffect = {}
	end

	self._chessEffect[x .. "_" .. y] = effect

	self:addSpEffectCd(x, y, effect)
end

function LocalEliminateChessModel:getSpEffect(x, y)
	if self._chessEffect == nil then
		return nil
	end

	return self._chessEffect[x .. "_" .. y]
end

function LocalEliminateChessModel:clearAllEffect()
	if self._chessEffect ~= nil then
		tabletool.clear(self._chessEffect)
	end

	if self._needChessCdEffect ~= nil then
		tabletool.clear(self._needChessCdEffect)
	end
end

function LocalEliminateChessModel:addSpEffectCd(x, y, effect)
	if self._needChessCdEffect == nil then
		self._needChessCdEffect = {}
	end

	if effect and effect == EliminateEnum_2_7.ChessEffect.pollution then
		local value = LengZhou6Config.instance:getEliminateBattleCost(32)

		table.insert(self._needChessCdEffect, {
			x = x,
			y = y,
			cd = value,
			effect = effect
		})
	end
end

function LocalEliminateChessModel:updateSpEffectCd()
	if self._needChessCdEffect == nil then
		return
	end

	local needRemove = {}

	for i = 1, #self._needChessCdEffect do
		local data = self._needChessCdEffect[i]

		if data.cd <= 0 then
			local x = data.x
			local y = data.y
			local effect = data.effect

			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.HideEffect, x, y, effect)

			needRemove[i] = true
		else
			data.cd = data.cd - 1
			self._needChessCdEffect[i] = data
		end
	end

	for i = #self._needChessCdEffect, 1, -1 do
		if needRemove[i] then
			table.remove(self._needChessCdEffect, i)
		end
	end
end

function LocalEliminateChessModel:setEliminateCount(count)
	self._eliminateCount = count
end

function LocalEliminateChessModel:roundDataClear()
	self:setEliminateCount(nil)

	if self._allEliminateRecordData ~= nil then
		tabletool.clear(self._allEliminateRecordData)
	end
end

function LocalEliminateChessModel:AddEliminateRecord()
	if self._allEliminateRecordData == nil then
		self._allEliminateRecordData = {}
	end

	local data = EliminateRecordDataMO.New()

	table.insert(self._allEliminateRecordData, data)
end

function LocalEliminateChessModel:getCurEliminateRecordData()
	if self._allEliminateRecordData == nil then
		self:AddEliminateRecord()
	end

	return self._allEliminateRecordData[#self._allEliminateRecordData]
end

function LocalEliminateChessModel:getAllEliminateRecordData()
	return self._allEliminateRecordData
end

function LocalEliminateChessModel:getEliminateRecordShowData()
	if self._eliminateRecordShowMo == nil then
		self._eliminateRecordShowMo = EliminateRecordShowMO.New()
	end

	return self._eliminateRecordShowMo
end

function LocalEliminateChessModel:clear()
	self._eliminateRecordShowMo = nil
	self._allEliminateRecordData = nil
	self.cells = nil
	self._weights = nil
	self._needChessCdEffect = nil
	self._chessEffect = nil
end

function LocalEliminateChessModel:testRound()
	local allName = {}

	for i = 1, 10000 do
		local id = self:getRandomId()
		local name = EliminateEnum_2_7.ChessIndexToType[id]

		table.insert(allName, name)
	end

	local count = {}

	for i = 1, #allName do
		local name = allName[i]

		count[name] = count[name] == nil and 1 or count[name] + 1
	end

	local str = ""

	for k, v in pairs(count) do
		str = str .. k .. " : " .. v / 10000 * 100 .. "%\n"
	end

	logNormal(str)
end

LocalEliminateChessModel.instance = LocalEliminateChessModel.New()

return LocalEliminateChessModel
