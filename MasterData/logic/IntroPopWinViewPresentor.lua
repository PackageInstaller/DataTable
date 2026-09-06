-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/IntroPopWinViewPresentor.lua

module("logic.extensions.storysummary.view.IntroPopWinViewPresentor", package.seeall)

local IntroPopWinViewPresentor = class("IntroPopWinViewPresentor", ViewPresentor)

function IntroPopWinViewPresentor:ctor()
	IntroPopWinViewPresentor.super.ctor(self)
end

function IntroPopWinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IntroPopWinViewPresentor:dependWhatResources()
	return {
		"ui/views/storysummary/intropopwinview.prefab"
	}
end

function IntroPopWinViewPresentor:buildViews()
	return {
		IntroPopWinView.New()
	}
end

return IntroPopWinViewPresentor
