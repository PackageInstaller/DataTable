-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/VersionActivityFixedDungeonReportFullViewContainer1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.VersionActivityFixedDungeonReportFullViewContainer1", package.seeall)

local VersionActivityFixedDungeonReportFullViewContainer1 = class("VersionActivityFixedDungeonReportFullViewContainer1", BaseViewContainer)

function VersionActivityFixedDungeonReportFullViewContainer1:buildViews()
	local views = {}
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local reportFullView = VersionActivityFixedHelper.getVersionActivityDungeonReportFullView(bigVersion, smallVersion, scriptSuffix)

	table.insert(views, reportFullView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivityFixedDungeonReportFullViewContainer1:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return VersionActivityFixedDungeonReportFullViewContainer1
