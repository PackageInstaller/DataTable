-- chunkname: @modules/logic/versionactivity4_0/enter/view/VersionActivity4_0EnterViewContainer.lua

module("modules.logic.versionactivity4_0.enter.view.VersionActivity4_0EnterViewContainer", package.seeall)

local VersionActivity4_0EnterViewContainer = class("VersionActivity4_0EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity4_0EnterViewContainer:getViews()
	return {
		VersionActivity4_0EnterView.New(),
		VersionActivity4_0EnterBgmView.New()
	}
end

function VersionActivity4_0EnterViewContainer:getMultiViews()
	return {
		VersionActivity4_0DungeonEnterView.New(),
		V3a2_BossRush_EnterView.New(),
		RoleStoryEnterView.New(),
		MatchGameVersionActivityEnterView.New(),
		AutoChessEnterView.New(),
		VersionActivity4_0SpLilyaEnterView.New(),
		VersionActivity4_0DeleikeEnterView.New()
	}
end

return VersionActivity4_0EnterViewContainer
