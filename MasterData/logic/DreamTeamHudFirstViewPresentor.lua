-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudFirstViewPresentor.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudFirstViewPresentor", package.seeall)

local DreamTeamHudFirstViewPresentor = class("DreamTeamHudFirstViewPresentor", ViewPresentor)

function DreamTeamHudFirstViewPresentor:ctor()
	DreamTeamHudFirstViewPresentor.super.ctor(self)
end

function DreamTeamHudFirstViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamHudFirstViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamhud/dreamteamhudfirstview.prefab"
	}
end

function DreamTeamHudFirstViewPresentor:buildViews()
	return {
		DreamTeamHudFirstView.New()
	}
end

return DreamTeamHudFirstViewPresentor
