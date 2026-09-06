-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossMissionPresentor.lua

module("logic.extensions.worldboss.view.WorldBossMissionPresentor", package.seeall)

local WorldBossMissionPresentor = class("WorldBossMissionPresentor", MissionViewPresentor)

function WorldBossMissionPresentor:ctor()
	WorldBossMissionPresentor.super.ctor(self)
end

function WorldBossMissionPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldBossMissionPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/worldboss/worldbossmissionview.prefab",
		"ui/views/worldboss/worldbosstiredview.prefab",
		self:_addCommonRes()
	}
end

function WorldBossMissionPresentor:buildViews()
	return {
		WorldBossFormationLeftView.New(),
		WorldBossFormationRightView.New(),
		WorldBossMissionFmtView.New(),
		WorldBossMissionView.New()
	}
end

return WorldBossMissionPresentor
