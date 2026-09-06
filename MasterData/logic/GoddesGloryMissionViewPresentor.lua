-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryMissionViewPresentor.lua

module(..., package.seeall)

local GoddesGloryMissionViewPresentor = class("GoddesGloryMissionViewPresentor", MissionViewPresentor)

GoddesGloryMissionViewPresentor.missionRes = "ui/views/goddessglory/goddessglorymissionview.prefab"

function GoddesGloryMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesGloryMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		GoddesGloryMissionViewPresentor.missionRes,
		self:_addCommonRes()
	}
end

function GoddesGloryMissionViewPresentor:buildViews()
	return {
		GoddesGloryMissionView.New(),
		GoddesGloryFmtRightView.New(),
		GoddesGloryFmtLeftView.New(),
		GoddesGloryMissionFmtView.New()
	}
end

function GoddesGloryMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddesGloryMissionViewPresentor
