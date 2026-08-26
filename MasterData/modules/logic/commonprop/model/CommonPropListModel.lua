-- chunkname: @modules/logic/commonprop/model/CommonPropListModel.lua

module("modules.logic.commonprop.model.CommonPropListModel", package.seeall)

local CommonPropListModel = class("CommonPropListModel", ListScrollModel)

function CommonPropListModel:setPropList(Infos)
	self._moList = Infos and Infos or {}

	self:_sortList(self._moList)
	self:_stackList(self._moList)
	self:setList(self._moList)
end

function CommonPropListModel:_sortList(list)
	table.sort(list, function(a, b)
		if self:_getQuality(a) ~= self:_getQuality(b) then
			return self:_getQuality(a) > self:_getQuality(b)
		elseif a.materilType ~= b.materilType then
			return a.materilType > b.materilType
		elseif a.materilType == 1 and b.materilType == 1 and self:_getSubType(a) ~= self:_getSubType(b) then
			return self:_getSubType(a) < self:_getSubType(b)
		elseif a.materilId ~= b.materilId then
			return a.materilId > b.materilId
		end
	end)
end

function CommonPropListModel:_getQuality(config)
	local co = ItemModel.instance:getItemConfig(config.materilType, config.materilId)

	return ItemModel.instance:getItemRare(co)
end

function CommonPropListModel:_getSubType(config)
	local co = ItemModel.instance:getItemConfig(config.materilType, config.materilId)

	return co.subType == nil and 0 or co.subType
end

function CommonPropListModel:_getStackable(item)
	return ItemConfig.instance:isItemStackable(item.materilType, item.materilId)
end

function CommonPropListModel:_stackList(list)
	local newList = {}

	for i, item in ipairs(list) do
		if self:_getStackable(item) then
			table.insert(newList, item)
		else
			for j = 1, item.quantity do
				local sItem = {
					quantity = 1,
					materilType = item.materilType,
					materilId = item.materilId,
					uid = item.uid
				}

				table.insert(newList, sItem)
			end
		end
	end

	self._moList = newList
end

CommonPropListModel.HighRare = 5

function CommonPropListModel:isHadHighRareProp()
	local list = self:getList()
	local config

	for _, item in ipairs(list) do
		if tonumber(item.materilType) == MaterialEnum.MaterialType.PlayerCloth then
			return true
		end

		config = ItemModel.instance:getItemConfig(tonumber(item.materilType), tonumber(item.materilId))

		if not config or not config.rare then
			logWarn(string.format("type : %s, id : %s; getConfig error", item.materilType, item.materilId))
		elseif config.rare >= CommonPropListModel.HighRare then
			return true
		end
	end

	return false
end

local cellWidth = 270

function CommonPropListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, cellWidth, i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

CommonPropListModel.instance = CommonPropListModel.New()

return CommonPropListModel
