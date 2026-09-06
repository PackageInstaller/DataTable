-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TLCRewardViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TLCRewardViewPresentor", package.seeall)

local TLCRewardViewPresentor = class("TLCRewardViewPresentor", ViewPresentor)

function TLCRewardViewPresentor:ctor()
	TLCRewardViewPresentor.super.ctor(self)
end

function TLCRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TLCRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tlcrewardview.prefab"
	}
end

function TLCRewardViewPresentor:buildViews()
	return {
		TLCRewardView.New()
	}
end

return TLCRewardViewPresentor
