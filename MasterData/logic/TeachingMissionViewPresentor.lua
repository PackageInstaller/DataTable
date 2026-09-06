-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingMissionViewPresentor.lua

module("logic.extensions.teachingdungeon.view.TeachingMissionViewPresentor", package.seeall)

local TeachingMissionViewPresentor = class("TeachingMissionViewPresentor", MissionViewPresentor)

function TeachingMissionViewPresentor:ctor()
	TeachingMissionViewPresentor.super.ctor(self)
end

function TeachingMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeachingMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function TeachingMissionViewPresentor:buildViews()
	return {
		TeachingMissionView.New(),
		TeachingFmtRightView.New(),
		TeachingFmtLeftView.New(),
		TeachingMissionFmtView.New()
	}
end

function TeachingMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TeachingMissionViewPresentor
