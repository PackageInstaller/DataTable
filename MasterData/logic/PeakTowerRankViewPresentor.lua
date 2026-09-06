-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerRankViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerRankViewPresentor", package.seeall)

local PeakTowerRankViewPresentor = class("PeakTowerRankViewPresentor", ViewPresentor)

function PeakTowerRankViewPresentor:ctor()
	PeakTowerRankViewPresentor.super.ctor(self)
end

function PeakTowerRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PeakTowerRankViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerrankview.prefab"
	}
end

function PeakTowerRankViewPresentor:buildViews()
	return {
		PeakTowerRankView.New()
	}
end

return PeakTowerRankViewPresentor
