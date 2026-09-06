-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/customformation/SummerTreasureSnatchCustomFormationViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.customformation.SummerTreasureSnatchCustomFormationViewPresentor", package.seeall)

local SummerTreasureSnatchCustomFormationViewPresentor = class("SummerTreasureSnatchCustomFormationViewPresentor", MissionViewPresentor)

function SummerTreasureSnatchCustomFormationViewPresentor:ctor()
	SummerTreasureSnatchCustomFormationViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchCustomFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchCustomFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchformationview.prefab"
	}
end

function SummerTreasureSnatchCustomFormationViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function SummerTreasureSnatchCustomFormationViewPresentor:buildViews()
	return {
		SummerTreasureSnatchCustomFormationView.New(),
		CustomFmtRightView.New(),
		CustomFmtLeftView.New(),
		CustomFormTabView.New()
	}
end

return SummerTreasureSnatchCustomFormationViewPresentor
