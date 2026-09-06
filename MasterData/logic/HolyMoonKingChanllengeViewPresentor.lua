-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syyueyingwang/view/HolyMoonKingChanllengeViewPresentor.lua

module("logic.extensions.syyueyingwang.view.HolyMoonKingChanllengeViewPresentor", package.seeall)

local HolyMoonKingChanllengeViewPresentor = class("HolyMoonKingChanllengeViewPresentor", ViewPresentor)

function HolyMoonKingChanllengeViewPresentor:ctor()
	HolyMoonKingChanllengeViewPresentor.super.ctor(self)
end

function HolyMoonKingChanllengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyMoonKingChanllengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syyueyingwang/holymoonkingchanllengeview.prefab"
	}
end

function HolyMoonKingChanllengeViewPresentor:buildViews()
	return {
		HolyMoonKingChanllengeView.New()
	}
end

return HolyMoonKingChanllengeViewPresentor
