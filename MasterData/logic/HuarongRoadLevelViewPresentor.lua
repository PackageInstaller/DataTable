-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/view/HuarongRoadLevelViewPresentor.lua

module("logic.extensions.huarongroad.view.HuarongRoadLevelViewPresentor", package.seeall)

local HuarongRoadLevelViewPresentor = class("HuarongRoadLevelViewPresentor", ViewPresentor)

function HuarongRoadLevelViewPresentor:ctor()
	HuarongRoadLevelViewPresentor.super.ctor(self)
end

function HuarongRoadLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuarongRoadLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightnuo/saintknightnuoselectview.prefab"
	}
end

function HuarongRoadLevelViewPresentor:buildViews()
	return {
		HuarongRoadLevelView.New()
	}
end

return HuarongRoadLevelViewPresentor
