-- chunkname: @modules/logic/versionactivity3_9/enter/view/VersionActivity3_9EnterViewContainer.lua

module("modules.logic.versionactivity3_9.enter.view.VersionActivity3_9EnterViewContainer", package.seeall)

local VersionActivity3_9EnterViewContainer = class("VersionActivity3_9EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_9EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_9EnterBgmView.New()
	}
end

function VersionActivity3_9EnterViewContainer:getMultiViews()
	local dungeonEnterView = VersionActivityFixedHelper.getVersionActivityDungeonEnterView(3, 9)

	return {
		dungeonEnterView.New(),
		VersionActivity3_9HedoneEnterView.New(),
		VersionActivity3_9NaxisuosiEnterView.New(),
		VersionActivity3_9PartyGameEnterView.New(),
		V3a9_v3a2_ReactivityEnterview.New(),
		RougeActivityView.New(),
		RoleStoryEnterView.New(),
		V3a9_BossRush_EnterRootView.New()
	}
end

return VersionActivity3_9EnterViewContainer
