-- chunkname: @modules/logic/room/model/common/RoomThemeItemListModel.lua

module("modules.logic.room.model.common.RoomThemeItemListModel", package.seeall)

local RoomThemeItemListModel = class("RoomThemeItemListModel", ListScrollModel)

RoomThemeItemListModel.SwitchType = {
	Source = 2,
	Collect = 1
}

function RoomThemeItemListModel:setItemShowType(type)
	self._showType = type

	self:onModelUpdate()
end

function RoomThemeItemListModel:getItemShowType()
	return self._showType or RoomThemeItemListModel.SwitchType.Collect
end

function RoomThemeItemListModel:setThemeId(themeId)
	local tempList = RoomModel.instance:getThemeItemMOListById(themeId)
	local molist = {}

	tabletool.addValues(molist, tempList)
	table.sort(molist, RoomThemeItemListModel.sortMOFunc)
	self:setList(molist)
	self:onModelUpdate()
end

function RoomThemeItemListModel.sortMOFunc(a, b)
	local aIndex = RoomThemeItemListModel._getFinishIndex(a)
	local bIndex = RoomThemeItemListModel._getFinishIndex(b)

	if aIndex ~= bIndex then
		return aIndex < bIndex
	end

	local aTypeIndex = RoomThemeItemListModel._getTypeIndex(a.materialType)
	local bTypeIndex = RoomThemeItemListModel._getTypeIndex(b.materialType)

	if aTypeIndex ~= bTypeIndex then
		return aTypeIndex < bTypeIndex
	end

	if a.id ~= b.id then
		return a.id < b.id
	end
end

function RoomThemeItemListModel._getSourcesTypeIndex(mo)
	local cfg = mo:getItemConfig()

	if cfg and not string.nilorempty(cfg.sourcesType) then
		local sourceTypeList = string.splitToNumber(cfg.sourcesType, "#")
		local order = 9999

		for i, sourcesType in ipairs(sourceTypeList) do
			local sourcesCfg = RoomConfig.instance:getSourcesTypeConfig(sourcesType)

			if sourcesCfg and order > sourcesCfg.order then
				order = sourcesCfg.order
			end
		end

		return order
	end

	return 99999
end

function RoomThemeItemListModel._getTypeIndex(materialType)
	if materialType == MaterialEnum.MaterialType.BlockPackage then
		return 1
	elseif materialType == MaterialEnum.MaterialType.Building then
		return 2
	end

	return 99999
end

function RoomThemeItemListModel._getFinishIndex(mo)
	if mo:getItemQuantity() < mo.itemNum then
		return 1
	end

	return 99999
end

RoomThemeItemListModel.instance = RoomThemeItemListModel.New()

return RoomThemeItemListModel
