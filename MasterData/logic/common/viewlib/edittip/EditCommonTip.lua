-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/edittip/EditCommonTip.lua

module("logic.common.viewlib.edittip.EditCommonTip", package.seeall)

local M = class("EditCommonTip", ViewComponent)

function M:buildUI()
	self._inputText = self:getInput("player_rename_tips_1468135034")
	self._saveBtn = self:getBtnByPath("content/btnConfirm")
	self._cancelBtn = self:getBtnByPath("content/btnCancel")
	self._closeBtn = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
end

function M:destroyUI()
	self._saveBtn = nil
	self._cancelBtn = nil
	self._closeBtn = nil
	self._callBackFunc = nil
	self._callBackHandle = nil
end

function M:bindEvents()
	self._saveBtn:AddClickListener(self._onClickSave, self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._saveBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self._callBackFunc = info.callBackFunc
	self._callBackHandle = info.callBackHandle

	self._inputText:SetText(info.defaultName or "")
	self._inputText:SetCharacterLimit(info.charLimit or 14)
end

function M:onExit()
	return
end

function M:_onClickSave()
	if self._callBackFunc then
		self._callBackFunc(self._callBackHandle, self._inputText:GetText())
	end

	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickClose()
	self:close()
end

return M
