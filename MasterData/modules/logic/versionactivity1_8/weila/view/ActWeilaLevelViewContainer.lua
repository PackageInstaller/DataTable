-- chunkname: @modules/logic/versionactivity1_8/weila/view/ActWeilaLevelViewContainer.lua

module("modules.logic.versionactivity1_8.weila.view.ActWeilaLevelViewContainer", package.seeall)

local ActWeilaLevelViewContainer = class("ActWeilaLevelViewContainer", BaseViewContainer)

function ActWeilaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActWeilaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActWeilaLevelViewContainer:buildTabViews(tabContainerId)
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

function ActWeilaLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_8Enum.ActivityId.Weila)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_8Enum.ActivityId.Weila
	})
end

return ActWeilaLevelViewContainer
