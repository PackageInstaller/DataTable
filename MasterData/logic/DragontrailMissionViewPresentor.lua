-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/mission/DragontrailMissionViewPresentor.lua

module("logic.extensions.dragontrial.view.mission.DragontrailMissionViewPresentor", package.seeall)

local DragontrailMissionViewPresentor = class("DragontrailMissionViewPresentor", MissionViewPresentor)

function DragontrailMissionViewPresentor:ctor()
	DragontrailMissionViewPresentor.super.ctor(self)
end

function DragontrailMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrailMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function DragontrailMissionViewPresentor:buildViews()
	return {
		DragontrailMissionView.New(),
		DragontrailFormationRightView.New(),
		DragontrailFormationLeftView.New(),
		DragontrailMissionFmtView.New()
	}
end

function DragontrailMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragontrailMissionViewPresentor
