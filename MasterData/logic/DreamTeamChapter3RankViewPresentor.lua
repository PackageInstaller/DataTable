-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter3RankViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter3RankViewPresentor", package.seeall)

local DreamTeamChapter3RankViewPresentor = class("DreamTeamChapter3RankViewPresentor", ViewPresentor)

function DreamTeamChapter3RankViewPresentor:ctor()
	DreamTeamChapter3RankViewPresentor.super.ctor(self)
end

function DreamTeamChapter3RankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapter3RankViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapter3rankview.prefab"
	}
end

function DreamTeamChapter3RankViewPresentor:buildViews()
	return {
		DreamTeamChapter3RankView.New()
	}
end

return DreamTeamChapter3RankViewPresentor
