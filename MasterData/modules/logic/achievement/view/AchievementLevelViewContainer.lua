-- chunkname: @modules/logic/achievement/view/AchievementLevelViewContainer.lua

module("modules.logic.achievement.view.AchievementLevelViewContainer", package.seeall)

local AchievementLevelViewContainer = class("AchievementLevelViewContainer", BaseViewContainer)

function AchievementLevelViewContainer:buildViews()
	return {
		AchievementLevelView.New()
	}
end

return AchievementLevelViewContainer
