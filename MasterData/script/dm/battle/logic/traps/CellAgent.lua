-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/traps/CellAgent.lua

CellAgent = class("CellAgent")

function CellAgent:initialize(cell)
	super.initialize(self)

	self._targetCell = cell
	self._trapRegistry = {}
	self._trapList = nil
end

function CellAgent:getCell()
	return self._targetCell
end

function CellAgent:getId()
	return self._targetCell and self._targetCell:getId()
end

function CellAgent:addTrapObject(trapObject)
	assert(trapObject ~= nil, "Invalid arguments")

	if self._trapRegistry[trapObject] ~= nil then
		return nil
	end

	self._trapRegistry[trapObject] = trapObject

	local trapList = self._trapList

	if trapList == nil then
		self._trapList = {
			trapObject
		}
	else
		trapList[table.maxn(trapList) + 1] = trapObject
	end

	return trapObject
end

function CellAgent:hasTrapObject(trapObject)
	return self._trapRegistry[trapObject] ~= nil
end

function CellAgent:getTraps()
	local trapList = self._trapList

	if trapList == nil then
		return {}
	end

	local trapRegistry = self._trapRegistry
	local holeIndex

	for i = 1, table.maxn(trapList) do
		local trapObject = trapList[i]

		if trapRegistry[trapObject] == nil then
			trapList[i] = nil

			if holeIndex == nil then
				holeIndex = i
			end
		elseif holeIndex ~= nil then
			trapList[holeIndex] = trapObject
			trapList[i] = nil
			holeIndex = holeIndex + 1
		end
	end

	return self._trapList
end

function CellAgent:selectBuffObjects(condition)
	local trapList = self._trapList

	if trapList == nil then
		return {}, 0
	end

	local trapRegistry = self._trapRegistry
	local matchedTraps, matchedCount = {}, 0
	local holeIndex

	for i = 1, table.maxn(trapList) do
		local trapObject = trapList[i]

		if trapRegistry[trapObject] == nil then
			trapList[i] = nil

			if holeIndex == nil then
				holeIndex = i
			end
		else
			if holeIndex ~= nil then
				trapList[holeIndex] = trapObject
				trapList[i] = nil
				holeIndex = holeIndex + 1
			end

			if condition == nil or condition(trapObject) then
				matchedCount = matchedCount + 1
				matchedTraps[matchedCount] = trapObject
			end
		end
	end

	return matchedTraps, matchedCount
end

function CellAgent:removeTrapObject(trapObject)
	assert(trapObject ~= nil, "Invalid arguments")

	if self._trapRegistry[trapObject] ~= trapObject then
		return nil
	end

	self._trapRegistry[trapObject] = nil

	return trapObject
end

function CellAgent:addImmuneTrapSelector(selector)
	if selector == nil then
		return nil
	end

	local immuneSelectors = self._immuneSelectors

	if immuneSelectors == nil then
		immuneSelectors = {}
		self._immuneSelectors = immuneSelectors
	end

	local cnt = immuneSelectors[selector]

	if cnt == nil then
		immuneSelectors[#immuneSelectors + 1] = selector
		immuneSelectors[selector] = 1
	else
		immuneSelectors[selector] = cnt + 1
	end

	return selector
end

function CellAgent:removeImmuneTrapSelector(selector)
	if selector == nil then
		return nil
	end

	local immuneSelectors = self._immuneSelectors

	if immuneSelectors == nil then
		return nil
	end

	local cnt = immuneSelectors[selector]

	if cnt == nil or cnt <= 0 then
		return nil
	end

	for i = 1, #immuneSelectors do
		if immuneSelectors[i] == selector then
			if cnt > 1 then
				immuneSelectors[selector] = cnt - 1

				return selector
			else
				immuneSelectors[selector] = nil

				return table.remove(immuneSelectors, i)
			end
		end
	end

	return nil
end

function CellAgent:isImmuneToTrapBuffObject(buffObject)
	local immuneSelectors = self._immuneSelectors

	if immuneSelectors == nil then
		return false
	end

	for i = 1, #immuneSelectors do
		local selector = immuneSelectors[i]

		if selector(buffObject) then
			return true
		end
	end

	return false
end
