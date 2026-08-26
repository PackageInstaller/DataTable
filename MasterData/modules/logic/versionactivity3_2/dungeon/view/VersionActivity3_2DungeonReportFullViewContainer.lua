-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/VersionActivity3_2DungeonReportFullViewContainer.lua

module("modules.logic.versionactivity3_2.dungeon.view.VersionActivity3_2DungeonReportFullViewContainer", package.seeall)

local VersionActivity3_2DungeonReportFullViewContainer = class("VersionActivity3_2DungeonReportFullViewContainer", BaseViewContainer)

function VersionActivity3_2DungeonReportFullViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_2DungeonReportFullView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity3_2DungeonReportFullViewContainer:buildTabViews(tabContainerId)
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

return VersionActivity3_2DungeonReportFullViewContainer
