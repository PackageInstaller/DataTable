-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MCMissionViewPresentor.lua

module("logic.extensions.materialchallenge.view.MCMissionViewPresentor", package.seeall)

local MCMissionViewPresentor = class("MCMissionViewPresentor", MissionViewPresentor)

function MCMissionViewPresentor:ctor()
	MCMissionViewPresentor.super.ctor(self)
end

function MCMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MCMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function MCMissionViewPresentor:buildViews()
	return {
		MCMissionView.New(),
		MCRightView.New(),
		MCFormationLeftView.New(),
		MCMissionFmtView.New()
	}
end

return MCMissionViewPresentor
