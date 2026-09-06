-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScoreRoundViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScoreRoundViewPresentor", package.seeall)

local YouthArenaThirdChampionScoreRoundViewPresentor = class("YouthArenaThirdChampionScoreRoundViewPresentor", ViewPresentor)

function YouthArenaThirdChampionScoreRoundViewPresentor:ctor()
	YouthArenaThirdChampionScoreRoundViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionScoreRoundViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionScoreRoundViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionscoreroundview.prefab"
	}
end

function YouthArenaThirdChampionScoreRoundViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionScoreRoundViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionScoreRoundView.New()
	}
end

return YouthArenaThirdChampionScoreRoundViewPresentor
