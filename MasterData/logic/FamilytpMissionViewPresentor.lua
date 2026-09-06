-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpMissionViewPresentor.lua

module("logic.extensions.familyteamplay.view.FamilytpMissionViewPresentor", package.seeall)

local FamilytpMissionViewPresentor = class("FamilytpMissionViewPresentor", MissionViewPresentor)

function FamilytpMissionViewPresentor:ctor()
	FamilytpMissionViewPresentor.super.ctor(self)
end

function FamilytpMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilytpMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/familyteamplay/imgtired.prefab",
		self:_addCommonRes()
	}
end

function FamilytpMissionViewPresentor:buildViews()
	return {
		FamilytpMissionView.New(),
		FamilytpFormationRightView.New(),
		FamilytpFormationLeftView.New(),
		FamilytpMissionFmtView.New()
	}
end

function FamilytpMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilytpMissionViewPresentor
