-- chunkname: @modules/logic/versionactivity2_0/joe/view/ActJoeLevelViewContainer.lua

module("modules.logic.versionactivity2_0.joe.view.ActJoeLevelViewContainer", package.seeall)

local ActJoeLevelViewContainer = class("ActJoeLevelViewContainer", BaseViewContainer)

function ActJoeLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActJoeLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActJoeLevelViewContainer:buildTabViews(tabContainerId)
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

function ActJoeLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_0Enum.ActivityId.Joe)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_0Enum.ActivityId.Joe
	})
end

return ActJoeLevelViewContainer
