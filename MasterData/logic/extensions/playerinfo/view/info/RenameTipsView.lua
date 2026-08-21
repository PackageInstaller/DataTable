-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/RenameTipsView.lua

module("logic.extensions.playerinfo.view.info.RenameTipsView", package.seeall)

local M = class("RenameTipsView", ViewComponent)

function M:buildUI()
	self._saveBtn = self:getBtnByPath("content/btnConfirm")
	self._cancelBtn = self:getBtnByPath("content/btnCancel")
	self._inputText = Astral.InputFieldAdapter.Get(self:getGo("player_rename_tips_1468135034"))
	self._btnExit = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._btnBg = self:getBtn("1&universal_second_tips_common_bg_-1467035629")
end

function M:destroyUI()
	self._saveBtn = nil
	self._cancelBtn = nil
	self._callBackFunc = nil
	self._callBackHandle = nil
end

function M:bindEvents()
	self._saveBtn:AddClickListener(self._onClickSave, self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
	self._inputText:AddOnValueChanged(self._onNameChange, self)
	self._btnExit:AddClickListener(self._onClickCancel, self)
	self._btnBg:AddClickListener(self._onClickCancel, self)
end

function M:unbindEvents()
	self._saveBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._inputText:RemoveOnValueChanged()
	self._btnExit:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function M:_onNameChange(nickName)
	if string.nilorempty(nickName) then
		return
	end

	local maxCount = PlayerCreateController.instance:getNameCountLimit()
	local limitCount = StringUtil.getCharacterLimit(nickName, maxCount)

	self._inputText:SetCharacterLimit(limitCount)
end

function M:onEnter()
	local info = self:getFirstParam()

	self._callBackFunc = info.callBackFunc
	self._callBackHandle = info.callBackHandle

	self._inputText:SetText(info.defaultContent or "")

	local maxCount = PlayerCreateController.instance:getNameCountLimit()
	local limitCount = StringUtil.getCharacterLimit(info.defaultContent, maxCount)

	self._inputText:SetCharacterLimit(limitCount)
end

function M:onExit()
	return
end

function M:_handleTextDetectResult(illegal, filteredText)
	if self._callBackFunc then
		self._callBackFunc(self._callBackHandle, self._inputText:GetText(), illegal)
	end

	if illegal == 0 then
		self:close()
	end
end

function M:_onClickSave()
	self:_handleTextDetectResult(0)
end

function M:_onClickCancel()
	self:close()
end

return M
