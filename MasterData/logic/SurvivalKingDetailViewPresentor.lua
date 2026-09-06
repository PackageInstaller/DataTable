-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingDetailViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingDetailViewPresentor", package.seeall)

local SurvivalKingDetailViewPresentor = class("SurvivalKingDetailViewPresentor", ViewPresentor)

function SurvivalKingDetailViewPresentor:ctor()
	SurvivalKingDetailViewPresentor.super.ctor(self)
end

function SurvivalKingDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingdetailview.prefab"
	}
end

function SurvivalKingDetailViewPresentor:buildViews()
	return {
		SurvivalKingDetailView.New()
	}
end

return SurvivalKingDetailViewPresentor
