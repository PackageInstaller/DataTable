-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionRaceTabViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionRaceTabViewPresentor", package.seeall)

local YouthArenaThirdChampionRaceTabViewPresentor = class("YouthArenaThirdChampionRaceTabViewPresentor", ViewPresentor)

function YouthArenaThirdChampionRaceTabViewPresentor:ctor()
	YouthArenaThirdChampionRaceTabViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionRaceTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionRaceTabViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionracetabview.prefab"
	}
end

function YouthArenaThirdChampionRaceTabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionRaceTabViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionRaceTabView.New()
	}
end

return YouthArenaThirdChampionRaceTabViewPresentor
