-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/store/TaskBuyGoods.lua

module("logic.extensions.task.util.impl.store.TaskBuyGoods", package.seeall)

local M = class("TaskBuyGoods")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local goodsId = tonumber(paramArray[2])

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	if goodsId == TaskEnum.Const.Any then
		tempStr = string.gsub(tempStr, "#2#", lang("common_any"))
	else
		local goodsCO = StoreConfig.instance:getGoodsCO(goodsId)

		if goodsCO then
			tempStr = string.gsub(tempStr, "#2#", goodsCO.name)
		elseif enableErrorLog then
			printError("Invalid goods id ,code:", code, "goodsId:", goodsId)
		end
	end

	return tempStr, maxCount, true
end

return M
