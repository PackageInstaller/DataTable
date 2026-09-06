-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/energy/config/EnergyConfig.lua

module("logic.extensions.energy.config.EnergyConfig", package.seeall)

local EnergyConfig = class("EnergyConfig", BaseConfig)

function EnergyConfig:onInit()
	EnergyConfig.super.onInit(self)
end

function EnergyConfig:getNames()
	return {
		"energy_define",
		"energy_buy_times"
	}
end

function EnergyConfig:handleConfig(name, content)
	if name == "energy_define" then
		self.energy_cfg = content
	elseif name == "energy_buy_times" then
		self.energy_buy_cfg = content
	end
end

function EnergyConfig:getEnergyCfg(id)
	return self.energy_cfg[id]
end

function EnergyConfig:getEnergyBuyCfgList(buyPlanId)
	local list = {}

	for k, v in pairs(self.energy_buy_cfg[buyPlanId]) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.times < b.times
	end)

	return list
end

EnergyConfig.instance = EnergyConfig.New()

return EnergyConfig
