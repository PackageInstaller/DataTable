-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/evolve/config/EvolveConfig.lua

module("logic.extensions.evolve.config.EvolveConfig", package.seeall)

local EvolveConfig = class("EvolveConfig", BaseConfig)

function EvolveConfig:onInit()
	EvolveConfig.super.onInit(self)

	self._petEvolveCfg = nil
	self.pet_divine_evolution = nil
	self.divineDic = nil
	self.pet_divine_plus_evolution = nil
	self.divinePlusDic = nil
	self.pet_divine_exchange = nil
	self.pet_divine_common = nil
	self._raceIdMapByEvolveItemId = nil
end

function EvolveConfig:getNames()
	return {
		"pet_evolve",
		"pet_divine_evolution",
		"pet_divine_plus_evolution",
		"pet_divine_exchange",
		"pet_divine_common"
	}
end

function EvolveConfig:handleConfig(name, content)
	if name == "pet_evolve" then
		self._petEvolveCfg = content
	elseif name == "pet_divine_evolution" then
		self.pet_divine_evolution = content

		self:handleDivine(content.dataList)
	elseif name == "pet_divine_plus_evolution" then
		self.pet_divine_plus_evolution = content

		self:handleDivinePlus(content.dataList)
	elseif name == "pet_divine_exchange" then
		self.pet_divine_exchange = content
	elseif name == "pet_divine_common" then
		self.pet_divine_common = content
	end
end

function EvolveConfig:handleDivine(dataList)
	self.divineDic = {}

	for i, v in ipairs(dataList) do
		self.divineDic[v.newRaceId] = v
	end
end

function EvolveConfig:handleDivinePlus(dataList)
	self.divinePlusDic = {}

	for i, v in ipairs(dataList) do
		self.divinePlusDic[v.newRaceId] = v
	end
end

function EvolveConfig:getCfgById(raceId, newRaceId)
	if self._petEvolveCfg[raceId] then
		return self._petEvolveCfg[raceId][newRaceId]
	end

	return nil
end

function EvolveConfig:getCfgByCost(rewardStr)
	if string.nilorempty(rewardStr) then
		return
	end

	local list = string.split(rewardStr, ":")

	if list and #list >= 2 then
		for i, v in ipairs(self._petEvolveCfg.dataList) do
			if not string.nilorempty(v.cost) then
				local costMatList = string.split(v.cost, ":")

				if costMatList and #costMatList >= 2 and costMatList[1] == list[1] and costMatList[2] == list[2] then
					return v
				end
			end
		end
	end
end

function EvolveConfig:getDivineEvolveCfgList()
	return self.pet_divine_evolution.dataList
end

function EvolveConfig:getAvailableTimeEvolveCfgList()
	local list = {}

	for i, v in ipairs(self.pet_divine_evolution.dataList) do
		local isLimitCfg = i >= 3

		if isLimitCfg then
			local cfgLimit = TimeLimitedConfig.instance:getCfgById(v.challengeId)

			if cfgLimit and GameUtil.checkIsInTimePeriod(cfgLimit.absoluteOpenDay, cfgLimit.absoluteEndDay) then
				table.insert(list, v)
			end
		else
			table.insert(list, v)
		end
	end

	return list
end

function EvolveConfig:getDivineEvolveCfg(raceId)
	return self.pet_divine_evolution[raceId]
end

function EvolveConfig:isCanDivine(raceId)
	local cfg = self.pet_divine_evolution[raceId]

	if not cfg then
		return false
	end

	if cfg.challengeId <= 2 then
		return true
	end

	local cfgLimit = TimeLimitedConfig.instance:getCfgById(cfg.challengeId)

	if cfgLimit and GameUtil.checkIsInTimePeriod(cfgLimit.absoluteOpenDay, cfgLimit.absoluteEndDay) then
		return true
	else
		return false
	end
end

function EvolveConfig:getDivineEvolveCfgByNewRaceId(newRaceId)
	return self.divineDic[newRaceId]
end

function EvolveConfig:getDivineEvolveCfgByChallengeId(challengeId)
	for i, v in ipairs(self.pet_divine_evolution.dataList) do
		if v.challengeId == challengeId then
			return v
		end
	end
end

function EvolveConfig:getDivineEnterPopupPowerLimit()
	if not self.pet_divine_common then
		return 0
	end

	local cfg = self.pet_divine_common.ENTER_POPUP_POWER_LIMIT

	return cfg and checknumber(cfg.value) or 0
end

function EvolveConfig:getDivineEnterPopupTips()
	if not self.pet_divine_common then
		return ""
	end

	local cfg = self.pet_divine_common.ENTER_POPUP_POWER_LIMIT

	return (cfg or nil) and (cfg.desc or "")
end

function EvolveConfig:getDivineExchangeJump()
	if not self.pet_divine_common then
		return ""
	end

	local cfg = self.pet_divine_common.EXCHANGE_JUMP

	return (cfg or nil) and (cfg.value or "")
end

function EvolveConfig:getDivineMaterialJump()
	if not self.pet_divine_common then
		return ""
	end

	local cfg = self.pet_divine_common.MATERIAL_JUMP

	return (cfg or nil) and (cfg.value or "")
end

function EvolveConfig:getNewRaceId()
	local count = #self.pet_divine_evolution.dataList

	return self.pet_divine_evolution.dataList[count].newRaceId or 0
end

function EvolveConfig:getDivineEvolvePlusList()
	return self.pet_divine_plus_evolution.dataList
end

function EvolveConfig:getReverseDivineEvolvePlusList()
	local cfgList = self.pet_divine_plus_evolution.dataList
	local copyCfgList = {}

	for i, v in ipairs(cfgList) do
		if v.evolutionType == EvolveEnum.EvolveType.Divine then
			if string.nilorempty(v.beginTime) then
				table.insert(copyCfgList, v)
			else
				local beginTime = GameUtil.string2time(v.beginTime)

				if beginTime <= ServerTime.now() then
					table.insert(copyCfgList, v)
				end
			end
		end
	end

	GameUtil.reverse(copyCfgList)

	return copyCfgList
end

function EvolveConfig:getDivineEvolvePlusCfg(raceId, evolutionType)
	if self.pet_divine_plus_evolution[raceId] then
		for i, v in pairs(self.pet_divine_plus_evolution[raceId]) do
			if v.evolutionType == evolutionType then
				return v
			end
		end
	end
end

function EvolveConfig:getDivineEvolvePlusCfgByNewRaceId(newRaceId)
	return self.divinePlusDic[newRaceId]
end

function EvolveConfig:getExchangeCfg(raceId)
	return self.pet_divine_exchange[raceId]
end

function EvolveConfig:getEvolvRaceIdByItemId(itemId)
	if self._raceIdMapByEvolveItemId == nil then
		local map = {}
		local cfgList = self.pet_divine_plus_evolution.dataList

		for i, v in ipairs(cfgList) do
			local costItemStr = v.goodsCost
			local matType, cfgId = MaterialMgr.getMatParams(costItemStr)

			if cfgId then
				map[cfgId] = v.newRaceId
			end
		end

		self._raceIdMapByEvolveItemId = map
	end

	return self._raceIdMapByEvolveItemId[itemId]
end

EvolveConfig.instance = EvolveConfig.New()

return EvolveConfig
