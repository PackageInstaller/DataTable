-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/config/StarGodConfig.lua

module("logic.extensions.stargod.config.StarGodConfig", package.seeall)

local StarGodConfig = class("StarGodConfig", BaseConfig)

StarGodConfig.MaxZhandouli = 1050

function StarGodConfig:onInit()
	StarGodConfig.super.onInit(self)

	self._stargodCfg = nil
	self._levelCfg = nil
	self._otherCfg = nil
	self._messengerCfg = nil
end

function StarGodConfig:getNames()
	return {
		"star_god_define",
		"star_god_level_define",
		"star_god_other_config",
		"star_god_messenger"
	}
end

function StarGodConfig:handleConfig(name, content)
	if name == "star_god_define" then
		self._stargodCfg = content
		self._stargodNameMap = {}

		for k, v in pairs(content) do
			if type(k) == "number" then
				self._stargodNameMap[v.typeName] = v
			end
		end
	elseif name == "star_god_level_define" then
		self._levelCfg = content
	elseif name == "star_god_other_config" then
		self._otherCfg = content
	elseif name == "star_god_messenger" then
		self._messengerCfg = content
	end
end

function StarGodConfig:getStarGodDefineByName(name)
	return self._stargodNameMap[name]
end

function StarGodConfig:getCfgByDefineId(id)
	return self._stargodCfg[id]
end

function StarGodConfig:getCfgs()
	return self._stargodCfg
end

function StarGodConfig:getLevelConfig(defineId, level)
	return self._levelCfg[defineId][level]
end

function StarGodConfig:getFightingPower(defineId, level)
	level = level or 1

	local levelCo = self:getLevelConfig(defineId, level)

	if levelCo then
		return levelCo.zhanDouLi
	end

	return 0
end

function StarGodConfig:getOtherConfig(key)
	return self._otherCfg[key]
end

function StarGodConfig:getBagCapacity(isRed, cLevel)
	if isRed then
		return checknumber(self._otherCfg.RED_CAPACITY.value)
	else
		return checknumber(string.split(self._otherCfg.CAPACITY.value, ",")[cLevel + 1])
	end
end

function StarGodConfig:getMessengerConfig(id)
	return self._messengerCfg[id]
end

StarGodConfig.instance = StarGodConfig.New()

return StarGodConfig
