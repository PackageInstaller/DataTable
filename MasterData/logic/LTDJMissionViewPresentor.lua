-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/formation/LTDJMissionViewPresentor.lua

module("logic.extensions.luotiandajiao.view.formation.LTDJMissionViewPresentor", package.seeall)

local LTDJMissionViewPresentor = class("LTDJMissionViewPresentor", MissionViewPresentor)

function LTDJMissionViewPresentor:ctor()
	LTDJMissionViewPresentor.super.ctor(self)
end

function LTDJMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LTDJMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function LTDJMissionViewPresentor:buildViews()
	return {
		LTDJMissionView.New(),
		LTDJFormationRightView.New(),
		LTDJFormationLeftView.New(),
		LTDJMissionFmtView.New()
	}
end

return LTDJMissionViewPresentor
