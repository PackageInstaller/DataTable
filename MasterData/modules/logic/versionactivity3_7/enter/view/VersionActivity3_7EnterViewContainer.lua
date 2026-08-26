-- chunkname: @modules/logic/versionactivity3_7/enter/view/VersionActivity3_7EnterViewContainer.lua

module("modules.logic.versionactivity3_7.enter.view.VersionActivity3_7EnterViewContainer", package.seeall)

local VersionActivity3_7EnterViewContainer = class("VersionActivity3_7EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_7EnterViewContainer:getViews()
	return {
		VersionActivity3_7EnterView.New(),
		VersionActivity3_7EnterBgmView.New()
	}
end

function VersionActivity3_7EnterViewContainer:getMultiViews()
	return {
		VersionActivity3_7DungeonEnterView.New(),
		VersionActivity3_7SodacheEnterView.New(),
		ArcadeEnterView.New(),
		V3a2_BossRush_EnterView.New(),
		VersionActivity3_7XRuiAnYiEnterView.New(),
		RoleStoryEnterView.New(),
		Rouge2_ActivityView.New(),
		AbyssEnterView.New(),
		V3a7_Wmz_EnterView.New()
	}
end

return VersionActivity3_7EnterViewContainer
