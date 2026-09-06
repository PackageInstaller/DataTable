-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeTipsViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeTipsViewPresentor", package.seeall)

local SunWuKongChallengeTipsViewPresentor = class("SunWuKongChallengeTipsViewPresentor", ViewPresentor)

function SunWuKongChallengeTipsViewPresentor:ctor()
	SunWuKongChallengeTipsViewPresentor.super.ctor(self)
end

function SunWuKongChallengeTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunWuKongChallengeTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengetipsview.prefab"
	}
end

function SunWuKongChallengeTipsViewPresentor:buildViews()
	return {
		SunWuKongChallengeTipsView.New()
	}
end

return SunWuKongChallengeTipsViewPresentor
