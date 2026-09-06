-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialViewPresentor", package.seeall)

local HerotrialViewPresentor = class("HerotrialViewPresentor", ViewPresentor)

function HerotrialViewPresentor:ctor()
	HerotrialViewPresentor.super.ctor(self)
end

function HerotrialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/herotrialview.prefab"
	}
end

function HerotrialViewPresentor:buildViews()
	return {
		HerotrialView.New()
	}
end

return HerotrialViewPresentor
