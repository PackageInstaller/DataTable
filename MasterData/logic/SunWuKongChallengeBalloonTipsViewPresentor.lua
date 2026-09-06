-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/balloongame/SunWuKongChallengeBalloonTipsViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.balloongame.SunWuKongChallengeBalloonTipsViewPresentor", package.seeall)

local SunWuKongChallengeBalloonTipsViewPresentor = class("SunWuKongChallengeBalloonTipsViewPresentor", ViewPresentor)

function SunWuKongChallengeBalloonTipsViewPresentor:ctor()
	SunWuKongChallengeBalloonTipsViewPresentor.super.ctor(self)
end

function SunWuKongChallengeBalloonTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunWuKongChallengeBalloonTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengeballoontipsview.prefab"
	}
end

function SunWuKongChallengeBalloonTipsViewPresentor:buildViews()
	return {
		SunWuKongChallengeBalloonTipsView.New()
	}
end

return SunWuKongChallengeBalloonTipsViewPresentor
