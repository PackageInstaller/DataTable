-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holyiceking/view/HolyicekingViewPresentor.lua

module("logic.extensions.holyiceking.view.HolyicekingViewPresentor", package.seeall)

local HolyicekingViewPresentor = class("HolyicekingViewPresentor", ViewPresentor)

function HolyicekingViewPresentor:ctor()
	HolyicekingViewPresentor.super.ctor(self)
end

function HolyicekingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyicekingViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holyiceking/holyicekingview.prefab"
	}
end

function HolyicekingViewPresentor:buildViews()
	return {
		HolyicekingView.New()
	}
end

return HolyicekingViewPresentor
