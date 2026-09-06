-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionShowViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionShowViewPresentor", package.seeall)

local YouthArenaThirdChampionShowViewPresentor = class("YouthArenaThirdChampionShowViewPresentor", ViewPresentor)

function YouthArenaThirdChampionShowViewPresentor:ctor()
	YouthArenaThirdChampionShowViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionShowViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionshowview.prefab"
	}
end

function YouthArenaThirdChampionShowViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionShowViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionShowView.New()
	}
end

return YouthArenaThirdChampionShowViewPresentor
