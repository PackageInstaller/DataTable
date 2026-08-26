-- chunkname: @modules/logic/handbook/view/HandbookViewContainer.lua

module("modules.logic.handbook.view.HandbookViewContainer", package.seeall)

local HandbookViewContainer = class("HandbookViewContainer", BaseViewContainer)

function HandbookViewContainer:buildViews()
	local views = {}

	table.insert(views, HandbookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookViewContainer:buildTabViews(tabContainerId)
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

function HandbookViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookViewContainer
