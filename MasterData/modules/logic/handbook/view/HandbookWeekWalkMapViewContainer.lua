-- chunkname: @modules/logic/handbook/view/HandbookWeekWalkMapViewContainer.lua

module("modules.logic.handbook.view.HandbookWeekWalkMapViewContainer", package.seeall)

local HandbookWeekWalkMapViewContainer = class("HandbookWeekWalkMapViewContainer", BaseViewContainer)

function HandbookWeekWalkMapViewContainer:buildViews()
	local views = {}

	table.insert(views, HandbookWeekWalkMapView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookWeekWalkMapViewContainer:buildTabViews(tabContainerId)
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

function HandbookWeekWalkMapViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookWeekWalkMapViewContainer
