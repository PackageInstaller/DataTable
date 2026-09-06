-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterAlchemyMMMainViewPresentor.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterAlchemyMMMainViewPresentor", package.seeall)

local DreamTeamChapterAlchemyMMMainViewPresentor = class("DreamTeamChapterAlchemyMMMainViewPresentor", ViewPresentor)

function DreamTeamChapterAlchemyMMMainViewPresentor:ctor()
	DreamTeamChapterAlchemyMMMainViewPresentor.super.ctor(self)
end

function DreamTeamChapterAlchemyMMMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamChapterAlchemyMMMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamchapter/dreamteamchapteralchemymmmainview.prefab"
	}
end

function DreamTeamChapterAlchemyMMMainViewPresentor:buildViews()
	return {
		DreamTeamChapterAlchemyMMMainView.New()
	}
end

return DreamTeamChapterAlchemyMMMainViewPresentor
