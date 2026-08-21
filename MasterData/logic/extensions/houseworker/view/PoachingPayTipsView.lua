-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/PoachingPayTipsView.lua

module("logic.extensions.houseworker.view.PoachingPayTipsView", package.seeall)

local M = class("PoachingPayTipsView", ViewComponent)

function M:buildUI()
	self._txtHint1 = self:getText("poaching_pay_tips_371025949")
	self._txtHint2 = self:getText("poaching_pay_tips_-1986480682")
	self._goFavorabilityEnough = self:getGo("poaching_pay_tips_-1477982521")
	self._goCostItemRoot = self:getGo("poaching_pay_tips_-646130235")
	self._goCostItem = self:getGo("0&rewards_detail_item_2141037416")

	goutil.setActive(self._goCostItem, false)

	self._btnClose = UIComponentType.ButtonAdapter(self:getGo("poaching_pay_tips_2092548776"))
	self._btnCancel = UIComponentType.ButtonAdapter(self:getGo("poaching_pay_tips_-602373081"))
	self._btnConfirm = UIComponentType.ButtonAdapter(self:getGo("poaching_pay_tips_-1848296406"))
end

function M:destroyUI()
	self._txtHint1 = nil
	self._txtHint2 = nil
	self._goFavorabilityEnough = nil
	self._goCostItemRoot = nil
	self._goCostItem = nil
	self._btnClose = nil
	self._btnCancel = nil
	self._btnConfirm = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	self._heroId = info.heroId

	self:refreshView(self._heroId)
end

function M:onExit()
	self:_setEvent(false)
	self:_clearPriceItemClone()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	end
end

function M:handleJumpViewEvent()
	self:close()
	ViewMgr.instance:close(ViewName.JobWorkerSelect)
	ViewMgr.instance:close(ViewName.JobDetail)
	ViewMgr.instance:close(ViewName.HouseJobAdjust)
	ViewMgr.instance:close(ViewName.JobAdjustSchedule)
	ViewMgr.instance:close(ViewName.LivingFacilitiesAdjustSchedule)
	ViewMgr.instance:close(ViewName.NewHouseWorkerMainView)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickConfirm()
	if not self:getFavorEnough() then
		FloatWordMgr.instance:show(lang("tip_condition_fail"))

		return
	end

	if not self:getItemEnough() then
		FloatWordMgr.instance:show(lang("tip_materials_not_enough"))

		return
	end

	HouseAgent.instance:sendHeroThoughtEduRequest(self._heroId)
	self:close()
end

function M:refreshView(heroId)
	local heroMo = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self._HeroFavorCur = heroMo:getTacit()
	self._txtHint1.text = langF("tip_try_poach_s", heroMo and heroMo:getName() or "")

	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(heroId)
	local formula = heroFeatureMo:getThoughtEduFormula()
	local cfgThoughtEdu = HouseConfig.instance:getConfigByKey(ConfigName.HouseThoughtEdu, formula)

	self._HeroFavorRequire = cfgThoughtEdu and cfgThoughtEdu.tacitLv or 0
	self._txtHint2.text = langF("tip_favorability_need_level_s", self._HeroFavorRequire)

	self:trySetItemEnough(cfgThoughtEdu.cost)
	self:setPriceShow(cfgThoughtEdu.cost)
	self:setTopCurrency(formula, cfgThoughtEdu.cost)
	goutil.setActive(self._goFavorabilityEnough, self:getFavorEnough())
	printWarn(string.format("角色[%s]当前友好[%s]", heroId, heroMo:getTacit()))
end

function M:getFavorEnough()
	return self._HeroFavorCur >= self._HeroFavorRequire
end

function M:getItemEnough()
	return self._itemEnough
end

function M:_clearPriceItemClone()
	local len = self._priceItem and #self._priceItem or 0

	if len > 0 then
		for i = len, 1, -1 do
			local shower = self._priceItem[i]
			local go = shower:getMainGo()

			shower:unbindEvents()
			shower:onExit()
			shower:destroyUI()
			goutil.destroy(go)
		end
	end
end

function M:trySetItemEnough(costItemLst)
	self._itemEnough = true

	local len = costItemLst and #costItemLst or 0

	if len > 0 then
		for _, item in ipairs(costItemLst) do
			local nowNum = ItemModel.instance:getItemCountByItemId(item.id)

			if nowNum < item.num then
				self._itemEnough = false
			end
		end
	end
end

function M:setPriceShow(costItemLst)
	local len = costItemLst and #costItemLst or 0
	local show = len > 0

	self._priceItem = {}

	if show then
		local index = 1

		while len > #self._priceItem do
			local tmpGo = goutil.cloneAndSetParent(self._goCostItem, self._goCostItemRoot.transform)
			local shower = self:_updatePriceItemShow(tmpGo, costItemLst[index])

			table.insert(self._priceItem, shower)

			index = index + 1
		end
	end

	goutil.setActive(self._goCostItemRoot, show)
end

function M:_updatePriceItemShow(go, item)
	local itemData = ItemUtil.createItemData({
		itemId = item.id
	})

	itemData:setCount(item.num)

	local shower = Astral.SimpleLuaComponentContainer.Add(go, HoldRewardItemCell)

	shower:setCellData(itemData, 0)
	shower:setNumShow(false)
	shower:setHandler(self)
	shower:setSignShow(CommEnum.BackPackItemSignTyp.None)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	local nowNum = ItemModel.instance:getItemCountByItemId(item.id)
	local numStr

	if nowNum >= item.num then
		numStr = string.format("%s", item.num)
	else
		numStr = string.format("<color=#ff3e48>%s</color>", item.num)
	end

	shower:setNumShow(true, numStr)
	goutil.setActive(go, true)

	return shower
end

function M:setTopCurrency(formula, costItemLst)
	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, CommEnum.MoneyShowType.HousePoachingShowType)
end

return M
