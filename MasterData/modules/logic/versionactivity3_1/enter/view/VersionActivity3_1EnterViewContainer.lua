-- chunkname: @modules/logic/versionactivity3_1/enter/view/VersionActivity3_1EnterViewContainer.lua

module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterViewContainer", package.seeall)

local VersionActivity3_1EnterViewContainer = class("VersionActivity3_1EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_1EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_1EnterBgmView.New()
	}
end

function VersionActivity3_1EnterViewContainer:getMultiViews()
	return {
		VersionActivity3_1DungeonEnterView.New(),
		V3a1_Act191EnterView.New(),
		SurvivalEnterView.New(),
		RoleStoryEnterView.New(),
		V3a1_YeShuMeiEnterView.New(),
		V1a6_BossRush_EnterView.New(),
		V3a1_v2a4_ReactivityEnterview.New(),
		V3a1_GaoSiNiao_EnterView.New()
	}
end

return VersionActivity3_1EnterViewContainer
