-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetDrawingViewPresentor.lua

module("logic.extensions.handbook.view.PetDrawingViewPresentor", package.seeall)

local PetDrawingViewPresentor = class("PetDrawingViewPresentor", ViewPresentor)

function PetDrawingViewPresentor:ctor()
	PetDrawingViewPresentor.super.ctor(self)
end

function PetDrawingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetDrawingViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petdrawingview.prefab"
	}
end

function PetDrawingViewPresentor:buildViews()
	return {
		PetDrawingView.New()
	}
end

return PetDrawingViewPresentor
