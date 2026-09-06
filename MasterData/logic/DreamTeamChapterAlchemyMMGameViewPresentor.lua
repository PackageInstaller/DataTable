-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterAlchemyMMGameViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterAlchemyMMGameViewPresentor", package.seeall)

local DreamTeamChapterAlchemyMMGameViewPresentor = class("DreamTeamChapterAlchemyMMGameViewPresentor", ViewPresentor)

function DreamTeamChapterAlchemyMMGameViewPresentor:ctor()
	DreamTeamChapterAlchemyMMGameViewPresentor.super.ctor(self)
end

function DreamTeamChapterAlchemyMMGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterAlchemyMMGameViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapteralchemymmgameview.prefab"
	}
end

function DreamTeamChapterAlchemyMMGameViewPresentor:buildViews()
	return {
		DreamTeamChapterAlchemyMMGameView.New()
	}
end

return DreamTeamChapterAlchemyMMGameViewPresentor
