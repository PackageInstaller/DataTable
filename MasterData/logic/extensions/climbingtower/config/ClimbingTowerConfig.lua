-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/config/ClimbingTowerConfig.lua

module("logic.extensions.climbingtower.config.ClimbingTowerConfig", package.seeall)

local M = class("ClimbingTowerConfig", BaseConfig)

function M:onInit()
	self._maxStoreyBrightSide = 1
	self._cfgTowerBrightSide = {}
	self._cfgTowerDarkSide = {}
	self._cfgTowerEffect = {}
	self._cfgDarkRound = {}
end

function M:getNames()
	return {
		ConfigName.LightMoonTower,
		ConfigName.DarkMoonTower,
		ConfigName.TowerEffect,
		ConfigName.DarkRound,
		ConfigName.ClimbTowerConst
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.LightMoonTower then
		for k, v in pairs(content.dataList or {}) do
			self._cfgTowerBrightSide[v.id] = v

			if v.id >= self._maxStoreyBrightSide then
				self._maxStoreyBrightSide = v.id
			end
		end
	elseif name == ConfigName.DarkMoonTower then
		self._darkContent = content

		for k, v in pairs(content.dataList or {}) do
			self._cfgTowerDarkSide[v.id] = ClimbingTowerDarkCO.New(v)
		end
	elseif name == ConfigName.TowerEffect then
		for k, v in pairs(content.dataList or {}) do
			self._cfgTowerEffect[v.code] = ClimbingTowerEffectCO.New(v)
		end
	elseif name == ConfigName.DarkRound then
		for k, v in pairs(content.dataList or {}) do
			self._cfgDarkRound[v.round] = ClimbingTowerDarkRoundCO.New(v)
		end
	end
end

function M:getConst(key)
	local data = self:getConfig(ConfigName.ClimbTowerConst)

	return data[key]
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getDarkList()
	return self._darkContent
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getBrightTowerDungeonIdByCode(code)
	local dungeonId = 0

	if self._cfgTowerBrightSide[code] then
		dungeonId = self._cfgTowerBrightSide[code].dungeon
	else
		printError(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.LightMoonTower, code))
	end

	return dungeonId
end

function M:getBrightSideMaxStorey()
	return self._maxStoreyBrightSide
end

function M:getDarkSideUnLockCondition()
	return self:getConst("DarkTowerUnlockCondition").numValue
end

function M:getTowerIndexNameBrightSide(code)
	local dungeonId = self:getBrightTowerDungeonIdByCode(code)
	local dungeonMo = ClimbingTowerModel.instance:getDungeonMoById(dungeonId)

	return dungeonMo and dungeonMo:getIndex() or ""
end

function M:getDarkTowerCO(id)
	if self._cfgTowerDarkSide[id] then
		return self._cfgTowerDarkSide[id]
	end

	printError(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.DarkMoonTower, id))

	return nil
end

function M:getTowerEffectCOMap()
	return self._cfgTowerEffect
end

function M:getTowerEffectCO(code)
	if self._cfgTowerEffect[code] then
		return self._cfgTowerEffect[code]
	end

	printError(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.TowerEffect, code))

	return nil
end

function M:getDarkRoundCO(round)
	if self._cfgDarkRound[round] then
		return self._cfgDarkRound[round]
	end

	printWarn(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.DarkRound, round))

	return nil
end

function M:getTimePointerAngleZ(hour, min)
	hour = hour > 12 and hour - 12 or hour

	local baseAngleHour = 30
	local baseAngleMin = 6
	local angleHour = baseAngleHour * hour
	local angleMin = baseAngleMin * min

	angleHour = angleHour + min / 60 * baseAngleHour

	return angleHour, angleMin
end

M.instance = M.New()

return M
