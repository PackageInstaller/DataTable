-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xj2MissionViewPresentor.lua

module("logic.extensions.xingjiang.view.Xj2MissionViewPresentor", package.seeall)

local Xj2MissionViewPresentor = class("Xj2MissionViewPresentor", MissionViewPresentor)

function Xj2MissionViewPresentor:ctor()
	Xj2MissionViewPresentor.super.ctor(self)
end

function Xj2MissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Xj2MissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function Xj2MissionViewPresentor:buildViews()
	return {
		Xj2MissionView.New(),
		Xj2MissionFmtRightView.New(),
		Xj2MissionFmtLeftView.New(),
		Xj2MissionFmtView.New()
	}
end

function Xj2MissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Xj2MissionViewPresentor
