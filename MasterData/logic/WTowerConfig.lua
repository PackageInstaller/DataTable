-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/config/WTowerConfig.lua

module("logic.extensions.warriortower.config.WTowerConfig", package.seeall)

local WTowerConfig = class("WTowerConfig", BaseConfig)

function WTowerConfig:onInit()
	WTowerConfig.super.onInit(self)

	self._wtCfg = nil
	self._wtAnalysisCfg = nil
	self._dicCfg = nil
	self._crpCfg = nil
end

function WTowerConfig:getNames()
	return {
		"warrior_tower_monster",
		"warrior_tower_creeps",
		"warrior_tower_params",
		"warrior_tower_extra",
		"warrior_tower_profit"
	}
end

function WTowerConfig:handleConfig(name, content)
	print("hadndasda  = " .. name)

	if name == "warrior_tower_monster" then
		self._wtCfg = content

		self:analysisWt()
	elseif name == "warrior_tower_creeps" then
		self._crpCfg = content
	elseif name == "warrior_tower_params" then
		self._dicCfg = content
	elseif name == "warrior_tower_extra" then
		self._paraCfg = content
	elseif name == "warrior_tower_profit" then
		self._profitCfg = content
	end
end

function WTowerConfig:getCrpCfg(id)
	return self._crpCfg[id]
end

function WTowerConfig:analysisWt()
	self._wtAnalysisCfg = {}

	local i = 1

	while i do
		if self._wtCfg[i] == nil then
			break
		end

		self._wtAnalysisCfg[i] = {}

		for k, v in pairs(self._wtCfg[i]) do
			table.insert(self._wtAnalysisCfg[i], v)
		end

		ArraySort.sortOn(self._wtAnalysisCfg[i], "creepsMasterId")

		i = i + 1
	end
end

function WTowerConfig:getCfgById(id, towerId)
	return self._wtAnalysisCfg[towerId][id]
end

function WTowerConfig:getCfgCount(towerId)
	return #self._wtAnalysisCfg[towerId]
end

function WTowerConfig:getCfgs(TowerId)
	local data = {}
	local towerId = TowerId and TowerId or 1

	for i, v in ipairs(self._wtCfg.dataList) do
		if towerId == v.towerId then
			table.insert(data, v)
		end
	end

	return data
end

function WTowerConfig:getDicCfg(towerId)
	return self._dicCfg[towerId]
end

function WTowerConfig:getDicCfgList()
	local list = {}

	if self._dicCfg then
		for k, v in pairs(self._dicCfg) do
			if type(k) == "number" then
				table.insert(list, v)
			end
		end
	end

	table.sort(list, function(a, b)
		return a.towerId < b.towerId
	end)

	return list
end

function WTowerConfig:getParaCfg(keyName)
	if self._paraCfg[keyName] then
		if not string.nilorempty(self._paraCfg[keyName].paramValue2) then
			return self._paraCfg[keyName].paramValue2
		else
			return self._paraCfg[keyName].paramValue
		end
	end
end

function WTowerConfig:getProfitCfg()
	return self._profitCfg
end

WTowerConfig.instance = WTowerConfig.New()

return WTowerConfig
