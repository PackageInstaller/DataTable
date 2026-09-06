-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerPolluteViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerPolluteViewPresentor", package.seeall)

local PeakTowerPolluteViewPresentor = class("PeakTowerPolluteViewPresentor", ViewPresentor)

function PeakTowerPolluteViewPresentor:ctor()
	PeakTowerPolluteViewPresentor.super.ctor(self)
end

function PeakTowerPolluteViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PeakTowerPolluteViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerpolluteview.prefab"
	}
end

function PeakTowerPolluteViewPresentor:buildViews()
	return {
		PeakTowerPolluteView.New()
	}
end

return PeakTowerPolluteViewPresentor
