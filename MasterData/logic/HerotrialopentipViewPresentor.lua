-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialopentipViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialopentipViewPresentor", package.seeall)

local HerotrialopentipViewPresentor = class("HerotrialopentipViewPresentor", ViewPresentor)

function HerotrialopentipViewPresentor:ctor()
	HerotrialopentipViewPresentor.super.ctor(self)
end

function HerotrialopentipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialopentipViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/herotrialopentip.prefab"
	}
end

function HerotrialopentipViewPresentor:buildViews()
	return {
		HerotrialopentipView.New()
	}
end

return HerotrialopentipViewPresentor
