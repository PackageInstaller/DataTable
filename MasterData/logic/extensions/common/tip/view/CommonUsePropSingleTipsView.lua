-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/view/CommonUsePropSingleTipsView.lua

module("logic.extensions.common.tip.view.CommonUsePropSingleTipsView", package.seeall)

local M = class("CommonUsePropSingleTipsView", ViewComponent)

function M:buildUI()
	self._txtInfo = self:getTextByPath("content/txtContent")
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnCancel = self:getBtnByPath("content/btnCancel")
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content/btnConfirm"), CommButton)
	self._item = Astral.SimpleLuaComponentContainer.Add(self:getGoByPath("content/backpack_item"), ItemCell)

	self._item:setShowSelectedEffect(false)

	self._rectTrTimeTips = self:getUIComponent("common_use_prop_single_tips_-1057266887", UIComponentType.RectTransform)
	self._txtTimeTitle = goutil.findChildComponent(self.mainGO, "content/timeTips/Text1", UIComponentType.Text)
	self._orgTxtTimeTitle = self._txtTimeTitle.text
	self._txtTime = goutil.findChildComponent(self.mainGO, "content/timeTips/Text1/txtTime1", UIComponentType.Text)
end

function M:destroyUI()
	self._txtInfo = nil
	self._btnCancel = nil
	self._btnConfirm = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	goutil.setActive(self._rectTrTimeTips.gameObject, false)
	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._confirmCallBackFunc = info.confirmCallBackFunc
	self._confirmCallBackHandler = info.confirmCallBackHandler
	self._timerCallBack = info.timerCallBack
	self._timerCallBackHandler = info.timerCallBackHandler
	self._txtInfo.text = info.txtContent

	local moneyShowType = info.moneyShowType or CommEnum.MoneyShowType.DefaultHideType

	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, moneyShowType)

	local itemId = info.itemId
	local costCount = info.costCount
	local itemData = ItemUtil.createItemData({
		itemId = itemId,
		count = costCount
	})
	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemName = itemData:getName()
	local enough = costCount <= count
	local numStr = enough and string.format("%s/%s", count, costCount) or string.format("<color=#d9474b>%s</color>/%s", count, costCount)

	self._item:updateData(itemData)
	self._item:getComponent("num"):setCountText("")
	self._item:getComponent("num"):setCostText(numStr)
	self._btnConfirm:setActiveState(enough)
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateTimer, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateTimer, self)
	end
end

function M:_updateTimer(e)
	if not self._isEnter then
		return
	end

	if self._timerCallBack then
		local show, txtTitle, txtContent = self._timerCallBack(self._timerCallBackHandler)

		self:_setTimeTipsShow(show, txtTitle, txtContent)
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	if self._confirmCallBackFunc then
		self._confirmCallBackFunc(self.confirmCallBackHandler)
	end

	self:close()
end

function M:_setTimeTipsShow(show, txtTitle, txtContent)
	self._txtTime.text = txtContent
	self._txtTimeTitle.text = string.nilorempty(txtTitle) and self._orgTxtTimeTitle or txtTitle

	goutil.setActive(self._rectTrTimeTips.gameObject, show)
end

return M
