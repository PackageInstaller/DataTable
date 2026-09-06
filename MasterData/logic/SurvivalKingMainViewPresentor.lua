-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingMainViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingMainViewPresentor", package.seeall)

local SurvivalKingMainViewPresentor = class("SurvivalKingMainViewPresentor", ViewPresentor)

function SurvivalKingMainViewPresentor:ctor()
	SurvivalKingMainViewPresentor.super.ctor(self)
end

function SurvivalKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingmainview.prefab"
	}
end

function SurvivalKingMainViewPresentor:buildViews()
	return {
		SurvivalKingMainView.New()
	}
end

return SurvivalKingMainViewPresentor
