-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanBuffViewPresentor.lua

module("logic.extensions.watertianyan.view.WaterTianYanBuffViewPresentor", package.seeall)

local WaterTianYanBuffViewPresentor = class("WaterTianYanBuffViewPresentor", ViewPresentor)

function WaterTianYanBuffViewPresentor:ctor()
	WaterTianYanBuffViewPresentor.super.ctor(self)
end

function WaterTianYanBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterTianYanBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/watertianyanbuffview.prefab"
	}
end

function WaterTianYanBuffViewPresentor:buildViews()
	return {
		WaterTianYanBuffView.New()
	}
end

function WaterTianYanBuffViewPresentor:setGrayMaskGO(grayMaskGO)
	WaterTianYanBuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return WaterTianYanBuffViewPresentor
