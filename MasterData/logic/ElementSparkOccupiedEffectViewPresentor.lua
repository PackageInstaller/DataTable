-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkOccupiedEffectViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkOccupiedEffectViewPresentor", package.seeall)

local ElementSparkOccupiedEffectViewPresentor = class("ElementSparkOccupiedEffectViewPresentor", ViewPresentor)

function ElementSparkOccupiedEffectViewPresentor:ctor()
	ElementSparkOccupiedEffectViewPresentor.super.ctor(self)
end

function ElementSparkOccupiedEffectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkOccupiedEffectViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkoccupiedeffectview.prefab"
	}
end

function ElementSparkOccupiedEffectViewPresentor:buildViews()
	return {
		ElementSparkOccupiedEffectView.New()
	}
end

return ElementSparkOccupiedEffectViewPresentor
