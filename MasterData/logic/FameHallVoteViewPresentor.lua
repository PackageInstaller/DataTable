-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehallvote/view/FameHallVoteViewPresentor.lua

module("logic.extensions.famehallvote.view.FameHallVoteViewPresentor", package.seeall)

local FameHallVoteViewPresentor = class("FameHallVoteViewPresentor", ViewPresentor)

function FameHallVoteViewPresentor:ctor()
	FameHallVoteViewPresentor.super.ctor(self)
end

function FameHallVoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallVoteViewPresentor:dependWhatResources()
	return {
		"ui/views/famehallvote/famehallvoteview.prefab"
	}
end

function FameHallVoteViewPresentor:buildViews()
	return {
		FameHallVoteView.New()
	}
end

return FameHallVoteViewPresentor
