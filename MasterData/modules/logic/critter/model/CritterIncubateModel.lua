-- chunkname: @modules/logic/critter/model/CritterIncubateModel.lua

module("modules.logic.critter.model.CritterIncubateModel", package.seeall)

local CritterIncubateModel = class("CritterIncubateModel", BaseModel)

function CritterIncubateModel:onInit()
	self._selectParentCrittersIds = nil
end

function CritterIncubateModel:reInit()
	self._selectParentCrittersIds = {}
end

function CritterIncubateModel:clear()
	CritterIncubateModel.super.clear(self)
	self:_clearData()
end

function CritterIncubateModel:_clearData()
	return
end

function CritterIncubateModel:getCanSelectCount()
	return 2
end

function CritterIncubateModel:_getNullSelect()
	for i = 1, self:getCanSelectCount() do
		if not self._selectParentCrittersIds[i] then
			return i
		end
	end
end

function CritterIncubateModel:addSelectParentCritter(uid)
	self._selectParentCrittersIds = self._selectParentCrittersIds or {}

	local index = self:_getNullSelect()

	if index then
		self._selectParentCrittersIds[index] = uid

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onSelectParentCritter, index, uid)
	end
end

function CritterIncubateModel:removeSelectParentCritter(uid)
	self._selectParentCrittersIds = self._selectParentCrittersIds or {}

	local index = tabletool.indexOf(self._selectParentCrittersIds, uid)

	if index then
		self._selectParentCrittersIds[index] = nil

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onRemoveParentCritter, index, uid)
	end
end

function CritterIncubateModel:isSelectParentCritter(uid)
	return LuaUtil.tableContains(self._selectParentCrittersIds, uid)
end

function CritterIncubateModel:getSelectParentCritterUIdByIndex(index)
	if not self._selectParentCrittersIds then
		return
	end

	local uid = self._selectParentCrittersIds[index]

	if uid then
		local mo = CritterModel.instance:getCritterMOByUid(uid)

		if mo then
			return uid
		end
	end

	self._selectParentCrittersIds[index] = nil
end

function CritterIncubateModel:getSelectParentCritterMoByid(defineId)
	if not self._selectParentCrittersIds then
		return
	end

	for i, uid in ipairs(self._selectParentCrittersIds) do
		local mo = CritterModel.instance:getCritterMOByUid(uid)

		if mo.defineId == defineId then
			return mo
		end
	end
end

function CritterIncubateModel:getSelectParentCritterCount()
	return self._selectParentCrittersIds and tabletool.len(self._selectParentCrittersIds) or 0, self:getCanSelectCount()
end

function CritterIncubateModel:getChildMOList()
	return self._previewChildCritters or {}
end

function CritterIncubateModel:setCritterPreviewInfo(childes)
	self._previewChildCritters = {}

	if childes then
		for i, critterInfo in ipairs(childes) do
			local critterMO = self:getById(critterInfo.uid)

			critterMO = critterMO or CritterMO.New()

			critterMO:init(critterInfo)
			table.insert(self._previewChildCritters, critterMO)
		end
	end
end

function CritterIncubateModel:getCritterMOByUid(uid)
	if not self._previewChildCritters then
		return
	end

	for _, mo in ipairs(self._previewChildCritters) do
		if mo.uid == uid then
			return mo
		end
	end
end

function CritterIncubateModel:notSummonToast()
	local _, _, enough, name = self:getPoolCurrency()

	if CritterSummonModel.instance:isMaxCritterCount() then
		return ToastEnum.RoomCritterMaxCount
	end

	if not enough then
		return ToastEnum.RoomCritterNotEnough, name
	end

	local count, max = self:getSelectParentCritterCount()

	if count < max then
		return ToastEnum.RoomCritteNeedTwo
	end

	return ""
end

function CritterIncubateModel:getPoolCurrency()
	local maxRare = 3

	if self._selectParentCrittersIds then
		for i, uid in ipairs(self._selectParentCrittersIds) do
			local mo = CritterModel.instance:getCritterMOByUid(uid)

			if mo then
				local rare = mo:getDefineCfg().rare

				maxRare = math.max(maxRare, rare)
			end
		end
	end

	local co = CritterConfig.instance:getCritterRareCfg(maxRare)

	if co then
		return CritterSummonModel.instance:getCostInfo(co.incubateCost)
	end
end

function CritterIncubateModel:getCostCurrency()
	local list = {}
	local costCurrency = {}

	for i, co in ipairs(lua_critter_rare.configList) do
		if not string.nilorempty(co.incubateCost) then
			local incubateCost = string.split(co.incubateCost, "#")

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

function CritterIncubateModel:setSortType(index)
	self._selectSortType = index
end

function CritterIncubateModel:getSortType()
	return self._selectSortType or CritterEnum.AttributeType.Efficiency
end

function CritterIncubateModel:setSortWay(index)
	self._selectSortWay = index
end

function CritterIncubateModel:getSortWay()
	return self._selectSortWay
end

CritterIncubateModel.instance = CritterIncubateModel.New()

return CritterIncubateModel
