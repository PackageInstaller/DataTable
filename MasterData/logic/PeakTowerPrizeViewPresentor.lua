-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerPrizeViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerPrizeViewPresentor", package.seeall)

local PeakTowerPrizeViewPresentor = class("PeakTowerPrizeViewPresentor", ViewPresentor)

function PeakTowerPrizeViewPresentor:ctor()
	PeakTowerPrizeViewPresentor.super.ctor(self)
end

function PeakTowerPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PeakTowerPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerprizeview.prefab"
	}
end

function PeakTowerPrizeViewPresentor:buildViews()
	return {
		PeakTowerPrizeView.New()
	}
end

return PeakTowerPrizeViewPresentor
