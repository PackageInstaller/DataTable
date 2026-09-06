-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holyiceking/view/HolyicekingchanllengeViewPresentor.lua

module("logic.extensions.holyiceking.view.HolyicekingchanllengeViewPresentor", package.seeall)

local HolyicekingchanllengeViewPresentor = class("HolyicekingchanllengeViewPresentor", ViewPresentor)

function HolyicekingchanllengeViewPresentor:ctor()
	HolyicekingchanllengeViewPresentor.super.ctor(self)
end

function HolyicekingchanllengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyicekingchanllengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holyiceking/holyicekingchanllengeview.prefab"
	}
end

function HolyicekingchanllengeViewPresentor:buildViews()
	return {
		HolyicekingchanllengeView.New()
	}
end

return HolyicekingchanllengeViewPresentor
