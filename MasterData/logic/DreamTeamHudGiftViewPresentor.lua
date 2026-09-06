-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudGiftViewPresentor.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudGiftViewPresentor", package.seeall)

local DreamTeamHudGiftViewPresentor = class("DreamTeamHudGiftViewPresentor", ViewPresentor)

function DreamTeamHudGiftViewPresentor:ctor()
	DreamTeamHudGiftViewPresentor.super.ctor(self)
end

function DreamTeamHudGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamHudGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamhud/dreamteamhudgiftview.prefab"
	}
end

function DreamTeamHudGiftViewPresentor:buildViews()
	return {
		DreamTeamHudGiftView.New()
	}
end

return DreamTeamHudGiftViewPresentor
