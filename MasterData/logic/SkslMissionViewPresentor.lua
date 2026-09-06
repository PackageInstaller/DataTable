-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/formation/SkslMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.formation.SkslMissionViewPresentor", package.seeall)

local SkslMissionViewPresentor = class("SkslMissionViewPresentor", MissionViewPresentor)

function SkslMissionViewPresentor:ctor()
	SkslMissionViewPresentor.super.ctor(self)
end

function SkslMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkslMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function SkslMissionViewPresentor:buildViews()
	return {
		SkslMissionView.New(),
		FormationRightView.New(),
		SkslFormationLeftView.New(),
		SkslMissionFmtView.New()
	}
end

function SkslMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SkslMissionViewPresentor
