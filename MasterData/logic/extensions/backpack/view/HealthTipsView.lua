-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/HealthTipsView.lua

module("logic.extensions.backpack.view.HealthTipsView", package.seeall)

local M = class("HealthTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/clickExit")
	self._btnCancle = self:getBtnByPath("allContent/btnCancel")
	self._btnUse = self:getBtnByPath("allContent/btnUse")
	self._btnMinus = Astral.UILongPressTrigger.Get(self:getGo("health_tips_157882474"))
	self._btnAdd = Astral.UILongPressTrigger.Get(self:getGo("health_tips_750925399"))

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._btnAdd:SetTriggerTime(longPressTriggerCfg)
	self._btnMinus:SetTriggerTime(longPressTriggerCfg)

	self._canvasGroupAdd = goutil.addComponentOnce(self._btnAdd.gameObject, ComponentType.CanvasGroup)
	self._canvasGroupMinus = goutil.addComponentOnce(self._btnMinus.gameObject, ComponentType.CanvasGroup)
	self._txtDetails = self:getText("health_tips_1833674939")
	self._txtNowUse = self:getText("health_tips_640780584")
	self._slider = UIComponentType.SliderAdapter(self:getGo("health_tips_-1274195630"))
	self._uiSlider = self:getUIComponent("health_tips_-1274195630", UIComponentType.Slider)
	self._uiSlider.value = 0

	local cellGo = self:getGo("health_tips_266905855")

	self._itemCell = Astral.SimpleLuaComponentContainer.Add(cellGo.transform:GetChild("0").gameObject, ItemCell)

	self._itemCell:setShowTipsPassEvent(false)
	self._itemCell:setShowSelectedEffect(false)

	local targetItem = ItemUtil.createItemData({
		itemId = CommEnum.CurrencyCodeEnum.TlCode
	})

	self._targetItemName = targetItem:getName()
	self._goTimeTips = self:getGo("health_tips_-1109780324")
	self._txtTimeNext = self:getUIComponent("health_tips_10492474", UIComponentType.Text)
	self._txtTimeMax = self:getUIComponent("health_tips_1039149664", UIComponentType.Text)
end

function M:destroyUI()
	self._btnCancle = nil
	self._btnUse = nil
	self._btnMinus = nil
	self._btnAdd = nil
	self._txtDetails = nil
	self._slider = nil
	self._uiSlider = nil
	self._itemCell = nil
	self._energyMax = nil
	self._energyRecoverMax = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickCancel, self)
	self._btnCancle:AddClickListener(self._onClickCancel, self)
	self._btnUse:AddClickListener(self._onClickUse, self)
	self._btnMinus:AddLongPressListener(self._tryMinusOne, self, nil)
	self._btnAdd:AddLongPressListener(self._onLongPressAdd, self, nil)
	self._slider:AddOnValueChanged(self._onSliderValChanged, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btnMinus:RemoveLongPressListener()
	self._btnAdd:RemoveLongPressListener()
	self._slider:RemoveOnValueChanged()
end

function M:onEnter()
	self._isEnter = true
	self._canvasGroup.interactable = true

	local info = self:getFirstParam()

	if not info.itemData then
		self:close()
	end

	self._itemData = info.itemData

	if self:_isOverExpireTime() then
		FloatWordMgr.instance:show(lang("tip_goods_overdue"))
	end

	self._energyMax = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyMax)
	self._energyRecoverMax = ConstConfig.instance:getNumValueByKey("EnergyAddLimit")

	self._itemCell:updateData(self._itemData)

	self._minDoubleCount = 1
	self._maxDoubleCount = self:_getMaxNum(self._energyRecoverMax)
	self._uiSlider.minValue = self._minDoubleCount
	self._uiSlider.maxValue = self._maxDoubleCount

	self._slider:SetValue(self._minDoubleCount)
	self:setEvent(true)

	local interactable = true

	if self:getCurEnergy() >= self._energyMax or self:_isEnergyMax(self:getCurDoubleCount()) then
		FloatWordMgr.instance:show(lang("tip_physical_power_max"))

		interactable = false
	elseif self:getCurEnergy() >= self._energyRecoverMax or self:_isEnergyMaxRecover(self:getCurDoubleCount()) then
		FloatWordMgr.instance:show(langF("tip_power_add_fail_by_recover_limit", self._energyRecoverMax))

		interactable = false
	end

	self._uiSlider.interactable = interactable
end

function M:onExit()
	self._isEnter = false
	self._canvasGroup.interactable = false
	self._itemData = nil

	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self.handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateTimer, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self.handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateTimer, self)
	end
end

function M:_updateTimer()
	if not self._isEnter then
		return
	end

	local leftTime, totalLeftTime = EnergyRecoverModel.instance:getEnergyRecoverTimeAll()
	local isMax = EnergyRecoverModel.instance:isEnergyMaxLimit()

	if leftTime >= 0 then
		self._txtTimeNext.text = TimeUtil.instance:second2TimeString(leftTime, true)
		self._txtTimeMax.text = TimeUtil.instance:second2TimeString(totalLeftTime, true)
	end

	goutil.setActive(self._goTimeTips, leftTime > 0 or not isMax)
end

function M:handleGainItemAdd(e)
	if not self._itemData then
		return
	end

	local uuid = self._itemData:getUuid()
	local itemPackData = ItemModel.instance:getItemDataByUuid(uuid)
	local realItemCount = itemPackData and itemPackData:getCount() or 0

	self._itemData:setCount(realItemCount)
	self:updateShow()
end

function M:_onSliderValChanged(val)
	self:setCurDoubleCount(val)
end

function M:setCurDoubleCount(count)
	self._curDoubleCount = count

	self:updateShow()
end

function M:getCurDoubleCount()
	return self._curDoubleCount or 1
end

function M:getCurEnergy()
	return ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode)
end

function M:_isEnergyMax(useNum)
	if not self._itemData then
		return true
	end

	local expInfo = tonumber(self._itemData:getExtrInfo())

	return useNum * expInfo + self:getCurEnergy() > self._energyMax
end

function M:_isEnergyMaxRecover(useNum)
	if not self._itemData then
		return true
	end

	local expInfo = tonumber(self._itemData:getExtrInfo())

	return useNum * expInfo + self:getCurEnergy() > self._energyRecoverMax
end

function M:_getMaxNum(maxVal)
	if not self._itemData then
		return 1
	end

	local maxCount = 0
	local curEnergy = self:getCurEnergy()
	local expInfo = tonumber(self._itemData:getExtrInfo())
	local count = self._itemData:getCount()

	for i = 1, count do
		if maxVal >= i * expInfo + curEnergy then
			maxCount = i
		end
	end

	return maxCount
end

function M:_isOverExpireTime()
	if not self._itemData then
		return true
	end

	local curTime = ServerTime.now() * 1000
	local expireTime = tonumber(self._itemData:getExpireTime())

	return expireTime ~= 0 and expireTime <= curTime
end

function M:updateShow()
	local curDoubleCount = self:getCurDoubleCount()
	local expInfo = self._itemData and tonumber(self._itemData:getExtrInfo()) or 0
	local _addEnergy = curDoubleCount * expInfo
	local _sorceItemName = self._itemData and self._itemData:getName() or ""

	self._txtDetails.text = string.format(lang("tip_recover_energy_predict"), curDoubleCount, _sorceItemName, _addEnergy, self._targetItemName)
	self._txtNowUse.text = curDoubleCount
	self._canvasGroupAdd.alpha = self._uiSlider.value >= self._uiSlider.maxValue and 0.2 or 1
	self._canvasGroupMinus.alpha = self._uiSlider.value <= self._uiSlider.minValue and 0.2 or 1
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickUse()
	if not self._itemData then
		return
	end

	if self:_isOverExpireTime() then
		FloatWordMgr.instance:show(lang("tip_goods_overdue"))

		return
	end

	local curDoubleCount = self:getCurDoubleCount()

	if curDoubleCount == 0 or self:getCurEnergy() >= self._energyMax or self:_isEnergyMax(curDoubleCount) then
		FloatWordMgr.instance:show(lang("tip_physical_power_max"))

		return
	end

	if self:getCurEnergy() >= self._energyRecoverMax or self:_isEnergyMaxRecover(curDoubleCount) then
		FloatWordMgr.instance:show(langF("tip_power_add_fail_by_recover_limit", self._energyRecoverMax))

		return
	end

	local uuid = self._itemData:getUuid()
	local _sendStr = string.format("{%s:%d}", uuid, curDoubleCount)

	HealthExchangeAgent.instance:sendUseEnergyItemsRequest(_sendStr)
	self:close()
end

function M:_onLongPressAdd()
	self:_tryAddOne(true)
end

function M:_tryAddOne(showToast)
	local curDoubleCount = self:getCurDoubleCount()
	local itemCount = self._itemData:getCount()

	if itemCount <= curDoubleCount then
		return
	end

	local _readyNum = curDoubleCount + 1

	if self:_isEnergyMaxRecover(_readyNum) then
		if showToast then
			FloatWordMgr.instance:show(langF("tip_power_add_fail_by_recover_limit", self._energyRecoverMax))
		end

		self:updateShow()

		return
	end

	if self:_isEnergyMax(_readyNum) then
		if showToast then
			FloatWordMgr.instance:show(lang("tip_physical_power_max"))
		end

		self:updateShow()

		return
	end

	self._slider:SetValue(_readyNum)
end

function M:_tryMinusOne()
	local curDoubleCount = self:getCurDoubleCount()

	if curDoubleCount <= 0 then
		return
	end

	self._slider:SetValue(curDoubleCount - 1)
end

return M
