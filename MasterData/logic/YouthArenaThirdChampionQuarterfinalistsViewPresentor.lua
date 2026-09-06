-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionQuarterfinalistsViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionQuarterfinalistsViewPresentor", package.seeall)

local YouthArenaThirdChampionQuarterfinalistsViewPresentor = class("YouthArenaThirdChampionQuarterfinalistsViewPresentor", ViewPresentor)

function YouthArenaThirdChampionQuarterfinalistsViewPresentor:ctor()
	YouthArenaThirdChampionQuarterfinalistsViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionQuarterfinalistsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionQuarterfinalistsViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionquarterfinalistsview.prefab"
	}
end

function YouthArenaThirdChampionQuarterfinalistsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionQuarterfinalistsViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionQuarterfinalistsView.New()
	}
end

return YouthArenaThirdChampionQuarterfinalistsViewPresentor
