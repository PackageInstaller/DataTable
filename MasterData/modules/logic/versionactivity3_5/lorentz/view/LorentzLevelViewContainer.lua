-- chunkname: @modules/logic/versionactivity3_5/lorentz/view/LorentzLevelViewContainer.lua

module("modules.logic.versionactivity3_5.lorentz.view.LorentzLevelViewContainer", package.seeall)

local LorentzLevelViewContainer = class("LorentzLevelViewContainer", BaseViewContainer)

function LorentzLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, LorentzLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function LorentzLevelViewContainer:buildTabViews(tabContainerId)
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

function LorentzLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_5Enum.ActivityId.Lorentz)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_5Enum.ActivityId.Lorentz
	})
end

return LorentzLevelViewContainer
