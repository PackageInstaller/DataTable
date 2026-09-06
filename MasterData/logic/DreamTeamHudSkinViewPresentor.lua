-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudSkinViewPresentor.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudSkinViewPresentor", package.seeall)

local DreamTeamHudSkinViewPresentor = class("DreamTeamHudSkinViewPresentor", ViewPresentor)

function DreamTeamHudSkinViewPresentor:ctor()
	DreamTeamHudSkinViewPresentor.super.ctor(self)
end

function DreamTeamHudSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamHudSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamhud/dreamteamhudskinview.prefab"
	}
end

function DreamTeamHudSkinViewPresentor:buildViews()
	return {
		DreamTeamHudSkinView.New()
	}
end

return DreamTeamHudSkinViewPresentor
