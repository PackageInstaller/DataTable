-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionKnockoutMainViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionKnockoutMainViewPresentor", package.seeall)

local YouthArenaThirdChampionKnockoutMainViewPresentor = class("YouthArenaThirdChampionKnockoutMainViewPresentor", ViewPresentor)

function YouthArenaThirdChampionKnockoutMainViewPresentor:ctor()
	YouthArenaThirdChampionKnockoutMainViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionKnockoutMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionKnockoutMainViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionknockoutmainview.prefab"
	}
end

function YouthArenaThirdChampionKnockoutMainViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionKnockoutMainView.New()
	}
end

return YouthArenaThirdChampionKnockoutMainViewPresentor
