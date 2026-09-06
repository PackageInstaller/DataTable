-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerweb/view/InnerWebViewPresentor.lua

module("logic.extensions.innerweb.view.InnerWebViewPresentor", package.seeall)

local InnerWebViewPresentor = class("InnerWebViewPresentor", ViewPresentor)

function InnerWebViewPresentor:ctor()
	InnerWebViewPresentor.super.ctor(self)
end

function InnerWebViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function InnerWebViewPresentor:dependWhatResources()
	return {
		"ui/views/innerweb/innerwebview.prefab"
	}
end

function InnerWebViewPresentor:buildViews()
	return {
		InnerWebView.New()
	}
end

function InnerWebViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return InnerWebViewPresentor
