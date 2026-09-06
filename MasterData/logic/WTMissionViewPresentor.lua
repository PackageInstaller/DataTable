-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WTMissionViewPresentor.lua

module("logic.extensions.mission.view.WTMissionViewPresentor", package.seeall)

local WTMissionViewPresentor = class("WTMissionViewPresentor", MissionViewPresentor)

function WTMissionViewPresentor:ctor()
	WTMissionViewPresentor.super.ctor(self)
end

function WTMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WTMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function WTMissionViewPresentor:buildViews()
	return {
		WTMissionView.New(),
		WarriorFormationRightView.New(),
		WarriorFormationLeftView.New(),
		WTMissionFmtView.New()
	}
end

return WTMissionViewPresentor
