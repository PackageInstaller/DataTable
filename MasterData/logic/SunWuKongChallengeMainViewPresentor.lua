-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeMainViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeMainViewPresentor", package.seeall)

local SunWuKongChallengeMainViewPresentor = class("SunWuKongChallengeMainViewPresentor", ViewPresentor)

function SunWuKongChallengeMainViewPresentor:ctor()
	SunWuKongChallengeMainViewPresentor.super.ctor(self)
end

function SunWuKongChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunWuKongChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengemainview.prefab"
	}
end

function SunWuKongChallengeMainViewPresentor:buildViews()
	return {
		SunWuKongChallengeMainView.New()
	}
end

return SunWuKongChallengeMainViewPresentor
