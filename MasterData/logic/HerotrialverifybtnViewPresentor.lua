-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialverifybtnViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialverifybtnViewPresentor", package.seeall)

local HerotrialverifybtnViewPresentor = class("HerotrialverifybtnViewPresentor", ViewPresentor)

function HerotrialverifybtnViewPresentor:ctor()
	HerotrialverifybtnViewPresentor.super.ctor(self)
end

function HerotrialverifybtnViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialverifybtnViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/herotrialverifybtn.prefab"
	}
end

function HerotrialverifybtnViewPresentor:buildViews()
	return {
		HerotrialverifybtnView.New()
	}
end

return HerotrialverifybtnViewPresentor
