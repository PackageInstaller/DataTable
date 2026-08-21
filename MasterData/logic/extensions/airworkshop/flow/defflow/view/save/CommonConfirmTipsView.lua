-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/save/CommonConfirmTipsView.lua

module("logic.extensions.airworkshop.flow.defflow.view.save.CommonConfirmTipsView", package.seeall)

local M = class("CommonConfirmTipsView", ViewComponent)

function M:buildUI()
	self._txtContent = self:getUIComponent("message_dialog_-858469084", UIComponentType.TextMeshProUGUI)
	self._btnLeft = Astral.SimpleLuaComponentContainer.Add(self:getGo("4&btn_left_-1571983320"), CommButton)
	self._btnRight = Astral.SimpleLuaComponentContainer.Add(self:getGo("5&btn_right_1251431307"), CommButton)
	self._btnClose = self:getBtn("message_tips_1822196934")
	self._btnAgreeGo = self:getGo("message_tips_1745137423")

	goutil.setActive(self._btnAgreeGo, false)
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
	local info = self:getFirstParam()

	self._clickLeftCallBackFunc = info.clickLeftCallBackFunc
	self._clickLeftCallBackHandler = info.clickLeftCallBackHandler
	self._clickRightCallBackFunc = info.clickRightCallBackFunc
	self._clickRightCallBackHandler = info.clickRightCallBackHandler
	self._txtContent.text = info.content

	self._btnLeft:setText(info.leftTxt or lang("tip_common_ensure_1"))
	self._btnRight:setText(info.rightTxt or lang("tip_common_cancel_1"))
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

return M
