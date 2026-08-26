-- chunkname: @modules/logic/room/view/common/RoomStroreGoodsTipViewBanner.lua

module("modules.logic.room.view.common.RoomStroreGoodsTipViewBanner", package.seeall)

local RoomStroreGoodsTipViewBanner = class("RoomStroreGoodsTipViewBanner", RoomMaterialTipViewBanner)

function RoomStroreGoodsTipViewBanner:_getItemDataList()
	local config = self.viewParam.storeGoodsMO.config
	local num2List = GameUtil.splitString2(config.product, true)
	local typeList = {
		MaterialEnum.MaterialType.RoomTheme,
		MaterialEnum.MaterialType.BlockPackage,
		MaterialEnum.MaterialType.Building
	}
	local itemDic = {}
	local needThemeBanner = #num2List > 1

	for i = 1, #num2List do
		local items = num2List[i]
		local itemType = items[1]
		local itemId = items[2]

		if needThemeBanner then
			local themeId = RoomConfig.instance:getThemeIdByItem(itemId, itemType)

			if themeId then
				self:_addItemInfoToDic(itemDic, themeId, MaterialEnum.MaterialType.RoomTheme)
			end
		end

		if tabletool.indexOf(typeList, itemType) then
			self:_addItemInfoToDic(itemDic, itemId, itemType)
		end
	end

	local list = {}

	for _, itemType in ipairs(typeList) do
		if itemDic[itemType] then
			for __, itemId in ipairs(itemDic[itemType]) do
				table.insert(list, {
					itemId = itemId,
					itemType = itemType
				})
			end
		end
	end

	return list
end

function RoomStroreGoodsTipViewBanner:_addItemInfoToDic(itemDic, itemId, itemType)
	itemDic = itemDic or {}
	itemDic[itemType] = itemDic[itemType] or {}

	if tabletool.indexOf(itemDic[itemType], itemId) == nil then
		table.insert(itemDic[itemType], itemId)
	end

	return itemDic
end

return RoomStroreGoodsTipViewBanner
