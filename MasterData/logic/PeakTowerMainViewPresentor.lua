-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerMainViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerMainViewPresentor", package.seeall)

local PeakTowerMainViewPresentor = class("PeakTowerMainViewPresentor", ViewPresentor)

function PeakTowerMainViewPresentor:ctor()
	PeakTowerMainViewPresentor.super.ctor(self)
end

function PeakTowerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PeakTowerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowermainview.prefab"
	}
end

function PeakTowerMainViewPresentor:buildViews()
	return {
		PeakTowerMainView.New()
	}
end

return PeakTowerMainViewPresentor
