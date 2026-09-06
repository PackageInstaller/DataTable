-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingLevelPresetViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingLevelPresetViewPresentor", package.seeall)

local SurvivalKingLevelPresetViewPresentor = class("SurvivalKingLevelPresetViewPresentor", ViewPresentor)

function SurvivalKingLevelPresetViewPresentor:ctor()
	SurvivalKingLevelPresetViewPresentor.super.ctor(self)
end

function SurvivalKingLevelPresetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingLevelPresetViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkinglevelpresetview.prefab"
	}
end

function SurvivalKingLevelPresetViewPresentor:buildViews()
	return {
		SurvivalKingLevelPresetView.New()
	}
end

return SurvivalKingLevelPresetViewPresentor
