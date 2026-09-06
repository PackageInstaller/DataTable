-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterSummaryViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterSummaryViewPresentor", package.seeall)

local DreamTeamChapterSummaryViewPresentor = class("DreamTeamChapterSummaryViewPresentor", ViewPresentor)

function DreamTeamChapterSummaryViewPresentor:ctor()
	DreamTeamChapterSummaryViewPresentor.super.ctor(self)
end

function DreamTeamChapterSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterSummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchaptersummaryview.prefab"
	}
end

function DreamTeamChapterSummaryViewPresentor:buildViews()
	return {
		DreamTeamChapterSummaryView.New()
	}
end

return DreamTeamChapterSummaryViewPresentor
