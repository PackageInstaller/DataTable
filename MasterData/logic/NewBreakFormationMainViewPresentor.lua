-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationMainViewPresentor.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationMainViewPresentor", package.seeall)

local NewBreakFormationMainViewPresentor = class("NewBreakFormationMainViewPresentor", ViewPresentor)

function NewBreakFormationMainViewPresentor:ctor()
	NewBreakFormationMainViewPresentor.super.ctor(self)
end

function NewBreakFormationMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewBreakFormationMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newbreakformation/newbreakformationmainview.prefab"
	}
end

function NewBreakFormationMainViewPresentor:buildViews()
	return {
		NewBreakFormationMainView.New()
	}
end

return NewBreakFormationMainViewPresentor
