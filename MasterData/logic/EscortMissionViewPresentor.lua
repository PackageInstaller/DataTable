-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortMissionViewPresentor.lua

module("logic.extensions.escort.view.EscortMissionViewPresentor", package.seeall)

local EscortMissionViewPresentor = class("EscortMissionViewPresentor", MissionViewPresentor)

function EscortMissionViewPresentor:ctor()
	EscortMissionViewPresentor.super.ctor(self)
end

function EscortMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EscortMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function EscortMissionViewPresentor:buildViews()
	return {
		EscortMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		EscortMissionFmtView.New()
	}
end

function EscortMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EscortMissionViewPresentor
