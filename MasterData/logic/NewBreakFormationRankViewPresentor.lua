-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationRankViewPresentor.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationRankViewPresentor", package.seeall)

local NewBreakFormationRankViewPresentor = class("NewBreakFormationRankViewPresentor", ViewPresentor)

function NewBreakFormationRankViewPresentor:ctor()
	NewBreakFormationRankViewPresentor.super.ctor(self)
end

function NewBreakFormationRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewBreakFormationRankViewPresentor:dependWhatResources()
	return {
		"ui/views/newbreakformation/newbreakformationrankview.prefab"
	}
end

function NewBreakFormationRankViewPresentor:buildViews()
	return {
		NewBreakFormationRankView.New()
	}
end

return NewBreakFormationRankViewPresentor
