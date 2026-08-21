-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopUtils.lua

local ShopUtils = {}

function ShopUtils.isLockedCommon(playerLevel, requiredLevel, conditionID)
	if requiredLevel ~= nil and playerLevel < requiredLevel then
		return true
	end

	if conditionID ~= nil then
		return ConditionLimitManager.inLimitState(conditionID)
	end

	return false
end

function ShopUtils.getLockHintCommon(playerLevel, requiredLevel, conditionID)
	if requiredLevel ~= nil and playerLevel < requiredLevel then
		return string.format(Lang.get(30568), requiredLevel)
	end

	if conditionID ~= nil and ConditionLimitManager.inLimitState(conditionID) then
		return ConditionLimitManager.getLimitUnlockDesc(conditionID) or Lang.get(195), ConditionLimitManager.getLimitUnlockDesc(conditionID, true)
	end

	return nil
end

return ShopUtils
