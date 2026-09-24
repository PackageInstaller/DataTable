-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeLevelViewContainer.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeLevelViewContainer", package.seeall)

local DeleikeLevelViewContainer = class("DeleikeLevelViewContainer", BaseViewContainer)

function DeleikeLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, DeleikeLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function DeleikeLevelViewContainer:buildTabViews(tabContainerId)
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

function DeleikeLevelViewContainer:onContainerInit()
	local actId = VersionActivity4_0Enum.ActivityId.Deleike

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return DeleikeLevelViewContainer
