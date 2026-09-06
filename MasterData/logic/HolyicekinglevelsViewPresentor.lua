-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holyiceking/view/HolyicekinglevelsViewPresentor.lua

module("logic.extensions.holyiceking.view.HolyicekinglevelsViewPresentor", package.seeall)

local HolyicekinglevelsViewPresentor = class("HolyicekinglevelsViewPresentor", ViewPresentor)

function HolyicekinglevelsViewPresentor:ctor()
	HolyicekinglevelsViewPresentor.super.ctor(self)
end

function HolyicekinglevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyicekinglevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holyiceking/holyicekinglevelsview.prefab"
	}
end

function HolyicekinglevelsViewPresentor:buildViews()
	return {
		HolyicekinglevelsView.New()
	}
end

return HolyicekinglevelsViewPresentor
