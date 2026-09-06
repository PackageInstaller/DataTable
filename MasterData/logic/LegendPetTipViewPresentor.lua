-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/LegendPetTipViewPresentor.lua

module("logic.extensions.legend.view.treasure.LegendPetTipViewPresentor", package.seeall)

local LegendPetTipViewPresentor = class("LegendPetTipViewPresentor", ViewWithGuidePresentor)

function LegendPetTipViewPresentor:ctor()
	LegendPetTipViewPresentor.super.ctor(self)
end

function LegendPetTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LegendPetTipViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/legendpettipview.prefab"
	}
end

function LegendPetTipViewPresentor:buildViews()
	return {
		LegendPetTipView.New()
	}
end

return LegendPetTipViewPresentor
