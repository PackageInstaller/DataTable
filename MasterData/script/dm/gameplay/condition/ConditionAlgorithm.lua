-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/condition/ConditionAlgorithm.lua

ConditionAlgorithm = class("ConditionAlgorithm", legs.Actor)

function ConditionAlgorithm:initialize(conditionkeeper)
	super.initialize(self)

	self._conditionkeeper = conditionkeeper

	self:register()
end

function ConditionAlgorithm:register()
	self._conditionkeeper:registerAlgorlthm("REACH", self.reach)
	self._conditionkeeper:registerAlgorlthm("REACHCOUNT", self.reachCount)
	self._conditionkeeper:registerAlgorlthm("LESSTHAN", self.lessThan)
end

function ConditionAlgorithm:reach(a, factor)
	return a >= factor[1]
end

function ConditionAlgorithm:reachCount(array, factor)
	local count = 0

	for i, value in pairs(array) do
		if value >= factor[1] then
			count = count + 1
		end
	end

	return count >= factor[2]
end

function ConditionAlgorithm:lessThan(a, factor)
	return a <= factor[1]
end
