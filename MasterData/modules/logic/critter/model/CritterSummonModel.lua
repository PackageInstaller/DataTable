-- chunkname: @modules/logic/critter/model/CritterSummonModel.lua

module("modules.logic.critter.model.CritterSummonModel", package.seeall)

local CritterSummonModel = class("CritterSummonModel", BaseModel)

function CritterSummonModel:onInit()
	return
end

function CritterSummonModel:reInit()
	return
end

function CritterSummonModel:clear()
	CritterSummonModel.super.clear(self)
	self:_clearData()
end

function CritterSummonModel:_clearData()
	return
end

function CritterSummonModel:initSummonPools(poolInfos)
	local moList = {}

	if poolInfos then
		for i, poolInfo in ipairs(poolInfos) do
			local criSummonMO = self:getById(poolInfo.poolId)

			criSummonMO = criSummonMO or CritterSummonMO.New()

			criSummonMO:init(poolInfo)
			table.insert(moList, criSummonMO)
		end
	end

	self:setList(moList)
end

function CritterSummonModel:setSummonPoolList(poolId)
	local summonPool = self:getById(poolId)

	if summonPool then
		RoomSummonPoolCritterListModel.instance:setDataList(summonPool.critterMos)
	end
end

function CritterSummonModel:onSummon(poolId, hasSummonCritter)
	local criSummonMO = self:getById(poolId)

	criSummonMO:onRefresh(hasSummonCritter)
end

function CritterSummonModel:getSummonPoolId()
	return 1
end

function CritterSummonModel:getSummonCount()
	return 1
end

function CritterSummonModel:isMaxCritterCount()
	local count = #CritterModel.instance:getAllCritters() or 0
	local maxCount = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterBackpackCapacity) or 0

	return count >= tonumber(maxCount)
end

function CritterSummonModel:isCanSummon(poolId)
	if self:isMaxCritterCount() then
		return false, ToastEnum.RoomCritterMaxCount
	end

	if not self:isNullPool(poolId) then
		return true
	end

	return false, ToastEnum.RoomCritterPoolEmpty
end

function CritterSummonModel:isNullPool(poolId)
	local summonPool = self:getById(poolId)

	if summonPool then
		for _, mo in pairs(summonPool.critterMos) do
			if mo:getPoolCount() > 0 then
				return false
			end
		end
	end

	return true
end

function CritterSummonModel:isFullPool(poolId)
	local summonPool = self:getById(poolId)

	if summonPool then
		for _, mo in pairs(summonPool.critterMos) do
			if not mo:isFullPool() then
				return false
			end
		end
	end

	return true
end

function CritterSummonModel:getPoolCritterCount(poolId)
	local summonPool = self:getById(poolId)

	if summonPool then
		return summonPool:getCritterCount()
	end

	return 0
end

function CritterSummonModel:getPoolCurrency(poolId, count)
	if not poolId then
		return
	end

	local co = CritterConfig.instance:getCritterSummonCfg(poolId)
	local cost = co.cost

	return self:getCostInfo(cost, count)
end

function CritterSummonModel:notSummonToast(pool, count)
	local isCanSummon, toast = self:isCanSummon(pool)
	local _, _, enough, name = self:getPoolCurrency(pool, count)

	if not isCanSummon then
		return toast
	elseif not enough then
		return ToastEnum.RoomCritterNotEnough, name
	end

	return ""
end

function CritterSummonModel:getCostInfo(cost, count)
	if string.nilorempty(cost) then
		return
	end

	local tempCount = 1

	if count then
		tempCount = math.max(1, tonumber(count))
	end

	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(cost)
	local config, icon = ItemModel.instance:getItemConfigAndIcon(cost_type, cost_id)
	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local enough = num >= cost_num * tempCount
	local str = luaLang("multiple") .. cost_num * tempCount

	return icon, str, enough, config.name
end

function CritterSummonModel:getCostCurrency()
	local list = {}
	local costCurrency = {}

	for i, co in ipairs(lua_critter_summon.configList) do
		if not string.nilorempty(co.cost) then
			local incubateCost = string.split(co.cost, "#")

			if incubateCost[1] and incubateCost[2] then
				local costType = incubateCost[1] .. "#" .. incubateCost[2]

				if not LuaUtil.tableContains(list, costType) then
					table.insert(list, costType)
				end
			end
		end
	end

	for _, str in ipairs(list) do
		local incubateCost = string.split(str, "#")

		if incubateCost[1] and incubateCost[2] then
			local materialtype = tonumber(incubateCost[1])
			local type = tonumber(incubateCost[2])

			if materialtype == MaterialEnum.MaterialType.Item then
				local currency = {
					isIcon = true,
					type = materialtype,
					id = type,
					jumpFunc = SummonMainModel.jumpToSummonCostShop
				}

				if not LuaUtil.tableContains(costCurrency, currency) then
					table.insert(costCurrency, currency)
				end
			elseif materialtype == MaterialEnum.MaterialType.Currency and not LuaUtil.tableContains(costCurrency, type) then
				table.insert(costCurrency, type)
			end
		end
	end

	return costCurrency
end

CritterSummonModel.instance = CritterSummonModel.New()

return CritterSummonModel
