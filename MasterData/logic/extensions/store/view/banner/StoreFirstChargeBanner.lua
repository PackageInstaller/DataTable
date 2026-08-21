-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/banner/StoreFirstChargeBanner.lua

module("logic.extensions.store.view.banner.StoreFirstChargeBanner", package.seeall)

local M = class("StoreFirstChargeBanner")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._resLoader = PrefabLoader.Get(self.mainGO)

	self._resLoader:load(ResName.Store_first_charge, self._onResourceLoaded, self)
end

function M:_onResourceLoaded(resource)
	local subViewGo = resource:getInst()

	if goutil.isNil(subViewGo) then
		return
	end

	goutil.addChildToParent(subViewGo, self.mainGO)

	if not self._registry then
		self._registry = ViewElementsRegistry.New(subViewGo)
	end

	self:buildUI()
	self:bindEvents()
	StoreRechargeAgent.instance:sendGetRechargeInfoRequest()
end

function M:buildUI()
	self._goItem = self._registry:findUIElement("0&rewards_detail_item_2141037416")
	self._goReward = self._registry:findUIElement("store_super_value_first_recharge_panel_-1928034203")
	self._btnCharge = self._registry:findUIElement("store_super_value_first_recharge_panel_-994191139", UIComponentType.ButtonAdapter)
	self._txtBtnCharge = self._registry:findUIElement("store_super_value_first_recharge_panel_-225619616", UIComponentType.Text)
	self._btnTips = self._registry:findUIElement("store_super_value_first_recharge_panel_-476512632", UIComponentType.ButtonAdapter)
	self._canvasGroup = self._btnCharge.gameObject:GetComponent(ComponentType.CanvasGroup)

	goutil.setActive(self._goItem, false)
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_FIRST_CHARGE, self._refreshView, self)
		GlobalDispatcher:addEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._refreshView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_FIRST_CHARGE, self._refreshView, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._refreshView, self)
	end
end

function M:bindEvents()
	if self._btnCharge then
		self._btnCharge:AddClickListener(self._onClickCharge, self)
	end

	self._btnTips:AddClickListener(self._onClickPreview, self)
end

function M:unbindEvents()
	if self._btnCharge then
		self._btnCharge:RemoveClickListener()
	end

	self._btnTips:RemoveClickListener()
end

function M:isLoaded()
	return self._resLoader:getInst()
end

function M:updateView(storeHotTabMo)
	self._storeHotTabMo = storeHotTabMo

	if self:isLoaded() then
		StoreRechargeAgent.instance:sendGetRechargeInfoRequest()
	end
end

function M:_refreshView()
	if not self._storeHotTabMo or not self:isLoaded() then
		return
	end

	self:_updateText()
	self:_updateReward()
end

function M:OnEnable()
	self:_setEvents(true)
end

function M:OnDisable()
	self:_setEvents(false)
end

function M:OnDestroy()
	self._resLoader:clear()

	self._resLoader = false
	self._rewardItems = nil
	self._storeHotTabMo = nil

	self:unbindEvents()
end

function M:_updateText()
	self._canvasGroup.alpha = 1

	local tips = "tip_store_first_charge_unsatisfied"

	if StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.hasGet then
		tips = "tip_store_first_charge_hasGet"
		self._canvasGroup.alpha = 0.2
	elseif StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.canGet then
		tips = "tip_store_first_charge_canGet"
	end

	self._txtBtnCharge.text = lang(tips)
end

function M:_updateReward()
	if not self._rewardItems then
		self._rewardItems = {}
	end

	local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

	if cfg.reward == 0 then
		return
	end

	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.reward)
	local index = 1

	if rewardCO and rewardCO.reward then
		for i, v in ipairs(rewardCO.reward) do
			local itemData = ItemUtil.createItemData({
				itemId = v.code,
				count = v.num
			})

			if itemData:getType() == GameEnum.ItemTypeEnum.HeroType then
				self._heroData = itemData
			end

			if not self._rewardItems[i] then
				local go = goutil.clone(self._goItem)

				goutil.addChildToParent(go, self._goReward)

				self._rewardItems[i] = Astral.LuaComponentContainer.Add(go, StoreItemCell)
			end

			self._rewardItems[i]:updateData(itemData)
			goutil.setActive(self._rewardItems[i]._go, true)

			index = index + 1
		end
	end

	for i = index, #self._rewardItems do
		goutil.setActive(self._rewardItems[i]._go, false)
	end
end

function M:_onClickCharge()
	if StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.hasGet then
		FloatWordMgr.instance:show(lang("tip_store_first_charge_hasGet"))

		return
	end

	if StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.canGet then
		StoreRechargeAgent.instance:sendReceiveFirstRequest()

		return
	end

	local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

	if cfg.jumpId ~= 0 then
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, cfg.jumpId)
	end
end

function M:_onClickPreview()
	if not self._heroData then
		return
	end

	CharacterUtil.openCharacterPreviewView(self._heroData:getItemId())
end

return M
