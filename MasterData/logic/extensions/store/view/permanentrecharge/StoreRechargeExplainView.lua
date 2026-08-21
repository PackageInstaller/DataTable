-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/permanentrecharge/StoreRechargeExplainView.lua

module("logic.extensions.store.view.permanentrecharge.StoreRechargeExplainView", package.seeall)

local M = class("StoreRechargeExplainView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._btnBg = self:getBtn("1&universal_second_tips_common_bg_-1467035629")
	self._txtContent = self:getUIComponent("store_member_welfare_explain_tips_1625493370", UIComponentType.TMPText)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.close, self)
	self._btnBg:AddClickListener(self.close, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function M:onEnter()
	self._txtContent.text = lang("tip_store_recharge_explain")
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

return M
