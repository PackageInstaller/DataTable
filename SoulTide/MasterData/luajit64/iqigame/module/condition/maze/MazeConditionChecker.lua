-- chunkname: @IQIGame\\Module\\Condition\\Maze\\MazeConditionChecker.lua

local m = {}

function m.Check(type, subType, params, comparison, targetValue)
	local checkResult = false
	local checkFailedReasonType

	if subType == Constant.ConditionConstant.SUB_TYPE_MAZE_CURR_MAZE_CID then
		checkResult = ConditionModule.ComparisonValue(MazeDataModule.MazeInstanceID, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "inter error"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_MAZE_CURR_PATH_NODE_CID then
		checkResult = ConditionModule.ComparisonValue(MazeDataModule.LeaderElementPOD.NodeId, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "inter error"
	else
		logError("error condition type : " .. type .. ", subType : " .. subType)
	end

	return checkResult, checkFailedReasonType
end

return m
