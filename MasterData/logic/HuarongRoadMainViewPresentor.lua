-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/view/HuarongRoadMainViewPresentor.lua

module("logic.extensions.huarongroad.view.HuarongRoadMainViewPresentor", package.seeall)

local HuarongRoadMainViewPresentor = class("HuarongRoadMainViewPresentor", ViewPresentor)

function HuarongRoadMainViewPresentor:ctor()
	HuarongRoadMainViewPresentor.super.ctor(self)
end

function HuarongRoadMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuarongRoadMainViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightnuo/saintknightnuomainview.prefab"
	}
end

function HuarongRoadMainViewPresentor:buildViews()
	return {
		HuarongRoadMainView.New()
	}
end

return HuarongRoadMainViewPresentor
