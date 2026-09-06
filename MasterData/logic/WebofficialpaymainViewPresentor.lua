-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/webofficialpay/view/WebofficialpaymainViewPresentor.lua

module("logic.extensions.webofficialpay.view.WebofficialpaymainViewPresentor", package.seeall)

local WebofficialpaymainViewPresentor = class("WebofficialpaymainViewPresentor", ViewPresentor)

function WebofficialpaymainViewPresentor:ctor()
	WebofficialpaymainViewPresentor.super.ctor(self)
end

function WebofficialpaymainViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function WebofficialpaymainViewPresentor:dependWhatResources()
	return {
		"ui/views/webofficialpay/webofficialpaymainview.prefab"
	}
end

function WebofficialpaymainViewPresentor:buildViews()
	return {
		WebofficialpaymainView.New()
	}
end

function WebofficialpaymainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WebofficialpaymainViewPresentor
