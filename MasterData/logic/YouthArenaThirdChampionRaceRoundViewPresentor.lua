-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionRaceRoundViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionRaceRoundViewPresentor", package.seeall)

local YouthArenaThirdChampionRaceRoundViewPresentor = class("YouthArenaThirdChampionRaceRoundViewPresentor", ViewPresentor)

function YouthArenaThirdChampionRaceRoundViewPresentor:ctor()
	YouthArenaThirdChampionRaceRoundViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionRaceRoundViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionRaceRoundViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionraceroundview.prefab"
	}
end

function YouthArenaThirdChampionRaceRoundViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionRaceRoundViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionRaceRoundView.New()
	}
end

return YouthArenaThirdChampionRaceRoundViewPresentor
