-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/formation/TongMissionViewPresentor.lua

module("logic.extensions.tongbattle.view.formation.TongMissionViewPresentor", package.seeall)

local TongMissionViewPresentor = class("TongMissionViewPresentor", MissionViewPresentor)

function TongMissionViewPresentor:ctor()
	TongMissionViewPresentor.super.ctor(self)
end

function TongMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function TongMissionViewPresentor:buildViews()
	return {
		TongMissionView.New(),
		TongFmtRightView.New(),
		TongFmtLeftView.New(),
		TongMissionFmtView.New()
	}
end

return TongMissionViewPresentor
