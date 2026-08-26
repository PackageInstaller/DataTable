-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/graffiti/VersionActivity2_0DungeonGraffitiViewContainer.lua

module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiViewContainer", package.seeall)

local VersionActivity2_0DungeonGraffitiViewContainer = class("VersionActivity2_0DungeonGraffitiViewContainer", BaseViewContainer)

function VersionActivity2_0DungeonGraffitiViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_0DungeonGraffitiView.New())
	table.insert(views, VersionActivity2_0DungeonGraffitiRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity2_0DungeonGraffitiViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

function VersionActivity2_0DungeonGraffitiViewContainer:_overrideCloseFunc()
	return
end

return VersionActivity2_0DungeonGraffitiViewContainer
