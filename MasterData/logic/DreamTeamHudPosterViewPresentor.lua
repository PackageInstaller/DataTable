-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudPosterViewPresentor.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudPosterViewPresentor", package.seeall)

local DreamTeamHudPosterViewPresentor = class("DreamTeamHudPosterViewPresentor", ViewPresentor)

function DreamTeamHudPosterViewPresentor:ctor()
	DreamTeamHudPosterViewPresentor.super.ctor(self)
end

function DreamTeamHudPosterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamHudPosterViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamhud/dreamteamhudposterview.prefab"
	}
end

function DreamTeamHudPosterViewPresentor:buildViews()
	return {
		DreamTeamHudPosterView.New()
	}
end

return DreamTeamHudPosterViewPresentor
