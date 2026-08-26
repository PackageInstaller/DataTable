-- chunkname: @modules/logic/handbook/view/HandbookStoryViewContainer.lua

module("modules.logic.handbook.view.HandbookStoryViewContainer", package.seeall)

local HandbookStoryViewContainer = class("HandbookStoryViewContainer", BaseViewContainer)

function HandbookStoryViewContainer:buildViews()
	local views = {}

	table.insert(views, HandbookStoryView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookStoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function HandbookStoryViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_checkpoint_story_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookStoryViewContainer
