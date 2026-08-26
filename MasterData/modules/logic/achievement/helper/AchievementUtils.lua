-- chunkname: @modules/logic/achievement/helper/AchievementUtils.lua

module("modules.logic.achievement.helper.AchievementUtils", package.seeall)

local AchievementUtils = class("AchievementUtils")

AchievementUtils.SingleShowTag = "1"
AchievementUtils.GroupShowTag = "2"

function AchievementUtils.decodeShowStr(showStr)
	local singleSet = {}
	local groupSet = {}

	if string.nilorempty(showStr) then
		return singleSet, groupSet
	end

	local strArr = string.split(showStr, ",")

	for i = 1, #strArr do
		local setStr = strArr[i]

		if not string.nilorempty(setStr) then
			AchievementUtils.fillShowSet(singleSet, groupSet, setStr)
		end
	end

	return singleSet, groupSet
end

function AchievementUtils.fillShowSet(singleSet, groupSet, setStr)
	local showStrArr = string.split(setStr, ":")

	if #showStrArr >= 2 then
		local showTag = showStrArr[1]
		local showStr = showStrArr[2]
		local isGroup = showTag == AchievementUtils.GroupShowTag
		local targetSet = isGroup and groupSet or singleSet

		if not string.nilorempty(showStr) then
			local idList = string.splitToNumber(showStr, "#")

			if idList and #idList > 0 then
				for _, id in ipairs(idList) do
					table.insert(targetSet, id)
				end
			end
		end
	end
end

function AchievementUtils.encodeShowStr()
	return
end

function AchievementUtils.isActivityGroup(achievementId)
	local achievementCo = AchievementConfig.instance:getAchievement(achievementId)

	return achievementCo and achievementCo.category == AchievementEnum.Type.Activity
end

function AchievementUtils.isGamePlayGroup(achievementId)
	local achievementCo = AchievementConfig.instance:getAchievement(achievementId)

	return achievementCo and achievementCo.category == AchievementEnum.Type.GamePlay
end

function AchievementUtils.isShowByAchievementCfg(achievementCfg)
	if achievementCfg and not AchievementEnum.HideType[achievementCfg.category] then
		return true
	end

	return false
end

function AchievementUtils.getBgPrefabUrl(bgName, isPlayerCard)
	if isPlayerCard then
		return string.format("ui/viewres/achievement/mishihai/%s_mini.prefab", bgName)
	else
		return string.format("ui/viewres/achievement/mishihai/%s_bg.prefab", bgName)
	end
end

function AchievementUtils.getAchievementProgressBySourceType(sourceType, callback, callbackObj)
	if sourceType == AchievementEnum.SourceType.Tower then
		local curPassLayerId = TowerPermanentModel.instance:getCurPermanentPassLayer()
		local maxDeepHigh = TowerPermanentDeepModel.instance:getCurMaxDeepHigh()
		local defaultDeep = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
		local isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless

		if defaultDeep < maxDeepHigh or isOpenEndless or curPassLayerId > 50 then
			return maxDeepHigh
		else
			return curPassLayerId * 10
		end
	end
end

return AchievementUtils
