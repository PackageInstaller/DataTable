-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationRewardViewPresentor.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationRewardViewPresentor", package.seeall)

local NewBreakFormationRewardViewPresentor = class("NewBreakFormationRewardViewPresentor", ViewPresentor)

function NewBreakFormationRewardViewPresentor:ctor()
	NewBreakFormationRewardViewPresentor.super.ctor(self)
end

function NewBreakFormationRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewBreakFormationRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/newbreakformation/newbreakformationrewardview.prefab"
	}
end

function NewBreakFormationRewardViewPresentor:buildViews()
	return {
		NewBreakFormationRewardView.New()
	}
end

return NewBreakFormationRewardViewPresentor
