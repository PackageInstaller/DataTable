-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeCimeliaViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeCimeliaViewPresentor", package.seeall)

local SunWuKongChallengeCimeliaViewPresentor = class("SunWuKongChallengeCimeliaViewPresentor", ViewPresentor)

function SunWuKongChallengeCimeliaViewPresentor:ctor()
	SunWuKongChallengeCimeliaViewPresentor.super.ctor(self)
end

function SunWuKongChallengeCimeliaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunWuKongChallengeCimeliaViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengecimeliaview.prefab"
	}
end

function SunWuKongChallengeCimeliaViewPresentor:buildViews()
	return {
		SunWuKongChallengeCimeliaView.New()
	}
end

return SunWuKongChallengeCimeliaViewPresentor
