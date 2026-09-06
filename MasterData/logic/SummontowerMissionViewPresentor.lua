-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerMissionViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerMissionViewPresentor", package.seeall)

local SummontowerMissionViewPresentor = class("SummontowerMissionViewPresentor", MissionViewPresentor)

SummontowerMissionViewPresentor.ViewResPath = "ui/views/summontower/summontowermissionview.prefab"

function SummontowerMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummontowerMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		SummontowerMissionViewPresentor.ViewResPath,
		self:_addCommonRes()
	}
end

function SummontowerMissionViewPresentor:buildViews()
	return {
		SummontowerMissionView.New(),
		SummontowerFmtRightView.New(),
		SummonTowerFmtLeftView.New(),
		SummontowerMissionFmtView.New()
	}
end

function SummontowerMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SummontowerMissionViewPresentor
