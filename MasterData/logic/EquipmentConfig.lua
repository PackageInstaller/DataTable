-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/config/EquipmentConfig.lua

module("logic.extensions.equipment.config.EquipmentConfig", package.seeall)

local EquipmentConfig = class("EquipmentConfig", BaseConfig)

function EquipmentConfig:onInit()
	EquipmentConfig.super.onInit(self)

	self.maxQualityNum = 4
	self.maxOneStrtNum = 300
	self.maxOneClickNum = 7
	self.costDecoRatio = 100
	self.manyMergeOne = 3
	self.attrProbability = 25
	self.maxAttrStone = 1
	self.strtQuaPlan = 0
	self.recyQuaPlan = 0
	self.exclMatList = {
		{
			id = 0,
			exp = 0
		},
		{
			id = 0,
			exp = 0
		},
		{
			id = 0,
			exp = 0
		},
		{
			id = 0,
			exp = 0
		}
	}
	self.goodConsume = {}
	self.goodMinLevel = 0
	self.maxOneClickTips = nil
	self.sttMatInfoList = nil
	self.equipDefineCfg = nil
	self.equipLevelCfg = nil
	self.equipQuaPlanCfg = nil
	self.tupoGropCfgs = nil
	self.attrStoneCfgs = nil
	self.composeDdefineCfgs = nil
	self.composePlanCfgs = nil
	self.costPlanCfgs = nil
	self.composePoolCfgs = nil
	self.sifterPlanCfgs = nil
	self.composeEquipPoolCfgs = nil
	self.composeThronePoolCfgs = nil
	self.allArtifactIds = nil
	self.throneRefundCfgs = nil
	self._functionTabCfgs = nil
end

function EquipmentConfig:getNames()
	return {
		"equipment_define",
		"equipment_lv_strategy",
		"equipment_other_config",
		"equipment_quality_plan",
		"equipment_race_type_stone",
		"equipment_compose_define",
		"equipment_compose_plan",
		"compose_cost_plan",
		"stargod_compose_choice_pool",
		"equipment_throne_refund",
		"factory_sifter_plan",
		"equipment_compose_pool",
		"throne_compose_pool",
		"equipment_throne_quality_refund",
		"equip_function_tab"
	}
end

function EquipmentConfig:handleConfig(name, content)
	if name == "equipment_other_config" then
		self._equipment_other_config = content
		self.sttMatInfoList = self:SetStrengtheningMaterial(content.UPGRADE_MATERIAL_IDS.value, content.UPGRADE_MATERIAL_EXPS.value)

		if content.DECOMPOSE_TIPS_QUALITY then
			self.maxQualityNum = tonumber(content.DECOMPOSE_TIPS_QUALITY.value)
		end

		if content.MAX_STRENGTHEN_LIMIT then
			self.maxOneStrtNum = tonumber(content.MAX_STRENGTHEN_LIMIT.value)
		end

		if content.MAX_ONECLICK_LIMIT then
			self.maxOneClickNum = tonumber(content.MAX_ONECLICK_LIMIT.value)
		end

		if content.MAX_ONECLICK_TIPS then
			self.maxOneClickTips = content.MAX_ONECLICK_TIPS.value
		end

		if content.MANY_MERGE_ONE then
			self.manyMergeOne = tonumber(content.MANY_MERGE_ONE.value)
		end

		if content.ATTRI_PROBABILITY then
			self.attrProbability = tonumber(content.ATTRI_PROBABILITY.value)
		end

		if content.MAX_ATTRI_STONE then
			self.maxAttrStone = tonumber(content.MAX_ATTRI_STONE.value)
		end

		if content.STRENGTHEN_QUALITY_PLAN then
			self.strtQuaPlan = tonumber(content.STRENGTHEN_QUALITY_PLAN.value)
		end

		if content.RECYCLE_QUALITY_PLAN then
			self.recyQuaPlan = tonumber(content.RECYCLE_QUALITY_PLAN.value)
		end

		if content.ORANGE_TWO_STONE_COUNT then
			self.goodConsume = string.split(content.ORANGE_TWO_STONE_COUNT.value, ",")
		end

		if content.BREAKOUT_ORANGE_TWO_PLAYER_LV then
			self.goodMinLevel = checknumber(content.BREAKOUT_ORANGE_TWO_PLAYER_LV.value)
		end

		if content.EXCLUSIVE_UPGRADE_MATERIAL_IDS then
			local list = string.split(content.EXCLUSIVE_UPGRADE_MATERIAL_IDS.value, ",")

			for i = 1, #list do
				if list[i] and self.exclMatList[i] then
					self.exclMatList[i].id = checknumber(list[i])
				end
			end
		end

		if content.EXCLUSIVE_UPGRADE_MATERIAL_EXPS then
			local list = string.split(content.EXCLUSIVE_UPGRADE_MATERIAL_EXPS.value, ",")

			for i = 1, #list do
				if list[i] and self.exclMatList[i] then
					self.exclMatList[i].exp = checknumber(list[i])
				end
			end
		end
	elseif name == "equipment_define" then
		self.equipDefineCfg = content

		self:_setEquipTupoGropCfgs(content.dataList)
	elseif name == "equipment_lv_strategy" then
		self.equipLevelCfg = content
	elseif name == "equipment_quality_plan" then
		self:_SetEquipQualityPlans(content.dataList)
	elseif name == "equipment_race_type_stone" then
		self.attrStoneCfgs = content
	elseif name == "equipment_compose_define" then
		self.composeDdefineCfgs = content
	elseif name == "equipment_compose_plan" then
		self.composePlanCfgs = content
	elseif name == "compose_cost_plan" then
		self.costPlanCfgs = content
	elseif name == "stargod_compose_choice_pool" then
		self.composePoolCfgs = content
	elseif name == "equipment_throne_refund" then
		self.throneRefundCfgs = content
	elseif name == "equipment_throne_quality_refund" then
		self._equipment_throne_quality_refund = content
	elseif name == "factory_sifter_plan" then
		self.sifterPlanCfgs = content
	elseif name == "equipment_compose_pool" then
		self.composeEquipPoolCfgs = content
	elseif name == "throne_compose_pool" then
		self.composeThronePoolCfgs = content
	elseif name == "equip_function_tab" then
		self._functionTabCfgs = content
	end
end

function EquipmentConfig:getCommonValue(key)
	if self._equipment_other_config[key] then
		return self._equipment_other_config[key].value
	end
end

function EquipmentConfig:getEquipFunctionTabCfgs()
	local temp = {}

	for _, cfg in pairs(self._functionTabCfgs or {}) do
		if cfg and checknumber(cfg.sort) > 0 and (cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)) then
			table.insert(temp, cfg)
		end
	end

	if #temp > 1 then
		table.sort(temp, function(a, b)
			return a.sort < b.sort
		end)
	end

	return temp
end

function EquipmentConfig:getEquipFunctionTabCfg(tabId)
	tabId = checknumber(tabId)

	if self._functionTabCfgs == nil or self._functionTabCfgs[tabId] == nil then
		return nil
	end

	return self._functionTabCfgs[tabId]
end

function EquipmentConfig:_SetEquipQualityPlans(data)
	self.equipQuaPlanCfg = {}

	for _, cfg in pairs(data or {}) do
		if cfg and checknumber(cfg.planId) > 0 then
			if self.equipQuaPlanCfg[cfg.planId] == nil then
				self.equipQuaPlanCfg[cfg.planId] = {}
			end

			table.insert(self.equipQuaPlanCfg[cfg.planId], cfg)
		end
	end

	for _, list in pairs(self.equipQuaPlanCfg or {}) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				return a.qualityNum < b.qualityNum
			end)
		end
	end
end

function EquipmentConfig:GetEquipDefineInfoById(defineId)
	if defineId == nil or self.equipDefineCfg == nil then
		return
	end

	return self.equipDefineCfg[checknumber(defineId)]
end

function EquipmentConfig:getSameGropWitQuality(defineId, quality)
	defineId = checknumber(defineId)
	quality = checknumber(quality)

	local cfg = self:GetEquipDefineInfoById(defineId)

	if cfg then
		local groupId = cfg.groupId

		for k, v in pairs(self.equipDefineCfg.dataList) do
			if v.groupId == groupId and v.quality == quality then
				return v
			end
		end
	end
end

function EquipmentConfig:getAllEquips()
	if self.equipDefineCfg == nil then
		return {}
	end

	return self.equipDefineCfg.dataList
end

function EquipmentConfig:GetEquipLevelInfos(defineId)
	if defineId == nil or self.equipLevelCfg == nil then
		return
	end

	return self.equipLevelCfg[defineId]
end

function EquipmentConfig:GetEquipInfoByLvl(defineId, lv)
	local list = self:GetEquipLevelInfos(defineId)

	if list == nil then
		return nil
	end

	return list[checknumber(lv)]
end

function EquipmentConfig:GetEquipQualityPlans(planId)
	if self.equipQuaPlanCfg == nil or self.equipQuaPlanCfg[planId] == nil then
		return
	end

	return self.equipQuaPlanCfg[planId]
end

function EquipmentConfig:GetEquipLevelInfoById(defineId, level)
	local infos = self:GetEquipLevelInfos(defineId)

	if infos == nil then
		return
	end

	if level == nil or level < 0 then
		level = 0
	end

	while infos[level] == nil do
		level = level - 1
	end

	return infos[level]
end

function EquipmentConfig:GetStrengtheningMaterial()
	return self.sttMatInfoList
end

function EquipmentConfig:SetStrengtheningMaterial(keyStr, valueStr)
	if string.nilorempty(keyStr) or string.nilorempty(valueStr) then
		return
	end

	local keyList = string.split(keyStr, ",")

	if keyList == nil or #keyList == 0 then
		return
	end

	local valueList = string.split(valueStr, ",")
	local sttMatList = {}

	for i = 1, #keyList do
		if not string.nilorempty(keyList[i]) then
			table.insert(sttMatList, {
				matId = tonumber(keyList[i]),
				matExp = (not string.nilorempty(valueList[i]) or nil) and tonumber(valueList[i])
			})
		end
	end

	return sttMatList
end

function EquipmentConfig:GetMaxQualityNum()
	return self.maxQualityNum or 4
end

function EquipmentConfig:GetMaxOneStrthNum()
	return self.maxOneStrtNum or 300
end

function EquipmentConfig:GetMaxOneClickNum()
	return self.maxOneClickNum or 7
end

function EquipmentConfig:GetMaxOneClickTips()
	return self.maxOneClickTips
end

function EquipmentConfig:GetCostDecoRatio()
	return self.costDecoRatio
end

function EquipmentConfig:GetStrtQuaPlanId()
	return checknumber(self.strtQuaPlan)
end

function EquipmentConfig:getEquipmentsZDL(raceId, skinId, equipments)
	local zdl = 0

	for k, tem in pairs(equipments) do
		local id = tem.id
		local cfgId = checknumber(tem.defineId)
		local lvl = checknumber(tem.lv)
		local bonusRaceId = checknumber(tem.bonusRaceId)
		local equip

		if checknumber(id) > 0 then
			equip = PetEquipModel.instance:GetEquipInfo(id)

			if equip then
				cfgId = equip:getDefineId()
				lvl = equip.starCount

				if bonusRaceId <= 0 then
					bonusRaceId = checknumber(equip.exclRaceId)
				end
			else
				return 0
			end
		end

		local cfg = self:GetEquipDefineInfoById(cfgId)
		local equipInfo = self:GetEquipInfoByLvl(cfg.equipmentLvStrategy, lvl)

		if bonusRaceId > 0 and bonusRaceId == raceId then
			local attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.racePropertyApp) or {}

			zdl = zdl + AttrMo.calcFightPowerByAttrs(attrs)
		elseif PetSkinConfig.instance:checkHasEleAttr(skinId, cfg.additionRaceType) then
			local attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp2) or {}

			zdl = zdl + AttrMo.calcFightPowerByAttrs(attrs)
		else
			local attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp) or {}

			zdl = zdl + AttrMo.calcFightPowerByAttrs(attrs)
		end
	end

	return zdl
end

function EquipmentConfig:getMaxEquipmentsZDL(raceId, skinId)
	local zdl = 0
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if petSkinCfg then
		local recmdEquipmentId = petSkinCfg.recmdEquipmentId

		for i, v in ipairs(recmdEquipmentId) do
			local positionType = self:GetEquipDefineInfoById(v).positionType
			local cfg = self:GetEquipDefineInfoById(checknumber(v))
			local tem = self:GetEquipLevelInfos(cfg.equipmentLvStrategy)
			local len = table.nums(tem)
			local equipInfo = tem[len - 1]

			if PetSkinConfig.instance:checkHasEleAttr(skinId, cfg.additionRaceType) then
				local attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp2) or {}

				for k, v in pairs(attrs) do
					local attrStr = GameEnum.AttrTypeName[k]
					local value = CharacterConfig.instance:getPropZdlValue(attrStr)

					zdl = zdl + v * value
				end
			else
				local attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp) or {}

				for k, v in pairs(attrs) do
					local attrStr = GameEnum.AttrTypeName[k]
					local value = CharacterConfig.instance:getPropZdlValue(attrStr)

					zdl = zdl + v * value
				end
			end
		end
	end

	return zdl
end

function EquipmentConfig:isOpenArtifact(skinId, pos)
	if self.allArtifactIds == nil or self.allArtifactIds[pos] == nil then
		return false
	end

	local list = self.allArtifactIds[pos]

	if list[skinId] == nil or #list[skinId] == 0 then
		return false
	end

	return true
end

function EquipmentConfig:getArtifactSkinIds(pos)
	if self.allArtifactIds == nil or self.allArtifactIds[pos] == nil then
		return nil
	end

	return self.allArtifactIds[pos]
end

function EquipmentConfig:getArtifactIds(skinId, pos)
	local list = self:getArtifactSkinIds(pos)

	if list == nil or list[skinId] == nil or #list[skinId] == 0 then
		return nil
	end

	return list[skinId]
end

function EquipmentConfig:getThroneRefundCfg(baseId)
	local cfg = self:GetEquipDefineInfoById(baseId)

	if cfg and cfg.throneRelatedSkinId > 0 then
		local quality = cfg.quality
		local res = self._equipment_throne_quality_refund[quality]

		if res then
			local str = res.refundMp

			if not string.nilorempty(str) then
				local list = string.split(str, "#")

				if #list > 0 then
					return list
				end
			end
		end
	end
end

function EquipmentConfig:GetExclusiveMaterial(pos)
	pos = checknumber(pos)

	if self.exclMatList == nil then
		return nil
	end

	if self.exclMatList[pos] == nil then
		return self.exclMatList
	end

	return self.exclMatList[pos]
end

function EquipmentConfig:_setEquipTupoGropCfgs(dataList)
	self.tupoGropCfgs = {}
	self.allArtifactIds = {
		[5] = {},
		[6] = {}
	}

	for _, cfg in pairs(dataList or {}) do
		if cfg and checknumber(cfg.beforeComposeGroup) > 0 then
			local pos = checknumber(cfg.positionType)

			if self.tupoGropCfgs[pos] == nil then
				self.tupoGropCfgs[pos] = {}
			end

			if cfg.throneRelatedSkinId > 0 then
				if self.tupoGropCfgs[pos][cfg.throneRelatedSkinId] == nil then
					self.tupoGropCfgs[pos][cfg.throneRelatedSkinId] = {}
				end

				table.insert(self.tupoGropCfgs[pos][cfg.throneRelatedSkinId], {
					baseId = cfg.id,
					beforeNum = cfg.beforeComposeGroup,
					afterNum = checknumber(cfg.afterComposeGroup),
					attr = cfg.additionRaceType,
					icon = cfg.icon
				})
			else
				if self.tupoGropCfgs[pos][cfg.jobType] == nil then
					self.tupoGropCfgs[pos][cfg.jobType] = {}
				end

				table.insert(self.tupoGropCfgs[pos][cfg.jobType], {
					baseId = cfg.id,
					beforeNum = cfg.beforeComposeGroup,
					afterNum = checknumber(cfg.afterComposeGroup),
					attr = cfg.additionRaceType,
					icon = cfg.icon
				})
			end
		end

		if cfg and cfg.throneRelatedSkinId > 0 and self.allArtifactIds[cfg.positionType] then
			if self.allArtifactIds[cfg.positionType][cfg.throneRelatedSkinId] == nil then
				self.allArtifactIds[cfg.positionType][cfg.throneRelatedSkinId] = {}
			end

			table.insert(self.allArtifactIds[cfg.positionType][cfg.throneRelatedSkinId], cfg.id)
		end
	end

	for _, posList in pairs(self.tupoGropCfgs or {}) do
		for _, jobList in pairs(posList or {}) do
			if jobList and #jobList > 1 then
				table.sort(jobList, function(a, b)
					return a.beforeNum < b.beforeNum
				end)
			end
		end
	end
end

function EquipmentConfig:getAllTupoGropCfgs()
	return self.tupoGropCfgs
end

function EquipmentConfig:GetTupoGropCfgs(pos, job)
	if self.tupoGropCfgs == nil or self.tupoGropCfgs[pos] == nil then
		return
	end

	local posList = self.tupoGropCfgs[pos]

	if posList == nil or posList[job] == nil or #posList[job] == 0 then
		return
	end

	return posList[job]
end

function EquipmentConfig:getTupoGoodConsume()
	return self.goodConsume
end

function EquipmentConfig:getTupoGoodMinLevel()
	return self.goodMinLevel
end

function EquipmentConfig:GetAttrStoneCfgs(planId, attId)
	if self.attrStoneCfgs == nil or self.attrStoneCfgs[planId] == nil then
		return
	end

	local list = self.attrStoneCfgs[planId]

	if checknumber(attId) > 0 then
		return list[attId]
	end

	return list
end

function EquipmentConfig:GetAttrStoneData(planId, attId)
	if self.attrStoneCfgs and self.attrStoneCfgs[planId] then
		return self.attrStoneCfgs[planId][attId]
	end
end

function EquipmentConfig:GetAttrStoneDataList()
	return (self.attrStoneCfgs or nil) and (self.attrStoneCfgs.dataList or {})
end

function EquipmentConfig:GetManyMergeOne()
	return self.manyMergeOne
end

function EquipmentConfig:GetAttrProbability()
	return self.attrProbability
end

function EquipmentConfig:GetMaxAttrStone()
	return self.maxAttrStone
end

function EquipmentConfig:GetRecyQuaPlanId()
	return checknumber(self.recyQuaPlan)
end

function EquipmentConfig:GetComposeDdefineCfgs(tabId)
	if self.composeDdefineCfgs == nil then
		return
	end

	if checknumber(tabId) <= 0 or self.composeDdefineCfgs[tabId] == nil then
		return self.composeDdefineCfgs
	end

	return self.composeDdefineCfgs[tabId]
end

function EquipmentConfig:GetComposePlanCfgs(planId)
	if self.composePlanCfgs == nil or self.composePlanCfgs[planId] == nil then
		return
	end

	return self.composePlanCfgs[planId]
end

function EquipmentConfig:getCostPlanCfgs(planId)
	if self.costPlanCfgs == nil or self.costPlanCfgs[planId] == nil then
		return nil
	end

	return self.costPlanCfgs[planId]
end

function EquipmentConfig:getComposePoolCfg(poolId, index)
	if self.composePoolCfgs == nil or self.composePoolCfgs[poolId] == nil then
		return nil
	end

	local list = self.composePoolCfgs[poolId]

	if index == nil or list[index] == nil then
		return list
	end

	return list[index]
end

function EquipmentConfig:getSifterPlanCfgs(planId)
	planId = checknumber(planId)

	if self.sifterPlanCfgs == nil or self.sifterPlanCfgs[planId] == nil then
		return {}
	end

	return self.sifterPlanCfgs[planId] or {}
end

function EquipmentConfig:getComposeEquipPoolCfgs(poolId, index)
	if self.composeEquipPoolCfgs == nil or self.composeEquipPoolCfgs[poolId] == nil then
		return nil
	end

	local list = self.composeEquipPoolCfgs[poolId]

	if index == nil or list[index] == nil then
		return list
	end

	return list[index]
end

function EquipmentConfig:getComposeThronePoolCfgs(poolId, index)
	if self.composeThronePoolCfgs == nil or self.composeThronePoolCfgs[poolId] == nil then
		return nil
	end

	local list = self.composeThronePoolCfgs[poolId]

	if index == nil or list[index] == nil then
		return list
	end

	return list[index]
end

EquipmentConfig.instance = EquipmentConfig.New()

return EquipmentConfig
