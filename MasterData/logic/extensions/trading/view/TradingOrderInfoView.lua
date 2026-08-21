-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderInfoView.lua

module("logic.extensions.trading.view.TradingOrderInfoView", package.seeall)

local OrderMaterialItem = class("OrderMaterialItem")

function OrderMaterialItem:ctor(compContainer)
	self._go = compContainer.gameObject
	self._imgIcon = goutil.findChildImageComponent(self._go, "")
	self._txtCount = goutil.findChildTextComponent(self._go, "")
end

function OrderMaterialItem:updateData(data)
	self._txtCount.text = data.count

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Battle, data.icon)
end

local M = class("TradingOrderInfoView", ViewComponent)

function M:buildUI()
	self._txtName = self:getText("trade_order_details_tips_1021807002")
	self._txtSource = self:getText("trade_order_details_tips_-1903757310")
	self._txtDesc = self:getText("trade_order_details_tips_1872836695")
	self._btnCancel = self:getBtn("trade_order_details_tips_1789369044")
	self._btnSubmit = self:getBtn("trade_order_details_tips_661267161")
	self._btnClose = self:getBtn("3&middle_tips_common_bg_-1205189576")
	self._btnMask = self:getBtn("trade_order_details_tips_446082096")
	self._traRewards = self:getGo("trade_order_details_tips_-861526774").transform
	self._traCosts = self:getGo("trade_order_details_tips_692744443").transform
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnSubmit:AddClickListener(self._onClickSubmit, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnMask:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnSubmit:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function M:onEnter()
	self._id = self:getFirstParam()
	self._orderType = self:getOpenParam()[2]
	self._orderIndex = self:getOpenParam()[3]

	self:updateData()
end

function M:onExit()
	return
end

function M:onExitFinished()
	return
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickSubmit()
	TradingAgent.instance:sendAcceptOrderRequest(self._orderType, self._orderIndex)
	self:close()
end

function M:_onClickClose()
	if ToolTipsController.instance:getInCloseTipsTime() then
		return
	end

	self:close()
end

function M:updateData()
	goutil.clearChildren(self._traRewards.gameObject)
	goutil.clearChildren(self._traCosts.gameObject)

	local co = TradingConfig.instance:getOrderDetailById(self._id)

	if not co then
		return
	end

	self._txtName.text = co.name
	self._txtDesc.text = co.desc
	self._txtSource.text = co.source

	local rewardList = {}
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(co.reward)

	for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			table.insert(rewardList, v)
		end
	end

	for i, v in ipairs(rewardCO.randomReward1 and rewardCO.randomReward1 or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			table.insert(rewardList, v)
		end
	end

	for i, v in ipairs(rewardCO.randomReward2 and rewardCO.randomReward2 or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			table.insert(rewardList, v)
		end
	end

	for i, v in ipairs(rewardCO.randomReward3 and rewardCO.randomReward3 or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			table.insert(rewardList, v)
		end
	end

	for i, reward in ipairs(rewardList) do
		local itemData = ItemUtil.createItemData({
			itemId = tonumber(reward.code),
			count = reward.num
		})
		local obj = self:getResInstance(ResName.Common_Backpack_Item)
		local objBeh = Astral.LuaComponentContainer.Add(obj, ItemCell)

		goutil.addChildToParent(obj, self._traRewards)
		objBeh:updateData(itemData)
		objBeh:setShowSelectedEffect(false)
		objBeh:getComponent("num"):setTextColor(parsecolor("#9E9E9E"))
		objBeh:getComponent("num"):setNumBgNodeVisible(false)
		goutil.setActive(obj, true)
	end

	for i, cost in ipairs(co.cost) do
		local itemData = ItemUtil.createItemData({
			count = 1,
			itemId = cost.id
		})
		local obj = self:getResInstance(ResName.Common_Backpack_Item)
		local objBeh = Astral.LuaComponentContainer.Add(obj, ItemCell)

		goutil.addChildToParent(obj, self._traCosts)

		local curNum = ItemModel.instance:getItemCountByItemId(cost.id)
		local count = curNum < cost.num and string.format("<color=#BF4049>%d</color>/%d", curNum, cost.num) or string.format("%d/%d", curNum, cost.num)

		objBeh:updateData(itemData)
		objBeh:setShowSelectedEffect(false)
		objBeh:getComponent("num"):setTextColor(parsecolor("#9E9E9E"))
		objBeh:getComponent("num"):setNumBgNodeVisible(false)
		objBeh:getComponent("num"):setCountText(count)
		goutil.setActive(obj, true)
	end
end

return M
