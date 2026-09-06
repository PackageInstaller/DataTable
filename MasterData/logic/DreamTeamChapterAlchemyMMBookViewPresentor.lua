-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterAlchemyMMBookViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterAlchemyMMBookViewPresentor", package.seeall)

local DreamTeamChapterAlchemyMMBookViewPresentor = class("DreamTeamChapterAlchemyMMBookViewPresentor", ViewPresentor)

function DreamTeamChapterAlchemyMMBookViewPresentor:ctor()
	DreamTeamChapterAlchemyMMBookViewPresentor.super.ctor(self)
end

function DreamTeamChapterAlchemyMMBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterAlchemyMMBookViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapteralchemymmbookview.prefab"
	}
end

function DreamTeamChapterAlchemyMMBookViewPresentor:buildViews()
	return {
		DreamTeamChapterAlchemyMMBookView.New()
	}
end

return DreamTeamChapterAlchemyMMBookViewPresentor
