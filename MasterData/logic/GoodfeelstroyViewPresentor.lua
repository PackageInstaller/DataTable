-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelstroyViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelstroyViewPresentor", package.seeall)

local GoodfeelstroyViewPresentor = class("GoodfeelstroyViewPresentor", ViewPresentor)

function GoodfeelstroyViewPresentor:ctor()
	GoodfeelstroyViewPresentor.super.ctor(self)
end

function GoodfeelstroyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelstroyViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelstroyview.prefab"
	}
end

function GoodfeelstroyViewPresentor:buildViews()
	return {
		GoodfeelstroyView.New()
	}
end

function GoodfeelstroyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoodfeelstroyViewPresentor
