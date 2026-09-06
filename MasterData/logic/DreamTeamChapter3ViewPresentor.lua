-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter3ViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter3ViewPresentor", package.seeall)

local DreamTeamChapter3ViewPresentor = class("DreamTeamChapter3ViewPresentor", ViewPresentor)

function DreamTeamChapter3ViewPresentor:ctor()
	DreamTeamChapter3ViewPresentor.super.ctor(self)
end

function DreamTeamChapter3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapter3ViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapter3view.prefab"
	}
end

function DreamTeamChapter3ViewPresentor:buildViews()
	return {
		DreamTeamChapter3View.New()
	}
end

return DreamTeamChapter3ViewPresentor
