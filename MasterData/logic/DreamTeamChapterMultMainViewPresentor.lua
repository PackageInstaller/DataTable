-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterMultMainViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterMultMainViewPresentor", package.seeall)

local DreamTeamChapterMultMainViewPresentor = class("DreamTeamChapterMultMainViewPresentor", ViewPresentor)

function DreamTeamChapterMultMainViewPresentor:ctor()
	DreamTeamChapterMultMainViewPresentor.super.ctor(self)
end

function DreamTeamChapterMultMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterMultMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchaptermultmainview.prefab"
	}
end

function DreamTeamChapterMultMainViewPresentor:buildViews()
	return {
		DreamTeamChapterMultMainView.New()
	}
end

return DreamTeamChapterMultMainViewPresentor
