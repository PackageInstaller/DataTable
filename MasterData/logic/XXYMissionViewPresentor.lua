-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/formation/XXYMissionViewPresentor.lua

module("logic.extensions.xinxiyamirror.view.formation.XXYMissionViewPresentor", package.seeall)

local XXYMissionViewPresentor = class("XXYMissionViewPresentor", MissionViewPresentor)

function XXYMissionViewPresentor:ctor()
	XXYMissionViewPresentor.super.ctor(self)
end

function XXYMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XXYMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function XXYMissionViewPresentor:buildViews()
	return {
		XXYMissionView.New(),
		XXYFmtRightView.New(),
		XXYFmtLeftView.New(),
		XXYMissionFmtView.New()
	}
end

return XXYMissionViewPresentor
