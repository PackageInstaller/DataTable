-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/config/LotteryConfig.lua

module("logic.extensions.lottery.config.LotteryConfig", package.seeall)

local LotteryConfig = class("LotteryConfig", BaseConfig)

function LotteryConfig:onInit()
	LotteryConfig.super.onInit(self)

	self.commonPrizeCfg = nil
	self.poolCfg = nil
	self.basePoolCfg = nil
	self.groupAllCfgs = nil
	self.progPrizeCfgs = nil
	self.godShopItemCfgs = nil
	self.commonShopItemCfgs = nil
	self.operateAllCfgs = nil
	self.consumeAllCfgs = nil
	self._selectPrizeCfgs = nil
	self._selectItemCfgs = nil
end

function LotteryConfig:getNames()
	return {
		"lottery_pool_config",
		"lottery_base_weight_config",
		"lottery_common_config",
		"lottery_progress_prize",
		"lottery_god_shop_item",
		"lottery_common_shop",
		"lottery_pool_group",
		"lottery_pay_shop",
		"lottery_consume_discount",
		"lottery_pool_select_prize",
		"lottery_pool_select_prize_main",
		"lottery_pool_select_prize_item",
		"lottery_self_select_pet_group"
	}
end

function LotteryConfig:handleConfig(name, content)
	if name == "lottery_common_config" then
		self.commonPrizeCfg = content
	elseif name == "lottery_pool_config" then
		self.poolCfg = content
	elseif name == "lottery_base_weight_config" then
		self._lottery_base_weight_config = content
		self._basePoolCfgList = content.dataList
	elseif name == "lottery_progress_prize" then
		self:SetProgPrizeCfgs(content.dataList)
	elseif name == "lottery_god_shop_item" then
		self.godShopItemCfgs = content
	elseif name == "lottery_common_shop" then
		self.commonShopItemCfgs = content.dataList
	elseif name == "lottery_pool_group" then
		self.groupAllCfgs = content
	elseif name == "lottery_pay_shop" then
		self.operateAllCfgs = content
	elseif name == "lottery_consume_discount" then
		self.consumeAllCfgs = content
	elseif name == "lottery_pool_select_prize_main" then
		self.lottery_pool_select_prize_mainCfg = content
	elseif name == "lottery_self_select_pet_group" then
		self._lottery_self_select_pet_group = content
	elseif name == "lottery_pool_select_prize" then
		self:_setPoolSelectPrizeCfgs(content.dataList)
	elseif name == "lottery_pool_select_prize_item" then
		self._lottery_pool_select_prize_item = content

		self:_setPoolSelectItemCfgs(content.dataList)
		self:_sortPrizeCfg(content.dataList)
	end
end

function LotteryConfig:GetSelfSelectPetGroupCfg(poolId)
	return self._lottery_self_select_pet_group[poolId]
end

function LotteryConfig:GetSelfSelectPetGroupCfgByGirdId(poolId, gridId)
	if self._lottery_self_select_pet_group[poolId] then
		return self._lottery_self_select_pet_group[poolId][gridId]
	end

	return nil
end

function LotteryConfig:GetSelectPrizePoolCfg(poolId)
	return self.lottery_pool_select_prize_mainCfg[poolId] or {}
end

function LotteryConfig:GetBasePoolCfg(poolId)
	if self.basePoolCfg == nil then
		self:_initBasePoolCfg()
	end

	return self.basePoolCfg[poolId] or {}
end

function LotteryConfig:GetExtPoolCfg(poolId)
	if self._extPoolCfg == nil then
		self:_initBasePoolCfg()
	end

	return self._extPoolCfg[poolId] or {}
end

function LotteryConfig:getBasePoolPetData(poolId, raceId)
	poolId = checknumber(poolId)
	raceId = checknumber(raceId)

	local onlineTime = "0-0-0"
	local tempId = CharacterConfig.instance:getInitRare(raceId)

	return {
		joinValidator = "",
		isShowPool = true,
		poolId = poolId,
		raceId = raceId,
		rare = tempId,
		onlineTime = onlineTime
	}
end

function LotteryConfig:_initBasePoolCfg()
	self.basePoolCfg = {}
	self._extPoolCfg = {}

	local haveList = {}
	local allUpList = {}

	for i, v in ipairs(self._basePoolCfgList) do
		if haveList[v.poolId] == nil then
			haveList[v.poolId] = {}
		end

		if v and v.raceId and not haveList[v.poolId][v.raceId] then
			if self.basePoolCfg[v.poolId] == nil then
				self.basePoolCfg[v.poolId] = {}
			end

			haveList[v.poolId][v.raceId] = true

			local tempId = CharacterConfig.instance:getInitRare(v.raceId)
			local data = {
				poolId = v.poolId,
				raceId = v.raceId,
				rare = tempId,
				onlineTime = v.onlineTime,
				joinValidator = v.joinValidator,
				isShowPool = v.isShowPool
			}

			if checknumber(v.upPool) > 0 then
				tempId = v.upPool
				self._extPoolCfg[v.poolId] = self._extPoolCfg[v.poolId] or {}
				self._extPoolCfg[v.poolId][tempId] = self._extPoolCfg[v.poolId][tempId] or {}

				table.insert(self._extPoolCfg[v.poolId][tempId], data)

				if allUpList[v.poolId] == nil then
					allUpList[v.poolId] = {}
				end

				allUpList[v.poolId][tempId] = tempId
			end

			if self.basePoolCfg[v.poolId][tempId] == nil then
				self.basePoolCfg[v.poolId][tempId] = {}
			end

			table.insert(self.basePoolCfg[v.poolId][tempId], data)
		end
	end

	for poolId, list in pairs(allUpList) do
		if list and self.poolCfg[poolId] then
			self.poolCfg[poolId].upList = {}

			for _, num in pairs(list) do
				table.insert(self.poolCfg[poolId].upList, num)
			end

			if #self.poolCfg[poolId].upList > 1 then
				table.sort(self.poolCfg[poolId].upList, function(a, b)
					return a < b
				end)
			end
		end
	end

	haveList = nil
	allUpList = nil
end

function LotteryConfig:GetPoolCfg(id)
	if checknumber(id) <= 0 then
		return self.poolCfg
	end

	return self.poolCfg[id]
end

function LotteryConfig:GetCommonPrizeCfgByKey(key)
	return self.commonPrizeCfg[key]
end

function LotteryConfig:GetPetTrainParams()
	local data = self.commonPrizeCfg.PET_TRAIN_PARAM

	if data == nil or string.nilorempty(data.value) then
		return
	end

	local list = string.split(data.value, ",")

	if list == nil or #list == 0 then
		return
	end

	local temp = {}

	for i = 1, #list do
		if list[i] and checknumber(list[i]) > 0 then
			temp[checknumber(list[i])] = list[i]
		end
	end

	return temp
end

function LotteryConfig:GetChouJiangTypeData()
	local data = self.commonPrizeCfg.MULT_DRAW_TYPES

	if data and data.value then
		local strs = string.split(data.value, ",")

		if strs == nil or #strs <= 1 then
			return {
				"1",
				"10"
			}
		end

		return strs
	end

	return {
		"1",
		"10"
	}
end

function LotteryConfig:GetPoolGroupCfg(groupId)
	groupId = checknumber(groupId)

	if self.groupAllCfgs == nil or self.groupAllCfgs[groupId] == nil then
		return nil
	end

	return self.groupAllCfgs[groupId]
end

function LotteryConfig:GetAllPoolGroupCfgs()
	return self.groupAllCfgs or {}
end

function LotteryConfig:getConsumeDiscountCfg(planId)
	if self.consumeAllCfgs == nil or planId == nil then
		return nil
	end

	return self.consumeAllCfgs[planId]
end

function LotteryConfig:SetProgPrizeCfgs(data)
	self.progPrizeCfgs = {}

	if data == nil or #data == 0 then
		return
	end

	for i = 1, #data do
		if data[i] then
			local poolId = data[i].poolId

			if self.progPrizeCfgs[poolId] == nil then
				self.progPrizeCfgs[poolId] = {}
			end

			table.insert(self.progPrizeCfgs[poolId], data[i])
		end
	end

	for _, list in pairs(self.progPrizeCfgs) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				return a.times < b.times
			end)
		end
	end
end

function LotteryConfig:GetProgPrizeCfgs(poolId)
	if self.progPrizeCfgs == nil or self.progPrizeCfgs[poolId] == nil then
		return {}
	end

	return self.progPrizeCfgs[poolId]
end

function LotteryConfig:GetGodShopItemCfgs(shopId)
	if self.godShopItemCfgs == nil or self.godShopItemCfgs[shopId] == nil then
		return
	end

	return self.godShopItemCfgs[shopId]
end

function LotteryConfig:GetCommonShopItemCfgs()
	return self.commonShopItemCfgs
end

function LotteryConfig:getOperateCfgs(indexId)
	if self.operateAllCfgs == nil then
		return nil
	end

	if indexId == nil or self.operateAllCfgs[indexId] == nil then
		return self.operateAllCfgs
	end

	return self.operateAllCfgs[indexId]
end

function LotteryConfig:_setPoolSelectPrizeCfgs(data)
	self._selectPrizeCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and cfg.row > 0 then
			self._selectPrizeCfgs[cfg.poolId] = self._selectPrizeCfgs[cfg.poolId] or {}
			self._selectPrizeCfgs[cfg.poolId][cfg.row] = self._selectPrizeCfgs[cfg.poolId][cfg.row] or {}

			table.insert(self._selectPrizeCfgs[cfg.poolId][cfg.row], cfg.posId)
		end
	end
end

function LotteryConfig:_setPoolSelectItemCfgs(data)
	self._selectItemCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and not string.nilorempty(cfg.prize) then
			self._selectItemCfgs[cfg.poolId] = self._selectItemCfgs[cfg.poolId] or {}
			self._selectItemCfgs[cfg.poolId][cfg.posId] = self._selectItemCfgs[cfg.poolId][cfg.posId] or {}

			table.insert(self._selectItemCfgs[cfg.poolId][cfg.posId], cfg)
		end
	end
end

function LotteryConfig:getPoolSelectPrizeCfgs(poolId)
	if self._selectPrizeCfgs == nil or self._selectPrizeCfgs[poolId] == nil then
		return nil
	end

	return self._selectPrizeCfgs[poolId]
end

function LotteryConfig:getPoolSelectItemCfgsByPoolId(poolId)
	return self._selectItemCfgs[poolId]
end

function LotteryConfig:getPoolSelectItemCfgs(poolId, posId)
	if self._selectItemCfgs == nil or self._selectItemCfgs[poolId] == nil then
		return nil
	end

	local list = self._selectItemCfgs[poolId]

	if checknumber(posId) <= 0 or list[posId] == nil then
		return list
	end

	return list[posId]
end

function LotteryConfig:getPrizeSortTabMap(poolId)
	return self._prizeMap[poolId]
end

function LotteryConfig:getPrizeCfgsSortTabList(poolId, posId, tabId)
	if self._prizeMap[poolId] then
		return self._prizeMap[poolId] and self._prizeMap[poolId][tabId]
	end
end

function LotteryConfig:_sortPrizeCfg(dataList)
	self._prizeMap = {}

	for i, v in ipairs(dataList) do
		self._prizeMap[v.poolId] = self._prizeMap[v.poolId] or {}

		local poolMap = self._prizeMap[v.poolId]

		poolMap[v.posId] = poolMap[v.posId] or {}

		local posPoolMap = poolMap[v.posId]

		posPoolMap[v.tabId] = posPoolMap[v.tabId] or {}

		local tabList = posPoolMap[v.tabId]

		table.insert(tabList, v)
	end
end

function LotteryConfig:getTabIdxList(poolId, posId)
	local tabIdxList = {}
	local poolMap = self._prizeMap[poolId]
	local posMap = poolMap and poolMap[posId]

	if posMap then
		for tabId, _ in pairs(posMap) do
			table.insert(tabIdxList, tabId)
		end
	end

	return tabIdxList
end

function LotteryConfig:getPrizeItemCfgsByPosId(poolId, posId)
	return self._selectItemCfgs[poolId] and self._selectItemCfgs[poolId][posId]
end

function LotteryConfig:getPrizeItemCfgById(poolId, posId, id)
	if self._selectItemCfgs[poolId] then
		return self._selectItemCfgs[poolId] and self._selectItemCfgs[poolId][id]
	end
end

function LotteryConfig:getCurTabId(poolId, posId)
	if self._selectItemCfgs[poolId] then
		local posCfgs = self._selectItemCfgs[poolId][posId]

		if posCfgs then
			local firstCfg = posCfgs[1]

			if firstCfg then
				return firstCfg.tabId
			end
		end

		return 1
	end
end

LotteryConfig.instance = LotteryConfig.New()

return LotteryConfig
