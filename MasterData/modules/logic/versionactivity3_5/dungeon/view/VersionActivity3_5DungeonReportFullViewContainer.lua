-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/VersionActivity3_5DungeonReportFullViewContainer.lua

module("modules.logic.versionactivity3_5.dungeon.view.VersionActivity3_5DungeonReportFullViewContainer", package.seeall)

local VersionActivity3_5DungeonReportFullViewContainer = class("VersionActivity3_5DungeonReportFullViewContainer", BaseViewContainer)

function VersionActivity3_5DungeonReportFullViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_5DungeonReportFullView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity3_5DungeonReportFullViewContainer:buildTabViews(tabContainerId)
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

return VersionActivity3_5DungeonReportFullViewContainer
