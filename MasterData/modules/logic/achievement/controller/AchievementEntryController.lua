-- chunkname: @modules/logic/achievement/controller/AchievementEntryController.lua

module("modules.logic.achievement.controller.AchievementEntryController", package.seeall)

local AchievementEntryController = class("AchievementEntryController", BaseController)

function AchievementEntryController:onOpenView()
	AchievementEntryModel.instance:initData()
end

function AchievementEntryController:onCloseView()
	return
end

function AchievementEntryController:updateAchievementState()
	AchievementEntryModel.instance:initData()
end

AchievementEntryController.instance = AchievementEntryController.New()

return AchievementEntryController
