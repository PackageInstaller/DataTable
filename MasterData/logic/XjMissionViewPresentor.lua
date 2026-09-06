-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjMissionViewPresentor.lua

module("logic.extensions.xingjiang.view.XjMissionViewPresentor", package.seeall)

local XjMissionViewPresentor = class("XjMissionViewPresentor", MissionViewPresentor)

function XjMissionViewPresentor:ctor()
	XjMissionViewPresentor.super.ctor(self)
end

function XjMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function XjMissionViewPresentor:buildViews()
	return {
		XjMissionView.New(),
		XjMissionFmtRightView.New(),
		XjMissionFmtLeftView.New(),
		XjMissionFmtView.New()
	}
end

function XjMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return XjMissionViewPresentor
