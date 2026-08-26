-- chunkname: @modules/logic/versionactivity3_4/enter/view/VersionActivity3_4EnterViewContainer.lua

module("modules.logic.versionactivity3_4.enter.view.VersionActivity3_4EnterViewContainer", package.seeall)

local VersionActivity3_4EnterViewContainer = class("VersionActivity3_4EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_4EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_4EnterBgmView.New()
	}
end

function VersionActivity3_4EnterViewContainer:getMultiViews()
	return {
		VersionActivity3_4DungeonEnterView.New(),
		V3a2_BossRush_EnterView.New(),
		VersionActivity3_4PartyGameEnterView.New(),
		SurvivalEnterView.New(),
		RoleStoryEnterView.New(),
		LuSiJianEnterView.New(),
		V3a4_v2a5_ReactivityEnterview.New(),
		Rouge2_ActivityView.New(),
		V3a4_Chg_EnterView.New()
	}
end

return VersionActivity3_4EnterViewContainer
