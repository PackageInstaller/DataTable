-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/config/ContractConfig.lua

module("logic.extensions.contract.config.ContractConfig", package.seeall)

local ContractConfig = class("ContractConfig", BaseConfig)

function ContractConfig:onInit()
	ContractConfig.super.onInit(self)

	self._contractCfg = nil
	self._contractSkillStrategy = nil
	self._contractCommonCfg = nil
	self._summonerAndSummonDic = {}
	self._contractSkillStrategyDic = {}
end

function ContractConfig:getNames()
	return {
		"contract",
		"contract_skill_strategy",
		"contract_common",
		"carried_define",
		"oracle_define",
		"heaven_awaken_summon_define",
		"battle_book_spirit",
		"spirit_invocation_define"
	}
end

function ContractConfig:handleConfig(name, content)
	if name == "contract" then
		self._contractCfg = content

		self:handleContract(content.dataList)
		self:handleContractMap(content.dataList)
	elseif name == "contract_skill_strategy" then
		self._contractSkillStrategy = content
	elseif name == "contract_common" then
		self._contractCommonCfg = content
	elseif name == "carried_define" then
		self._carried_define = content
	elseif name == "oracle_define" then
		self._oracle_define = content
	elseif name == "heaven_awaken_summon_define" then
		self._heaven_awaken_summon_define = content
	elseif name == "battle_book_spirit" then
		self._battle_book_spirit = content
	elseif name == "spirit_invocation_define" then
		self._spirit_invocation_define = content
	end
end

function ContractConfig:getCfgById(id)
	return self._contractCfg[id]
end

function ContractConfig:getCarriedByRaceId(masterRaceId, raceId)
	if self._carried_define[masterRaceId] then
		return self._carried_define[masterRaceId][raceId]
	end
end

function ContractConfig:getOracleByRaceId(masterRaceId, raceId)
	if self._oracle_define[masterRaceId] then
		return self._oracle_define[masterRaceId][raceId]
	end
end

function ContractConfig:getContractList()
	if self._contractCfg then
		return self._contractCfg.dataList
	end

	return {}
end

function ContractConfig:getSkillStrategyBySkillId(contractSkillId)
	return self._contractSkillStrategy[contractSkillId]
end

function ContractConfig:getSkillStrategyById(strategyId)
	return self._contractSkillStrategy.dataList
end

function ContractConfig:getConstValueByKey(key)
	if self._contractCommonCfg[key] then
		if not string.nilorempty(self._contractCommonCfg[key].value2) then
			return self._contractCommonCfg[key].value2
		else
			return self._contractCommonCfg[key].value
		end
	end

	return ""
end

function ContractConfig:handleContract(dataList)
	self._summonerAndSummonDic = self._summonerAndSummonDic or {}

	for i, m in ipairs(dataList) do
		if m.summonMasterRaceIds and #m.summonMasterRaceIds > 0 and not m.isHide then
			for k, n in ipairs(m.summonMasterRaceIds) do
				if m.summonedRaceIds then
					self._summonerAndSummonDic[n] = self._summonerAndSummonDic[n] or {}

					for index, summonRaceId in ipairs(m.summonedRaceIds) do
						local element = {}

						element.summonRaceId = summonRaceId
						element.groupId = m.groupId

						table.insert(self._summonerAndSummonDic[n], element)
					end
				end
			end
		end
	end
end

function ContractConfig:handleContractMap(dataList)
	self._masterAndSummonsMap = self._masterAndSummonsMap or {}

	for i, cfg in ipairs(dataList) do
		if not cfg.isHide then
			for k, masterId in ipairs(cfg.summonMasterRaceIds or {}) do
				self._masterAndSummonsMap[masterId] = self._masterAndSummonsMap[masterId] or {}

				for index, summonRaceId in ipairs(cfg.summonedRaceIds or {}) do
					self._masterAndSummonsMap[masterId][summonRaceId] = cfg
				end
			end
		end
	end

	self._summonAndMastersMap = self._summonAndMastersMap or {}

	for i, cfg in ipairs(dataList) do
		if not cfg.isHide then
			for k, summonRaceId in ipairs(cfg.summonedRaceIds or {}) do
				self._summonAndMastersMap[summonRaceId] = self._summonAndMastersMap[summonRaceId] or {}

				for index, masterId in ipairs(cfg.summonMasterRaceIds or {}) do
					self._summonAndMastersMap[summonRaceId][masterId] = cfg
				end
			end
		end
	end
end

function ContractConfig:getGroupId(masterId, summonId)
	if self._masterAndSummonsMap and self._masterAndSummonsMap[masterId] and self._masterAndSummonsMap[masterId][summonId] then
		local cfg = self._masterAndSummonsMap[masterId][summonId]

		return cfg.groupId
	end

	return 0
end

function ContractConfig:getGroupCfg(masterId, summonId)
	if self._masterAndSummonsMap and self._masterAndSummonsMap[masterId] and self._masterAndSummonsMap[masterId][summonId] then
		return self._masterAndSummonsMap[masterId][summonId]
	end

	return nil
end

function ContractConfig:getMasterGroupCfgList(masterId)
	if self._masterAndSummonsMap then
		return self._masterAndSummonsMap[masterId]
	end

	return nil
end

function ContractConfig:getItsMasterList(summonId)
	if self._summonAndMastersMap then
		return self._summonAndMastersMap[summonId]
	end

	return nil
end

function ContractConfig:getSummonBySummonMasterId(summonMasterId)
	if self._summonerAndSummonDic[summonMasterId] then
		return self._summonerAndSummonDic[summonMasterId]
	end

	return {}
end

function ContractConfig:getBtlSummonFactor(summonMasterRaceId, summonRaceId)
	local cfg = self:getGroupCfg(summonMasterRaceId, summonRaceId)

	if cfg then
		return cfg.zdlFactor
	end

	return 1
end

function ContractConfig:getSummonMasterRaceIdList()
	local masterDic = {}

	for summonMasterRaceId, summon in pairs(self._summonerAndSummonDic) do
		for i, v in ipairs(summon) do
			local cfg = self:getCfgById(v.groupId)
			local isNewSummoner = cfg and checknumber(cfg.isNewOne) == 1

			if isNewSummoner and not masterDic[summonMasterRaceId] then
				masterDic[summonMasterRaceId] = true

				break
			end
		end
	end

	local list = {}

	for k, v in pairs(masterDic) do
		table.insert(list, k)
	end

	return list
end

function ContractConfig:getHeavenAwakenSummonCfgs(masterRaceId)
	return self._heaven_awaken_summon_define[masterRaceId]
end

function ContractConfig:getBookSpiritCfgs(masterRaceId)
	return self._battle_book_spirit[masterRaceId]
end

function ContractConfig:getBookSpiritByRaceId(masterRaceId, raceId)
	if self._battle_book_spirit[masterRaceId] then
		return self._battle_book_spirit[masterRaceId][raceId]
	end
end

function ContractConfig:getSpiritInvocationCfg(spiritInvocationSkillId)
	return self._spirit_invocation_define[spiritInvocationSkillId]
end

ContractConfig.instance = ContractConfig.New()

return ContractConfig
