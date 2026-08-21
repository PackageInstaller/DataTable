-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/view/HealthExchangeByYtFragmentView.lua

module("logic.extensions.healthexchange.view.HealthExchangeByYtFragmentView", package.seeall)

local M = class("HealthExchangeByYtFragmentView")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self._registry
	local mainGO = self._mainGO

	self._goPanel = registry:findUIElement("health_exchange_tips_1010175278")
	self._txtCurEnergy = registry:findUIElement("health_exchange_tips_-1618018733", UIComponentType.Text)
	self._txtWantAddEnergy = registry:findUIElement("health_exchange_tips_-204869103", UIComponentType.Text)
	self._txtMaxEnergy = registry:findUIElement("health_exchange_tips_1708112615", UIComponentType.Text)

	TextUtils.SetColor(self._txtMaxEnergy, MoneyUtil.MaxEnergyColor)

	self._txtBuyLimit = registry:findUIElement("health_exchange_tips_-167069204", UIComponentType.Text)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(mainGO, "content/btnUse"), CommButton)
	self._goBuyCost = registry:findUIElement("health_exchange_tips_-1051399152")
	self._itemCell = Astral.SimpleLuaComponentContainer.Add(self._goBuyCost.transform:GetChild("0").gameObject, ItemCell)
	self._currencyExchangeId = HealthExchangeModel.instance:getEnergyBuyRuleId()
	self._energyMax = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyMax)
	self._energyRecoverMax = ConstConfig.instance:getNumValueByKey("EnergyAddLimit")
end

function M:destroyUI()
	self._txtBuyLimit = nil
	self._goBuyCost = nil
	self._itemCell = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	goutil.setActive(self._goBuyCost, true)
	goutil.setActive(self._goPanel, true)
	self:_refreshEnergyBuyView()
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
	goutil.setActive(self._goBuyCost, false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleGainItemViewClose, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.CURRENCY_EXCHANGE_TIME_CHANGE, self._handleCurrencyExchangeTimeChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_JUMP_TO_STORE_REPLY, self._handleJumpToStoreReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleGainItemViewClose, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.CURRENCY_EXCHANGE_TIME_CHANGE, self._handleCurrencyExchangeTimeChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_JUMP_TO_STORE_REPLY, self._handleJumpToStoreReply, self)
	end
end

function M:_handleGainItemViewClose()
	self:_refreshEnergyBuyView()
end

function M:_handleGainItemAdd(e, params)
	self:_refreshEnergyBuyView()

	self._txtCurEnergy.text = HealthExchangeModel.instance:getCurEnergy()
end

function M:_handleCurrencyExchangeTimeChange(e, ruleId)
	self:_refreshEnergyBuyView()
end

function M:_handleJumpToStoreReply(e, success)
	if not success then
		ToolTipsMgr.showCharacterTopToast(lang("tip_system_open_not_online"), CommEnum.CharacterTopToastIcon.Info, 1)
	end
end

function M:setBtnConfirmInteractable(active)
	self._btnConfirm:setActiveState(active)
end

function M:init()
	local cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(self._currencyExchangeId)

	if cfgCO then
		self._energyBuyCostItemId = cfgCO:getSourceId()
		self._energyBuyCost = cfgCO:getSourceNum()
		self._energyBuyNum = cfgCO:getTargetNum()
		self._energyBuyJumpId = cfgCO:getJumpId()
	end

	local itemId = self._energyBuyCostItemId
	local itemCount = ItemModel.instance:getItemCountByItemId(itemId)
	local ytItem = ItemUtil.createItemData({
		itemId = itemId,
		count = itemCount
	})

	self._itemCell:updateData(ytItem)
	self._itemCell:setShowTipsPassEvent(false)
	self._itemCell:setShowSelectedEffect(false)

	self._itemName = ytItem:getName()

	local energyMaxPlayer = PlayerModel.instance:getEnergyLimit()
	local curEnergy = HealthExchangeModel.instance:getCurEnergy()
	local finalEnergy = curEnergy + self._energyBuyNum
	local isMaxEnergy = energyMaxPlayer < finalEnergy

	self._txtWantAddEnergy.text = finalEnergy

	if isMaxEnergy then
		self._txtWantAddEnergy.color = parsecolor(MoneyUtil.CurEnergyReachMaxColor)
	else
		self._txtWantAddEnergy.color = parsecolor(MoneyUtil.CurEnergyNormalColor)
	end

	self._txtMaxEnergy.text = string.format("/%s", energyMaxPlayer)
	self._txtCurEnergy.text = curEnergy
end

function M:_refreshEnergyBuyView()
	self:init()

	local jumpId = self._energyBuyJumpId
	local curNum = ItemModel.instance:getItemCountByItemId(self._energyBuyCostItemId)
	local cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(self._currencyExchangeId)
	local itemNameSource = cfgCO:getItemNameSource()
	local itemNameTarget = cfgCO:getItemNameTarget()
	local buyRemainedCount = HealthExchangeModel.instance:getEnergyBuyRemainedTime()
	local remainedStr = buyRemainedCount == 0 and string.format("<color=#d9474b>%s</color>", buyRemainedCount) or buyRemainedCount
	local buyMaxCount = HealthExchangeModel.instance:getEnergyBuyMaxTime()

	self._txtBuyLimit.text = langF("tip_buy_power_remained_count", remainedStr, buyMaxCount)

	local enough = curNum > 0 and curNum >= self._energyBuyCost

	if enough then
		self._btnConfirm:setText(lang("tip_exchange"))
		self:_updateCellNum(tostring(self._energyBuyCost))
		self:setBtnConfirmInteractable(buyRemainedCount > 0)
	elseif jumpId > 0 then
		local systemOpen = SystemJumpController.instance:canJump(jumpId, false)

		self._btnConfirm:setText(lang("tip_goto_1"))
		self:setBtnConfirmInteractable(systemOpen)
		self:_updateCellNum(string.format("<color=#d9474b>%s</color>", self._energyBuyCost))
	else
		self._btnConfirm:setText(lang("tip_exchange"))
		self:setBtnConfirmInteractable(false)
		self:_updateCellNum(string.format("<color=#d9474b>%s</color>", self._energyBuyCost))
	end
end

function M:_updateCellNum(str)
	self._itemCell:getComponent("num"):setNumBgNodeVisible(false)
	self._itemCell:getComponent("num"):setCountText(str)
end

function M:_onClickCostItem()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_generic_select, nil, nil, nil)

	if not self._itemData then
		self._itemData = ItemData.New({
			count = 0,
			itemId = self._energyBuyCostItemId
		})
	end

	GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, self._itemData, self._goBuyCost, 0, true, true)
end

function M:onClickConfirm()
	self._curYtNum = ItemModel.instance:getItemCountByItemId(self._energyBuyCostItemId)

	if self._curYtNum <= 0 or self._curYtNum < self._energyBuyCost then
		local jumpId = self._energyBuyJumpId

		if jumpId > 0 then
			if SystemJumpController.instance:canJump(jumpId, true) then
				local dialog = Dialog.showMessage(lang("tip_title"), langF("tip_power_yt_jump_guide", self._itemName))

				dialog:setConfirmListener(function()
					GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
				end, self)
				dialog:setCancelListener(function()
					ViewMgr.instance:close(ViewName.HealthExchangeTipsView)
				end, self)
			end
		else
			local cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(self._currencyExchangeId)
			local itemNameSource = cfgCO:getItemNameSource()

			FloatWordMgr.instance:show(string.format(lang("tip_origin_coin_not_enough"), itemNameSource))
		end
	else
		if HealthExchangeModel.instance:getEnergyBuyRemainedTime() <= 0 then
			FloatWordMgr.instance:show(lang("tip_buy_power_max_day"))

			return
		end

		local _curEnergy = HealthExchangeModel.instance:getCurEnergy()

		if _curEnergy + self._energyBuyNum > self._energyRecoverMax then
			FloatWordMgr.instance:show(langF("tip_power_add_fail_by_recover_limit", self._energyRecoverMax))

			return
		end

		if _curEnergy + self._energyBuyNum > self._energyMax then
			FloatWordMgr.instance:show(lang("tip_buy_power_max"))

			return
		end

		BackpackAgent.instance:sendExchangeCurrencyRequest(self._currencyExchangeId, 1)
	end
end

return M
