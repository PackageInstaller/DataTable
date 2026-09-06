-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterScriptKillBookViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterScriptKillBookViewPresentor", package.seeall)

local DreamTeamChapterScriptKillBookViewPresentor = class("DreamTeamChapterScriptKillBookViewPresentor", ViewPresentor)

function DreamTeamChapterScriptKillBookViewPresentor:ctor()
	DreamTeamChapterScriptKillBookViewPresentor.super.ctor(self)
end

function DreamTeamChapterScriptKillBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterScriptKillBookViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapterscriptkillbookview.prefab"
	}
end

function DreamTeamChapterScriptKillBookViewPresentor:buildViews()
	return {
		DreamTeamChapterScriptKillBookView.New()
	}
end

return DreamTeamChapterScriptKillBookViewPresentor
