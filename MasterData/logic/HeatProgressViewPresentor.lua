-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heatprogress/view/HeatProgressViewPresentor.lua

module("logic.extensions.heatprogress.view.HeatProgressViewPresentor", package.seeall)

local HeatProgressViewPresentor = class("HeatProgressViewPresentor", ViewPresentor)

function HeatProgressViewPresentor:ctor()
	HeatProgressViewPresentor.super.ctor(self)
end

function HeatProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeatProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/heatprogress/heatprogressview.prefab"
	}
end

function HeatProgressViewPresentor:buildViews()
	return {
		HeatProgressView.New()
	}
end

return HeatProgressViewPresentor
