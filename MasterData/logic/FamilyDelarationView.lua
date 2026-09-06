-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyDelarationView.lua

module("logic.extensions.family.view.FamilyDelarationView", package.seeall)

local FamilyDelarationView = class("FamilyDelarationView", ViewComponent)

function FamilyDelarationView:ctor()
	FamilyDelarationView.super.ctor(self)
end

function FamilyDelarationView:destroyUI()
	FamilyDelarationView.super.destroyUI(self)
end

function FamilyDelarationView:onExitFinished()
	FamilyDelarationView.super.onExitFinished(self)
end

function FamilyDelarationView:onEnterFinished()
	FamilyDelarationView.super.onEnterFinished(self)
end

function FamilyDelarationView:unbindEvents()
	FamilyDelarationView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._btnOk:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
end

function FamilyDelarationView:bindEvents()
	FamilyDelarationView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancle:AddClickListener(self._onClickClose, self)
end

function FamilyDelarationView:onExit()
	FamilyDelarationView.super.onExit(self)
end

function FamilyDelarationView:buildUI()
	FamilyDelarationView.super.buildUI(self)

	self._closeButton = self:getBtn("Nego_Main/Btn_Close")

	local Nego_Main = self:getGo("Nego_Main")

	self._btnOk = self:getBtn("Nego_Main/btnOk")
	self._btnCancle = self:getBtn("Nego_Main/btnCancle")
	self._inputField = Framework.InputFieldAdapter.GetFrom(Nego_Main, "inputField")
	self._txtLeftCount = goutil.findChildTextComponent(Nego_Main, "txtLeftCount")
end

function FamilyDelarationView:onEnter()
	FamilyDelarationView.super.onEnter(self)
	self:_updateBtnGray(true)

	local declaration = FamilyModel.instance:getDeclaration()

	self._maxLen = checknumber(FamilyConfig.instance:getCommonValue("DECLARATION_MAX_LENGTH"))

	self._inputField:SetText(declaration)
	self._inputField:SetCharacterLimit(self._maxLen)
end

function FamilyDelarationView:_onValueChanged()
	local text = self._inputField:GetText()

	self:_updateBtnGray(text == FamilyModel.instance:getDeclaration())

	local t = StringUtil.utf8split(text)
	local len = 0

	for i = 1, #t do
		if i > self._maxLen then
			break
		else
			len = len + 1
		end
	end

	self._txtLeftCount.text = string.format("%s/%s", len, self._maxLen)
end

function FamilyDelarationView:_updateBtnGray(isGray)
	if self._isGray ~= isGray then
		self._isGray = isGray

		uGuiUtil.setGoGrayState(self._btnOk, isGray)

		self._isGray = isGray
	end
end

function FamilyDelarationView:_onClickOk()
	local text = self._inputField:GetText()

	if self._isGray then
		FloatWordMgr.instance:show(lang("tip_family_declaration"))
	elseif string.nilorempty(text) then
		FloatWordMgr.instance:show(lang("text_family_desc_36"))
	else
		FamilyAgent.instance:sendModifyFamilyDeclarationReq(text, function(msg)
			FamilyModel.instance:setDeclaration(text)
			FloatWordMgr.instance:show(lang("text_family_desc_37"))
			GlobalDispatcher:dispatch(GlobalNotify.DeclarationChange)
			self:close()
		end)
	end
end

function FamilyDelarationView:_onClickClose()
	self:close()
end

return FamilyDelarationView
