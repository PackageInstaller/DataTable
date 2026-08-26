-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueViewContainer", package.seeall)

local AergusiClueViewContainer = class("AergusiClueViewContainer", BaseViewContainer)

function AergusiClueViewContainer:buildViews()
	return {
		AergusiClueMergeView.New(),
		AergusiClueListView.New(),
		AergusiClueDetailView.New(),
		AergusiClueView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function AergusiClueViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function AergusiClueViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New()

	if self.viewParam and self.viewParam.episodeId then
		navigateView:setParam({
			true,
			false,
			false
		})
	else
		navigateView:setParam({
			true,
			true,
			false
		})
	end

	navigateView:setOverrideClose(self.overrideOnCloseClick, self)

	return {
		navigateView
	}
end

function AergusiClueViewContainer:overrideOnCloseClick()
	if self.viewParam and self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj, -1)
	end

	self:closeThis()
end

return AergusiClueViewContainer
