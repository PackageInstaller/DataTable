-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanTipViewPresentor.lua

module("logic.extensions.watertianyan.view.WaterTianYanTipViewPresentor", package.seeall)

local WaterTianYanTipViewPresentor = class("WaterTianYanTipViewPresentor", ViewPresentor)

function WaterTianYanTipViewPresentor:ctor()
	WaterTianYanTipViewPresentor.super.ctor(self)
end

function WaterTianYanTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterTianYanTipViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/watertianyantipview.prefab"
	}
end

function WaterTianYanTipViewPresentor:buildViews()
	return {
		WaterTianYanTipView.New()
	}
end

return WaterTianYanTipViewPresentor
