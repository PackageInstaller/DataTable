-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareMissionViewPresentor.lua

module("logic.extensions.sharetask.view.ShareMissionViewPresentor", package.seeall)

local ShareMissionViewPresentor = class("ShareMissionViewPresentor", MissionViewPresentor)

function ShareMissionViewPresentor:ctor()
	ShareMissionViewPresentor.super.ctor(self)
end

function ShareMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShareMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function ShareMissionViewPresentor:buildViews()
	return {
		ShareMissionView.New(),
		ShareRightView.New(),
		ShareLeftView.New(),
		ShareMissionFmtView.New()
	}
end

function ShareMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShareMissionViewPresentor
