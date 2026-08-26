-- chunkname: @modules/logic/versionactivity3_2/enter/view/VersionActivity3_2EnterViewContainer.lua

module("modules.logic.versionactivity3_2.enter.view.VersionActivity3_2EnterViewContainer", package.seeall)

local VersionActivity3_2EnterViewContainer = class("VersionActivity3_2EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_2EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_2EnterBgmView.New()
	}
end

function VersionActivity3_2EnterViewContainer:getMultiViews()
	return {
		VersionActivity3_2DungeonEnterView.New(),
		RoleStoryEnterView.New(),
		V3a2_BossRush_EnterView.New(),
		VersionActivity3_2BeiLiErEnterView.New(),
		VersionActivity3_2HuiDiaoLanEnterView.New(),
		AutoChessEnterView.New(),
		Rouge2_ActivityView.New()
	}
end

return VersionActivity3_2EnterViewContainer
