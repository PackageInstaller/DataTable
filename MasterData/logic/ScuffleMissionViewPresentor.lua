-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleMissionViewPresentor.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleMissionViewPresentor", package.seeall)

local ScuffleMissionViewPresentor = class("ScuffleMissionViewPresentor", MissionViewPresentor)

ScuffleMissionViewPresentor.FmtPetsPath = "ui/views/scuffle/scufflefmtpets.prefab"

function ScuffleMissionViewPresentor:ctor()
	ScuffleMissionViewPresentor.super.ctor(self)
end

function ScuffleMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		ScuffleMissionViewPresentor.FmtPetsPath,
		self:_addCommonRes()
	}
end

function ScuffleMissionViewPresentor:buildViews()
	return {
		ScuffleMissionView.New(),
		ScuffleFormationRightView.New(),
		ScuffleFormationLeftView.New(),
		ScuffleMissionFmtView.New()
	}
end

function ScuffleMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ScuffleMissionViewPresentor
