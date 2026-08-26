-- chunkname: @modules/logic/versionactivity3_6/enter/view/VersionActivity3_6EnterViewContainer.lua

module("modules.logic.versionactivity3_6.enter.view.VersionActivity3_6EnterViewContainer", package.seeall)

local VersionActivity3_6EnterViewContainer = class("VersionActivity3_6EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity3_6EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity3_6EnterBgmView.New()
	}
end

function VersionActivity3_6EnterViewContainer:getMultiViews()
	return {
		VersionActivity3_6DungeonEnterView.New(),
		V3a2_BossRush_EnterView.New(),
		AbyssEnterView.New(),
		V3a6YaMiEnterView.New()
	}
end

return VersionActivity3_6EnterViewContainer
