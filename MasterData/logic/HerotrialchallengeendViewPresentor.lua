-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialchallengeendViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialchallengeendViewPresentor", package.seeall)

local HerotrialchallengeendViewPresentor = class("HerotrialchallengeendViewPresentor", ViewPresentor)

function HerotrialchallengeendViewPresentor:ctor()
	HerotrialchallengeendViewPresentor.super.ctor(self)
end

function HerotrialchallengeendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialchallengeendViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/herotrialchallengeend.prefab"
	}
end

function HerotrialchallengeendViewPresentor:buildViews()
	return {
		HerotrialchallengeendView.New()
	}
end

return HerotrialchallengeendViewPresentor
