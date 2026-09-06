-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/ExpeditionMissionViewPresentor.lua

module(..., package.seeall)

local ExpeditionMissionViewPresentor = class("ExpeditionMissionViewPresentor", MissionViewPresentor)

ExpeditionMissionViewPresentor.itemExpPet = "ui/views/expedition/item_exppet.prefab"

function ExpeditionMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExpeditionMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		ExpeditionMissionViewPresentor.itemExpPet,
		self:_addCommonRes()
	}
end

function ExpeditionMissionViewPresentor:buildViews()
	return {
		ExpeditionMissionView.New(),
		ExpeditionFmtRightView.New(),
		ExpeditionFmtLeftView.New(),
		ExpeditionMissionFmtView.New()
	}
end

function ExpeditionMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExpeditionMissionViewPresentor
