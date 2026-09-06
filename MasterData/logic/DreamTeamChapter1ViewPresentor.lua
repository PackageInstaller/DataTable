-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter1ViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter1ViewPresentor", package.seeall)

local DreamTeamChapter1ViewPresentor = class("DreamTeamChapter1ViewPresentor", ViewPresentor)

function DreamTeamChapter1ViewPresentor:ctor()
	DreamTeamChapter1ViewPresentor.super.ctor(self)
end

function DreamTeamChapter1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapter1ViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapter1view.prefab"
	}
end

function DreamTeamChapter1ViewPresentor:buildViews()
	return {
		DreamTeamChapter1View.New()
	}
end

return DreamTeamChapter1ViewPresentor
