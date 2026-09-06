-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/ultimatewar/UltimateWarTowerFinalBossRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.ultimatewar.UltimateWarTowerFinalBossRankChildViewPresentor", package.seeall)

local UltimateWarTowerFinalBossRankChildViewPresentor = class("UltimateWarTowerFinalBossRankChildViewPresentor", ViewPresentor)

function UltimateWarTowerFinalBossRankChildViewPresentor:ctor()
	UltimateWarTowerFinalBossRankChildViewPresentor.super.ctor(self)
end

function UltimateWarTowerFinalBossRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerFinalBossRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/ultimatewartowerfinalbossrankchildview.prefab"
	}
end

function UltimateWarTowerFinalBossRankChildViewPresentor:buildViews()
	return {
		UltimateWarTowerFinalBossRankChildView.New()
	}
end

function UltimateWarTowerFinalBossRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return UltimateWarTowerFinalBossRankChildViewPresentor
