-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/ChargeCostRankViewPresentor.lua

module("logic.extensions.accumulatecharge.view.ChargeCostRankViewPresentor", package.seeall)

local ChargeCostRankViewPresentor = class("ChargeCostRankViewPresentor", ViewPresentor)

function ChargeCostRankViewPresentor:ctor()
	ChargeCostRankViewPresentor.super.ctor(self)
end

function ChargeCostRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChargeCostRankViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulatecharge/chargecostrankview.prefab"
	}
end

function ChargeCostRankViewPresentor:buildViews()
	return {
		ChargeCostRankView.New()
	}
end

return ChargeCostRankViewPresentor
