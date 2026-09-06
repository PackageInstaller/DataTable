-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerBasicViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerBasicViewPresentor", package.seeall)

local PeakTowerBasicViewPresentor = class("PeakTowerBasicViewPresentor", ViewPresentor)

function PeakTowerBasicViewPresentor:ctor()
	PeakTowerBasicViewPresentor.super.ctor(self)
end

function PeakTowerBasicViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PeakTowerBasicViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerbasicview.prefab"
	}
end

function PeakTowerBasicViewPresentor:buildViews()
	return {
		PeakTowerBasicView.New()
	}
end

return PeakTowerBasicViewPresentor
