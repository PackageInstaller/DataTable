-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewPromoteView.lua

module("logic.extensions.season.view.SeasonNewPromoteView", package.seeall)

local M = class("SeasonNewPromoteView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._txtHint = self:getTextByPath("txtTips")
	self._goScrollRect = self:getGoByPath("scrollView")
	self._goScrollContent = goutil.findChild(self._goScrollRect, "ViewPort/content")
	self._loopList = LoopListHelper.New(self._goScrollRect)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._sliderBuyLv = self:getSlider("secret_time_buy_level_tips_848803011")
	self._btnMinus = self:getBtn("secret_time_buy_level_tips_-517090291")
	self._btnAdd = self:getBtn("secret_time_buy_level_tips_397683377")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_right_1251431307"), CommButton)
	self._btnClose = self:getBtn("universal_second_tips_common_bg_1201003252")
	self._txtBuyLv = self:getText("secret_time_buy_level_tips_662316174")
	self.go_com_price = self:getGo("7&com_price_1317146225")
	self._scrollRectWidth = RectTransformUtils.GetWidth(self._goScrollRect.transform)
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_price)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnMinus:AddClickListener(self._onClickBtnMinus, self)
	self._btnAdd:AddClickListener(self._onClickBtnAdd, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
	self._btnConfirm:AddClickListener(self._onClickBtnConfirm, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._sliderBuyLv:AddOnValueChanged(self._onBuyLvChanged, self)
end

function M:unbindEvents()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._sliderBuyLv:RemoveOnValueChanged()
end

function M:onEnter()
	self._promoteLv = 1
	self._sliderBuyLv.slider.maxValue = self:_getMaxBugLv()

	self._sliderBuyLv:SetValue(self._promoteLv)
	self:refreshView()
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:_getMaxBugLv()
	local curSeasonId = SeasonModel.instance:getSeasonId()
	local curLv = SeasonModel.instance:getCurrLv()
	local normalMaxLv = SeasonConfig.instance:getLimitLv(curSeasonId)
	local maxBuyLv = normalMaxLv - curLv

	return maxBuyLv > 0 and maxBuyLv or 1
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("backpack_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, ItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, ItemCell)

		shower:setShowSelectedEffect(false)
	end

	local mo = self._items[curIndex]
	local itemData = ItemUtil.createItemData({
		itemId = mo:getCode(),
		count = mo:getNum()
	})

	shower:updateData(itemData)

	return item
end

function M:refreshView()
	local currLv = SeasonModel.instance:getCurrLv()
	local targetLv = currLv + self._promoteLv

	self._txtHint.text = string.format(lang("tip_season_8"), targetLv)

	local costPerNum = SeasonConfig.instance:getUpgradeLvMoneyNum()

	self._txtBuyLv.text = self._promoteLv

	local costCode = SeasonConfig.instance:getUpgradeLvMoneyCode()

	self._costCell:updateData(costCode, self._promoteLv * costPerNum)

	self._items = SeasonModel.instance:getRewardsByPromoteLv(self._promoteLv)

	self._loopList:SetListItemCount(#self._items, true)
	self._loopList:RefreshAllShownItem()

	local scrollRect = self._goScrollRect:GetComponent(UIComponentType.ScrollRect)
	local width = RectTransformUtils.GetWidth(self._goScrollContent.transform)

	if width < self._scrollRectWidth then
		scrollRect.enabled = false

		Astral.TransformUtil.SetLocalPosX(self._goScrollContent.transform, (self._scrollRectWidth - width) / 2)
	else
		scrollRect.enabled = true

		self._loopList:MoveToItemIndex(#self._items)
	end
end

function M:_getMaxUpgradeLv()
	local maxLv = SeasonConfig.instance:getMaxLv()
	local currLv = SeasonModel.instance:getCurrLv()
	local upgradeLv = math.max(1, maxLv - currLv)
	local costCode = SeasonConfig.instance:getUpgradeLvMoneyCode()
	local costPerNum = SeasonConfig.instance:getUpgradeLvMoneyNum()
	local ownNum = ItemModel.instance:getItemCountByItemId(costCode)
	local costLv = math.floor(ownNum / costPerNum)

	return math.max(1, math.min(costLv, upgradeLv))
end

function M:_onClickBtnMinus()
	self._promoteLv = math.max(1, self._promoteLv - 1)

	self._sliderBuyLv:SetValue(self._promoteLv)
	self:refreshView()
end

function M:_onClickBtnAdd()
	local upgradeLv = self:_getMaxUpgradeLv()
	local maxBuyLv = self:_getMaxBugLv()

	self._promoteLv = math.min(upgradeLv, maxBuyLv, self._promoteLv + 1)

	self._sliderBuyLv:SetValue(self._promoteLv)
	self:refreshView()
end

function M:_onClickBtnCancel()
	self:close()
end

function M:_onClickBtnConfirm()
	local costCode = SeasonConfig.instance:getUpgradeLvMoneyCode()
	local costPerNum = SeasonConfig.instance:getUpgradeLvMoneyNum()
	local ownNum = ItemModel.instance:getItemCountByItemId(costCode)
	local maxLv = SeasonConfig.instance:getMaxLv()
	local currLv = SeasonModel.instance:getCurrLv()

	if maxLv <= currLv then
		FloatWordMgr.instance:show(lang("tip_season_9"))
	elseif ownNum < costPerNum * self._promoteLv then
		FloatWordMgr.instance:show(lang("tip_season_10"))
	else
		SeasonAgent.instance:sendUpgradeRequest(self._promoteLv)
		self:close()
	end
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onBuyLvChanged(value)
	local upgradeLv = self:_getMaxUpgradeLv()
	local maxBuyLv = self:_getMaxBugLv()
	local maxLv = math.min(upgradeLv, maxBuyLv)

	if maxLv < value then
		self._sliderBuyLv:SetValue(maxLv)

		return
	end

	if value < 1 then
		self._sliderBuyLv:SetValue(1)

		return
	end

	self._promoteLv = value

	self:refreshView()
end

return M
