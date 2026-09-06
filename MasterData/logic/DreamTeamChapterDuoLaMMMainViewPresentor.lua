-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterDuoLaMMMainViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterDuoLaMMMainViewPresentor", package.seeall)

local DreamTeamChapterDuoLaMMMainViewPresentor = class("DreamTeamChapterDuoLaMMMainViewPresentor", ViewPresentor)

function DreamTeamChapterDuoLaMMMainViewPresentor:ctor()
	DreamTeamChapterDuoLaMMMainViewPresentor.super.ctor(self)
end

function DreamTeamChapterDuoLaMMMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterDuoLaMMMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapterduolammmainview.prefab"
	}
end

function DreamTeamChapterDuoLaMMMainViewPresentor:buildViews()
	return {
		DreamTeamChapterDuoLaMMMainView.New()
	}
end

return DreamTeamChapterDuoLaMMMainViewPresentor
