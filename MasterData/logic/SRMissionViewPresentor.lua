-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/formation/SRMissionViewPresentor.lua

module("logic.extensions.sunranbattle.view.formation.SRMissionViewPresentor", package.seeall)

local SRMissionViewPresentor = class("SRMissionViewPresentor", MissionViewPresentor)

function SRMissionViewPresentor:ctor()
	SRMissionViewPresentor.super.ctor(self)
end

function SRMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SRMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function SRMissionViewPresentor:buildViews()
	return {
		SRMissionView.New(),
		SRFmtRightView.New(),
		FormationLeftView.New(),
		SRMissionFmtView.New()
	}
end

return SRMissionViewPresentor
