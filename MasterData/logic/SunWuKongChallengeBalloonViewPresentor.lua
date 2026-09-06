-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/balloongame/SunWuKongChallengeBalloonViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.balloongame.SunWuKongChallengeBalloonViewPresentor", package.seeall)

local SunWuKongChallengeBalloonViewPresentor = class("SunWuKongChallengeBalloonViewPresentor", ViewPresentor)

function SunWuKongChallengeBalloonViewPresentor:ctor()
	SunWuKongChallengeBalloonViewPresentor.super.ctor(self)
end

function SunWuKongChallengeBalloonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunWuKongChallengeBalloonViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengeballoonview.prefab"
	}
end

function SunWuKongChallengeBalloonViewPresentor:buildViews()
	return {
		SunWuKongChallengeBalloonView.New()
	}
end

return SunWuKongChallengeBalloonViewPresentor
