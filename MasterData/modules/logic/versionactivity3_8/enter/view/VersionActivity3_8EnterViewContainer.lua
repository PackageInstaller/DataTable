-- chunkname: @modules/logic/versionactivity3_8/enter/view/VersionActivity3_8EnterViewContainer.lua

module("modules.logic.versionactivity3_8.enter.view.VersionActivity3_8EnterViewContainer", package.seeall)

local VersionActivity3_8EnterViewContainer = class("VersionActivity3_8EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_8EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_8EnterBgmView.New()
	}
end

function VersionActivity3_8EnterViewContainer:getMultiViews()
	local dungeonEnterView = VersionActivityFixedHelper.getVersionActivityDungeonEnterView(3, 8)

	return {
		dungeonEnterView.New(),
		VersionActivity3_8EchoSongEnterView.New(),
		VersionActivity3_8DianJiShiEnterView.New(),
		V3a8_v3a1_ReactivityEnterview.New(),
		V3a2_BossRush_EnterView.New(),
		V3a1_Act191EnterView.New(),
		AbyssEnterView.New(),
		RoleStoryEnterView.New()
	}
end

return VersionActivity3_8EnterViewContainer
