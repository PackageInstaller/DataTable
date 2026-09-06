-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingLevelBuffViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingLevelBuffViewPresentor", package.seeall)

local SurvivalKingLevelBuffViewPresentor = class("SurvivalKingLevelBuffViewPresentor", ViewPresentor)

function SurvivalKingLevelBuffViewPresentor:ctor()
	SurvivalKingLevelBuffViewPresentor.super.ctor(self)
end

function SurvivalKingLevelBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingLevelBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkinglevelbuffview.prefab"
	}
end

function SurvivalKingLevelBuffViewPresentor:buildViews()
	return {
		SurvivalKingLevelBuffView.New()
	}
end

return SurvivalKingLevelBuffViewPresentor
