-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/CopyMissionFmtView.lua

module("logic.extensions.plotcopy.view.CopyMissionFmtView", package.seeall)

local CopyMissionFmtView = class("CopyMissionFmtView", MissionFmtView)

function CopyMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function CopyMissionFmtView:_getCreepCos()
	local teamId = self:_getMonsterCo().teamIds

	return (CopyConfig.instance:getTeamPets(teamId))
end

function CopyMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	local chapterId = params[1]
	local stageId = params[2]
	local cfgStage = CopyConfig.instance:getStageById(chapterId, stageId)

	return cfgStage or {}
end

return CopyMissionFmtView
