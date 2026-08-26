-- chunkname: @modules/logic/achievement/view/AchievementEntryViewContainer.lua

module("modules.logic.achievement.view.AchievementEntryViewContainer", package.seeall)

local AchievementEntryViewContainer = class("AchievementEntryViewContainer", BaseViewContainer)

function AchievementEntryViewContainer:buildViews()
	return {
		AchievementEntryView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function AchievementEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self.closeCallback)

		return {
			self.navigateView
		}
	end
end

function AchievementEntryViewContainer:closeCallback()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_close)
end

return AchievementEntryViewContainer
