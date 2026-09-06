-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syyueyingwang/view/HolyMoonKingViewPresentor.lua

module("logic.extensions.syyueyingwang.view.HolyMoonKingViewPresentor", package.seeall)

local HolyMoonKingViewPresentor = class("HolyMoonKingViewPresentor", ViewPresentor)

function HolyMoonKingViewPresentor:ctor()
	HolyMoonKingViewPresentor.super.ctor(self)
end

function HolyMoonKingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyMoonKingViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syyueyingwang/holymoonkingview.prefab"
	}
end

function HolyMoonKingViewPresentor:buildViews()
	return {
		HolyMoonKingView.New()
	}
end

return HolyMoonKingViewPresentor
