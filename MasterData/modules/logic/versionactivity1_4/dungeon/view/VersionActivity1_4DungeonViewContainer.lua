-- chunkname: @modules/logic/versionactivity1_4/dungeon/view/VersionActivity1_4DungeonViewContainer.lua

module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonViewContainer", package.seeall)

local VersionActivity1_4DungeonViewContainer = class("VersionActivity1_4DungeonViewContainer", BaseViewContainer)

function VersionActivity1_4DungeonViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity1_4DungeonView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function VersionActivity1_4DungeonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return VersionActivity1_4DungeonViewContainer
