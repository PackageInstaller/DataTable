-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/view/TopHintTipsView.lua

module("logic.extensions.mail.view.TopHintTipsView", package.seeall)

local M = class("TopHintTipsView", ViewComponent)

function M:buildUI()
	self._descText = self:getText("mail_capacity_tips_98689041")
	self._btnFull = self:getBtn("mail_capacity_tips_2027383806")
	self._normalBgObj = self:getGo("mail_capacity_tips_1281291666")
	self._secretBgObj = self:getGo("mail_capacity_tips_-1065518632")
end

function M:destroyUI()
	self._descText = nil
	self._imgHead = nil
	self._btnFull = nil
	self._normalBgObj = nil
	self._secretBgObj = nil
end

function M:bindEvents()
	self._btnFull:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnFull:RemoveClickListener()
end

function M:onEnter()
	local openParam = self:getOpenParam()
	local desc = openParam[1]
	local showNormalBg = openParam[2]

	goutil.setActive(self._normalBgObj, showNormalBg)
	goutil.setActive(self._secretBgObj, not showNormalBg)

	self._descText.text = desc
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
end

return M
