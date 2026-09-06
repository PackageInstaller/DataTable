-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/mission/DragontrailMissionFmtView.lua

module("logic.extensions.dragontrial.view.mission.DragontrailMissionFmtView", package.seeall)

local DragontrailMissionFmtView = class("DragontrailMissionFmtView", MissionFmtView)

function DragontrailMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function DragontrailMissionFmtView:_getCreepCos()
	local cfgStage = self:_getMonsterCo()

	return (DragontrialConfig.instance:getCreeps(cfgStage.creepsMasterId))
end

function DragontrailMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()
	local planId = params[1]
	local stageId = params[2]

	return (DragontrialConfig.instance:getStageById(planId, stageId))
end

return DragontrailMissionFmtView
