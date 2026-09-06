-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScoreMyScheduleViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScoreMyScheduleViewPresentor", package.seeall)

local YouthArenaThirdChampionScoreMyScheduleViewPresentor = class("YouthArenaThirdChampionScoreMyScheduleViewPresentor", ViewPresentor)

function YouthArenaThirdChampionScoreMyScheduleViewPresentor:ctor()
	YouthArenaThirdChampionScoreMyScheduleViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionScoreMyScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChampionScoreMyScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdchampionscoremyscheduleview.prefab"
	}
end

function YouthArenaThirdChampionScoreMyScheduleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdChampionScoreMyScheduleViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionScoreMyScheduleView.New()
	}
end

return YouthArenaThirdChampionScoreMyScheduleViewPresentor
