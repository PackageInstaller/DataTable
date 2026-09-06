-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingSignViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingSignViewPresentor", package.seeall)

local SurvivalKingSignViewPresentor = class("SurvivalKingSignViewPresentor", ViewPresentor)

function SurvivalKingSignViewPresentor:ctor()
	SurvivalKingSignViewPresentor.super.ctor(self)
end

function SurvivalKingSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingSignViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingsignview.prefab"
	}
end

function SurvivalKingSignViewPresentor:buildViews()
	return {
		SurvivalKingSignView.New()
	}
end

return SurvivalKingSignViewPresentor
