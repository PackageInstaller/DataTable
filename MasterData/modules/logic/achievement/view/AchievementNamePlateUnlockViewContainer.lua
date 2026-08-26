-- chunkname: @modules/logic/achievement/view/AchievementNamePlateUnlockViewContainer.lua

module("modules.logic.achievement.view.AchievementNamePlateUnlockViewContainer", package.seeall)

local AchievementNamePlateUnlockViewContainer = class("AchievementNamePlateUnlockViewContainer", BaseViewContainer)

function AchievementNamePlateUnlockViewContainer:buildViews()
	local views = {}

	table.insert(views, AchievementNamePlateUnlockView.New())

	return views
end

return AchievementNamePlateUnlockViewContainer
