-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/view/HuarongRoadGameViewPresentor.lua

module("logic.extensions.huarongroad.view.HuarongRoadGameViewPresentor", package.seeall)

local HuarongRoadGameViewPresentor = class("HuarongRoadGameViewPresentor", ViewPresentor)

function HuarongRoadGameViewPresentor:ctor()
	HuarongRoadGameViewPresentor.super.ctor(self)
end

function HuarongRoadGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuarongRoadGameViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightnuo/saintknightnuogameview.prefab"
	}
end

function HuarongRoadGameViewPresentor:buildViews()
	return {
		HuarongRoadGameView.New()
	}
end

return HuarongRoadGameViewPresentor
