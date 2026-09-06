-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/EBMissionViewPresentor.lua

module("logic.extensions.mission.view.EBMissionViewPresentor", package.seeall)

local EBMissionViewPresentor = class("EBMissionViewPresentor", MissionViewPresentor)

function EBMissionViewPresentor:ctor()
	EBMissionViewPresentor.super.ctor(self)
end

function EBMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EBMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function EBMissionViewPresentor:buildViews()
	return {
		EBMissionView.New(),
		EBRightView.New(),
		EBFormationLeftView.New(),
		EBMissionFmtView.New()
	}
end

function EBMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EBMissionViewPresentor
