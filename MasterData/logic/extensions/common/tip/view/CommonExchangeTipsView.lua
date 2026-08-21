-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/view/CommonExchangeTipsView.lua

module("logic.extensions.common.tip.view.CommonExchangeTipsView", package.seeall)

local M = class("CommonExchangeTipsView", ViewComponent)

function M:buildUI()
	self._txtTitle = self:getText("universal_second_tips_common_bg_-1535781828")
	self._txtContent = self:getText("common_use_prop_tips_-1738190741")
	self._txtTips = self:getText("common_use_prop_tips_-1313644853")
	self._btnLeft = self:getBtn("btn_left_-1571983320")
	self._btnRight = self:getBtn("btn_right_1251431307")
	self._btnClose = self:getBtn("universal_second_tips_common_bg_1201003252")
	self._goArrow = self:getGo("common_use_prop_tips_1190656694")
	self._goLeftItem = self:getGo("2&rewards_detail_item_2141037416")
	self._leftItemCell = Astral.LuaComponentContainer.Add(self._goLeftItem, StoreItemCell)
	self._goRightItem = self:getGo("3&rewards_detail_item_2141037416")
	self._rightItemCel = Astral.LuaComponentContainer.Add(self._goRightItem, StoreItemCell)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self._handleJumpViewEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self._handleJumpViewEvent, self)
	end
end

function M:bindEvents()
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	self._clickLeftCallBackFunc = info.clickLeftCallBackFunc
	self._clickLeftCallBackHandler = info.clickLeftCallBackHandler
	self._clickRightCallBackFunc = info.clickRightCallBackFunc
	self._clickRightCallBackHandler = info.clickRightCallBackHandler
	self._txtContent.text = info.content

	if info.title then
		self._txtTitle.text = info.title
	end

	self._txtTips.text = info.tips

	if info.leftItemData == nil then
		goutil.setActive(self._goLeftItem, false)
		goutil.setActive(self._goArrow, false)
	else
		self._leftItemCell:updateData(info.leftItemData)
	end

	if info.rightItemData == nil then
		goutil.setActive(self._goRightItem, false)
		goutil.setActive(self._goArrow, false)
	else
		self._rightItemCel:updateData(info.rightItemData)
	end

	self._leftItemCell:getComponent("num"):setCostTextActive(false)
	self._rightItemCel:getComponent("num"):setCostTextActive(false)

	local leftNumColor = info.leftNumColor and info.leftNumColor or "#B6B7B7"
	local rightNumColor = info.rightNumColor and info.rightNumColor or "#B6B7B7"

	self._leftItemCell:getComponent("num"):setTextColor(Astral.ColorUtil.ParseColor(leftNumColor))
	self._rightItemCel:getComponent("num"):setTextColor(Astral.ColorUtil.ParseColor(rightNumColor))
end

function M:onExit()
	self:_setEvent(false)
end

function M:_onClickLeft()
	if self._clickLeftCallBackFunc then
		self._clickLeftCallBackFunc(self._clickLeftCallBackHandler)
	end

	self:close()
end

function M:_onClickRight()
	if self._clickRightCallBackFunc then
		self._clickRightCallBackFunc(self._clickRightCallBackHandler)
	end

	self:close()
end

function M:_onClickClose()
	self:close()
end

function M:_handleJumpViewEvent(e, jumpId, ...)
	self:close()
end

return M
