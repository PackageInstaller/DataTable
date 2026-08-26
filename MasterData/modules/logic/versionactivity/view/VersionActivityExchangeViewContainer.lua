-- chunkname: @modules/logic/versionactivity/view/VersionActivityExchangeViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityExchangeViewContainer", package.seeall)

local VersionActivityExchangeViewContainer = class("VersionActivityExchangeViewContainer", BaseViewContainer)

function VersionActivityExchangeViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, VersionActivityExchangeView.New())

	return views
end

function VersionActivityExchangeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	end
end

function VersionActivityExchangeViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act112)
end

return VersionActivityExchangeViewContainer
