-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingWayMissionViewPresentor.lua

module("logic.extensions.kingway.view.KingWayMissionViewPresentor", package.seeall)

local KingWayMissionViewPresentor = class("KingWayMissionViewPresentor", MissionViewPresentor)

function KingWayMissionViewPresentor:ctor()
	KingWayMissionViewPresentor.super.ctor(self)
end

function KingWayMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingWayMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function KingWayMissionViewPresentor:buildViews()
	return {
		KingWayMissionView.New(),
		FormationRightView.New(),
		KingWayFmtLeftView.New(),
		KingWayMissionFmtView.New()
	}
end

function KingWayMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingWayMissionViewPresentor
