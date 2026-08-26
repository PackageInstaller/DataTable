-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmMainViewContainer.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmMainViewContainer", package.seeall)

local ArmMainViewContainer = class("ArmMainViewContainer", BaseViewContainer)

function ArmMainViewContainer:buildViews()
	return {
		ArmMainView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function ArmMainViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function ArmMainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act305)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act305
	})
end

return ArmMainViewContainer
