-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateVoteGoldGainPopViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateVoteGoldGainPopViewPresentor", package.seeall)

local ShowDownEliminateVoteGoldGainPopViewPresentor = class("ShowDownEliminateVoteGoldGainPopViewPresentor", ViewPresentor)

function ShowDownEliminateVoteGoldGainPopViewPresentor:ctor()
	ShowDownEliminateVoteGoldGainPopViewPresentor.super.ctor(self)
end

function ShowDownEliminateVoteGoldGainPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateVoteGoldGainPopViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminatevotegoldgainpopview.prefab"
	}
end

function ShowDownEliminateVoteGoldGainPopViewPresentor:buildViews()
	return {
		ShowDownEliminateVoteGoldGainPopView.New()
	}
end

return ShowDownEliminateVoteGoldGainPopViewPresentor
