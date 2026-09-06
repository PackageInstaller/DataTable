-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WtowerfastrevenueViewPresentor.lua

module("logic.extensions.warriortower.view.WtowerfastrevenueViewPresentor", package.seeall)

local WtowerfastrevenueViewPresentor = class("WtowerfastrevenueViewPresentor", ViewPresentor)

function WtowerfastrevenueViewPresentor:ctor()
	WtowerfastrevenueViewPresentor.super.ctor(self)
end

function WtowerfastrevenueViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WtowerfastrevenueViewPresentor:dependWhatResources()
	return {
		"ui/views/warriortower/wtowerfastrevenueview.prefab"
	}
end

function WtowerfastrevenueViewPresentor:buildViews()
	return {
		WtowerfastrevenueView.New()
	}
end

return WtowerfastrevenueViewPresentor
