-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerVerifyViewPresentor.lua

module("logic.extensions.peaktower.view.PeakTowerVerifyViewPresentor", package.seeall)

local PeakTowerVerifyViewPresentor = class("PeakTowerVerifyViewPresentor", ViewPresentor)

function PeakTowerVerifyViewPresentor:ctor()
	PeakTowerVerifyViewPresentor.super.ctor(self)
end

function PeakTowerVerifyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PeakTowerVerifyViewPresentor:dependWhatResources()
	return {
		"ui/views/peaktower/peaktowerverifyview.prefab"
	}
end

function PeakTowerVerifyViewPresentor:buildViews()
	return {
		PeakTowerVerifyView.New()
	}
end

return PeakTowerVerifyViewPresentor
