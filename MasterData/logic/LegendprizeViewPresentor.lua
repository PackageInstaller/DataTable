-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendprizeViewPresentor.lua

module("logic.extensions.legend.view.LegendprizeViewPresentor", package.seeall)

local LegendprizeViewPresentor = class("LegendprizeViewPresentor", ViewPresentor)

function LegendprizeViewPresentor:ctor()
	LegendprizeViewPresentor.super.ctor(self)
end

function LegendprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LegendprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/legendprizeview.prefab"
	}
end

function LegendprizeViewPresentor:buildViews()
	return {
		LegendprizeView.New()
	}
end

return LegendprizeViewPresentor
