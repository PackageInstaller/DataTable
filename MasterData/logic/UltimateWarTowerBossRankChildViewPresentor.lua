-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/ultimatewar/UltimateWarTowerBossRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.ultimatewar.UltimateWarTowerBossRankChildViewPresentor", package.seeall)

local UltimateWarTowerBossRankChildViewPresentor = class("UltimateWarTowerBossRankChildViewPresentor", ViewPresentor)

function UltimateWarTowerBossRankChildViewPresentor:ctor()
	UltimateWarTowerBossRankChildViewPresentor.super.ctor(self)
end

function UltimateWarTowerBossRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerBossRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/ultimatewartowerbossrankchildview.prefab"
	}
end

function UltimateWarTowerBossRankChildViewPresentor:buildViews()
	return {
		UltimateWarTowerBossRankChildView.New()
	}
end

function UltimateWarTowerBossRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return UltimateWarTowerBossRankChildViewPresentor
