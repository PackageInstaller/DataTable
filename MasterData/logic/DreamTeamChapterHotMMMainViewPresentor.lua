-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterHotMMMainViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterHotMMMainViewPresentor", package.seeall)

local DreamTeamChapterHotMMMainViewPresentor = class("DreamTeamChapterHotMMMainViewPresentor", ViewPresentor)

function DreamTeamChapterHotMMMainViewPresentor:ctor()
	DreamTeamChapterHotMMMainViewPresentor.super.ctor(self)
end

function DreamTeamChapterHotMMMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterHotMMMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapterhotmmmainview.prefab"
	}
end

function DreamTeamChapterHotMMMainViewPresentor:buildViews()
	return {
		DreamTeamChapterHotMMMainView.New()
	}
end

return DreamTeamChapterHotMMMainViewPresentor
