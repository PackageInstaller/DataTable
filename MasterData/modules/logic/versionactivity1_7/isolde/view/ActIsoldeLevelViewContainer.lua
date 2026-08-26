-- chunkname: @modules/logic/versionactivity1_7/isolde/view/ActIsoldeLevelViewContainer.lua

module("modules.logic.versionactivity1_7.isolde.view.ActIsoldeLevelViewContainer", package.seeall)

local ActIsoldeLevelViewContainer = class("ActIsoldeLevelViewContainer", BaseViewContainer)

function ActIsoldeLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActIsoldeLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActIsoldeLevelViewContainer:buildTabViews(tabContainerId)
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

function ActIsoldeLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Isolde)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Isolde
	})
end

return ActIsoldeLevelViewContainer
