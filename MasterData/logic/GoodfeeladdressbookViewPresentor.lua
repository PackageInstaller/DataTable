-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeeladdressbookViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeeladdressbookViewPresentor", package.seeall)

local GoodfeeladdressbookViewPresentor = class("GoodfeeladdressbookViewPresentor", ViewPresentor)

function GoodfeeladdressbookViewPresentor:ctor()
	GoodfeeladdressbookViewPresentor.super.ctor(self)
end

function GoodfeeladdressbookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeeladdressbookViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeeladdressbookview.prefab"
	}
end

function GoodfeeladdressbookViewPresentor:buildViews()
	return {
		GoodfeeladdressbookView.New()
	}
end

function GoodfeeladdressbookViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoodfeeladdressbookViewPresentor
