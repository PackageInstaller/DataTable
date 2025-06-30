-- chunkname: @IQIGame\\Module\\Condition\\Maze\\ItemConditionChecker.lua

local m = {}

function m.Check(type, subType, params, comparison, targetValue)
	local checkResult = false
	local checkFailedReasonType

	if subType == Constant.ConditionConstant.SUB_TYPE_ITEM_ID then
		checkResult = ConditionModule.ComparisonValue(MazeDataModule.GetItemNumByCfgID(params[1]), targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ITEM, CfgItemTable[params[1]].Name)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_HAS_ITEM then
		local itemType = params[1]
		local itemSubType = params[2]

		for i = 1, #MazeDataModule.Items do
			if MazeDataModule.Items[i].Type == itemType and MazeDataModule.Items[i].SubType == itemSubType then
				checkResult = true

				break
			end
		end

		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ITEM, CfgItemTable[params[1]].Name)
	else
		logError("error condition type : " .. type .. ", subType : " .. subType)
	end

	return checkResult, checkFailedReasonType
end

return m
