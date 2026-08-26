-- chunkname: @modules/logic/dungeon/controller/DungeonPuzzlePipeRule.lua

module("modules.logic.dungeon.controller.DungeonPuzzlePipeRule", package.seeall)

local DungeonPuzzlePipeRule = class("DungeonPuzzlePipeRule")
local LEFT = DungeonPuzzleEnum.dir.left
local RIGHT = DungeonPuzzleEnum.dir.right
local DOWN = DungeonPuzzleEnum.dir.down
local UP = DungeonPuzzleEnum.dir.up

function DungeonPuzzlePipeRule:ctor()
	self._ruleChange = {
		[28] = 46,
		[248] = 468,
		[24] = 48,
		[46] = 28,
		[48] = 68,
		[246] = 248,
		[268] = 246,
		[468] = 268,
		[26] = 24,
		[68] = 26,
		[DungeonPuzzlePipeModel.constEntry] = DungeonPuzzlePipeModel.constEntry
	}
	self._ruleConnect = {}

	for k, v in pairs(self._ruleChange) do
		if k ~= 0 then
			local rule = {}
			local val = k

			while val > 0 do
				local mod = val % 10

				val = (val - mod) / 10
				rule[mod] = true
			end

			self._ruleConnect[k] = rule
		end
	end

	self._ruleConnect[DungeonPuzzlePipeModel.constEntry] = {
		[RIGHT] = true,
		[LEFT] = true,
		[DOWN] = true,
		[UP] = true
	}
end

function DungeonPuzzlePipeRule:setGameSize(w, h)
	self._gameWidth = w
	self._gameHeight = h
end

function DungeonPuzzlePipeRule:isGameClear(resultTable)
	for entryMo, result in pairs(resultTable) do
		if not self:getIsEntryClear(entryMo) then
			return false
		end
	end

	return true
end

function DungeonPuzzlePipeRule:getIsEntryClear(entryMo)
	return entryMo.entryCount >= DungeonPuzzleEnum.pipeEntryClearCount and entryMo:getConnectValue() >= DungeonPuzzleEnum.pipeEntryClearDecimal
end

function DungeonPuzzlePipeRule:getReachTable()
	local entryTable, resultTable = {}, {}
	local openSet = {}
	local entryList = DungeonPuzzlePipeModel.instance:getEntryList()

	for i, entryMo in ipairs(entryList) do
		table.insert(openSet, entryMo)

		local traceTable, resultEntry = self:_getSearchPipeResult(entryMo, openSet)

		resultTable[entryMo] = resultEntry
		entryTable[entryMo] = traceTable
		entryMo.entryCount = #resultEntry
	end

	return entryTable, resultTable
end

function DungeonPuzzlePipeRule:_getSearchPipeResult(entryMo, openSet)
	local resultTable = {}
	local traceSet = {}

	while #openSet > 0 do
		local tmpMo = table.remove(openSet)

		if tmpMo:isEntry() and tmpMo ~= entryMo then
			if not traceSet[tmpMo] then
				table.insert(resultTable, tmpMo)
			end
		else
			self:_addToOpenSet(tmpMo, traceSet, openSet)
		end

		traceSet[tmpMo] = true
	end

	return traceSet, resultTable
end

function DungeonPuzzlePipeRule:_addToOpenSet(tmpMo, traceSet, openSet)
	for dir, _ in pairs(tmpMo.connectSet) do
		local nextX, nextY, reverse = DungeonPuzzlePipeRule.getIndexByDir(tmpMo.x, tmpMo.y, dir)

		if nextX > 0 and nextX <= self._gameWidth and nextY > 0 and nextY <= self._gameHeight then
			local nextMo = DungeonPuzzlePipeModel.instance:getData(nextX, nextY)

			if not traceSet[nextMo] then
				table.insert(openSet, nextMo)
			end
		end
	end
end

function DungeonPuzzlePipeRule:_mergeReachDir(entryTable)
	local compareList = {}

	for entryMo, reachMap in pairs(entryTable) do
		table.insert(compareList, reachMap)
	end

	local len = #compareList

	for i = 1, len do
		local mergeMap = {}

		for j = i + 1, len do
			local map_i, map_j = compareList[i], compareList[j]

			for mo, _ in pairs(map_i) do
				if map_j[mo] then
					mergeMap[mo] = 1
				end
			end

			self:_markReachDir(mergeMap)
		end
	end
end

function DungeonPuzzlePipeRule:_markReachDir(mergeMap)
	for mo, _ in pairs(mergeMap) do
		for dir, _ in pairs(mo.connectSet) do
			local connectX, connectY, reverse = DungeonPuzzlePipeRule.getIndexByDir(mo.x, mo.y, dir)

			if connectX > 0 and connectX <= self._gameWidth and connectY > 0 and connectY <= self._gameHeight then
				local connectMo = DungeonPuzzlePipeModel.instance:getData(connectX, connectY)

				if mergeMap[connectMo] then
					mo.entryConnect[dir] = true
					connectMo.entryConnect[reverse] = true
				end
			end
		end
	end
end

function DungeonPuzzlePipeRule:_unmarkBranch()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			local mo = DungeonPuzzlePipeModel.instance:getData(x, y)

			self:_unmarkSearchNode(mo)
		end
	end
end

function DungeonPuzzlePipeRule:_unmarkSearchNode(mo)
	local searchMo = mo

	while searchMo ~= nil do
		if tabletool.len(searchMo.entryConnect) == 1 and not searchMo:isEntry() then
			local dir

			for k, _ in pairs(searchMo.entryConnect) do
				dir = k
			end

			local nextX, nextY, reverse = DungeonPuzzlePipeRule.getIndexByDir(searchMo.x, searchMo.y, dir)
			local nextMo = DungeonPuzzlePipeModel.instance:getData(nextX, nextY)

			searchMo.entryConnect[dir] = nil
			nextMo.entryConnect[reverse] = nil
			searchMo = nextMo
		else
			searchMo = nil
		end
	end
end

function DungeonPuzzlePipeRule:setSingleConnection(x, y, dir, reverse, centerMO)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local targetMO = DungeonPuzzlePipeModel.instance:getData(x, y)
		local targetRule = self._ruleConnect[targetMO.value]
		local selfRule = self._ruleConnect[centerMO.value]

		if targetRule[dir] then
			local result = selfRule[reverse]

			if result then
				targetMO.connectSet[dir] = true
				centerMO.connectSet[reverse] = true
			else
				targetMO.connectSet[dir] = nil
				centerMO.connectSet[reverse] = nil
			end
		end
	end
end

function DungeonPuzzlePipeRule:changeDirection(x, y)
	local mo = DungeonPuzzlePipeModel.instance:getData(x, y)
	local nextVal = self._ruleChange[mo.value]

	if nextVal then
		mo.value = nextVal
	end

	return mo
end

function DungeonPuzzlePipeRule:getRandomSkipSet()
	local skipSet = {}
	local entryList = DungeonPuzzlePipeModel.instance:getEntryList()
	local w, h = DungeonPuzzlePipeModel.instance:getGameSize()

	for _, entry in ipairs(entryList) do
		skipSet[entry] = true

		local x, y = entry.x, entry.y

		self:_insertToSet(x - 1, y, skipSet)
		self:_insertToSet(x + 1, y, skipSet)
		self:_insertToSet(x, y - 1, skipSet)
		self:_insertToSet(x, y + 1, skipSet)
	end

	return skipSet
end

function DungeonPuzzlePipeRule:_insertToSet(x, y, targetSet)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = DungeonPuzzlePipeModel.instance:getData(x, y)

		targetSet[mo] = true
	end
end

function DungeonPuzzlePipeRule.getIndexByDir(x, y, dir)
	if dir == LEFT then
		return x - 1, y, RIGHT
	elseif dir == RIGHT then
		return x + 1, y, LEFT
	elseif dir == UP then
		return x, y + 1, DOWN
	elseif dir == DOWN then
		return x, y - 1, UP
	end
end

return DungeonPuzzlePipeRule
