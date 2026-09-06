-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderResultViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderResultViewPresentor", package.seeall)

local HolyWaterOrderResultViewPresentor = class("HolyWaterOrderResultViewPresentor", ViewPresentor)

function HolyWaterOrderResultViewPresentor:ctor()
	HolyWaterOrderResultViewPresentor.super.ctor(self)
end

function HolyWaterOrderResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyWaterOrderResultViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterorderresultview.prefab"
	}
end

function HolyWaterOrderResultViewPresentor:buildViews()
	return {
		HolyWaterOrderResultView.New()
	}
end

return HolyWaterOrderResultViewPresentor
