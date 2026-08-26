-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/controller/MaliAnNaSoliderAiMgr.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaliAnNaSoliderAiMgr", package.seeall)

local MaliAnNaSoliderAiMgr = class("MaliAnNaSoliderAiMgr")

function MaliAnNaSoliderAiMgr:ctor()
	self._defineList = {
		[Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot] = self._attAckSlot,
		[Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad] = self._attackRoad,
		[Activity201MaLiAnNaEnum.SlotAIFuncType.retreat] = self._retreat,
		[Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot] = self._helpSlot
	}
	self._weights = {}

	for i = 1, #Activity201MaLiAnNaEnum.AllSlotAIFuncType do
		table.insert(self._weights, 1)
	end

	self.attackTriggerRate = 0
	self.positiveMoveTriggerRate = 0
	self.negativeMoveTriggerRate = 0
	self._heroMoveRate = 0
	self._heroOrSoldier = 0
	self._heroGoFrontOrNot = 0
	self._needTick = false
end

function MaliAnNaSoliderAiMgr:initAiParamsById(gameId)
	self._needTick = false
	self._tickTime = 0
	self._tickInterval = 10000

	self:_changeAiParamsByIdByIndex(gameId, 1)
end

function MaliAnNaSoliderAiMgr:_changeAiParamsByIdByIndex(gameId, index)
	local allGameAIConfig = lua_activity203_ai.configDict[gameId]

	if allGameAIConfig and allGameAIConfig[index] then
		local config = allGameAIConfig[index]

		self._tickInterval = config.gaptime or 10000
		self._weights[1] = config.attack_weight or 1
		self._weights[2] = config.positive_move_weight or 1
		self._weights[3] = config.negative_move_weight or 1
		self._weights[4] = config.assist_weight or 1
		self.attackTriggerRate = config.attack_trigger_rate
		self.positiveMoveTriggerRate = config.positive_move_trigger_rate
		self.negativeMoveTriggerRate = config.negative_move_trigger_rate
		self._heroMoveRate = config.hero_move_rate or 0
		self._heroOrSoldier = config.hero_or_soldier or false
		self._heroGoFrontOrNot = config.hero_go_front_ornot or false
		self._needTick = true

		math.randomseed(os.time())
	end
end

function MaliAnNaSoliderAiMgr:clear()
	self._tickTime = 0
end

function MaliAnNaSoliderAiMgr:getHandleFunc(type)
	return self._defineList[type]
end

function MaliAnNaSoliderAiMgr:update(deltaTime)
	if not self._needTick then
		return
	end

	self._tickTime = self._tickTime + deltaTime * 1000

	if self._tickTime < self._tickInterval then
		return
	end

	self._tickTime = 0

	local index = EliminateModelUtils.getRandomNumberByWeight(self._weights)
	local typeKey = Activity201MaLiAnNaEnum.AllSlotAIFuncType[index]

	self._typeKey = typeKey

	local func = self:getHandleFunc(typeKey)

	if isDebugBuild then
		local name = MaliAnNaSoliderAiMgr.instance.getName(typeKey)

		logNormal("AI本次tick: " .. name)
	end

	if func then
		func(self)
	end
end

function MaliAnNaSoliderAiMgr:_attAckSlot()
	local allSlot = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local attackPaths = {}

	if allSlot then
		for _, slot in pairs(allSlot) do
			if slot and slot:canAI() and slot:getSoliderPercent() >= self.attackTriggerRate then
				local paths = self._shortestPaths(slot:getId())

				for i = 1, #paths do
					local path = paths[i]

					if path ~= nil and #path >= 2 then
						table.insert(attackPaths, path)
					end
				end
			end
		end
	end

	table.sort(attackPaths, function(a, b)
		local startSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[1])
		local startSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[1])

		if startSlotA:getSoliderPercent() == startSlotB:getSoliderPercent() then
			local lengthA = self.getPathAllLength(a)
			local lengthB = self.getPathAllLength(b)

			if lengthA == lengthB then
				local endSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[#a])
				local endSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[#b])

				return endSlotA:getSoliderCount() < endSlotB:getSoliderCount()
			end

			return lengthA < lengthB
		end

		return startSlotA:getSoliderPercent() > startSlotB:getSoliderPercent()
	end)

	local attackPath, isHeroFirst = self:getDisPatchPath(attackPaths, Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot)

	return self._disPatch(attackPath, isHeroFirst)
end

function MaliAnNaSoliderAiMgr:_attackRoad()
	local allSlot = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local attackPaths = {}

	if allSlot then
		for _, slot in pairs(allSlot) do
			if slot and slot:canAI() and slot:getSoliderPercent() >= self.positiveMoveTriggerRate then
				local paths = self._shortestPaths(slot:getId())

				for i = 1, #paths do
					local path = paths[i]

					table.remove(path, #path)

					if path ~= nil and #path >= 2 then
						table.insert(attackPaths, path)
					end
				end
			end
		end
	end

	table.sort(attackPaths, function(a, b)
		local startSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[1])
		local startSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[1])

		if startSlotA:getSoliderPercent() == startSlotB:getSoliderPercent() then
			local lengthA = self.getPathAllLength(a)
			local lengthB = self.getPathAllLength(b)

			if lengthA == lengthB then
				local endSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[#a])
				local endSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[#b])

				return endSlotA:getSoliderCount() < endSlotB:getSoliderCount()
			end

			return lengthA < lengthB
		end

		return startSlotA:getSoliderPercent() > startSlotB:getSoliderPercent()
	end)

	local attackPath, isHeroFirst = self:getDisPatchPath(attackPaths, Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad)

	return self._disPatch(attackPath, isHeroFirst)
end

function MaliAnNaSoliderAiMgr:_retreat()
	local allSlot = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local retreatPaths = {}

	if allSlot then
		for _, slot in pairs(allSlot) do
			if slot and slot:canAI() then
				local paths = self._shortestPathsToEnemyMain(slot:getId())

				for i = 1, #paths do
					local path = paths[i]

					if path ~= nil and #path >= 2 then
						local index = #path - 2

						for j = 1, index do
							local copyPath = tabletool.copy(path)

							for k = 1, j do
								table.remove(copyPath, #copyPath)
							end

							table.insert(retreatPaths, path)
						end
					end
				end
			end
		end
	end

	table.sort(retreatPaths, function(a, b)
		local startSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[1])
		local startSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[1])

		if startSlotA:getSoliderPercent() == startSlotB:getSoliderPercent() then
			if startSlotA:getSoliderCount() == startSlotA:getSoliderCount() then
				local endSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[#a])
				local endSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[#b])

				return endSlotA:getSoliderCount() > endSlotB:getSoliderCount()
			end

			return startSlotA:getSoliderCount() < startSlotA:getSoliderCount()
		end

		return startSlotA:getSoliderPercent() < startSlotB:getSoliderPercent()
	end)

	local retreatPath, isHeroFirst = self:getDisPatchPath(retreatPaths, Activity201MaLiAnNaEnum.SlotAIFuncType.retreat)

	return self._disPatch(retreatPath, isHeroFirst)
end

function MaliAnNaSoliderAiMgr:_helpSlot()
	local allSlot = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local helpPaths = {}

	if allSlot then
		for _, slot in pairs(allSlot) do
			if slot and slot:canAI() and Activity201MaLiAnNaGameModel.instance:isInAttackState(slot) then
				local paths = self._findTargetCampPaths(slot:getId(), Activity201MaLiAnNaEnum.CampType.Enemy)

				for i = 1, #paths do
					local path = paths[i]

					if path ~= nil and #path >= 2 then
						tabletool.revert(path)
						table.insert(helpPaths, path)
					end
				end
			end
		end
	end

	table.sort(helpPaths, function(a, b)
		local endSlotA = Activity201MaLiAnNaGameModel.instance:getSlotById(a[#a])
		local endSlotB = Activity201MaLiAnNaGameModel.instance:getSlotById(b[#b])

		if endSlotA:getSoliderPercent() == endSlotB:getSoliderPercent() then
			if endSlotA:getSoliderCount() == endSlotB:getSoliderCount() then
				local lengthA = self.getPathAllLength(a)
				local lengthB = self.getPathAllLength(b)

				return lengthA < lengthB
			end

			return endSlotA:getSoliderCount() > endSlotB:getSoliderCount()
		end

		return endSlotA:getSoliderPercent() > endSlotB:getSoliderPercent()
	end)

	local helpPath, isHeroFirst = self:getDisPatchPath(helpPaths, Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot)

	return self._disPatch(helpPath, isHeroFirst)
end

function MaliAnNaSoliderAiMgr:getDisPatchPath(paths, disPatchType)
	if paths == nil then
		return nil, false
	end

	if disPatchType == Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot and not self._heroGoFrontOrNot then
		return table.remove(paths, 1), false
	end

	local isHeroFirst = MaliAnNaSoliderAiMgr.simpleProbabilityTrigger(self._heroMoveRate)

	if isHeroFirst then
		local pathCount = #paths

		for i = 1, pathCount do
			local path = paths[i]
			local slotId = path[1]
			local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

			if slot and slot:getHeroSoliderList() ~= 0 then
				return path, true
			end
		end
	else
		return table.remove(paths, 1), false
	end
end

function MaliAnNaSoliderAiMgr._disPatch(path, isHeroFirst)
	if path == nil or #path < 2 then
		return false
	end

	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(path[1])

	if slot:canDispatch() then
		local disPatchId = Activity201MaLiAnNaGameModel.instance:getNextDisPatchId()

		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.ShowDisPatchPath, disPatchId, Activity201MaLiAnNaEnum.CampType.Enemy, path)
		slot:setDispatchSoldierInfo(disPatchId, path, isHeroFirst)

		if isDebugBuild then
			local key = MaliAnNaSoliderAiMgr.instance._typeKey
			local name = MaliAnNaSoliderAiMgr.instance.getName(key)

			logNormal("AI本次tick: [执行]" .. name .. " slotId: " .. slot:getConfig().baseId .. " 剩余派遣数量：" .. slot._dispatchValue .. "当前时间：" .. os.time())
		end

		return true
	end

	return false
end

function MaliAnNaSoliderAiMgr._shortestPathToEnemyMainBFS(startSlotId)
	return MaliAnNaSoliderAiMgr._shortestPathBFSFuncCheck(startSlotId, function(node)
		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(node)
		local camp = slotA:getSlotCamp()
		local config = slotA:getConfig()

		return camp == Activity201MaLiAnNaEnum.CampType.Enemy and config.isHQ
	end)
end

function MaliAnNaSoliderAiMgr._shortestPathBFS(startSlotId)
	return MaliAnNaSoliderAiMgr._shortestPathBFSFuncCheck(startSlotId, function(node)
		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(node)
		local camp = slotA:getSlotCamp()

		return camp == Activity201MaLiAnNaEnum.CampType.Player or camp == Activity201MaLiAnNaEnum.CampType.Middle
	end)
end

function MaliAnNaSoliderAiMgr._findTargetCampPathBFS(startSlotId, targetCamp)
	return MaliAnNaSoliderAiMgr._shortestPathBFSFuncCheck(startSlotId, function(node)
		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(node)
		local camp = slotA:getSlotCamp()

		return camp == targetCamp
	end)
end

function MaliAnNaSoliderAiMgr._shortestPathBFSFuncCheck(startSlotId, funcCheck)
	local graph = Activity201MaLiAnNaGameModel.instance:getRoadGraph()
	local queue = {
		{
			startSlotId
		}
	}
	local visited = {
		[startSlotId] = true
	}

	while #queue > 0 do
		local path = table.remove(queue, 1)
		local node = path[#path]

		if funcCheck and funcCheck(node) then
			return path
		end

		for _, neighbor in ipairs(graph[node] or {}) do
			if not visited[neighbor] then
				visited[neighbor] = true

				local newPath = tabletool.copy(path)

				table.insert(newPath, neighbor)
				table.insert(queue, newPath)
			end
		end
	end

	return nil
end

function MaliAnNaSoliderAiMgr.getPathAllLength(path)
	if not path or #path < 2 then
		return 0
	end

	local totalLength = 0

	for i = 1, #path - 1 do
		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(path[i])
		local slotB = Activity201MaLiAnNaGameModel.instance:getSlotById(path[i + 1])

		if slotA and slotB then
			totalLength = totalLength + slotA:getDistanceTo(slotB)
		end
	end

	return totalLength
end

function MaliAnNaSoliderAiMgr._shortestPathsToEnemyMain(startSlotId)
	return MaliAnNaSoliderAiMgr.findAllPaths(startSlotId, function(node)
		if node == nil then
			return false
		end

		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(node)
		local camp = slotA:getSlotCamp()
		local config = slotA:getConfig()

		return camp == Activity201MaLiAnNaEnum.CampType.Enemy and config.isHQ
	end)
end

function MaliAnNaSoliderAiMgr._shortestPaths(startSlotId)
	return MaliAnNaSoliderAiMgr.findAllPaths(startSlotId, function(node)
		if node == nil then
			return false
		end

		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(node)
		local camp = slotA:getSlotCamp()

		return camp == Activity201MaLiAnNaEnum.CampType.Player or camp == Activity201MaLiAnNaEnum.CampType.Middle
	end)
end

function MaliAnNaSoliderAiMgr._findTargetCampPaths(startSlotId, targetCamp)
	return MaliAnNaSoliderAiMgr.findAllPaths(startSlotId, function(node)
		local slotA = Activity201MaLiAnNaGameModel.instance:getSlotById(node)
		local camp = slotA:getSlotCamp()

		return camp == targetCamp
	end)
end

function MaliAnNaSoliderAiMgr.findAllPaths(start, checkFunc)
	local graph = Activity201MaLiAnNaGameModel.instance:getRoadGraph()
	local visited = {}
	local allPaths = {}

	local function dfs(current, path)
		visited[current] = true

		table.insert(path, current)

		if checkFunc and checkFunc(current) and current ~= start then
			table.insert(allPaths, tabletool.copy(path))
		else
			for _, neighbor in pairs((not graph[current] or nil) and {}) do
				local startSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(start)
				local currentSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(current)

				if not visited[neighbor] and currentSlot:getSlotCamp() == startSlot:getSlotCamp() then
					dfs(neighbor, path)
				end
			end
		end

		visited[current] = false

		table.remove(path)
	end

	dfs(start, {})

	local minPathCount = 0

	for i = 1, #allPaths do
		local path = allPaths[i]

		if minPathCount > #path or minPathCount == 0 then
			minPathCount = #path
		end
	end

	if minPathCount ~= 0 then
		local count = #allPaths

		for i = count, 1, -1 do
			local path = allPaths[i]

			if #path ~= minPathCount then
				table.remove(allPaths, i)
			end
		end
	end

	return allPaths
end

function MaliAnNaSoliderAiMgr.simpleProbabilityTrigger(probability)
	return probability > math.random()
end

function MaliAnNaSoliderAiMgr.guaranteedTrigger(probability, maxAttempts)
	local failedAttempts = 0

	return function()
		failedAttempts = failedAttempts + 1

		if failedAttempts >= maxAttempts then
			failedAttempts = 0

			return true
		end

		return math.random() < probability
	end
end

function MaliAnNaSoliderAiMgr.getName(key)
	local name = ""

	if Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot == key then
		name = "攻击"
	end

	if Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad == key then
		name = "有效调兵"
	end

	if Activity201MaLiAnNaEnum.SlotAIFuncType.retreat == key then
		name = "无效调兵"
	end

	return (Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot == key or nil) and "支援"
end

MaliAnNaSoliderAiMgr.instance = MaliAnNaSoliderAiMgr.New()

return MaliAnNaSoliderAiMgr
