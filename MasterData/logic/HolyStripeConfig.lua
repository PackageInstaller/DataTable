-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/config/HolyStripeConfig.lua

module("logic.extensions.holystripe.config.HolyStripeConfig", package.seeall)

local HolyStripeConfig = class("HolyStripeConfig", BaseConfig)

function HolyStripeConfig:onInit()
	HolyStripeConfig.super.onInit(self)
end

function HolyStripeConfig:getNames()
	return {
		"holy_stripe",
		"holy_stripe_basic_property",
		"holy_stripe_strengthen",
		"holy_stripe_strengthen_cost",
		"holy_stripe_quenching",
		"holy_stripe_suit",
		"holy_stripe_params",
		"holy_stripe_hud_rule",
		"holy_stripe_hud",
		"holy_stripe_filter",
		"holy_stripe_filter_status"
	}
end

function HolyStripeConfig:handleConfig(name, content)
	if name == "holy_stripe" then
		self._holy_stripe = content

		self:_handleSuitNameInfo()
	elseif name == "holy_stripe_basic_property" then
		self._holy_stripe_basic_property = content
	elseif name == "holy_stripe_strengthen" then
		self._holy_stripe_strengthen = content
	elseif name == "holy_stripe_strengthen_cost" then
		self._holy_stripe_strengthen_cost = content
	elseif name == "holy_stripe_quenching" then
		self._holy_stripe_quenching = content
	elseif name == "holy_stripe_suit" then
		self._holy_stripe_suit = content
	elseif name == "holy_stripe_params" then
		self._holy_stripe_params = content
	elseif name == "holy_stripe_hud_rule" then
		self._holy_stripe_hud_rule = content
	elseif name == "holy_stripe_hud" then
		self._holy_stripe_hud = content
	elseif name == "holy_stripe_filter" then
		self._holy_stripe_filter = content
	elseif name == "holy_stripe_filter_status" then
		self._holy_stripe_filter_status = content
	end
end

function HolyStripeConfig:getHolyStripeDataList()
	return self._holy_stripe.dataList
end

function HolyStripeConfig:getHolyStripeCfg(configId)
	return self._holy_stripe[configId]
end

function HolyStripeConfig:getSuitCfgList()
	return self._holy_stripe_suit.dataList
end

function HolyStripeConfig:getSuitCfgBySuitType(suitType)
	return self._holy_stripe_suit[suitType]
end

function HolyStripeConfig:getSuitCfg(suitType, num)
	return self._holy_stripe_suit[suitType][num]
end

function HolyStripeConfig:getPropertyTypeByConfig(positionType, id)
	local cfg = self:getPropertyCfg(positionType, id)

	if cfg then
		return cfg.propertyType
	end
end

function HolyStripeConfig:getPropertyCfg(positionType, id)
	if self._holy_stripe_basic_property[positionType] then
		return self._holy_stripe_basic_property[positionType][id]
	end
end

function HolyStripeConfig:getMainPropertyByLv(propertyType, quality, lv)
	if self._holy_stripe_strengthen[propertyType] and self._holy_stripe_strengthen[propertyType][quality] then
		return self._holy_stripe_strengthen[propertyType][quality][lv]
	end
end

function HolyStripeConfig:getStrengthCostCfgs(quality)
	return self._holy_stripe_strengthen_cost[quality]
end

function HolyStripeConfig:getParamsValue(key)
	if self._holy_stripe_params[key] then
		return self._holy_stripe_params[key].value
	end
end

function HolyStripeConfig:getUnlockLvs()
	local list = {}
	local params = self._holy_stripe_params.QUENCHING_UNLOCK_LVS.value
	local splitParams = string.split(params, ",")

	for i, v in ipairs(splitParams) do
		table.insert(list, checknumber(v))
	end

	return list
end

function HolyStripeConfig:getQuenchingPropertys(position, quality)
	if self._holy_stripe_quenching[position] then
		return self._holy_stripe_quenching[position][quality]
	end
end

function HolyStripeConfig:getQuenchingProperty(position, quality, id)
	local cfg = self:getQuenchingPropertys(position, quality)

	if cfg then
		return cfg[id]
	end
end

function HolyStripeConfig:getMainPropertyTypeCfgs(posType)
	return self._holy_stripe_basic_property[posType]
end

function HolyStripeConfig:getMainPropertyType(posType, propertyId)
	return self._holy_stripe_basic_property[posType][propertyId]
end

function HolyStripeConfig:getSubPropertyType(posType, qualityId, quenchingIds)
	local list = {}

	for i, v in ipairs(quenchingIds) do
		local cfg = self:getQuenchingProperty(posType, qualityId, v)

		if cfg then
			table.insert(list, cfg)
		end
	end

	return list
end

function HolyStripeConfig:getStrengthenCost(quality)
	return self._holy_stripe_strengthen_cost[quality]
end

function HolyStripeConfig:getStrengthMats()
	if not self._cache_strengthmats then
		self._cache_strengthmats = {}

		local matStr = self._holy_stripe_params.STRENGTHEN_MATERIAL_IDS.value
		local mats = string.split(matStr, ",")
		local valueStr = self._holy_stripe_params.STRENGTHEN_MATERIAL_EXPS.value
		local values = string.split(valueStr, ",")

		for i, v in ipairs(mats) do
			local matId = checknumber(v)

			self._cache_strengthmats[i] = {
				isMat = true,
				matId = matId,
				exp = checknumber(values[i]),
				cfgStr = string.format("%s:%s", MatType.Item, matId)
			}
		end
	end

	return self._cache_strengthmats
end

function HolyStripeConfig:getSmeltRefundExpRate()
	return checknumber(self._holy_stripe_params.SMELT_REFUND_EXP_RATE.value)
end

function HolyStripeConfig:getQuenchingUnlockLvs()
	if not self._cache_quenching_unlock_lvs then
		self._cache_quenching_unlock_lvs = {}

		local valueStr = self._holy_stripe_params.QUENCHING_UNLOCK_LVS.value
		local values = string.split(valueStr, ",")

		for i, v in ipairs(values) do
			table.insert(self._cache_quenching_unlock_lvs, checknumber(v))
		end
	end

	return self._cache_quenching_unlock_lvs
end

function HolyStripeConfig:getSmeltDays()
	if not self._cache_smelt_days then
		self._cache_smelt_days = {}

		local valueStr = self._holy_stripe_params.SMELT_DAYS.value
		local value = string.split(valueStr, ",")

		for i, v in ipairs(value) do
			table.insert(self._cache_smelt_days, checknumber(v))
		end
	end

	return self._cache_smelt_days
end

function HolyStripeConfig:getSuitInfo(suitId)
	local result = {
		icon = "",
		name = ""
	}

	for i, v in pairs(self._holy_stripe) do
		if v.suitType == suitId then
			result.name = v.name
			result.icon = v.icon
			result.cfg = v

			break
		end
	end

	return result
end

function HolyStripeConfig:getStrengthenCostCoins()
	local result = {}
	local valueStr = self._holy_stripe_params.STRENGTHEN_COST_COINS.value
	local value = string.split(valueStr, ",")

	for i, v in ipairs(value) do
		local cfg = string.split(v, ":")

		table.insert(result, {
			quality = i,
			exp = checknumber(cfg[1]),
			cost = checknumber(cfg[2])
		})
	end

	return result
end

function HolyStripeConfig:getMaxSmeltLimit()
	return checknumber(self._holy_stripe_params.MAX_SMELT_LIMIT.value)
end

function HolyStripeConfig:getMaxStrengthLimit()
	return checknumber(self._holy_stripe_params.MAX_STRENGTHEN_LIMIT.value)
end

function HolyStripeConfig:getQuickActionSelectLimit()
	return checknumber(self:getParamsValue("QUICK_ACTION_SELECT_LIMIT"))
end

function HolyStripeConfig:getHudRuleCfgs()
	return self._holy_stripe_hud_rule.dataList
end

function HolyStripeConfig:getHudCfgs()
	return self._holy_stripe_hud.dataList
end

function HolyStripeConfig:getFilterList()
	local list = {}

	for i, v in ipairs(self._holy_stripe_filter) do
		local count = HolyStripeController.instance:getAttrTypeByName(v.filterPropertyType)

		if count then
			for i, v in pairs(GameEnum.HolyStripeAttrType) do
				if v == count then
					table.insert(list, {
						id = i,
						value = v
					})
				end
			end
		end
	end

	return list
end

function HolyStripeConfig:getStatusFilterList()
	local list = {}

	for i, v in ipairs(self._holy_stripe_filter_status or {}) do
		if not string.nilorempty(v.filterStatusType) then
			table.insert(list, {
				id = v.id,
				value = v.filterStatusType
			})
		end
	end

	return list
end

function HolyStripeConfig:getFilterCfgs()
	return self._holy_stripe_filter.dataList
end

function HolyStripeConfig:getFilterCfg(id)
	return self._holy_stripe_filter[id]
end

function HolyStripeConfig:_handleSuitNameInfo()
	self._suitNameInfo = {}

	for i, v in ipairs(self._holy_stripe.dataList) do
		self._suitNameInfo[v.name] = v.suitType
	end
end

function HolyStripeConfig:getSuitType(suitName)
	return self._suitNameInfo[suitName]
end

function HolyStripeConfig:getAllSuitInfo()
	local list = {}

	for name, v in pairs(self._suitNameInfo) do
		table.insert(list, {
			name = name,
			type = v
		})
	end

	table.sort(list, function(a, b)
		return a.type < b.type
	end)

	return list
end

HolyStripeConfig.instance = HolyStripeConfig.New()

return HolyStripeConfig
