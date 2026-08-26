-- chunkname: @modules/logic/versionactivity2_0/mercuria/view/ActMercuriaLevelViewContainer.lua

module("modules.logic.versionactivity2_0.mercuria.view.ActMercuriaLevelViewContainer", package.seeall)

local ActMercuriaLevelViewContainer = class("ActMercuriaLevelViewContainer", BaseViewContainer)

function ActMercuriaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActMercuriaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActMercuriaLevelViewContainer:buildTabViews(tabContainerId)
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

function ActMercuriaLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_0Enum.ActivityId.Mercuria)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_0Enum.ActivityId.Mercuria
	})
end

return ActMercuriaLevelViewContainer
