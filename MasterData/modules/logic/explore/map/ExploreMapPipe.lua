-- chunkname: @modules/logic/explore/map/ExploreMapPipe.lua

module("modules.logic.explore.map.ExploreMapPipe", package.seeall)

local ExploreMapPipe = class("ExploreMapPipe")
local PipeColor = ExploreEnum.PipeColor
local finalColorDict = {
	[PipeColor.Color1] = PipeColor.Color1,
	[PipeColor.Color2] = PipeColor.Color2,
	[PipeColor.Color3] = PipeColor.Color3,
	[bit.bor(PipeColor.Color1, PipeColor.Color2)] = PipeColor.Color3,
	[bit.bor(PipeColor.Color3, PipeColor.Color2)] = PipeColor.Color1,
	[bit.bor(PipeColor.Color1, PipeColor.Color3)] = PipeColor.Color2
}

GameUtil.setDefaultValue(finalColorDict, PipeColor.None)

function ExploreMapPipe:loadMap()
	return
end

function ExploreMapPipe:init()
	local map = ExploreController.instance:getMap()
	local allPipes = map:getUnitsByTypeDict(ExploreEnum.PipeTypes)

	if #allPipes <= 0 then
		return
	end

	self._allPipeMos = {}
	self._allPipeComps = {}

	for _, pipe in pairs(allPipes) do
		local key = ExploreHelper.getKey(pipe.mo.nodePos)

		self._allPipeMos[key] = pipe.mo
		self._allPipeComps[key] = pipe.pipeComp
	end

	self:initColors(true)

	self._tweenId = nil
end

function ExploreMapPipe.sortUnitById(a, b)
	return a.id < b.id
end

function ExploreMapPipe:initColors(isFirst, cacheActiveSensor, calcHistory)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	calcHistory = calcHistory or {}

	if #calcHistory > 50 then
		local str = ""

		if isDebugBuild then
			for _, pipeMo in pairs(self._allPipeMos) do
				str = string.format("%s\n[%s,%s,%s]", str, pipeMo.id, pipeMo:getColor(0), pipeMo:isInteractActiveState())
			end
		end

		logError("密室管道死循环了？？？" .. str)

		return
	end

	self._all = nil
	self._allOutColor = nil

	local all = {}
	local allOutColor = {}

	cacheActiveSensor = cacheActiveSensor or {}
	self._cacheActiveSensor = cacheActiveSensor

	local map = ExploreController.instance:getMap()
	local allPipeEntrance = map:getUnitsByType(ExploreEnum.ItemType.PipeEntrance)

	table.sort(allPipeEntrance, ExploreMapPipe.sortUnitById)

	for _, unit in ipairs(allPipeEntrance) do
		local color = unit.mo:getColor()

		if color ~= ExploreEnum.PipeColor.None then
			allOutColor[unit.id] = color

			self:calcRelation(unit.mo, unit.id, all, nil, unit.mo:getPipeOutDir())
		end
	end

	local allPipeSensor = map:getUnitsByType(ExploreEnum.ItemType.PipeSensor)

	table.sort(allPipeSensor, ExploreMapPipe.sortUnitById)

	for _, unit in ipairs(allPipeSensor) do
		local color = unit.mo:getColor()

		if color ~= ExploreEnum.PipeColor.None then
			allOutColor[unit.id] = color

			self:calcRelation(unit.mo, unit.id, all, nil, unit.mo:getPipeOutDir())
		end
	end

	local allPipeMemory = map:getUnitsByType(ExploreEnum.ItemType.PipeMemory)

	table.sort(allPipeMemory, ExploreMapPipe.sortUnitById)

	for _, unit in ipairs(allPipeMemory) do
		local color = unit.mo:getColor()

		if color ~= ExploreEnum.PipeColor.None then
			allOutColor[unit.id] = color

			self:calcRelation(unit.mo, unit.id, all, nil, unit.mo:getPipeOutDir())
		end
	end

	self:delUnUseDir(all)

	local fromDict = {}
	local allNoOutDivisive = {}

	for _, item in ipairs(all) do
		if item.isDivisive then
			if not fromDict[item.toId] then
				fromDict[item.toId] = {
					[item.fromId] = true
				}
			else
				fromDict[item.toId][item.fromId] = true
			end

			if item.noOutDivisive then
				allNoOutDivisive[item.toId] = true
			end
		end
	end

	local clean = true

	while clean do
		clean = false

		for toId, fromIdList in pairs(fromDict) do
			local color = PipeColor.None

			for id in pairs(fromIdList) do
				if id ~= toId then
					if allOutColor[id] then
						color = bit.bor(color, allOutColor[id])
					else
						color = nil

						break
					end
				end
			end

			if color then
				if allNoOutDivisive[toId] and not self:haveValue(PipeColor, color) then
					allOutColor[toId] = PipeColor.None
				end

				clean = true
				fromDict[toId] = nil
			end
		end

		if not clean and next(fromDict) then
			for toId, fromIdList in pairs(fromDict) do
				local color = PipeColor.None

				for id in pairs(fromIdList) do
					if id ~= toId then
						if allOutColor[id] then
							color = bit.bor(color, allOutColor[id])
						elseif not self:isRound({}, toId, id, fromDict) then
							color = nil

							break
						end
					end
				end

				if color ~= PipeColor.None and color then
					if allNoOutDivisive[toId] and not self:haveValue(PipeColor, color) then
						allOutColor[toId] = PipeColor.None
					end

					clean = true
					fromDict[toId] = nil

					break
				end
			end
		end
	end

	local history = {}

	for _, unit in ipairs(allPipeSensor) do
		local color = unit.mo:getColor()

		if not cacheActiveSensor[unit.id] and color == ExploreEnum.PipeColor.None then
			local xy = ExploreHelper.dirToXY(unit.mo.unitDir)
			local inKey = ExploreHelper.getKeyXY(unit.mo.nodePos.x + xy.x, unit.mo.nodePos.y + xy.y)
			local inUnitMo = self._allPipeMos[inKey]

			if inUnitMo and self:getOutDirColor(all, allOutColor, ExploreHelper.getDir(unit.mo.unitDir + 180), inUnitMo.id, ExploreEnum.PipeDirMatchMode.Single) == unit.mo:getNeedColor() then
				cacheActiveSensor[unit.id] = true
				history[unit.id] = 1
			end
		end
	end

	for _, unit in ipairs(allPipeMemory) do
		local color = unit.mo:getColor()
		local xy = ExploreHelper.dirToXY(unit.mo.unitDir)
		local inKey = ExploreHelper.getKeyXY(unit.mo.nodePos.x + xy.x, unit.mo.nodePos.y + xy.y)
		local inUnitMo = self._allPipeMos[inKey]
		local nowColor = inUnitMo and self:getOutDirColor(all, allOutColor, ExploreHelper.getDir(unit.mo.unitDir + 180), inUnitMo.id, ExploreEnum.PipeDirMatchMode.Single) or ExploreEnum.PipeColor.None

		if nowColor ~= color and nowColor ~= ExploreEnum.PipeColor.None then
			unit.mo:setCacheColor(nowColor)

			history[unit.id] = nowColor
		end
	end

	if not self:haveHistory(calcHistory, history) then
		table.insert(calcHistory, history)

		return self:initColors(isFirst, cacheActiveSensor, calcHistory)
	end

	self._all = all
	self._allOutColor = allOutColor

	if isFirst then
		self._initDone = true
	end

	for _, comp in pairs(self._allPipeComps) do
		comp:applyColor(isFirst)
	end

	if not isFirst then
		ExploreModel.instance:setStepPause(true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Pipe)

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.4, self._frameCall, self._finishCall, self, nil, EaseType.Linear)
	end
end

function ExploreMapPipe:haveHistory(calcHistory, history)
	for _, preHistory in pairs(calcHistory) do
		if tabletool.len(preHistory) == tabletool.len(history) then
			local isSame = true

			for k, v in pairs(preHistory) do
				if history[k] ~= v then
					isSame = false

					break
				end
			end

			if isSame then
				return true
			end
		end
	end

	return false
end

function ExploreMapPipe:isRound(cache, toId, checkId, fromDict)
	if toId == checkId then
		return true
	end

	checkId = checkId or toId

	if cache[checkId] then
		return
	end

	cache[checkId] = true

	local list = fromDict[checkId]

	if list then
		for fromId in pairs(fromDict) do
			if self:isRound(cache, toId, fromId, fromDict) then
				return true
			end
		end
	end
end

function ExploreMapPipe:haveValue(t, value)
	for k, v in pairs(t) do
		if v == value then
			return true
		end
	end

	return false
end

function ExploreMapPipe:isCacheActive(id)
	if not self._cacheActiveSensor then
		return
	end

	return self._cacheActiveSensor[id]
end

function ExploreMapPipe:_frameCall(value)
	for _, comp in pairs(self._allPipeComps) do
		comp:tweenColor(value)
	end
end

function ExploreMapPipe:_finishCall()
	ExploreModel.instance:setStepPause(false)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Pipe)
end

function ExploreMapPipe:getDirColor(id, dir)
	local all = self._all
	local allOutColor = self._allOutColor
	local unitMo = ExploreController.instance:getMap():getUnit(id).mo

	if unitMo:isDivisive() then
		local inItem

		for _, item in ipairs(all) do
			if item.toId == id and dir == item.inDir then
				inItem = item

				break
			end
		end

		if inItem then
			return (inItem or nil) and (allOutColor[inItem.fromId] or self:getOutDirColor(all, allOutColor, dir, id, ExploreEnum.PipeDirMatchMode.Single))
		end
	end

	return self:getOutDirColor(all, allOutColor, dir, id, ExploreEnum.PipeDirMatchMode.Both)
end

function ExploreMapPipe:getCenterColor(toId)
	return self:getOutDirColor(nil, nil, nil, toId, ExploreEnum.PipeDirMatchMode.All)
end

function ExploreMapPipe:getOutDirColor(all, allOutColor, outDir, toId, matchInDir)
	all = all or self._all
	allOutColor = allOutColor or self._allOutColor

	if not all then
		return ExploreEnum.PipeColor.None
	end

	if allOutColor[toId] then
		local unitMO = ExploreMapModel.instance:getUnitMO(toId)

		if not unitMO then
			return ExploreEnum.PipeColor.None
		end

		if outDir and not unitMO:isOutDir(outDir) then
			return ExploreEnum.PipeColor.None
		end

		return allOutColor[toId]
	end

	local matchItem

	for _, item in ipairs(all) do
		local isMatch = false

		if matchInDir == ExploreEnum.PipeDirMatchMode.Single then
			isMatch = outDir == item.outDir
		elseif matchInDir == ExploreEnum.PipeDirMatchMode.Both then
			isMatch = outDir == item.outDir or outDir == item.inDir
		elseif matchInDir == ExploreEnum.PipeDirMatchMode.All then
			isMatch = true
		end

		if item.toId == toId and isMatch then
			matchItem = item

			break
		end
	end

	return (matchItem or nil) and (allOutColor[matchItem.fromId] or ExploreEnum.PipeColor.None)
end

function ExploreMapPipe:delUnUseDir(all)
	local haveRemomve = true

	while haveRemomve do
		haveRemomve = false

		for _, item in ipairs(all) do
			if item.isDivisive then
				local removeKeys = {}

				for key, item2 in ipairs(all) do
					if item2.fromId == item.toId and item.inDir == item2.fromDir or item2.toId == item.toId and item.inDir == item2.outDir then
						table.insert(removeKeys, key)
					end
				end

				for i = #removeKeys, 1, -1 do
					table.remove(all, removeKeys[i])

					haveRemomve = true
				end
			end

			if haveRemomve then
				break
			end
		end
	end

	for i = #all, 1, -1 do
		local itemA = all[i]

		for j = i - 1, 1, -1 do
			local itemB = all[j]

			if not itemA.isDivisive and itemA.toId == itemB.toId and itemA.inDir == itemB.outDir then
				table.remove(all, i)

				break
			end
		end
	end
end

function ExploreMapPipe:calcRelation(unitMo, fromId, all, inDir, fromDir)
	local dir1, dir2, dir3 = unitMo:getPipeOutDir(inDir)

	self:calcRelationDir(dir1, unitMo, fromId, all, inDir, fromDir)
	self:calcRelationDir(dir2, unitMo, fromId, all, inDir, fromDir)
	self:calcRelationDir(dir3, unitMo, fromId, all, inDir, fromDir)
end

function ExploreMapPipe:calcRelationDir(dir, unitMo, fromId, all, inDir, fromDir)
	if not dir then
		return
	end

	for _, relationInfo in ipairs(all) do
		if relationInfo.inDir == inDir and relationInfo.toId == unitMo.id and relationInfo.outDir == dir then
			return
		end
	end

	local var_16_0 = {
		fromId = fromId,
		inDir = inDir,
		toId = unitMo.id,
		outDir = dir,
		fromDir = fromDir,
		isDivisive = unitMo:isDivisive()
	}

	var_16_0.noOutDivisive = unitMo:isDivisive() and not unitMo:haveOutDir()

	table.insert(all, var_16_0)

	local xy = ExploreHelper.dirToXY(dir)
	local nextKey = ExploreHelper.getKeyXY(unitMo.nodePos.x + xy.x, unitMo.nodePos.y + xy.y)
	local nextUnitMo = self._allPipeMos[nextKey]

	if not nextUnitMo or nextUnitMo.type ~= ExploreEnum.ItemType.Pipe then
		return
	end

	if unitMo:isDivisive() then
		fromId = unitMo.id
		fromDir = dir
	end

	return self:calcRelation(nextUnitMo, fromId, all, ExploreHelper.getDir(dir + 180), fromDir)
end

function ExploreMapPipe:isInitDone()
	return self._initDone
end

function ExploreMapPipe:unloadMap()
	self:destroy()
end

function ExploreMapPipe:destroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._initDone = false
	self._allPipeMos = {}
	self._allPipeComps = {}
	self._all = nil
	self._allOutColor = nil
	self._cacheActiveSensor = nil
end

return ExploreMapPipe
