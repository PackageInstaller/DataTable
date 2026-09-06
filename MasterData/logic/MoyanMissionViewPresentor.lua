-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/mission/MoyanMissionViewPresentor.lua

module("logic.extensions.mangtower.view.MoyanMissionViewPresentor", package.seeall)

local MoyanMissionViewPresentor = class("MoyanMissionViewPresentor", MissionViewPresentor)

function MoyanMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoyanMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		ExpeditionMissionViewPresentor.itemExpPet,
		self:_addCommonRes()
	}
end

function MoyanMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function MoyanMissionViewPresentor:buildViews()
	return {
		MoyanMissionView.New(),
		MoyanFmtRightView.New(),
		MoyanFmtLeftView.New(),
		MoyanMissionFmtView.New()
	}
end

return MoyanMissionViewPresentor
