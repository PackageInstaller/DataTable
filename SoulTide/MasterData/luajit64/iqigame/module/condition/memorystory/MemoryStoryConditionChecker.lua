-- chunkname: @IQIGame\\Module\\Condition\\MemoryStory\\MemoryStoryConditionChecker.lua

local m = {}

m[Constant.ConditionConstant.SUB_TYPE_MEMORY_STORY_SUBMIT_TASK] = function(params, comparisonOP, targetValue)
	local taskId = tonumber(params[1])
	local value = MemoryStoryPlayerModule.HasSubmitTask(taskId) and 1 or 0

	log("[SUB_TYPE_MEMORY_STORY_SUBMIT_TASK] TaskId: " .. tostring(taskId) .. "[" .. tostring(value) .. tostring(comparisonOP) .. tostring(targetValue) .. "]")

	return ConditionModule.ComparisonValue(value, targetValue, comparisonOP), ""
end
m[Constant.ConditionConstant.SUB_TYPE_MEMORY_STORY_SUCCEED_TASK] = function(params, comparisonOP, targetValue)
	local taskId = tonumber(params[1])
	local value = MemoryStoryPlayerModule.HasTaskSucceed(taskId) and 1 or 0

	log("[SUB_TYPE_MEMORY_STORY_SUCCEED_TASK] TaskId: " .. tostring(taskId) .. "[" .. tostring(value) .. tostring(comparisonOP) .. tostring(targetValue) .. "]")

	return ConditionModule.ComparisonValue(value, targetValue, comparisonOP), ""
end
m[Constant.ConditionConstant.SUB_TYPE_MEMORY_STORY_RECEIVE_TASK] = function(params, comparisonOP, targetValue)
	local taskId = tonumber(params[1])
	local value = MemoryStoryPlayerModule.GetReceiveTaskData(taskId) ~= nil and 1 or 0

	log("[SUB_TYPE_MEMORY_STORY_RECEIVE_TASK] TaskId: " .. tostring(taskId) .. "[" .. tostring(value) .. tostring(comparisonOP) .. tostring(targetValue) .. "]")

	return ConditionModule.ComparisonValue(value, targetValue, comparisonOP), ""
end
m[Constant.ConditionConstant.SUB_TYPE_MEMORY_STORY_SCENE_HAS_ELEMENT] = function(params, comparisonOP, targetValue)
	local elementId = tonumber(params[1])
	local value = MemoryStoryModule.HasElement(elementId) and 1 or 0

	log("[SUB_TYPE_MEMORY_STORY_SCENE_HAS_ELEMENT] ElementId: " .. tostring(elementId) .. "[" .. tostring(value) .. tostring(comparisonOP) .. tostring(targetValue) .. "]")

	return ConditionModule.ComparisonValue(value, targetValue, comparisonOP), ""
end
m[Constant.ConditionConstant.SUB_TYPE_MEMORY_STORY_ITEM_STATE] = function(params, comparisonOP, targetValue)
	local itemId = tonumber(params[1])
	local ownerCount = MemoryStoryPlayerModule.GetItemCount(itemId)

	log("[SUB_TYPE_MEMORY_STORY_ITEM_STATE] ItemId: " .. tostring(itemId) .. "[" .. tostring(ownerCount) .. tostring(comparisonOP) .. tostring(targetValue) .. "]")

	return ConditionModule.ComparisonValue(ownerCount, targetValue, comparisonOP), ""
end

return m
