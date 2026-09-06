-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownEliminateVoteViewPresentor.lua

module("logic.extensions.showdown.view.ShowdownEliminateVoteViewPresentor", package.seeall)

local ShowdownEliminateVoteViewPresentor = class("ShowdownEliminateVoteViewPresentor", ViewPresentor)

function ShowdownEliminateVoteViewPresentor:ctor()
	ShowdownEliminateVoteViewPresentor.super.ctor(self)
end

function ShowdownEliminateVoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowdownEliminateVoteViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminatevoteview.prefab"
	}
end

function ShowdownEliminateVoteViewPresentor:buildViews()
	return {
		ShowdownEliminateVoteView.New()
	}
end

return ShowdownEliminateVoteViewPresentor
