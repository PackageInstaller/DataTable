-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/formation/SkslMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.formation.SkslMissionFmtView", package.seeall)

local SkslMissionFmtView = class("SkslMissionFmtView", MissionFmtView)

function SkslMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function SkslMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	local creepsMasterId = checknumber(params[2])
	local cCfg = ShikongshenglongConfig.instance:getCreepsCfg(creepsMasterId)

	return cCfg or {}
end

function SkslMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	local creepsMasterId = checknumber(params[2])
	local levelCfg = ShikongshenglongConfig.instance:getTeamCfg(creepsMasterId)

	return levelCfg or {}
end

return SkslMissionFmtView
