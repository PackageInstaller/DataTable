-- chunkname: @modules/logic/main/view/FeedBackViewContainer.lua

module("modules.logic.main.view.FeedBackViewContainer", package.seeall)

local FeedBackViewContainer = class("FeedBackViewContainer", BaseViewContainer)

function FeedBackViewContainer:buildViews()
	return {
		FeedBackView.New(),
		TabViewGroup.New(1, "browser")
	}
end

function FeedBackViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigationView
	}
end

function FeedBackViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_feedback_close)
end

return FeedBackViewContainer
