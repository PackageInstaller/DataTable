-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooplaceViewPresentor.lua

module("logic.extensions.zoo.view.ZooplaceViewPresentor", package.seeall)

local ZooplaceViewPresentor = class("ZooplaceViewPresentor", ViewPresentor)

function ZooplaceViewPresentor:ctor()
	ZooplaceViewPresentor.super.ctor(self)
end

function ZooplaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZooplaceViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooplaceview.prefab"
	}
end

function ZooplaceViewPresentor:buildViews()
	return {
		ZooplaceView.New()
	}
end

return ZooplaceViewPresentor
