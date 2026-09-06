-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/PvEMissionViewPresentor.lua

module("logic.extensions.mission.view.PvEMissionViewPresentor", package.seeall)

local PvEMissionViewPresentor = class("PvEMissionViewPresentor", MissionViewPresentor)

function PvEMissionViewPresentor:ctor()
	PvEMissionViewPresentor.super.ctor(self)
end

function PvEMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PvEMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function PvEMissionViewPresentor:buildViews()
	return {
		PvEMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		PvEMissionFmtView.New()
	}
end

function PvEMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PvEMissionViewPresentor
