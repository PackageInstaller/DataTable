-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerStageViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerStageViewPresentor", package.seeall)

local PeakTowerStageViewPresentor = class("PeakTowerStageViewPresentor", ViewPresentor)

function PeakTowerStageViewPresentor:ctor()
	PeakTowerStageViewPresentor.super.ctor(self)
end

function PeakTowerStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PeakTowerStageViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerstageview.prefab"
	}
end

function PeakTowerStageViewPresentor:buildViews()
	return {
		PeakTowerStageView.New()
	}
end

return PeakTowerStageViewPresentor
