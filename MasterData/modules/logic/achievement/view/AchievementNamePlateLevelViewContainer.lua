-- chunkname: @modules/logic/achievement/view/AchievementNamePlateLevelViewContainer.lua

module("modules.logic.achievement.view.AchievementNamePlateLevelViewContainer", package.seeall)

local AchievementNamePlateLevelViewContainer = class("AchievementNamePlateLevelViewContainer", BaseViewContainer)

function AchievementNamePlateLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, AchievementNamePlateLevelView.New())

	return views
end

return AchievementNamePlateLevelViewContainer
