-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/BuffConfig.lua

module("logic.battle.config.BuffConfig", package.seeall)

local BuffConfig = class("BuffConfig", BaseConfig)

function BuffConfig:onInit()
	self._cfgBuff = false
	self._cfgBuffEffect = false
	self._buffDescKey2Code = {}
end

function BuffConfig:getNames()
	return {
		ConfigName.Buff,
		ConfigName.BuffEffect
	}
end

function BuffConfig:handleConfig(name, content)
	if name == ConfigName.Buff then
		self._cfgBuff = content
	elseif name == ConfigName.BuffEffect then
		self._cfgBuffEffect = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end

	self:_buildDescKey()
end

function BuffConfig:_buildDescKey()
	for k, v in pairs(self._cfgBuff.dataList) do
		self._buffDescKey2Code[v.skillDescKey] = v.id
	end
end

function BuffConfig:getBuffCO(code, noLog)
	local buffCO = self._cfgBuff[code]

	if code > 0 and not buffCO and not noLog and BattleLog.enableError then
		BattleLog.error(string.format("BuffConfig::cannot find buff config for code[%s]", code))
	end

	return buffCO
end

function BuffConfig:getBuffEffectCO(effectCode)
	return self._cfgBuffEffect[effectCode]
end

function BuffConfig:getBuffIdByKey(descKey)
	return self._buffDescKey2Code[descKey]
end

BuffConfig.instance = BuffConfig.New()

return BuffConfig
