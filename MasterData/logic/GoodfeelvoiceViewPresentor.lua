-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelvoiceViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelvoiceViewPresentor", package.seeall)

local GoodfeelvoiceViewPresentor = class("GoodfeelvoiceViewPresentor", ViewPresentor)

function GoodfeelvoiceViewPresentor:ctor()
	GoodfeelvoiceViewPresentor.super.ctor(self)
end

function GoodfeelvoiceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelvoiceViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelvoiceview.prefab"
	}
end

function GoodfeelvoiceViewPresentor:buildViews()
	return {
		GoodfeelvoiceView.New()
	}
end

function GoodfeelvoiceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoodfeelvoiceViewPresentor
