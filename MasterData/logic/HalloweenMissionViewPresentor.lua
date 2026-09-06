-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/formation/HalloweenMissionViewPresentor.lua

module("logic.extensions.halloweenguest.view.formation.HalloweenMissionViewPresentor", package.seeall)

local HalloweenMissionViewPresentor = class("HalloweenMissionViewPresentor", MissionViewPresentor)

function HalloweenMissionViewPresentor:ctor()
	HalloweenMissionViewPresentor.super.ctor(self)
end

function HalloweenMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HalloweenMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function HalloweenMissionViewPresentor:buildViews()
	return {
		HalloweenMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		HalloweenMissionFmtView.New()
	}
end

return HalloweenMissionViewPresentor
