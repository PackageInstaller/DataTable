-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/itemexchange/ItemExchangeTipsView.lua

module("logic.extensions.backpack.view.itemexchange.ItemExchangeTipsView", package.seeall)

local M = class("ItemExchangeTipsView", ViewComponent)

M.ColorRed = "#d9474b"

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._topCurrencyGo = self:getGo("top_currency_1050779625")
	self._txtDesc = self:getText("common_exchange_tips_-542329446")
	self._btnCancel = self:getBtnByPath("allContent/btnCancel")
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnConfirm = self:getBtnByPath("allContent/btnUse")
	self._txtBtnConfirm = goutil.findChildTextComponent(self._btnConfirm.gameObject, "normal/Text1")
	self._itemSource = Astral.LuaComponentContainer.Add(self:getGo("2&rewards_detail_item_2141037416"), ItemCell)

	self._itemSource:Awake()
	self._itemSource:getComponent("num"):setVisible(true)
	self._itemSource:setShowSelectedEffect(false)
	self._itemSource:setShowTipsPassEvent(false)

	self._itemTarget = Astral.LuaComponentContainer.Add(self:getGo("3&rewards_detail_item_2141037416"), ItemCell)

	self._itemTarget:Awake()
	self._itemTarget:getComponent("num"):setVisible(true)
	self._itemTarget:setShowSelectedEffect(false)
	self._itemTarget:setShowTipsPassEvent(false)

	self._txtUseNum = self:getText("common_exchange_tips_-1797876727")

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._btnMinus = Astral.UILongPressTrigger.Get(self:getGo("common_exchange_tips_-1148320437"))
	self._btnAdd = Astral.UILongPressTrigger.Get(self:getGo("common_exchange_tips_-1641731210"))

	self._btnAdd:SetTriggerTime(longPressTriggerCfg)
	self._btnMinus:SetTriggerTime(longPressTriggerCfg)

	self._slider = UIComponentType.SliderAdapter(self:getGo("common_exchange_tips_116018291"))
	self._uiSlider = self:getUIComponent("common_exchange_tips_116018291", UIComponentType.Slider)
	self._uiSlider.value = 0

	local item2Go = self:getResInstance(CommonResPath.Url_Currency_Item)

	goutil.addChildToParent(item2Go, self._topCurrencyGo)

	local item1Go = self:getResInstance(CommonResPath.Url_Currency_Item)

	goutil.addChildToParent(item1Go, self._topCurrencyGo)
	goutil.setActive(goutil.findChild(item1Go, "btnAdd"), false)
	goutil.setActive(goutil.findChild(item2Go, "btnAdd"), false)

	self._sourceCountTxt = goutil.findChildTextComponent(item1Go, "txtValue")
	self._targetCountTxt = goutil.findChildTextComponent(item2Go, "txtValue")
	self._sourceImg = goutil.addComponentOnce(goutil.findChild(item1Go, "imgIcon"), UIComponentType.Image)
	self._targetImg = goutil.addComponentOnce(goutil.findChild(item2Go, "imgIcon"), UIComponentType.Image)

	local width = goutil.getWidth(self._topCurrencyGo.transform)
	local anchoredPos = self._topCurrencyGo.transform.anchoredPosition

	Astral.TransformUtil.SetAnchoredPos(self._topCurrencyGo.transform, -width / 2, anchoredPos.y)
end

function M:destroyUI()
	self._itemSource = nil
	self._itemTarget = nil
	self._gridLayoutGroup = nil
	self._txtDesc = nil
	self._btnCancel = nil
	self._btnClose = nil
	self._btnConfirm = nil
	self._txtBtnConfirm = nil
	self._btnMinus = nil
	self._btnAdd = nil

	for _, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnAdd:AddLongPressListener(self._onLongPressAdd, self, nil)
	self._btnMinus:AddLongPressListener(self._tryMinusOne, self, nil)
	self._slider:AddOnValueChanged(self._onSliderValChanged, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnAdd:RemoveLongPressListener()
	self._btnMinus:RemoveLongPressListener()
	self._slider:RemoveOnValueChanged()

	for _, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	self._cellItem = {}

	local info = self:getFirstParam()

	self._sourceId = info.sourceId
	self._targetId = info.targetId
	self._minMulti = info.minMulti
	self._sourceStep = info.sourceStep
	self._targetStep = info.targetStep
	self._isMulti = info.isMulti
	self._maxLimit = info.maxLimit
	self._jumpId = info.jumpId and info.jumpId or 0

	self:updateCfg(self._id)

	self._curMultiNum = self._minMulti

	self:updateItemPreUseShow()
	self:_setEvent(true)
end

function M:onExit()
	self._cacheSourceItemCount = nil

	self:_setEvent(false)

	for _, value in pairs(self._cellItem or {}) do
		value:onExit()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
	end
end

function M:_handleGainItemAdd(e, params)
	local lastSoureItemCount = self._cacheSourceItemCount

	if lastSoureItemCount and lastSoureItemCount ~= self:_getItemCount(self._sourceId) then
		self:_updateCount()
		self:updateItemPreUseShow()
	end
end

function M:updateCfg()
	self:_updateCount()

	self._sourceCO = BackpackConfig.instance:getItemInfoByItemId(self._sourceId)

	if not self._jumpId and self._sourceCO.jumpId and self._sourceCO.jumpId > 0 then
		self._jumpId = self._sourceCO.jumpId
	end

	self._jumpDesc = self:getJumpDesc()
	self._targetCO = BackpackConfig.instance:getItemInfoByItemId(self._targetId)

	self:updateItemShow(true, self._sourceId)
	self:updateItemShow(false, self._targetId)
end

function M:_loadRightTopIcon(img, data)
	if not data then
		return
	end

	local icon = data:getIcon()
	local itemTypeEnum = data:getType()

	if string.nilorempty(icon) then
		return
	end

	IconLoader.setSpriteByItemType(img, itemTypeEnum, icon)
end

function M:_updateCount()
	self._sourceCount = ItemModel.instance:getItemCountByItemId(self._sourceId)
	self._targetCount = ItemModel.instance:getItemCountByItemId(self._targetId)
	self._maxNum, self._maxMulti = self:_getNowCanUseMaxNum()
	self._cacheSourceItemCount = self._sourceCount
	self._sourceCountTxt.text = self._sourceCount
	self._targetCountTxt.text = self._targetCount
	self._uiSlider.minValue = 0
	self._uiSlider.maxValue = self._maxMulti
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	local nowMultiNum = self._curMultiNum

	if self:_getSourceEnough(nowMultiNum) then
		local wantedUseSourceNum = self:_getWantedUseSourceNum(nowMultiNum)
		local wantedGetTargetNum = self:_getWantedGetTargetNum(nowMultiNum)

		self:_sendAgent()
	elseif self._jumpId > 0 then
		if not SystemJumpController.instance:canJump(self._jumpId, true) then
			return
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._jumpId)
	else
		FloatWordMgr.instance:show(string.format(lang("tip_store_item_not_enough"), self._sourceCO.name))

		return
	end

	self:close()
end

function M:_sendAgent()
	local sourceType = self._sourceCO.type

	if sourceType == GameEnum.ItemTypeEnum.HeroItemType then
		ContractAgent.instance:sendHeroComposeRequest(self._sourceId, self._curMultiNum * self._targetStep)
	end
end

function M:updateItemPreUseShow()
	local wantedSourceNum = self._curMultiNum * self._sourceStep
	local wantedTargetNum = self._curMultiNum * self._targetStep
	local enough = self:_getSourceEnough(self._curMultiNum)

	if enough then
		self._txtBtnConfirm.text = lang("tip_exchange")

		self._itemSource:getComponent("num"):setCountText(wantedSourceNum)

		self._txtDesc.text = string.format(lang("tip_cost_s_exchange_s"), wantedSourceNum, self._sourceCO.name, wantedTargetNum, self._targetCO.name)
	else
		self._itemSource:getComponent("num"):setCountText(string.format("<color=%s>%d</color>", self.ColorRed, wantedSourceNum))

		if self._jumpId > 0 then
			self._txtBtnConfirm.text = lang("tip_goto_get")
			self._txtDesc.text = string.format(lang("tip_not_enough_goto"), self._sourceCO.name, self.ColorRed, wantedSourceNum, self._jumpDesc)
		else
			self._txtBtnConfirm.text = lang("tip_exchange")
			self._txtDesc.text = string.format(lang("tip_cost_s_exchange_s_c"), self.ColorRed, wantedSourceNum, self._sourceCO.name, wantedTargetNum, self._targetCO.name)
		end
	end

	self._txtUseNum.text = wantedSourceNum

	self._itemTarget:getComponent("num"):setVisible(true)
	self._itemTarget:getComponent("num"):setCountText(wantedTargetNum)
end

function M:getJumpDesc()
	local jumpDesc = ""
	local jumpId = self._jumpId

	if jumpId and jumpId > 0 then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if jumpInfo then
			jumpDesc = jumpInfo.jumpDesc
		else
			printError(string.format("无法从[%s]找到[%s]的配置", ConfigName.SystemJump, jumpId))
		end
	end

	return jumpDesc
end

function M:_onSliderValChanged(val)
	self._curMultiNum = val

	self:updateItemPreUseShow()
end

function M:_onLongPressAdd()
	self:_tryAddOne(true)
end

function M:_tryAddOne(showToast)
	if self._curMultiNum >= self._maxMulti then
		FloatWordMgr.instance:show(lang("tip_exchange_add_max"))

		return
	end

	local _readyNum = self._curMultiNum + 1

	if _readyNum > self._maxMulti then
		return
	end

	self._curMultiNum = _readyNum

	self:updateItemPreUseShow()
	self._uiSlider:SetValueWithoutNotify(self._curMultiNum)
end

function M:_tryMinusOne()
	if self._curMultiNum <= self:_getMinMulti() then
		FloatWordMgr.instance:show(lang("tip_exchange_minus_min"))

		return
	end

	local _readyNum = self._curMultiNum - 1

	if _readyNum < self:_getMinMulti() then
		return
	end

	self._curMultiNum = _readyNum

	self:updateItemPreUseShow()
	self._uiSlider:SetValueWithoutNotify(self._curMultiNum)
end

function M:updateItemShow(isSource, itemId)
	local itemCell = isSource and self._itemSource or self._itemTarget
	local itemData = ItemData.New({
		count = 1,
		itemId = itemId
	})

	itemCell:updateData(itemData)

	local countStr

	if isSource then
		itemCell:getComponent("num"):setVisible(not self._isMulti)
		self:_loadRightTopIcon(self._sourceImg, itemData)
	else
		self:_loadRightTopIcon(self._targetImg, itemData)
	end
end

function M:_getMinMulti()
	return self._minMulti or 1
end

function M:_getItemCount(itemId)
	return ItemModel.instance:getItemCountByItemId(itemId)
end

function M:_getSourceEnough(multiNum)
	local owenNum = self:_getItemCount(self._sourceId)

	return owenNum >= self:_getWantedUseSourceNum(multiNum)
end

function M:_getWantedUseSourceNum(multiNum)
	return multiNum * self._sourceStep
end

function M:_getWantedGetTargetNum(multiNum)
	return multiNum * self._targetStep
end

function M:_getNowCanUseMaxNum()
	local num = 0
	local multi = 0
	local multiMax = self._maxLimit
	local owenNum = self._sourceCount

	multi = math.floor(owenNum / self._sourceStep)
	multi = multiMax ~= 0 and multiMax <= multi and multiMax or multi
	multi = multi <= self:_getMinMulti() and self:_getMinMulti() or multi
	num = self:_getWantedUseSourceNum(multi)

	return num, multi
end

return M
