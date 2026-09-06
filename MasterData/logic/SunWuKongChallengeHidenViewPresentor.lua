-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeHidenViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeHidenViewPresentor", package.seeall)

local SunWuKongChallengeHidenViewPresentor = class("SunWuKongChallengeHidenViewPresentor", ViewPresentor)

function SunWuKongChallengeHidenViewPresentor:ctor()
	SunWuKongChallengeHidenViewPresentor.super.ctor(self)
end

function SunWuKongChallengeHidenViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunWuKongChallengeHidenViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengehidenview.prefab"
	}
end

function SunWuKongChallengeHidenViewPresentor:buildViews()
	return {
		SunWuKongChallengeHidenView.New()
	}
end

return SunWuKongChallengeHidenViewPresentor
