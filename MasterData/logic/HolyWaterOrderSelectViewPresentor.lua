-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderSelectViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderSelectViewPresentor", package.seeall)

local HolyWaterOrderSelectViewPresentor = class("HolyWaterOrderSelectViewPresentor", ViewPresentor)

function HolyWaterOrderSelectViewPresentor:ctor()
	HolyWaterOrderSelectViewPresentor.super.ctor(self)
end

function HolyWaterOrderSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyWaterOrderSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterorderselectview.prefab"
	}
end

function HolyWaterOrderSelectViewPresentor:buildViews()
	return {
		HolyWaterOrderSelectView.New()
	}
end

return HolyWaterOrderSelectViewPresentor
