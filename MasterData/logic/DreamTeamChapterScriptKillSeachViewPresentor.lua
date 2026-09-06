-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterScriptKillSeachViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterScriptKillSeachViewPresentor", package.seeall)

local DreamTeamChapterScriptKillSeachViewPresentor = class("DreamTeamChapterScriptKillSeachViewPresentor", ViewPresentor)

function DreamTeamChapterScriptKillSeachViewPresentor:ctor()
	DreamTeamChapterScriptKillSeachViewPresentor.super.ctor(self)
end

function DreamTeamChapterScriptKillSeachViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterScriptKillSeachViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapterscriptkillseachview.prefab"
	}
end

function DreamTeamChapterScriptKillSeachViewPresentor:buildViews()
	return {
		DreamTeamChapterScriptKillSeachView.New()
	}
end

return DreamTeamChapterScriptKillSeachViewPresentor
