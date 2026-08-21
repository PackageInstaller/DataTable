-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/EffectConfig.lua

module("logic.battle.config.EffectConfig", package.seeall)

local EffectConfig = class("EffectConfig", BaseConfig)

function EffectConfig:onInit()
	self._cfgEffect = false
	self._cfgFullEffectPrefab = false
end

function EffectConfig:getNames()
	return {
		ConfigName.Effect,
		ConfigName.FullEffectPrefab
	}
end

function EffectConfig:handleConfig(name, content)
	if name == ConfigName.Effect then
		self._cfgEffect = content
	elseif name == ConfigName.FullEffectPrefab then
		self._cfgFullEffectPrefab = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function EffectConfig:getEffectCO(code)
	local effectCO = self._cfgEffect[code]

	if code > 0 and not effectCO and BattleLog.enableError then
		BattleLog.error(string.format("EffectConfig::cannot find effect config for code[%s]", code))
	end

	return effectCO
end

function EffectConfig:getEffectPrefab(code)
	local effectCO = self._cfgFullEffectPrefab[code]

	if code > 0 and not effectCO and enableErrorLog then
		printError(string.format("EffectConfig::cannot find effect config for code[%s]", code))
	end

	return effectCO
end

EffectConfig.instance = EffectConfig.New()

return EffectConfig
