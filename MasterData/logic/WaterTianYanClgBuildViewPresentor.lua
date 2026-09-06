-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanClgBuildViewPresentor.lua

module("logic.extensions.watertianyan.view.WaterTianYanClgBuildViewPresentor", package.seeall)

local WaterTianYanClgBuildViewPresentor = class("WaterTianYanClgBuildViewPresentor", ViewPresentor)

function WaterTianYanClgBuildViewPresentor:ctor()
	WaterTianYanClgBuildViewPresentor.super.ctor(self)
end

function WaterTianYanClgBuildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterTianYanClgBuildViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/watertianyanclgbuildview.prefab"
	}
end

function WaterTianYanClgBuildViewPresentor:buildViews()
	return {
		WaterTianYanClgBuildView.New()
	}
end

return WaterTianYanClgBuildViewPresentor
