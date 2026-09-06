-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/peakdiamond/PeakDiamondViewPresentor.lua

module("logic.extensions.bonus.view.peakdiamond.PeakDiamondViewPresentor", package.seeall)

local PeakDiamondViewPresentor = class("PeakDiamondViewPresentor", ViewPresentor)

function PeakDiamondViewPresentor:ctor()
	PeakDiamondViewPresentor.super.ctor(self)
end

function PeakDiamondViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PeakDiamondViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/peakdiamond/peakdiamondview.prefab"
	}
end

function PeakDiamondViewPresentor:buildViews()
	return {
		PeakDiamondView.New()
	}
end

return PeakDiamondViewPresentor
