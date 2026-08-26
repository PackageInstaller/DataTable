-- chunkname: @modules/logic/versionactivity2_7/enter/view/VersionActivity2_7EnterViewContainer.lua

module("modules.logic.versionactivity2_7.enter.view.VersionActivity2_7EnterViewContainer", package.seeall)

local VersionActivity2_7EnterViewContainer = class("VersionActivity2_7EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity2_7EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity2_7EnterBgmView.New()
	}
end

function VersionActivity2_7EnterViewContainer:getMultiViews()
	return {
		VersionActivity2_7DungeonEnterView.New(),
		V2a7_Act191EnterView.New(),
		V2a6_CooperGarlandEnterView.New(),
		V2a7_LengZhou6EnterView.New(),
		V2a7_v2a0_ReactivityEnterview.New(),
		Act183VersionActivityEnterView.New(),
		RoleStoryEnterView.New()
	}
end

return VersionActivity2_7EnterViewContainer
