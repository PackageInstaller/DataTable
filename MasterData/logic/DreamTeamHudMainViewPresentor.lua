-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudMainViewPresentor.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudMainViewPresentor", package.seeall)

local DreamTeamHudMainViewPresentor = class("DreamTeamHudMainViewPresentor", ViewPresentor)

function DreamTeamHudMainViewPresentor:ctor()
	DreamTeamHudMainViewPresentor.super.ctor(self)
end

function DreamTeamHudMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamHudMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamhud/dreamteamhudview.prefab"
	}
end

function DreamTeamHudMainViewPresentor:buildViews()
	return {
		DreamTeamHudMainView.New()
	}
end

return DreamTeamHudMainViewPresentor
