-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkBossOccupiedEffectViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkBossOccupiedEffectViewPresentor", package.seeall)

local ElementSparkBossOccupiedEffectViewPresentor = class("ElementSparkBossOccupiedEffectViewPresentor", ViewPresentor)

function ElementSparkBossOccupiedEffectViewPresentor:ctor()
	ElementSparkBossOccupiedEffectViewPresentor.super.ctor(self)
end

function ElementSparkBossOccupiedEffectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementSparkBossOccupiedEffectViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkbossoccupiedeffectview.prefab"
	}
end

function ElementSparkBossOccupiedEffectViewPresentor:buildViews()
	return {
		ElementSparkBossOccupiedEffectView.New()
	}
end

return ElementSparkBossOccupiedEffectViewPresentor
