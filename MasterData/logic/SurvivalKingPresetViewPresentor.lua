-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingPresetViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingPresetViewPresentor", package.seeall)

local SurvivalKingPresetViewPresentor = class("SurvivalKingPresetViewPresentor", ViewPresentor)

function SurvivalKingPresetViewPresentor:ctor()
	SurvivalKingPresetViewPresentor.super.ctor(self)
end

function SurvivalKingPresetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingPresetViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingpresetview.prefab"
	}
end

function SurvivalKingPresetViewPresentor:buildViews()
	return {
		SurvivalKingPresetView.New()
	}
end

return SurvivalKingPresetViewPresentor
