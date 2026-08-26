-- chunkname: @modules/logic/versionactivity/view/VersionActivityPushBoxLevelViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityPushBoxLevelViewContainer", package.seeall)

local VersionActivityPushBoxLevelViewContainer = class("VersionActivityPushBoxLevelViewContainer", BaseViewContainer)

function VersionActivityPushBoxLevelViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		VersionActivityPushBoxLevelView.New()
	}
end

function VersionActivityPushBoxLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

function VersionActivityPushBoxLevelViewContainer:onContainerOpen()
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act111)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act111
	})
end

return VersionActivityPushBoxLevelViewContainer
