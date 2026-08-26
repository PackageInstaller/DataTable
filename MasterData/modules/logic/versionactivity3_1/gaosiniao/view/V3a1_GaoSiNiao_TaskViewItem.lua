-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_TaskViewItem.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_TaskViewItem", package.seeall)

local V3a1_GaoSiNiao_TaskViewItem = class("V3a1_GaoSiNiao_TaskViewItem", CorvusTaskItem)

function V3a1_GaoSiNiao_TaskViewItem:_getRewardList()
	local mo = self._mo
	local CO = mo.config
	local bonus = CO.bonus

	if string.nilorempty(bonus) then
		return {}
	end

	local rewardList = {}

	if tonumber(bonus) then
		local list = DungeonConfig.instance:getRewardItems(tonumber(bonus))

		for i, v in ipairs(list) do
			rewardList[i] = {
				v[1],
				v[2],
				v[3]
			}
		end
	else
		local list = ItemModel.instance:getItemDataListByConfigStr(bonus)

		for i, v in ipairs(list) do
			rewardList[i] = {
				v.materilType,
				v.materilId,
				v.quantity
			}
		end
	end

	return rewardList
end

return V3a1_GaoSiNiao_TaskViewItem
