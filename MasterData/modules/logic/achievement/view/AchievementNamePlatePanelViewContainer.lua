-- chunkname: @modules/logic/achievement/view/AchievementNamePlatePanelViewContainer.lua

module("modules.logic.achievement.view.AchievementNamePlatePanelViewContainer", package.seeall)

local AchievementNamePlatePanelViewContainer = class("AchievementNamePlatePanelViewContainer", BaseViewContainer)

function AchievementNamePlatePanelViewContainer:buildViews()
	local views = {}

	table.insert(views, AchievementNamePlatePanelView.New())

	return views
end

return AchievementNamePlatePanelViewContainer
