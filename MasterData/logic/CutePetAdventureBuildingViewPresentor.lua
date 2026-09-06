-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdventureBuildingViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetAdventureBuildingViewPresentor", package.seeall)

local CutePetAdventureBuildingViewPresentor = class("CutePetAdventureBuildingViewPresentor", ViewPresentor)

function CutePetAdventureBuildingViewPresentor:ctor()
	CutePetAdventureBuildingViewPresentor.super.ctor(self)
end

function CutePetAdventureBuildingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetAdventureBuildingViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetadventurebuildingview.prefab"
	}
end

function CutePetAdventureBuildingViewPresentor:buildViews()
	return {
		CutePetAdventureBuildingView.New()
	}
end

return CutePetAdventureBuildingViewPresentor
