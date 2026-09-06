-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionMyScheduleViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionMyScheduleViewPresentor", package.seeall)

local YouthArenaThirdChampionMyScheduleViewPresentor = class("YouthArenaThirdChampionMyScheduleViewPresentor", ViewPresentor)

function YouthArenaThirdChampionMyScheduleViewPresentor:ctor()
	YouthArenaThirdChampionMyScheduleViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionMyScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionMyScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionmyscheduleview.prefab"
	}
end

function YouthArenaThirdChampionMyScheduleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionMyScheduleViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionMyScheduleView.New()
	}
end

return YouthArenaThirdChampionMyScheduleViewPresentor
