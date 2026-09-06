-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/XiaonuorightViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.XiaonuorightViewPresentor", package.seeall)

local XiaonuorightViewPresentor = class("XiaonuorightViewPresentor", ViewPresentor)

function XiaonuorightViewPresentor:ctor()
	XiaonuorightViewPresentor.super.ctor(self)
end

function XiaonuorightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaonuorightViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/xiaonuorightview.prefab"
	}
end

function XiaonuorightViewPresentor:buildViews()
	return {
		XiaonuorightView.New()
	}
end

return XiaonuorightViewPresentor
