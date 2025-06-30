-- chunkname: @IQIGame\\Module\\Condition\\MemoryStory\\MemoryStoryConditionModule.lua

local m = {}

m[Constant.ConditionConstant.TYPE_MEMORY_STORY] = require("IQIGame.Module.Condition.MemoryStory.MemoryStoryConditionChecker")

function m.__CheckInner(type, subType, params, comparisonOP, targetValue)
	if not MemoryStoryModule.InMemoryStoryScene then
		logError("Condition module : current is not in memory story scene")

		return false, nil
	end

	local Checker = m[type]

	if Checker == nil then
		logError("Condition module : type does not exist : {0}.", type)

		return false, nil
	end

	local func = Checker[subType]

	if func == nil then
		logError("Condition module : sub type does not exist : {0}.", subType)

		return false, nil
	end

	return func(params, comparisonOP, targetValue)
end

return m
