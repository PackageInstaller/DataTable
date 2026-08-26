-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/VersionActivity3_4DungeonReportFullViewContainer.lua

module("modules.logic.versionactivity3_4.dungeon.view.VersionActivity3_4DungeonReportFullViewContainer", package.seeall)

local VersionActivity3_4DungeonReportFullViewContainer = class("VersionActivity3_4DungeonReportFullViewContainer", BaseViewContainer)

function VersionActivity3_4DungeonReportFullViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_4DungeonReportFullView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity3_4DungeonReportFullViewContainer:buildTabViews(tabContainerId)
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

return VersionActivity3_4DungeonReportFullViewContainer
