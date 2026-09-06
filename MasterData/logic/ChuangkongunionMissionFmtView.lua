-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionMissionFmtView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionMissionFmtView", package.seeall)

local ChuangkongunionMissionFmtView = class("ChuangkongunionMissionFmtView", MissionFmtView)

function ChuangkongunionMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function ChuangkongunionMissionFmtView:_getCreepCos()
	local teamCfg = self:_getMonsterCo()

	return (ChuangkongunionConfig.instance:getCreepsById(teamCfg.creepsMasterId))
end

function ChuangkongunionMissionFmtView:_getMonsterCo()
	local _openParam = self:getOpenParam()
	local _teamId = _openParam[3]

	return (ChuangkongunionConfig.instance:getTeamById(_teamId or _openParam[1].teamId))
end

return ChuangkongunionMissionFmtView
