-- chunkname: @modules/logic/achievement/view/AchievementGroupPreViewContainer.lua

module("modules.logic.achievement.view.AchievementGroupPreViewContainer", package.seeall)

local AchievementGroupPreViewContainer = class("AchievementGroupPreViewContainer", BaseViewContainer)

function AchievementGroupPreViewContainer:buildViews()
	return {
		AchievementGroupPreView.New()
	}
end

return AchievementGroupPreViewContainer
