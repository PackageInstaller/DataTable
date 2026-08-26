-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaLevelViewContainer.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaLevelViewContainer", package.seeall)

local MarshaLevelViewContainer = class("MarshaLevelViewContainer", BaseViewContainer)

function MarshaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, MarshaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function MarshaLevelViewContainer:buildTabViews(tabContainerId)
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

function MarshaLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_3Enum.ActivityId.Marsha)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_3Enum.ActivityId.Marsha
	})
end

return MarshaLevelViewContainer
