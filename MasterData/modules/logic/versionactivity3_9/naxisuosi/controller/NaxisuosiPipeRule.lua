-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/controller/NaxisuosiPipeRule.lua

module("modules.logic.versionactivity3_9.naxisuosi.controller.NaxisuosiPipeRule", package.seeall)

local NaxisuosiPipeRule = class("NaxisuosiPipeRule")
local LEFT = NaxisuosiPipeEnum.dir.left
local RIGHT = NaxisuosiPipeEnum.dir.right
local DOWN = NaxisuosiPipeEnum.dir.down
local UP = NaxisuosiPipeEnum.dir.up
local EmptyChange = 0

local function isConnectAllType(typeId)
	return typeId == NaxisuosiPipeEnum.type.first or typeId == NaxisuosiPipeEnum.type.last or typeId == NaxisuosiPipeEnum.type.connect
end

local statusPriority = {
	[NaxisuosiPipeEnum.LineStatus.Normal] = 0,
	[NaxisuosiPipeEnum.LineStatus.Connect] = 1,
	[NaxisuosiPipeEnum.LineStatus.Error] = 2
}

function NaxisuosiPipeRule:ctor()
	self._ruleChange = {
		[0] = 0,
		[28] = 46,
		[248] = 468,
		[468] = 268,
		[46] = 28,
		[48] = 68,
		[246] = 248,
		[268] = 246,
		[24] = 48,
		[26] = 24,
		[68] = 26,
		[2468] = 2468
	}
	self._ruleConnect = {}

	for k, v in pairs(self._ruleChange) do
		local rule = {}
		local val = k

		while val > 0 do
			local mod = val % 10

			val = math.floor(val / 10)
			rule[mod] = true
		end

		self._ruleConnect[k] = rule
	end

	self._ruleConnect[EmptyChange] = {
		[RIGHT] = false,
		[LEFT] = false,
		[DOWN] = false,
		[UP] = false
	}
end

function NaxisuosiPipeRule:setGameSize(w, h)
	self._gameWidth = w
	self._gameHeight = h
end

function NaxisuosiPipeRule:isGameClear(resultTable)
	for entryMo, result in pairs(resultTable) do
		if not self:getIsEntryClear(entryMo) then
			return false
		end
	end

	return true
end

function NaxisuosiPipeRule:getIsEntryClear(entryMo)
	if entryMo.pathType == NaxisuosiPipeEnum.PathType.ConnectAll then
		if not isConnectAllType(entryMo.typeId) then
			return true
		end

		if entryMo.hasWrongNode then
			return false
		end

		local totalEntryCount = NaxisuosiPipeModel.instance:getConnectAllEntryCount()

		return entryMo.entryCount >= totalEntryCount - 1
	end

	if entryMo.typeId == NaxisuosiPipeEnum.type.first or entryMo.typeId == NaxisuosiPipeEnum.type.last then
		return entryMo.entryCount >= 1
	end

	return entryMo.entryCount >= NaxisuosiPipeEnum.pipeEntryClearCount and entryMo:getConnectValue() >= NaxisuosiPipeEnum.pipeEntryClearDecimal
end

function NaxisuosiPipeRule:getReachTable()
	local entryTable, resultTable = {}, {}
	local openSet = {}
	local orderList = {}
	local entryList = NaxisuosiPipeModel.instance:getEntryList()

	table.sort(entryList, NaxisuosiPipeRule._sortOrderList)

	for i, entryMo in ipairs(entryList) do
		table.insert(openSet, entryMo)

		local traceTable, resultEntry = self:_getSearchPipeResult(entryMo, openSet)

		resultTable[entryMo] = resultEntry
		entryTable[entryMo] = traceTable
		entryMo.entryCount = #resultEntry

		if entryMo.pathType == NaxisuosiPipeEnum.PathType.Order then
			table.insert(orderList, entryMo)
		end
	end

	if #orderList > 0 then
		self:_mergeReachDir(entryTable)
		table.sort(orderList, NaxisuosiPipeRule._sortOrderList)

		local isCanConn = false

		for i, entryMo in ipairs(orderList) do
			if entryMo.typeId == NaxisuosiPipeEnum.type.first then
				isCanConn = entryMo.entryCount > 0
			else
				if not isCanConn then
					entryMo:cleanEntrySet()

					entryMo.entryCount = 0
					resultTable[entryMo] = {}
					entryTable[entryMo] = {}
				end

				if isCanConn and not self:getIsEntryClear(entryMo) then
					isCanConn = false
				end
			end
		end

		self:_cleaConnMark()
	end

	return entryTable, resultTable
end

function NaxisuosiPipeRule:_cleaConnMark()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			local entryMo = NaxisuosiPipeModel.instance:getData(x, y)
			local entryCount = entryMo.entryCount

			entryMo:cleanEntrySet()

			entryMo.entryCount = entryCount
		end
	end
end

function NaxisuosiPipeRule._sortOrderList(a, b)
	if a.pathIndex ~= b.pathIndex then
		return a.pathIndex < b.pathIndex
	end

	if a.numIndex ~= b.numIndex then
		return a.numIndex < b.numIndex
	end
end

function NaxisuosiPipeRule:_getSearchPipeResult(entryMo, openSet)
	local entryList = {}
	local traceSet = {}
	local hasWrongNode = false

	while #openSet > 0 do
		local tmpMo = table.remove(openSet)

		self:_addToOpenSet(tmpMo, traceSet, openSet, entryList)
	end

	for i = #entryList, 1, -1 do
		local tmpMo = entryList[i]

		if tmpMo.typeId == NaxisuosiPipeEnum.type.wrong then
			hasWrongNode = true
		end

		if not self:_checkEntryConnect(entryMo, tmpMo) or entryMo == tmpMo then
			traceSet[tmpMo] = nil

			table.remove(entryList, i)
		end
	end

	if #entryList < 1 and not hasWrongNode and (entryMo.pathType ~= NaxisuosiPipeEnum.PathType.ConnectAll or not isConnectAllType(entryMo.typeId)) then
		traceSet = {}
	end

	entryMo.hasWrongNode = hasWrongNode

	return traceSet, entryList
end

function NaxisuosiPipeRule:_checkEntryConnect(entryMo, tmpMo)
	if entryMo.pathType == NaxisuosiPipeEnum.PathType.ConnectAll then
		return isConnectAllType(entryMo.typeId) and isConnectAllType(tmpMo.typeId)
	end

	if tmpMo.pathIndex ~= entryMo.pathIndex or tmpMo.pathType ~= entryMo.pathType then
		return false
	end

	if tmpMo.pathType == NaxisuosiPipeEnum.PathType.Order then
		local tModel = NaxisuosiPipeModel.instance
		local tmpIndex = tModel:getIndexByMO(tmpMo)
		local curIndex = tModel:getIndexByMO(entryMo)

		if math.abs(curIndex - tmpIndex) ~= 1 then
			return false
		end
	end

	return true
end

function NaxisuosiPipeRule:_addToOpenSet(tmpMo, traceSet, openSet, entryList)
	local isFromEntry = isConnectAllType(tmpMo.typeId)

	for dir, _ in pairs(tmpMo.connectSet) do
		local nextX, nextY, reverse = NaxisuosiPipeRule.getIndexByDir(tmpMo.x, tmpMo.y, dir)

		if nextX > 0 and nextX <= self._gameWidth and nextY > 0 and nextY <= self._gameHeight then
			local nextMo = NaxisuosiPipeModel.instance:getData(nextX, nextY)

			if traceSet[nextMo] or isFromEntry and nextMo.typeId == NaxisuosiPipeEnum.type.wrong then
				-- block empty
			else
				traceSet[nextMo] = true

				if nextMo:isEntry() then
					table.insert(entryList, nextMo)

					if isConnectAllType(nextMo.typeId) then
						table.insert(openSet, nextMo)
					end
				else
					table.insert(openSet, nextMo)
				end
			end
		end
	end

	traceSet[tmpMo] = true
end

function NaxisuosiPipeRule:_mergeReachDir(entryTable)
	local compareList = {}
	local entryMoList = {}

	for entryMo, reachMap in pairs(entryTable) do
		table.insert(compareList, reachMap)
		table.insert(entryMoList, entryMo)
	end

	local len = #compareList

	for i = 1, len do
		local mergeMap = {}

		for j = i + 1, len do
			local entryMoI, entryMoJ = entryMoList[i], entryMoList[j]

			if self:_checkEntryConnect(entryMoI, entryMoJ) then
				local mapI, mapJ = compareList[i], compareList[j]

				for mo, _ in pairs(mapI) do
					if mapJ[mo] then
						mergeMap[mo] = entryMoI.pathIndex
					end
				end

				self:_markReachDir(mergeMap)
			end
		end
	end
end

function NaxisuosiPipeRule:_markReachDir(mergeMap)
	for mo, connPathIndex in pairs(mergeMap) do
		for dir, _ in pairs(mo.connectSet) do
			local connectX, connectY, reverse = NaxisuosiPipeRule.getIndexByDir(mo.x, mo.y, dir)

			if connectX > 0 and connectX <= self._gameWidth and connectY > 0 and connectY <= self._gameHeight then
				local connectMo = NaxisuosiPipeModel.instance:getData(connectX, connectY)

				if mergeMap[connectMo] then
					mo.entryConnect[dir] = true
					connectMo.entryConnect[reverse] = true
					mo.connectPathIndex = connPathIndex
					connectMo.connectPathIndex = connPathIndex
				end
			end
		end
	end
end

function NaxisuosiPipeRule:_unmarkBranch()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			local mo = NaxisuosiPipeModel.instance:getData(x, y)

			self:_unmarkSearchNode(mo)
		end
	end
end

function NaxisuosiPipeRule:_unmarkSearchNode(mo)
	local searchMo = mo

	while searchMo ~= nil do
		if tabletool.len(searchMo.entryConnect) == 1 and not searchMo:isEntry() then
			local dir

			for k, _ in pairs(searchMo.entryConnect) do
				dir = k
			end

			local nextX, nextY, reverse = NaxisuosiPipeRule.getIndexByDir(searchMo.x, searchMo.y, dir)
			local nextMo = NaxisuosiPipeModel.instance:getData(nextX, nextY)

			searchMo.entryConnect[dir] = nil
			nextMo.entryConnect[reverse] = nil
			searchMo = nextMo
		else
			searchMo = nil
		end
	end
end

function NaxisuosiPipeRule:setSingleConnection(x, y, dir, reverse, centerMO)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local targetMO = NaxisuosiPipeModel.instance:getData(x, y)
		local targetRule = self._ruleConnect[targetMO.value]

		if targetRule[dir] then
			if targetRule[dir] then
				targetMO.connectSet[dir] = true
				centerMO.connectSet[reverse] = true
			else
				targetMO.connectSet[dir] = nil
				centerMO.connectSet[reverse] = nil
			end
		end
	end
end

function NaxisuosiPipeRule:changeDirection(x, y)
	local mo = NaxisuosiPipeModel.instance:getData(x, y)
	local nextVal = self._ruleChange[mo.value]

	if nextVal then
		mo.value = nextVal
	end

	return mo
end

function NaxisuosiPipeRule:getRandomSkipSet()
	local skipSet = {}
	local entryList = NaxisuosiPipeModel.instance:getEntryList()
	local w, h = NaxisuosiPipeModel.instance:getGameSize()

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

function NaxisuosiPipeRule:_insertToSet(x, y, targetSet)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = NaxisuosiPipeModel.instance:getData(x, y)

		targetSet[mo] = true
	end
end

function NaxisuosiPipeRule.getIndexByDir(x, y, dir)
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

function NaxisuosiPipeRule:updateAllStatus(entryTable, resultTable)
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			local mo = NaxisuosiPipeModel.instance:getData(x, y)

			mo.status = NaxisuosiPipeEnum.LineStatus.Normal
		end
	end

	for entryMo, resultList in pairs(resultTable) do
		local lineStatus = self:_getLineStatus(entryMo, resultList)

		if lineStatus ~= NaxisuosiPipeEnum.LineStatus.Normal then
			local traceTable = entryTable[entryMo]

			if traceTable then
				local isConnectAll = entryMo.pathType == NaxisuosiPipeEnum.PathType.ConnectAll

				for mo, _ in pairs(traceTable) do
					if entryMo.hasWrongNode then
						if mo.connectSet and next(mo.connectSet) then
							self:_applyStatus(mo, lineStatus)
						end
					elseif isConnectAll then
						if mo.connectSet and next(mo.connectSet) then
							self:_applyStatus(mo, lineStatus)
						end
					elseif mo.entryConnect and next(mo.entryConnect) then
						self:_applyStatus(mo, lineStatus)
					end
				end
			end
		end
	end
end

function NaxisuosiPipeRule:_getLineStatus(entryMo, resultList)
	local isConnectedToFirst = entryMo.typeId == NaxisuosiPipeEnum.type.first

	if not isConnectedToFirst then
		for _, mo in ipairs(resultList) do
			if mo.typeId == NaxisuosiPipeEnum.type.first then
				isConnectedToFirst = true

				break
			end
		end
	end

	if entryMo.hasWrongNode and isConnectedToFirst then
		return NaxisuosiPipeEnum.LineStatus.Error
	end

	if isConnectedToFirst then
		return NaxisuosiPipeEnum.LineStatus.Connect
	end

	return NaxisuosiPipeEnum.LineStatus.Normal
end

function NaxisuosiPipeRule:_applyStatus(mo, newStatus)
	if not mo.status or statusPriority[newStatus] > statusPriority[mo.status] then
		mo.status = newStatus
	end
end

return NaxisuosiPipeRule
