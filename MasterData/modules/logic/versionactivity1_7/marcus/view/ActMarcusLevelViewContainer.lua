-- chunkname: @modules/logic/versionactivity1_7/marcus/view/ActMarcusLevelViewContainer.lua

module("modules.logic.versionactivity1_7.marcus.view.ActMarcusLevelViewContainer", package.seeall)

local ActMarcusLevelViewContainer = class("ActMarcusLevelViewContainer", BaseViewContainer)

function ActMarcusLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActMarcusLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActMarcusLevelViewContainer:buildTabViews(tabContainerId)
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

function ActMarcusLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Marcus)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Marcus
	})
end

return ActMarcusLevelViewContainer
