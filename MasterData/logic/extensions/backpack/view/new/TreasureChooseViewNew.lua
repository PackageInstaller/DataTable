-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/new/TreasureChooseViewNew.lua

module("logic.extensions.backpack.view.new.TreasureChooseViewNew", package.seeall)

local M = class("TreasureChooseViewNew", ViewComponent)

function M:buildUI()
	self._btnCancle = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_right_1251431307"), CommButton)
	self._btnClose = self:getBtn("4&universal_second_tips_common_bg_1201003252")
	self._btnBg = self:getBtn("4&universal_second_tips_common_bg_-1467035629")
	self._txtTitle = self:getText("4&universal_second_tips_common_bg_-1535781828")
	self._btnAdd = self:getBtn("secret_time_buy_level_tips_397683377")
	self._btnMinus = self:getBtn("secret_time_buy_level_tips_-517090291")
	self.text_txtNum = self:getText("secret_time_buy_level_tips_662316174")
	self._slider = self:getUIComponent("secret_time_buy_level_tips_848803011", UIComponentType.Slider)
	self._sliderCount = self:getSlider("secret_time_buy_level_tips_848803011")
	self._rectTrContent = self:getUIComponent("common_multiple_choice_tips_-1123175783", UIComponentType.RectTransform)

	goutil.setActive(self._rectTrContent:GetChild(0).gameObject, false)

	self._gridLayoutGroup = self._rectTrContent:GetComponent(UIComponentType.GridLayoutGroup)
	self._gridLayoutGroup.enabled = true
	self._contentSizeFilter = self._rectTrContent:GetComponent("ContentSizeFitter")
	self._contentSizeFilter.enabled = true
	self._goTextPrice = self:getGo("7&com_price_1317146225")
	self._goTextTips = self:getGo("common_multiple_choice_tips_143310378")

	goutil.setActive(self._goTextPrice)
	goutil.setActive(self._goTextTips)

	self._txtCountContent = self:getText("common_multiple_choice_tips_1425455421")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.onClickClose, self)
	self._btnBg:AddClickListener(self.onClickClose, self)
	self._btnCancle:AddClickListener(self.onClickCancel, self)
	self._btnConfirm:AddClickListener(self.onClickUse, self)
	self._btnMinus:AddClickListener(self.tryMinusOne, self)
	self._btnAdd:AddClickListener(self.tryAddOne, self)
	self._sliderCount:AddOnValueChanged(self._onSelectCountChanged, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._sliderCount:RemoveOnValueChanged()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.ITEM_TREASURE_CHOOSE, self._onSelectItem, self)

	local params = self:getOpenParam()

	if not params then
		return
	end

	self._item = params[1]

	local needItemId = params[2]
	local needItemCount = params[3] or 0

	self._curUseNum = math.min(0, self._item:getCount())

	local itemCo = self._item:getItemInfo()

	self._maxUseCount = itemCo.batchUseLimit == 0 and 1 or itemCo.batchUseLimit
	self._sliderCount.slider.maxValue = self:_getCanUseMaxCount()

	self._slider:SetValueWithoutNotify(self._curUseNum)
	self:_refreshCountChanged()

	self._selectIndex = 0
	self._txtTitle.text = itemCo.name

	local item = ItemUtil.createItemData({
		count = 1,
		itemId = needItemId
	})

	self._txtCountContent.text = langF("tip_treasure_choose_need", needItemCount, item:getName())

	goutil.setActive(self._txtCountContent.gameObject, needItemCount > 0)
	self:showRewardsList(itemCo.rewards)
	self:_initSelectItem(needItemId, needItemCount)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.ITEM_TREASURE_CHOOSE, self._onSelectItem, self)
end

function M:onExitFinished()
	for _, cell in pairs(self._itemCell or {}) do
		goutil.destroy(cell:getGo())
	end

	self._itemCell = nil
end

function M:_refreshCountChanged()
	self.text_txtNum.text = string.format("%d/%d", self._curUseNum, self._item:getCount())
end

function M:tryAddOne()
	if not self._selectIndex or self._selectIndex < 1 then
		FloatWordMgr.instance:show(lang("tip_item_use_treasure_not_choose"))

		return
	end

	self._curUseNum = math.min(self._curUseNum + 1, self:_getCanUseMaxCount())

	self._sliderCount:SetValue(self._curUseNum)
end

function M:tryMinusOne()
	if not self._selectIndex or self._selectIndex < 1 then
		return
	end

	self._curUseNum = math.max(self._curUseNum - 1, 0)

	self._sliderCount:SetValue(self._curUseNum)
end

function M:_getCanUseMaxCount()
	local itemHas = self._item:getCount()

	return math.min(itemHas, self._maxUseCount)
end

function M:_initSelectItem(selectItemId, selectItemCount)
	if not self._itemCell or not selectItemId then
		return
	end

	for i = 1, #self._itemCell do
		local itemCell = self._itemCell[i]
		local data = itemCell:getData()

		if data:getItemId() == selectItemId then
			itemCell:dealSelect()

			if selectItemCount and selectItemCount > 0 then
				local itemCount = data:getCount()
				local itemHas = self._item:getCount()

				self._curUseNum = math.ceil(selectItemCount / itemCount)
				self._curUseNum = itemHas >= self._curUseNum and self._curUseNum or itemHas
				self._curUseNum = self._curUseNum == 0 and 1 or self._curUseNum

				self._sliderCount:SetValue(self._curUseNum)
				self:_refreshCountChanged()
			end
		end
	end
end

function M:handleOverExpireTime()
	local itemExpireTime = tonumber(self._item:getExpireTime())

	if not itemExpireTime or itemExpireTime == 0 then
		return false
	end

	local curTime = ServerTime.now() * 1000
	local isOver = itemExpireTime <= curTime

	if isOver then
		FloatWordMgr.instance:show(lang("tip_goods_overdue"))

		return true
	end

	return false
end

function M:onClickUse()
	if self:handleOverExpireTime() then
		return
	end

	if self._curUseNum == 0 or self._maxUseCount and self._curUseNum > self._maxUseCount then
		return
	end

	if not self._selectIndex or self._selectIndex < 1 then
		FloatWordMgr.instance:show(lang("tip_item_use_treasure_not_choose"))

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ITEM_USE_EVENT, {
		uuid = self._item:getUuid(),
		type = self._item:getType(),
		subType = self._item:getSubType(),
		itemId = self._item:getItemId(),
		count = self._curUseNum,
		param = tostring(self._selectIndex - 1)
	})
	ViewMgr.instance:close(ViewName.TreasureChooseViewNew, false, WindowType.WindowCloseReasonType.QuickCloseType)
end

function M:_onSelectCountChanged(value)
	if not self._selectIndex or self._selectIndex < 1 then
		if value > 0 then
			value = 0

			self._slider:SetValueWithoutNotify(value)
		end

		if not ViewMgr.instance:isOpen(ViewName.CharacterTopToastTips) then
			FloatWordMgr.instance:show(lang("tip_item_use_treasure_not_choose"))
		end
	end

	self._curUseNum = value

	self:_refreshCountChanged()
end

function M:showRewardsList(rewards)
	self._rewards = {}

	for _, info in pairs(rewards) do
		local item = ItemUtil.createItemData({
			itemId = info.code,
			count = info.num
		})

		table.insert(self._rewards, item)
	end

	self:refreshItemScroll()
end

function M:onClickClose()
	self:close()
end

function M:onClickCancel()
	self:close()
end

function M:_onSelectItem(_, index)
	local selectTwice = self._selectIndex and self._selectIndex == index

	self._selectIndex = index

	for i, cell in ipairs(self._itemCell or {}) do
		local isSelected = self._selectIndex == i

		cell:onSelect(isSelected)

		if selectTwice and isSelected then
			cell:dealLongSelect()
		end
	end
end

function M:refreshItemScroll()
	self._itemCell = {}

	while self._rectTrContent.childCount < #self._rewards + 1 do
		goutil.cloneAndSetParent(self._rectTrContent:GetChild(0).gameObject, self._rectTrContent)
	end

	for i = 1, self._rectTrContent.childCount - 1 do
		local itemGo = self._rectTrContent:GetChild(i).gameObject
		local itemData = self._rewards[i]

		if itemData then
			local itemView = Astral.LuaComponentContainer.Add(itemGo, TreasureRewardItemCell)

			itemView:updateData(itemData)
			itemView:setIndex(i)
			itemView:setNumVisible(itemData:getCount() > 1)
			itemView:setItemName(itemData:getName())
			itemView:onSelect(self._selectIndex == i)

			self._itemCell[i] = itemView
		end

		goutil.setActive(itemGo, itemData)
	end
end

function M:showTitleHint()
	return
end

return M
