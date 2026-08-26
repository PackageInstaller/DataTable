-- chunkname: @modules/logic/handbook/view/HandbookWeekWalkViewContainer.lua

module("modules.logic.handbook.view.HandbookWeekWalkViewContainer", package.seeall)

local HandbookWeekWalkViewContainer = class("HandbookWeekWalkViewContainer", BaseViewContainer)

function HandbookWeekWalkViewContainer:buildViews()
	local views = {}

	table.insert(views, HandbookWeekWalkView.New())
	table.insert(views, HandbookWeekWalkSceneView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookWeekWalkViewContainer:buildTabViews(tabContainerId)
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

function HandbookWeekWalkViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookWeekWalkViewContainer
