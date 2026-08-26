-- chunkname: @modules/logic/versionactivity1_9/lucy/view/ActLucyLevelViewContainer.lua

module("modules.logic.versionactivity1_9.lucy.view.ActLucyLevelViewContainer", package.seeall)

local ActLucyLevelViewContainer = class("ActLucyLevelViewContainer", BaseViewContainer)

function ActLucyLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActLucyLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActLucyLevelViewContainer:buildTabViews(tabContainerId)
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

function ActLucyLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.Lucy)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.Lucy
	})
end

return ActLucyLevelViewContainer
