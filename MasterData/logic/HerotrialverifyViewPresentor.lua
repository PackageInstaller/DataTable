-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialverifyViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialverifyViewPresentor", package.seeall)

local HerotrialverifyViewPresentor = class("HerotrialverifyViewPresentor", ViewPresentor)

function HerotrialverifyViewPresentor:ctor()
	HerotrialverifyViewPresentor.super.ctor(self)
end

function HerotrialverifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialverifyViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/herotrialverifyview.prefab"
	}
end

function HerotrialverifyViewPresentor:buildViews()
	return {
		HerotrialverifyView.New()
	}
end

return HerotrialverifyViewPresentor
