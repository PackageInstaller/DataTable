-- chunkname: @modules/logic/versionactivity3_7/xruianyi/view/XRuiAnYiLevelViewContainer.lua

module("modules.logic.versionactivity3_7.xruianyi.view.XRuiAnYiLevelViewContainer", package.seeall)

local XRuiAnYiLevelViewContainer = class("XRuiAnYiLevelViewContainer", BaseViewContainer)

function XRuiAnYiLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, XRuiAnYiLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function XRuiAnYiLevelViewContainer:buildTabViews(tabContainerId)
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

function XRuiAnYiLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_7Enum.ActivityId.XRuiAnYi)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_7Enum.ActivityId.XRuiAnYi
	})
end

return XRuiAnYiLevelViewContainer
