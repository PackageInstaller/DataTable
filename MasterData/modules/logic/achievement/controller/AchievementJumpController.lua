-- chunkname: @modules/logic/achievement/controller/AchievementJumpController.lua

module("modules.logic.achievement.controller.AchievementJumpController", package.seeall)

local AchievementJumpController = class("AchievementJumpController", BaseController)

function AchievementJumpController:jumpToAchievement(originJumpParamList)
	local jumpParamList = self:tryParaseParamsToNumber(originJumpParamList)
	local jumpType = jumpParamList and jumpParamList[2]
	local jumpHandleFunc = self:getJumpHandleFunc(jumpType)
	local isExcuteSucc = false

	if jumpHandleFunc then
		isExcuteSucc = jumpHandleFunc(unpack(jumpParamList))
	else
		logError(string.format("cannot find JumpHandleFunction, jumpType = %s", jumpType))
	end

	return isExcuteSucc
end

function AchievementJumpController:tryParaseParamsToNumber(originJumpParamList)
	local paramList = {}

	if originJumpParamList then
		for _, param in ipairs(originJumpParamList) do
			local numberParam = tonumber(param)

			if numberParam then
				table.insert(paramList, numberParam)
			else
				table.insert(paramList, param)
			end
		end
	end

	return paramList
end

function AchievementJumpController:getJumpHandleFunc(jumpType)
	return AchievementJumpController.instance["jumpHandleFunc_" .. tostring(jumpType)]
end

function AchievementJumpController.jumpHandleFunc_1(openId, jumpType, achievementId)
	local isOpenLevelView = true

	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Single, achievementId, isOpenLevelView)
end

function AchievementJumpController.jumpHandleFunc_2(openId, jumpType, groupId)
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Group, groupId)
end

function AchievementJumpController.jumpHandleFunc_3(openId, jumpType, categoryType)
	AchievementController.instance:openAchievementMainView(categoryType)
end

function AchievementJumpController.jumpHandleFunc_4(openId, jumpType, groupId, groupPreViewUrl)
	AchievementController.instance:openAchievementGroupPreView(groupId, groupPreViewUrl)
end

AchievementJumpController.instance = AchievementJumpController.New()

return AchievementJumpController
