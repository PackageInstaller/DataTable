-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/view/ZeropaymainViewPresentor.lua

module("logic.extensions.zeropay.view.ZeropaymainViewPresentor", package.seeall)

local ZeropaymainViewPresentor = class("ZeropaymainViewPresentor", ViewPresentor)

function ZeropaymainViewPresentor:ctor()
	ZeropaymainViewPresentor.super.ctor(self)
end

function ZeropaymainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZeropaymainViewPresentor:dependWhatResources()
	return {
		"ui/views/zeropay/zeropaymainview.prefab"
	}
end

function ZeropaymainViewPresentor:buildViews()
	return {
		ZeropaymainView.New()
	}
end

return ZeropaymainViewPresentor
