-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/ultimatewar/UltimateWarTowerStageRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.ultimatewar.UltimateWarTowerStageRankChildViewPresentor", package.seeall)

local UltimateWarTowerStageRankChildViewPresentor = class("UltimateWarTowerStageRankChildViewPresentor", ViewPresentor)

function UltimateWarTowerStageRankChildViewPresentor:ctor()
	UltimateWarTowerStageRankChildViewPresentor.super.ctor(self)
end

function UltimateWarTowerStageRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerStageRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/ultimatewartowerstagerankchildview.prefab"
	}
end

function UltimateWarTowerStageRankChildViewPresentor:buildViews()
	return {
		UltimateWarTowerStageRankChildView.New()
	}
end

function UltimateWarTowerStageRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return UltimateWarTowerStageRankChildViewPresentor
