-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/config/DomainCultivateConfig.lua

module("logic.extensions.throwshells.config.DomainCultivateConfig", package.seeall)

local DomainCultivateConfig = class("DomainCultivateConfig", BaseConfig)

function DomainCultivateConfig:onInit()
	DomainCultivateConfig.super.onInit(self)

	self._paramCfg = nil
	self._actCfg = nil
	self._gameCfg = nil
	self._buyCfg = nil
	self._terrCfg = nil
	self._monsterCfg = nil
	self._propCfg = nil
end

function DomainCultivateConfig:getNames()
	return {
		"kamui_level",
		"kamui_define",
		"kamui_program"
	}
end

function DomainCultivateConfig:handleConfig(name, content)
	if name == "kamui_level" then
		self._levelCfg = content
	elseif name == "kamui_define" then
		self._defineCfg = content
	elseif name == "kamui_program" then
		self._programCfg = content
	end
end

function DomainCultivateConfig:getLevelCfg(id)
	return self._levelCfg[id]
end

function DomainCultivateConfig:getLevelCfg2(id, level)
	return self._levelCfg[id][level]
end

function DomainCultivateConfig:getDefineCfg(id)
	return self._defineCfg[id]
end

function DomainCultivateConfig:getProgramCfg(id, level)
	return self._programCfg[id][level]
end

function DomainCultivateConfig:getProgramCfgList(id, level)
	local t = self._programCfg[id][level]
	local list = {}

	for k, v in pairs(t) do
		table.insert(list, v)
	end

	return list
end

DomainCultivateConfig.instance = DomainCultivateConfig.New()

return DomainCultivateConfig
