-- chunkname: @modules/logic/versionactivity1_8/windsong/view/ActWindSongLevelViewContainer.lua

module("modules.logic.versionactivity1_8.windsong.view.ActWindSongLevelViewContainer", package.seeall)

local ActWindSongLevelViewContainer = class("ActWindSongLevelViewContainer", BaseViewContainer)

function ActWindSongLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActWindSongLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActWindSongLevelViewContainer:buildTabViews(tabContainerId)
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

function ActWindSongLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_8Enum.ActivityId.WindSong)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_8Enum.ActivityId.WindSong
	})
end

return ActWindSongLevelViewContainer
