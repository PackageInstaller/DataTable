-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiLevelViewContainer.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiLevelViewContainer", package.seeall)

local DianJiShiLevelViewContainer = class("DianJiShiLevelViewContainer", BaseViewContainer)

function DianJiShiLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, DianJiShiLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function DianJiShiLevelViewContainer:buildTabViews(tabContainerId)
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

function DianJiShiLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_8Enum.ActivityId.DianJiShi)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_8Enum.ActivityId.DianJiShi
	})
end

return DianJiShiLevelViewContainer
