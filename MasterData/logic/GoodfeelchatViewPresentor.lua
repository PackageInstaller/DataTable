-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelchatViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelchatViewPresentor", package.seeall)

local GoodfeelchatViewPresentor = class("GoodfeelchatViewPresentor", ViewPresentor)

function GoodfeelchatViewPresentor:ctor()
	GoodfeelchatViewPresentor.super.ctor(self)
end

function GoodfeelchatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelchatViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelchatview.prefab"
	}
end

function GoodfeelchatViewPresentor:buildViews()
	return {
		GoodfeelchatView.New()
	}
end

function GoodfeelchatViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoodfeelchatViewPresentor
