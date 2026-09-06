-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingBuffViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingBuffViewPresentor", package.seeall)

local SurvivalKingBuffViewPresentor = class("SurvivalKingBuffViewPresentor", ViewPresentor)

function SurvivalKingBuffViewPresentor:ctor()
	SurvivalKingBuffViewPresentor.super.ctor(self)
end

function SurvivalKingBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingbuffview.prefab"
	}
end

function SurvivalKingBuffViewPresentor:buildViews()
	return {
		SurvivalKingBuffView.New()
	}
end

return SurvivalKingBuffViewPresentor
