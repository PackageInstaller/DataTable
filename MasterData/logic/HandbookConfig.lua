-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/config/HandbookConfig.lua

module("logic.extensions.handbook.config.HandbookConfig", package.seeall)

local HandbookConfig = class("HandbookConfig", BaseConfig)

function HandbookConfig:onInit()
	HandbookConfig.super.onInit(self)
	print("init HandbookConfig")
end

function HandbookConfig:getNames()
	return {
		"pet_manual_team",
		"pet_manual_team_collect_prize",
		"pet_manual_team_awaken_prize",
		"pet_manual_team_prize",
		"pet_details",
		"pet_information",
		"pet_manual_common_config",
		"pet_manual_benefit",
		"pet_poster_res",
		"power_check_define",
		"power_check_common",
		"power_check_strategy",
		"power_check_detail",
		"pet_rank_define",
		"pet_rank_common",
		"pet_rank_common_client",
		"pet_rank_tab",
		"pet_rank_prize"
	}
end

function HandbookConfig:handleConfig(name, content)
	if name == "pet_manual_team" then
		self._teamCfgs = content
		self._raceIdToTeamId = {}

		for teamId, cfg in pairs(self._teamCfgs) do
			if checknumber(teamId) > 0 then
				for _, raceId in ipairs(cfg.needRaceIds) do
					self._raceIdToTeamId[raceId] = self._raceIdToTeamId[raceId] or {}

					table.insert(self._raceIdToTeamId[raceId], teamId)
				end
			end
		end
	elseif name == "pet_manual_team_collect_prize" then
		self._collectPrizeCfgs = content
	elseif name == "pet_manual_team_awaken_prize" then
		self._awakenPrizeCfgs = content
	elseif name == "pet_manual_team_prize" then
		self._teamPrizeCfg = content

		self:calcMaxZdlAndAttr()
	elseif name == "pet_details" then
		self._petDetailsCfgs = content
	elseif name == "pet_information" then
		self._petInformation = content
	elseif name == "pet_manual_common_config" then
		self._petCommonCfgs = content
	elseif name == "pet_manual_benefit" then
		self._petBenefitCfgs = content
	elseif name == "pet_poster_res" then
		self._petPosterResCfgs = content
	elseif name == "power_check_define" then
		self.power_check_defineCfg = content
	elseif name == "power_check_common" then
		self.power_check_commonCfg = content
	elseif name == "power_check_strategy" then
		self.power_check_strategyCfg = content
	elseif name == "power_check_detail" then
		self.power_check_detailCfg = content
	elseif name == "pet_rank_define" then
		self.pet_rank_define_array = content
		self.pet_rank_define_map = {}

		for id, conf in pairs(self.pet_rank_define_array) do
			if checknumber(id) > 0 then
				self.pet_rank_define_map[conf.raceId] = conf
			end
		end
	elseif name == "pet_rank_common" then
		self.pet_rank_common = content
	elseif name == "pet_rank_common_client" then
		self.pet_rank_common_client = content
	elseif name == "pet_rank_tab" then
		self.pet_rank_tab = content
	elseif name == "pet_rank_prize" then
		self.pet_rank_prize = content
	end
end

function HandbookConfig:getPowerCheckDefine(id)
	return self.power_check_defineCfg[id] or {}
end

function HandbookConfig:getPowerCheckDetailList()
	return self.power_check_detailCfg.dataList
end

function HandbookConfig:getPowerCheckDetailCfg(id)
	return self.power_check_detailCfg[id]
end

function HandbookConfig:getPowerCheckStrategyCfg(id)
	return self.power_check_strategyCfg[id]
end

function HandbookConfig:getPowerCheckCommon(id)
	local obj = self.power_check_commonCfg[id]

	if obj then
		return obj.value
	end

	return ""
end

function HandbookConfig:getTeamIdsByRaceId(raceId)
	return self._raceIdToTeamId[raceId] or {}
end

function HandbookConfig:getCfgById(id)
	if self._teamCfgs ~= nil then
		return self._teamCfgs[id]
	else
		return nil
	end
end

function HandbookConfig:getCfgs()
	if self._teamCfgs ~= nil then
		return self._teamCfgs.dataList
	else
		return {}
	end
end

function HandbookConfig:getTeamPrize(id)
	return self._teamPrizeCfg[id]
end

function HandbookConfig:getTeamAttrCfg(tid, id)
	tid = checknumber(tid)
	id = checknumber(id)

	if self._teamPrizeCfg[tid] then
		return self._teamPrizeCfg[tid][id]
	end
end

function HandbookConfig:calcMaxZdlAndAttr()
	local dataList = self._teamPrizeCfg.dataList

	self.maxTeamZdl = 0
	self.maxAttr = {}

	for i, cfg in ipairs(dataList) do
		local zdl = cfg.zdl

		self.maxTeamZdl = self.maxTeamZdl + zdl

		local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp) or {}

		self.maxAttr = AttrMo.addSameAttrs(attrs, self.maxAttr)
	end
end

function HandbookConfig:getMaxTeamZdl()
	return self.maxTeamZdl
end

function HandbookConfig:getPetTeamFightingPower(teamId, teamInfo, isMyTeam)
	if teamInfo then
		if isMyTeam == true then
			return BagModel.instance.teamZdl
		elseif teamInfo.isMax then
			return self:getMaxTeamZdl()
		else
			local res, zdl = self:calcAllAttr(teamInfo.infos)

			return zdl
		end
	end

	return 0
end

function HandbookConfig:calcAllAttr(petTeams, res)
	local zdl = 0

	if res == nil then
		res = {}

		if petTeams then
			for i, v in ipairs(petTeams) do
				local teamId = v.teamId
				local achievePrizeIds = v.achievePrizeIds

				for _, id in ipairs(achievePrizeIds) do
					local cfg = HandbookConfig.instance:getTeamAttrCfg(teamId, id)

					if cfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp) or {}

						res = AttrMo.addSameAttrs(attrs, res)
						zdl = zdl + cfg.zdl
					end
				end
			end
		end
	end

	return res, zdl
end

function HandbookConfig:getCollectPrizeCfg(id, num)
	if self._collectPrizeCfgs ~= nil and self._collectPrizeCfgs[id] ~= nil then
		return self._collectPrizeCfgs[id][num]
	else
		return nil
	end
end

function HandbookConfig:getCollectPrizeCfgs(id)
	if self._collectPrizeCfgs ~= nil then
		return self._collectPrizeCfgs[id] or {}
	else
		return {}
	end
end

function HandbookConfig:getAwakenPrizeCfg(id, num)
	if self._awakenPrizeCfgs ~= nil and self._awakenPrizeCfgs[id] ~= nil then
		return self._awakenPrizeCfgs[id][num]
	else
		return nil
	end
end

function HandbookConfig:getAwakenPrizeCfgs(id)
	print("xxxxxxxxxxxx" .. tostring(self._awakenPrizeCfgs == nil))

	if self._awakenPrizeCfgs ~= nil then
		print("len = " .. #self._awakenPrizeCfgs[id] .. "id = " .. id)

		return self._awakenPrizeCfgs[id] or {}
	else
		return {}
	end
end

function HandbookConfig:getPetDetailsCfgById(raceId)
	return self._petDetailsCfgs[raceId]
end

function HandbookConfig:getPetDetailsCfgs()
	return self._petDetailsCfgs.dataList
end

function HandbookConfig:getPetInfo(raceId)
	return self._petInformation[raceId]
end

function HandbookConfig:getPetCommonCfgs(key)
	return self._petCommonCfgs[key].value
end

function HandbookConfig:getBenefitCfgs(manualBenefitId)
	local ret = {}

	for k, v in pairs(self._petBenefitCfgs[manualBenefitId]) do
		table.insert(ret, v)
	end

	return ret
end

function HandbookConfig:getBenefitCfg(manualBenefitId, level)
	local cfg = self._petBenefitCfgs[manualBenefitId]

	if cfg then
		return cfg[level]
	end
end

function HandbookConfig:getPetPosterResCfgById(resId)
	return self._petPosterResCfgs[resId]
end

function HandbookConfig:getPetRankConfs()
	return self.pet_rank_define_array
end

function HandbookConfig:getPetRankConfByRaceId(raceId)
	return self.pet_rank_define_map[raceId]
end

function HandbookConfig:getPetRankCommon(key)
	local conf = self.pet_rank_common[key]

	if conf then
		return conf.value
	end

	return ""
end

function HandbookConfig:getPetRankClientCommon(key)
	local conf = self.pet_rank_common_client[key]

	if conf then
		return conf.value
	end

	return ""
end

function HandbookConfig:getPetRankTabConfs()
	return self.pet_rank_tab
end

function HandbookConfig:getPrizeNeedRankDefault()
	local value = self:getPetRankCommon("prizeNeedRankDefault")

	return checknumber(value)
end

function HandbookConfig:getPetRankPrizeConf(id, rankType, rank, rankSize, rankPrizeId)
	if rankPrizeId == nil then
		rankPrizeId = 1
	end

	local configs = self.pet_rank_prize[id]

	if configs then
		configs = configs[rankType]

		if configs then
			configs = configs[rankPrizeId]

			if configs then
				local configsT = {}

				for _, config in pairs(configs) do
					table.insert(configsT, config)
				end

				table.sort(configsT, function(a, b)
					return a.rankRange[1] < b.rankRange[1]
				end)

				for i, config in ipairs(configsT) do
					if rank >= config.rankRange[1] and rank <= config.rankRange[2] then
						return config
					end
				end

				return configsT[#configsT]
			end
		end
	end
end

function HandbookConfig:getPetRankPrizeConfs(id, rankType, rankPrizeId)
	if rankPrizeId == nil then
		rankPrizeId = 1
	end

	local configs = self.pet_rank_prize[id]

	if configs then
		local data2 = self.pet_rank_prize[id][rankType]

		if data2 then
			return self.pet_rank_prize[id][rankType][rankPrizeId]
		end
	end
end

function HandbookConfig:getFinalRange(id, rankType, rank, rankSize, rankPrizeId)
	if rankPrizeId == nil then
		rankPrizeId = 1
	end

	local conf = self:getPetRankPrizeConf(id, rankType, rank, rankSize, rankPrizeId)

	return (conf or nil) and (conf.rankRange[2] or 0)
end

function HandbookConfig:getImpressionStickerMaxNum(rankId)
	local cfgs = self.pet_rank_prize[rankId]

	if cfgs then
		for rankType, cfg1 in pairs(cfgs) do
			for rankPrizeId, cfg2 in pairs(cfg1) do
				for rankRange, cfg3 in pairs(cfg2) do
					if rankPrizeId == PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID then
						return cfg3.rankRange and cfg3.rankRange[2]
					end
				end
			end
		end
	end
end

function HandbookConfig:getHasImpressionStickerCfg(rankId)
	local cfgs = self.pet_rank_prize[rankId]

	if cfgs then
		for rankType, cfg1 in pairs(cfgs) do
			for rankPrizeId, cfg2 in pairs(cfg1) do
				for rankRange, cfg3 in pairs(cfg2) do
					if rankPrizeId == PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID then
						return cfg3
					end
				end
			end
		end
	end
end

HandbookConfig.instance = HandbookConfig.New()

return HandbookConfig
