-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanClgMainViewPresentor.lua

module("logic.extensions.watertianyan.view.WaterTianYanClgMainViewPresentor", package.seeall)

local WaterTianYanClgMainViewPresentor = class("WaterTianYanClgMainViewPresentor", ViewPresentor)

function WaterTianYanClgMainViewPresentor:ctor()
	WaterTianYanClgMainViewPresentor.super.ctor(self)
end

function WaterTianYanClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterTianYanClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/watertianyanclgmainview.prefab"
	}
end

function WaterTianYanClgMainViewPresentor:buildViews()
	return {
		WaterTianYanClgMainView.New()
	}
end

return WaterTianYanClgMainViewPresentor
