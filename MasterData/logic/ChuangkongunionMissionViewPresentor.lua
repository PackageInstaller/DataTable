-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionMissionViewPresentor.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionMissionViewPresentor", package.seeall)

local ChuangkongunionMissionViewPresentor = class("ChuangkongunionMissionViewPresentor", MissionViewPresentor)

function ChuangkongunionMissionViewPresentor:ctor()
	ChuangkongunionMissionViewPresentor.super.ctor(self)
end

function ChuangkongunionMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangkongunionMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function ChuangkongunionMissionViewPresentor:buildViews()
	return {
		ChuangkongunionMissionView.New(),
		ChuangkongunionFormationRightView.New(),
		ChuangkongunionMissionLeftView.New(),
		ChuangkongunionMissionFmtView.New()
	}
end

function ChuangkongunionMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ChuangkongunionMissionViewPresentor
