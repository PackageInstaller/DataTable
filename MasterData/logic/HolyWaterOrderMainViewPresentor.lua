-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderMainViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderMainViewPresentor", package.seeall)

local HolyWaterOrderMainViewPresentor = class("HolyWaterOrderMainViewPresentor", ViewPresentor)

function HolyWaterOrderMainViewPresentor:ctor()
	HolyWaterOrderMainViewPresentor.super.ctor(self)
end

function HolyWaterOrderMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyWaterOrderMainViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterordermainview.prefab"
	}
end

function HolyWaterOrderMainViewPresentor:buildViews()
	return {
		HolyWaterOrderMainView.New()
	}
end

return HolyWaterOrderMainViewPresentor
