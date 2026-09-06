-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderRankViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderRankViewPresentor", package.seeall)

local HolyWaterOrderRankViewPresentor = class("HolyWaterOrderRankViewPresentor", ViewPresentor)

function HolyWaterOrderRankViewPresentor:ctor()
	HolyWaterOrderRankViewPresentor.super.ctor(self)
end

function HolyWaterOrderRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyWaterOrderRankViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterorderrankview.prefab"
	}
end

function HolyWaterOrderRankViewPresentor:buildViews()
	return {
		HolyWaterOrderRankView.New()
	}
end

return HolyWaterOrderRankViewPresentor
