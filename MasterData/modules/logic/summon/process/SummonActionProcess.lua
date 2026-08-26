-- chunkname: @modules/logic/summon/process/SummonActionProcess.lua

module("modules.logic.summon.process.SummonActionProcess", package.seeall)

local SummonActionProcess = class("SummonActionProcess")
local Remain_Cost_ItemId = 140001

function SummonActionProcess:summonAction(param, isTen)
	if isTen == true then
		self:summon10Action(param)
	else
		self:summon1Action(param)
	end
end

function SummonActionProcess:summon10Action(param)
	if param then
		if not param.curPool then
			local curPool = SummonMainModel.instance:getCurPool()

			if not curPool then
				return
			end

			self._curPool = curPool

			local cost_type, cost_id, cost_num, ownNum, config_costNum, costList = SummonMainModel.instance:getCost10ById(curPool.id, false, true)

			param = param or {}
			param.type = cost_type
			param.id = cost_id
			param.quantity = cost_num
			param.notEnough = false

			if not param.callback then
				param.callback = self._summon10Confirm
				param.callbackObj = self
			end

			local itemEnough = cost_num <= ownNum
			local everyCostCount = SummonMainModel.instance.everyCostCount
			local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()
			local remainCount = cost_num - ownNum
			local costRemain = everyCostCount * remainCount

			if not itemEnough and currencyNum < costRemain then
				param.notEnough = true
			end

			local itemCostStr = self:_getItemCostConfirmStr(costList, cost_num, remainCount)

			if itemEnough then
				if not string.nilorempty(itemCostStr) then
					GameFacade.showMessageBox(MessageBoxIdDefine.SummonActionCostMoreTypeTip, MsgBoxEnum.BoxType.Yes_No, param.callback, param.noCallback, nil, param.callbackObj, param.noCallbackObj, nil, itemCostStr)

					return
				end

				param.needTransform = false

				if param.callbackObj then
					param.callback(param.callbackObj)
				else
					param.callback()
				end

				return
			else
				param.needTransform = true
				param.cost_type = SummonMainModel.instance.costCurrencyType
				param.cost_id = SummonMainModel.instance.costCurrencyId
				param.cost_quantity = costRemain
				param.miss_quantity = remainCount
				param.needItemCostStr = itemCostStr
			end

			SummonMainController.instance:openSummonConfirmView(param)
		end
	end
end

function SummonActionProcess:_summon10Confirm()
	self:_sendSummonConfirm(10)
end

function SummonActionProcess:_getItemCostConfirmStr(costList, costNum, remainCount)
	local costStr

	if costNum > 1 and costList and self:_isNeedItemCostConfirm(costList, remainCount > 0) then
		local needNum = costNum
		local itemLangStr = luaLang("sp02_summon_itemnum_confirm")
		local addLangStr = luaLang("sp02_summon_itemnum_confirm_add")
		local tItemModel = ItemModel.instance

		if remainCount > 0 and self:_needCompleteCostList(costList) then
			table.insert(costList, {
				MaterialEnum.MaterialType.Item,
				Remain_Cost_ItemId,
				costList[1][3]
			})
		end

		for i, costs in ipairs(costList) do
			local cost_type, cost_id, cost_num = costs[1], costs[2], costs[3]
			local count = tItemModel:getItemQuantity(cost_type, cost_id)
			local config = tItemModel:getItemConfig(cost_type, cost_id)

			if remainCount > 0 and cost_id == Remain_Cost_ItemId then
				count = count + remainCount
			end

			if needNum > 0 and count > 0 and config then
				local str = GameUtil.getSubPlaceholderLuaLangTwoParam(itemLangStr, config.name, math.min(needNum, count))

				needNum = needNum - count
				costStr = costStr == nil and str or costStr .. addLangStr .. str
			end

			if needNum <= 0 then
				break
			end
		end
	end

	return costStr
end

function SummonActionProcess:_isNeedItemCostConfirm(costList, notEnough)
	if costList then
		if #costList > 1 then
			return true
		end

		if notEnough and #costList == 1 then
			local itemId = costList[1][2]

			return itemId ~= Remain_Cost_ItemId
		end
	end

	return false
end

function SummonActionProcess:_needCompleteCostList(costList)
	if costList then
		for i, costs in ipairs(costList) do
			local itemId = costList[1][2]

			if itemId == Remain_Cost_ItemId then
				return false
			end
		end

		return true
	end

	return false
end

function SummonActionProcess:summon1Action(param)
	if param then
		if not param.curPool then
			local curPool = SummonMainModel.instance:getCurPool()

			if not curPool then
				return
			end

			self._curPool = curPool

			local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(curPool.cost1)

			param = param or {}
			param.type = cost_type
			param.id = cost_id
			param.quantity = cost_num
			param.notEnough = false

			if not param.callback then
				param.callback = self._summon1Confirm
				param.callbackObj = self
			end

			local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
			local itemEnough = cost_num <= num
			local everyCostCount = SummonMainModel.instance.everyCostCount
			local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()

			if not itemEnough and currencyNum < everyCostCount then
				param.notEnough = true
			end

			if itemEnough then
				param.needTransform = false

				if param.callbackObj then
					param.callback(param.callbackObj)
				else
					param.callback()
				end

				return
			else
				param.needTransform = true
				param.cost_type = SummonMainModel.instance.costCurrencyType
				param.cost_id = SummonMainModel.instance.costCurrencyId
				param.cost_quantity = everyCostCount
				param.miss_quantity = 1
			end

			SummonMainController.instance:openSummonConfirmView(param)
		end
	end
end

function SummonActionProcess:_summon1Confirm()
	self:_sendSummonConfirm(1)
end

function SummonActionProcess:_sendSummonConfirm(count)
	local curPool = self._curPool

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, count, false, true)
end

return SummonActionProcess
