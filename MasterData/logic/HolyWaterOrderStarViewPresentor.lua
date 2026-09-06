-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderStarViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderStarViewPresentor", package.seeall)

local HolyWaterOrderStarViewPresentor = class("HolyWaterOrderStarViewPresentor", ViewPresentor)

function HolyWaterOrderStarViewPresentor:ctor()
	HolyWaterOrderStarViewPresentor.super.ctor(self)
end

function HolyWaterOrderStarViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyWaterOrderStarViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterorderstarview.prefab"
	}
end

function HolyWaterOrderStarViewPresentor:buildViews()
	return {
		HolyWaterOrderStarView.New()
	}
end

return HolyWaterOrderStarViewPresentor
