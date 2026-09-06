-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FWPNMissionViewPresentor.lua

module("logic.extensions.newfamily.view.war.formation.FWPNMissionViewPresentor", package.seeall)

local FWPNMissionViewPresentor = class("FWPNMissionViewPresentor", MissionViewPresentor)

function FWPNMissionViewPresentor:ctor()
	FWPNMissionViewPresentor.super.ctor(self)
end

function FWPNMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FWPNMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function FWPNMissionViewPresentor:buildViews()
	return {
		FWPNMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		FWPNMissionFmtView.New()
	}
end

return FWPNMissionViewPresentor
