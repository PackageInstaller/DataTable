-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/BuffTargetAgent.lua

BuffTargetAgent = class("BuffTargetAgent")

BuffTargetAgent:has("_enterBuffs", {
	is = "rw"
})

function BuffTargetAgent:initialize(targetObject)
	super.initialize(self)

	self._targetObject = targetObject
	self._buffRegistry = {}
	self._buffList = nil
	self._buffGroups = nil
end

function BuffTargetAgent:getTargetObject()
	return self._targetObject
end

function BuffTargetAgent:getId()
	return self._targetObject and self._targetObject:getId()
end

function BuffTargetAgent:addBuffObject(buffObject)
	assert(buffObject ~= nil, "Invalid arguments")

	if self._buffRegistry[buffObject] ~= nil then
		return nil
	end

	self._buffRegistry[buffObject] = buffObject

	local buffList = self._buffList

	if buffList == nil then
		self._buffList = {
			buffObject
		}
	else
		buffList[table.maxn(buffList) + 1] = buffObject
	end

	return buffObject
end

function BuffTargetAgent:hasBuffObject(buffObject)
	return self._buffRegistry[buffObject] ~= nil
end

function BuffTargetAgent:removeBuffObject(buffObject)
	assert(buffObject ~= nil, "Invalid arguments")

	if self._buffRegistry[buffObject] ~= buffObject then
		return nil
	end

	self._buffRegistry[buffObject] = nil

	return buffObject
end

function BuffTargetAgent:removeBuffObjectsWithCondition(condition)
	local buffList = self._buffList

	if buffList == nil then
		return nil
	end

	local buffRegistry = self._buffRegistry

	if condition == nil then
		self._buffList = nil

		local holeIndex

		for i = 1, table.maxn(buffList) do
			local buffObject = buffList[i]

			if buffRegistry[buffObject] == nil then
				buffList[i] = nil

				if holeIndex == nil then
					holeIndex = i
				end
			else
				buffRegistry[buffObject] = nil

				if holeIndex ~= nil then
					buffList[holeIndex] = buffObject
					buffList[i] = nil
					holeIndex = holeIndex + 1
				end
			end
		end

		return buffList
	end

	local removedBuffs = {}
	local holeIndex

	for i = 1, table.maxn(buffList) do
		local buffObject = buffList[i]

		if buffRegistry[buffObject] == nil then
			buffList[i] = nil

			if holeIndex == nil then
				holeIndex = i
			end
		elseif condition(buffObject) then
			buffRegistry[buffObject] = nil
			removedBuffs[#removedBuffs + 1] = buffObject
			buffList[i] = nil

			if holeIndex == nil then
				holeIndex = i
			end
		elseif holeIndex ~= nil then
			buffList[holeIndex] = buffObject
			buffList[i] = nil
			holeIndex = holeIndex + 1
		end
	end

	return removedBuffs
end

function BuffTargetAgent:selectBuffObjects(condition)
	local buffList = self._buffList

	if buffList == nil then
		return {}, 0
	end

	local buffRegistry = self._buffRegistry
	local matchedBuffs, matchedCount = {}, 0
	local holeIndex

	for i = 1, table.maxn(buffList) do
		local buffObject = buffList[i]

		if buffRegistry[buffObject] == nil then
			buffList[i] = nil

			if holeIndex == nil then
				holeIndex = i
			end
		else
			if holeIndex ~= nil then
				buffList[holeIndex] = buffObject
				buffList[i] = nil
				holeIndex = holeIndex + 1
			end

			if condition == nil or condition(buffObject) then
				matchedCount = matchedCount + 1
				matchedBuffs[matchedCount] = buffObject
			end
		end
	end

	return matchedBuffs, matchedCount
end

function BuffTargetAgent:retrieveBuffGroup(groupId)
	if groupId == nil then
		return nil
	end

	local buffGroups = self._buffGroups

	if buffGroups == nil then
		buffGroups = {}
		self._buffGroups = buffGroups
	end

	return buffGroups[groupId]
end

function BuffTargetAgent:createBuffGroup(groupId, buffObject)
	if groupId == nil then
		return nil
	end

	local buffGroups = self._buffGroups

	if buffGroups == nil then
		buffGroups = {}
		self._buffGroups = buffGroups
	end

	local buffGroup = buffGroups[groupId]

	if buffGroup == nil and groupId ~= nil and buffObject then
		buffGroup = BuffGroup:new(buffObject)

		buffGroup:setGroupId(groupId)

		buffGroups[groupId] = buffGroup
	end

	return buffGroup
end

function BuffTargetAgent:discardBuffGroup(groupId)
	local buffGroups = self._buffGroups

	if buffGroups == nil or groupId == nil then
		return nil
	end

	buffGroups[groupId] = nil

	return buffGroups[groupId]
end

function BuffTargetAgent:addImmuneSelector(selector, bufftype)
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
		immuneSelectors[#immuneSelectors + 1] = {
			selector = selector,
			bufftype = bufftype or "normal"
		}
		immuneSelectors[selector] = 1
	else
		immuneSelectors[selector] = cnt + 1
	end

	return selector
end

function BuffTargetAgent:removeImmuneSelector(selector)
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
		if immuneSelectors[i].selector == selector then
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

function BuffTargetAgent:isImmuneToBuffObject(buffObject)
	local immuneSelectors = self._immuneSelectors

	if immuneSelectors == nil then
		return false
	end

	for i = 1, #immuneSelectors do
		if immuneSelectors[i].bufftype == "normal" then
			-- block empty
		end

		::label_14_0::
	end

	return false
end

function BuffTargetAgent:isImmuneToTrapBuffObject(buffObject)
	local immuneSelectors = self._immuneSelectors

	if immuneSelectors == nil then
		return false
	end

	for i = 1, #immuneSelectors do
		if immuneSelectors[i].bufftype == "trap" then
			-- block empty
		end

		::label_15_0::
	end

	return false
end
