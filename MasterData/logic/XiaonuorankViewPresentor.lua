-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/XiaonuorankViewPresentor.lua

module("logic.extensions.idlegame.view.XiaonuorankViewPresentor", package.seeall)

local XiaonuorankViewPresentor = class("XiaonuorankViewPresentor", ViewPresentor)

function XiaonuorankViewPresentor:ctor()
	XiaonuorankViewPresentor.super.ctor(self)
end

function XiaonuorankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaonuorankViewPresentor:dependWhatResources()
	return {
		"ui/views/idlegame/xiaonuorankview.prefab"
	}
end

function XiaonuorankViewPresentor:buildViews()
	return {
		XiaonuoRankview.New()
	}
end

return XiaonuorankViewPresentor
