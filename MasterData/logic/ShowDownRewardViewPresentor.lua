-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownRewardViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownRewardViewPresentor", package.seeall)

local ShowDownRewardViewPresentor = class("ShowDownRewardViewPresentor", ViewPresentor)

function ShowDownRewardViewPresentor:ctor()
	ShowDownRewardViewPresentor.super.ctor(self)
end

function ShowDownRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownrewardview.prefab"
	}
end

function ShowDownRewardViewPresentor:buildViews()
	return {
		ShowDownRewardView.New()
	}
end

return ShowDownRewardViewPresentor
