-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanMainViewPresentor.lua

module("logic.extensions.watertianyan.view.WaterTianYanMainViewPresentor", package.seeall)

local WaterTianYanMainViewPresentor = class("WaterTianYanMainViewPresentor", ViewPresentor)

function WaterTianYanMainViewPresentor:ctor()
	WaterTianYanMainViewPresentor.super.ctor(self)
end

function WaterTianYanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterTianYanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/watertianyanmainview.prefab"
	}
end

function WaterTianYanMainViewPresentor:buildViews()
	return {
		WaterTianYanMainView.New()
	}
end

return WaterTianYanMainViewPresentor
