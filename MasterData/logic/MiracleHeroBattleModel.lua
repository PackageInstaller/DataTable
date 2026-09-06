-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/MiracleHeroBattleModel.lua

module("logic.extensions.miraclehero.model.MiracleHeroBattleModel", package.seeall)

local MiracleHeroBattleModel = class("MiracleHeroBattleModel", BaseModel)

function MiracleHeroBattleModel:ctor()
	self._removeOperate = Array.New()
	self._map_size = Vector2.New(2, 10)

	self:onReset()
end

function MiracleHeroBattleModel:onReset()
	self._battleIndex = 1
	self._typeList = {}

	self._removeOperate:Clear()
end

function MiracleHeroBattleModel:initMapData(actId, challengeId, stageId, typeMap)
	self._typeList = {}

	for i, v in pairs(typeMap) do
		table.insert(self._typeList, i)
	end

	local typeNum = #self._typeList
	local stageCfg = MiracleHeroConfig.instance:getStageCfg(actId, challengeId, stageId)
	local layoutPlanCfg = MiracleHeroConfig.instance:getLayoutPlan(stageCfg.planId)
	local layoutPlanCfgByElementCfg = layoutPlanCfg[typeNum]
	local layoutIds = layoutPlanCfgByElementCfg.layoutId
	local randomIndex = math.random(1, #layoutIds)
	local layoutId = layoutIds[randomIndex]
	local mapCfg = MiracleHeroConfig.instance:getLayout(layoutId)
	local randomList = {}

	for i, v in ipairs(self._typeList) do
		table.insert(randomList, v)
	end

	randomList = GameUtil.permuteArray(randomList)

	local repaceList = {}

	for i = 1, typeNum do
		repaceList[self._typeList[i]] = randomList[i]
	end

	self._mapCells = {}

	for i = 1, self._map_size.x do
		self._mapCells[i] = self._mapCells[i] or {}

		for j = 1, self._map_size.y do
			local mo = MiracleHeroAttrCellMO.New()

			mo.type = repaceList[mapCfg[i].blocksRow[j]]
			mo.x = i
			mo.y = j
			self._mapCells[i][j] = mo
		end
	end

	self._selectMap = {}

	for i = 1, self._map_size.x do
		self._selectMap[i] = self._selectMap[i] or {}

		for j = 1, self._map_size.y do
			self._selectMap[i][j] = false
		end
	end

	self._firstSelectCell = nil
	self._aabbBoxLeftCell = nil
	self._aabbBoxRightCell = nil
end

function MiracleHeroBattleModel:checkTypeList(typeMap)
	self._typeList = {}

	for i, v in pairs(typeMap) do
		table.insert(self._typeList, i)
	end
end

function MiracleHeroBattleModel:getMapData()
	return self._mapCells
end

function MiracleHeroBattleModel:getMapSize()
	return self._map_size
end

function MiracleHeroBattleModel:getSelectMap()
	return self._selectMap
end

function MiracleHeroBattleModel:createBattle()
	self._battleIndex = self._battleIndex + 1
end

function MiracleHeroBattleModel:getBattleIndex()
	return self._battleIndex
end

function MiracleHeroBattleModel:setCellData(x, y, type)
	self._mapCells[x][y].type = type
end

function MiracleHeroBattleModel:addRemoveCell(x, y)
	local operateMo = MiracleHeroAttrCellMO.New()

	operateMo.x = x
	operateMo.y = y

	local has, idx = self._removeOperate:FindByFunc(function(item)
		return item:checkSamePos(operateMo)
	end)

	if not has then
		self._removeOperate:PushBack(operateMo)
	end
end

function MiracleHeroBattleModel:clearOperate()
	self._removeOperate:Clear()
end

function MiracleHeroBattleModel:getOperate()
	return self._removeOperate
end

function MiracleHeroBattleModel:removeCellData()
	self._removeOperate:ForEach(function(operateMo, index)
		self._mapCells[operateMo.x][operateMo.y].type = 0
	end)
end

function MiracleHeroBattleModel:getSupplyCellType()
	return self._typeList[math.random(1, #self._typeList)]
end

function MiracleHeroBattleModel:addAttrCell(x, y)
	local add = false

	if not self._selectMap[x] then
		self._selectMap[x] = self._selectMap[x] or {}
		add = true
	end

	if not self._selectMap[x][y] then
		self._selectMap[x][y] = true
		add = true
	end

	if not add then
		return add
	end

	if not self._firstSelectCell then
		self._firstSelectCell = Vector2(x, y)
		self._aabbBoxLeftCell = Vector2(x, y)
		self._aabbBoxRightCell = Vector2(x, y)
	end

	local minX, minY = self._aabbBoxLeftCell.x, self._aabbBoxLeftCell.y
	local maxX, maxY = self._aabbBoxRightCell.x, self._aabbBoxRightCell.y
	local firstCheckX, firstCheckY = self._firstSelectCell.x, self._firstSelectCell.y
	local targetType = self._mapCells[firstCheckX][firstCheckY].type

	for x = maxX + 1, self._map_size.x do
		if self._selectMap[x][firstCheckY] and self._mapCells[x][firstCheckY].type == targetType then
			local isAllCheck = true

			for y = minY, maxY do
				if not self._selectMap[x][y] or self._mapCells[x][y].type ~= targetType then
					isAllCheck = false

					break
				end
			end

			if isAllCheck == true then
				maxX = x
			else
				break
			end
		else
			break
		end
	end

	for x = minX - 1, 1, -1 do
		if self._selectMap[x][firstCheckY] and self._mapCells[x][firstCheckY].type == targetType then
			local isAllCheck = true

			for y = minY, maxY do
				if not self._selectMap[x][y] or self._mapCells[x][y].type ~= targetType then
					isAllCheck = false

					break
				end
			end

			if isAllCheck == true then
				minX = x
			else
				break
			end
		else
			break
		end
	end

	for y = maxY + 1, self._map_size.y do
		local isAllCheck = true

		for x = minX, maxX do
			if not self._selectMap[x][y] or self._mapCells[x][y].type ~= targetType then
				isAllCheck = false

				break
			end
		end

		if isAllCheck == true then
			maxY = y
		else
			break
		end
	end

	for y = minY - 1, 1, -1 do
		local isAllCheck = true

		for x = minX, maxX do
			if not self._selectMap[x][y] or self._mapCells[x][y].type ~= targetType then
				isAllCheck = false

				break
			end
		end

		if isAllCheck == true then
			minY = y
		else
			break
		end
	end

	self._aabbBoxLeftCell.x = minX
	self._aabbBoxLeftCell.y = minY
	self._aabbBoxRightCell.x = maxX
	self._aabbBoxRightCell.y = maxY

	return add
end

function MiracleHeroBattleModel:getActiveCell()
	if not self._firstSelectCell then
		return nil
	end

	local activeList = {}

	for i = self._aabbBoxLeftCell.x, self._aabbBoxRightCell.x do
		for j = self._aabbBoxLeftCell.y, self._aabbBoxRightCell.y do
			activeList[i] = activeList[i] or {}
			activeList[i][j] = true
		end
	end

	return activeList
end

function MiracleHeroBattleModel:_removeAllAttrCell()
	self._firstSelectCell = nil
	self._aabbBoxLeftCell = nil
	self._aabbBoxRightCell = nil
	self._selectMap = self._selectMap or {}

	for i = 1, self._map_size.x do
		self._selectMap[i] = self._selectMap[i] or {}

		for j = 1, self._map_size.y do
			self._selectMap[i][j] = false
		end
	end
end

function MiracleHeroBattleModel:autoSelectCell()
	self._aabbBoxLeftCell = Vector2(1, 1)
	self._aabbBoxRightCell = Vector2(1, 1)

	local maxNum = 1
	local right = {}
	local down = {}

	for i = 1, self._map_size.x do
		right[i] = {}
		down[i] = {}

		for j = 1, self._map_size.y do
			right[i][j] = 0
			down[i][j] = 0
		end
	end

	for i = self._map_size.x, 1, -1 do
		for j = self._map_size.y, 1, -1 do
			if i == self._map_size.x then
				right[i][j] = 1
			elseif self._mapCells[i][j].type == self._mapCells[i + 1][j].type then
				right[i][j] = right[i + 1][j] + 1 or 1
			end

			if j == self._map_size.y then
				down[i][j] = 1
			elseif self._mapCells[i][j].type == self._mapCells[i][j + 1].type then
				down[i][j] = down[i][j + 1] + 1 or 1
			end
		end
	end

	for i = 1, self._map_size.x do
		for j = 1, self._map_size.y do
			for width = 1, right[i][j] do
				local height = down[i][j]

				for k = 0, width - 1 do
					height = math.min(height, down[i + k][j])
				end

				local area = width * height

				if maxNum < area then
					maxNum = area
					self._aabbBoxLeftCell.x = i
					self._aabbBoxLeftCell.y = j
					self._aabbBoxRightCell.x = i + width - 1
					self._aabbBoxRightCell.y = j + height - 1
				end
			end
		end
	end

	self._firstSelectCell = self._aabbBoxLeftCell
end

function MiracleHeroBattleModel:setReadyBattleStartInfo(msg)
	self._actionId = msg.actionId
	self._petInfo = msg.formation
end

function MiracleHeroBattleModel:getPetInfo()
	return self._petInfo
end

function MiracleHeroBattleModel:getActionId()
	return self._actionId
end

function MiracleHeroBattleModel:addActionId()
	self._actionId = self._actionId + 1
end

function MiracleHeroBattleModel:setRandomClientKey()
	self._clientKey = math.random(1, 1000000)

	return self._clientKey
end

function MiracleHeroBattleModel:getClientKey()
	return self._clientKey
end

function MiracleHeroBattleModel:getServerKey()
	return self._serverKey
end

function MiracleHeroBattleModel:handleBattleStart(msg)
	self._actionId = msg.actionId
	self._serverKey = msg.serverKey
end

MiracleHeroBattleModel.instance = MiracleHeroBattleModel.New()

return MiracleHeroBattleModel
