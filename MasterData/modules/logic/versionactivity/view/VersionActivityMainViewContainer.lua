-- chunkname: @modules/logic/versionactivity/view/VersionActivityMainViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityMainViewContainer", package.seeall)

local VersionActivityMainViewContainer = class("VersionActivityMainViewContainer", BaseViewContainer)

function VersionActivityMainViewContainer:buildViews()
	return {
		VersionActivityMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivityMainViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	self.navigateView:setOverrideClose(self.overClose, self)

	return {
		self.navigateView
	}
end

function VersionActivityMainViewContainer:overClose()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapView)
end

return VersionActivityMainViewContainer
