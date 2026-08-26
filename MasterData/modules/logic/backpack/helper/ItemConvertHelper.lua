-- chunkname: @modules/logic/backpack/helper/ItemConvertHelper.lua

module("modules.logic.backpack.helper.ItemConvertHelper", package.seeall)

local ItemConvertHelper = _M

function ItemConvertHelper.isItemConvert(itemId)
	local funcName = string.format("checkConvert_%s", itemId)
	local func = ItemConvertHelper[funcName]

	if not func then
		return false
	end

	return func(itemId)
end

function ItemConvertHelper.checkConvert_143801()
	return not SummonMainModel.instance:getNewbiePoolExist()
end

return ItemConvertHelper
