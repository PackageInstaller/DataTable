-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdRankPrizeViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdRankPrizeViewPresentor", package.seeall)

local YouthArenaThirdRankPrizeViewPresentor = class("YouthArenaThirdRankPrizeViewPresentor", ViewPresentor)

function YouthArenaThirdRankPrizeViewPresentor:ctor()
	YouthArenaThirdRankPrizeViewPresentor.super.ctor(self)
end

function YouthArenaThirdRankPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdRankPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdrankprizeview.prefab"
	}
end

function YouthArenaThirdRankPrizeViewPresentor:buildViews()
	return {
		YouthArenaThirdRankPrizeView.New()
	}
end

return YouthArenaThirdRankPrizeViewPresentor
