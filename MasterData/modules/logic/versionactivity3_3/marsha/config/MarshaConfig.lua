-- chunkname: @modules/logic/versionactivity3_3/marsha/config/MarshaConfig.lua

module("modules.logic.versionactivity3_3.marsha.config.MarshaConfig", package.seeall)

local MarshaConfig = class("MarshaConfig", BaseConfig)

function MarshaConfig:onInit()
	self._mapCos = {}
end

function MarshaConfig:reqConfigNames()
	return {
		"activity221_ball",
		"activity221_skill",
		"activity221_game"
	}
end

function MarshaConfig:getBallConfig(ballType)
	local config = lua_activity221_ball.configDict[ballType]

	if config then
		return config
	else
		logError(string.format("221_玛尔纱角色活动 情绪球表不存在BallType为 %s 的配置", ballType))
	end
end

function MarshaConfig:getSkillConfig(skillId)
	local config = lua_activity221_skill.configDict[skillId]

	if config then
		return config
	else
		logError(string.format("221_玛尔纱角色活动 技能表不存在SkillId为 %s 的配置", skillId))
	end
end

function MarshaConfig:getGameConfig(mapId)
	local gameCfg = lua_activity221_game.configDict[mapId]

	if gameCfg then
		return gameCfg
	else
		logError(string.format("221_玛尔纱角色活动 玩法关卡表不存在mapId为 %s 的配置", mapId))
	end
end

function MarshaConfig:getMapConfig(mapId)
	if not self._mapCos[mapId] then
		local co = MarshaMapCo.New()
		local rawCo = addGlobalModule("modules.configs.emoball.lua_emoball_map_" .. tostring(mapId), "lua_emoball_map_" .. tostring(mapId))

		if not rawCo then
			logError("221_玛尔纱角色活动 情绪球地图配置不存在" .. mapId)

			return
		end

		co:init(rawCo)

		self._mapCos[mapId] = co
	end

	return self._mapCos[mapId]
end

function MarshaConfig:getMapBallCnt(mapId, unitType)
	local count = 0
	local mapCo = self:getMapConfig(mapId)

	if mapCo then
		for _, unitCo in ipairs(mapCo.units) do
			if unitCo.unitType == unitType then
				count = count + 1
			end
		end
	end

	return count
end

function MarshaConfig:getSkillCoList(skillIdStr)
	local skillCoList = {}

	if not string.nilorempty(skillIdStr) then
		local skillIds = string.splitToNumber(skillIdStr, "|")

		for _, skillId in ipairs(skillIds) do
			skillCoList[#skillCoList + 1] = self:getSkillConfig(skillId)
		end
	end

	return skillCoList
end

MarshaConfig.instance = MarshaConfig.New()

return MarshaConfig
