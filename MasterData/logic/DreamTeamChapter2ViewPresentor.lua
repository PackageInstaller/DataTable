-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter2ViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter2ViewPresentor", package.seeall)

local DreamTeamChapter2ViewPresentor = class("DreamTeamChapter2ViewPresentor", ViewPresentor)

function DreamTeamChapter2ViewPresentor:ctor()
	DreamTeamChapter2ViewPresentor.super.ctor(self)
end

function DreamTeamChapter2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapter2ViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapter2view.prefab"
	}
end

function DreamTeamChapter2ViewPresentor:buildViews()
	return {
		DreamTeamChapter2View.New()
	}
end

return DreamTeamChapter2ViewPresentor
