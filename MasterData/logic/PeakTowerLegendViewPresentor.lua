-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerLegendViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerLegendViewPresentor", package.seeall)

local PeakTowerLegendViewPresentor = class("PeakTowerLegendViewPresentor", ViewPresentor)

function PeakTowerLegendViewPresentor:ctor()
	PeakTowerLegendViewPresentor.super.ctor(self)
end

function PeakTowerLegendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PeakTowerLegendViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerlegendview.prefab"
	}
end

function PeakTowerLegendViewPresentor:buildViews()
	return {
		PeakTowerLegendView.New()
	}
end

return PeakTowerLegendViewPresentor
