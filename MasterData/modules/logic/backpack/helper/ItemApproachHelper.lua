-- chunkname: @modules/logic/backpack/helper/ItemApproachHelper.lua

module("modules.logic.backpack.helper.ItemApproachHelper", package.seeall)

local ItemApproachHelper = _M

function ItemApproachHelper.isTaskApproach(getApproach)
	if not getApproach then
		return false
	end

	if getApproach == MaterialEnum.GetApproach.Task or getApproach == MaterialEnum.GetApproach.TaskAct or getApproach >= MaterialEnum.TaskGetApproachLimit.Min and getApproach <= MaterialEnum.TaskGetApproachLimit.Max then
		return true
	end

	return false
end

return ItemApproachHelper
