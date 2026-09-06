-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScoreMainViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScoreMainViewPresentor", package.seeall)

local YouthArenaThirdChampionScoreMainViewPresentor = class("YouthArenaThirdChampionScoreMainViewPresentor", ViewPresentor)

function YouthArenaThirdChampionScoreMainViewPresentor:ctor()
	YouthArenaThirdChampionScoreMainViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionScoreMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionScoreMainViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionscoremainview.prefab"
	}
end

function YouthArenaThirdChampionScoreMainViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionScoreMainView.New()
	}
end

return YouthArenaThirdChampionScoreMainViewPresentor
