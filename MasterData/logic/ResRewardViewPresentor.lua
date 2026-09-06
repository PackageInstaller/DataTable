-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResRewardViewPresentor.lua

module("logic.extensions.materialchallenge.view.ResRewardViewPresentor", package.seeall)

local ResRewardViewPresentor = class("ResRewardViewPresentor", ViewPresentor)

function ResRewardViewPresentor:ctor()
	ResRewardViewPresentor.super.ctor(self)
end

function ResRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ResRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/resrewardview.prefab"
	}
end

function ResRewardViewPresentor:buildViews()
	return {
		ResRewardView.New()
	}
end

return ResRewardViewPresentor
