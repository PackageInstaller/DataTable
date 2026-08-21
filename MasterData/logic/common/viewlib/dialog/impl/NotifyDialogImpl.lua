-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/dialog/impl/NotifyDialogImpl.lua

module("logic.common.viewlib.dialog.impl.NotifyDialogImpl", package.seeall)

local M = class("NotifyDialogImpl", BaseDialog)

function M:ctor()
	M.super.ctor(self)

	self._title = false
	self._content = false
	self._confirmContent = false
	self._confirmHandler = Handler.New()
	self._confirmNotCloseHandler = Handler.New()
end

function M:buildUI()
	M.super.buildUI(self)

	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._txtTitle = self._registry:findUIElement("message_tips_-1921776596", UIComponentType.Text)
	self._txtConent = self._registry:findUIElement("message_dialog_-858469084", UIComponentType.TextMeshProUGUI)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("6&btn_middle_-31477526"), CommButton)

	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	goutil.setActive(self._registry:findUIElement("4&btn_left_-1571983320"), false)
	goutil.setActive(self._registry:findUIElement("5&btn_right_1251431307"), false)
	goutil.setActive(self._registry:findUIElement("6&btn_middle_-31477526"), true)
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._registry:cleanRegistry()
	self._btnConfirm:RemoveClickListener()

	self._registry = nil
	self._txtTitle = nil
	self._txtConent = nil
	self._btnConfirm = nil
end

function M:onEnter()
	M.super.onEnter(self)

	self._mask = ModalMask.addBlackMask(self.mainGO)
	self._txtTitle.text = self._title or ""
	self._txtConent.text = self._content or ""

	if self._confirmContent then
		self._btnConfirm:setText(self._confirmContent)
	end

	if self._contentAlignment then
		self._txtConent.alignment = self._contentAlignment
	end
end

function M:onExit()
	M.super.onExit(self)
	ModalMask.releaseMask(self._mask)
	self._confirmHandler:clear()
	self._confirmNotCloseHandler:clear()

	self._mask = false
	self._title = false
	self._content = false
	self._confirmContent = false
	self._contentAlignment = false
	self._txtConent.alignment = TMPro.TextAlignmentOptions.Center
end

function M:onViewRootChanged()
	if self._mask then
		self._mask:setBackgroundMask(self.mainGO)
	end
end

function M:setTitle(title)
	self._title = title

	return self
end

function M:setContent(content)
	self._content = content

	return self
end

function M:setConfirmButtonText(content)
	self._confirmContent = content

	if self.mainGO and not goutil.isNil(self.mainGO) then
		self._btnConfirm:setText(content)
	end

	return self
end

function M:setConfirmListener(callback, callbackSelf)
	self._confirmHandler:setListener(callback, callbackSelf)

	return self
end

function M:setConfirmNotCloseListener(callback, callbackSelf)
	self._confirmNotCloseHandler:setListener(callback, callbackSelf)

	return self
end

function M:_onClickConfirm()
	if self._confirmNotCloseHandler:hadCallback() then
		self._confirmNotCloseHandler:call()

		return
	end

	self._confirmHandler:call()
	self:close()
end

function M:onClickOutSideClose()
	self:_onClickConfirm()
end

function M:setContentAlignment(alignment)
	self._contentAlignment = alignment

	if self.mainGO and not goutil.isNil(self.mainGO) then
		self._txtConent.alignment = alignment
	end
end

return M
