-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationLevelViewPresentor.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationLevelViewPresentor", package.seeall)

local NewBreakFormationLevelViewPresentor = class("NewBreakFormationLevelViewPresentor", ViewPresentor)

function NewBreakFormationLevelViewPresentor:ctor()
	NewBreakFormationLevelViewPresentor.super.ctor(self)
end

function NewBreakFormationLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewBreakFormationLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/newbreakformation/newbreakformationlevelview.prefab"
	}
end

function NewBreakFormationLevelViewPresentor:buildViews()
	return {
		NewBreakFormationLevelView.New()
	}
end

return NewBreakFormationLevelViewPresentor
