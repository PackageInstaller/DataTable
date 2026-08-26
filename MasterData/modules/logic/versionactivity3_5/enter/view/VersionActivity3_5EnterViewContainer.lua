-- chunkname: @modules/logic/versionactivity3_5/enter/view/VersionActivity3_5EnterViewContainer.lua

module("modules.logic.versionactivity3_5.enter.view.VersionActivity3_5EnterViewContainer", package.seeall)

local VersionActivity3_5EnterViewContainer = class("VersionActivity3_5EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_5EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_5EnterBgmView.New()
	}
end

function VersionActivity3_5EnterViewContainer:getMultiViews()
	return {
		VersionActivity3_5DungeonEnterView.New(),
		V3a2_BossRush_EnterView.New(),
		V3a5_v2a7_ReactivityEnterview.New(),
		VersionActivity3_5LamonaEnterView.New(),
		VersionActivity3_5LorentzEnterView.New(),
		RoleStoryEnterView.New(),
		AutoChessEnterView.New(),
		V3a5_Season123EnterView.New()
	}
end

return VersionActivity3_5EnterViewContainer
