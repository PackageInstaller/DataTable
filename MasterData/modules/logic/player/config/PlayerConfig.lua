-- chunkname: @modules/logic/player/config/PlayerConfig.lua

module("modules.logic.player.config.PlayerConfig", package.seeall)

local PlayerConfig = class("PlayerConfig", BaseConfig)

function PlayerConfig:ctor()
	self.playconfig = nil
	self._clothSkillDict = nil
	self.playerClothConfig = nil
	self.playerBgDict = nil
end

function PlayerConfig:reqConfigNames()
	return {
		"player_level",
		"cloth",
		"cloth_level",
		"player_bg"
	}
end

function PlayerConfig:onConfigLoaded(configName, configTable)
	if configName == "player_level" then
		self.playconfig = configTable
	elseif configName == "cloth_level" then
		self._clothSkillDict = {}

		for _, clothLevelCO in ipairs(configTable.configList) do
			self:_initClothSkill(clothLevelCO, 1)
			self:_initClothSkill(clothLevelCO, 2)
			self:_initClothSkill(clothLevelCO, 3)
		end
	elseif configName == "cloth" then
		self.playerClothConfig = configTable

		self:buildPlayerConfigRare()
	elseif configName == "player_bg" then
		self.playerBgDict = {}

		for _, bgCo in ipairs(configTable.configList) do
			self.playerBgDict[bgCo.item] = bgCo
		end
	end
end

function PlayerConfig:buildPlayerConfigRare()
	if not self.playerClothConfig then
		return
	end

	local oldMetatable = getmetatable(lua_cloth.configList[1])
	local metatable = {}

	function metatable.__index(t, key)
		if key == "rare" then
			return 5
		end

		return oldMetatable.__index(t, key)
	end

	metatable.__newindex = oldMetatable.__newindex

	for _, clothCo in ipairs(lua_cloth.configList) do
		setmetatable(clothCo, metatable)
	end
end

function PlayerConfig:getBgCo(bgId)
	return self.playerBgDict[bgId]
end

function PlayerConfig:_initClothSkill(clothLevelCO, index)
	local clothId = clothLevelCO.id
	local level = clothLevelCO.level
	local skillId = clothLevelCO["skill" .. index]

	if skillId and skillId > 0 then
		self._clothSkillDict[clothId] = self._clothSkillDict[clothId] or {}
		self._clothSkillDict[clothId][index] = self._clothSkillDict[clothId][index] or {
			skillId,
			level
		}
	end
end

function PlayerConfig:getPlayerLevelCO(level)
	return self.playconfig.configDict[level]
end

function PlayerConfig:getPlayerClothConfig(id)
	return self.playerClothConfig.configDict[id]
end

function PlayerConfig:getClothSkill(clothId, skillIndex)
	if self._clothSkillDict then
		local clothSkills = self._clothSkillDict[clothId]

		if clothSkills then
			return clothSkills[skillIndex]
		end
	end
end

PlayerConfig.instance = PlayerConfig.New()

return PlayerConfig
