-- chunkname: @modules/logic/common/view/CommonInputView.lua

module("modules.logic.common.view.CommonInputView", package.seeall)

local CommonInputView = class("CommonInputView", BaseView)

function CommonInputView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
	self._txtyes = gohelper.findChildText(self.viewGO, "#btn_yes/#txt_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	self._txtno = gohelper.findChildText(self.viewGO, "#btn_no/#txt_no")
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "#input")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonInputView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._input:AddOnEndEdit(self._onEndEdit, self)
	self._input:AddOnValueChanged(self._onValueChanged, self)
end

function CommonInputView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._input:RemoveOnEndEdit()
	self._input:RemoveOnValueChanged()
end

function CommonInputView:_editableInitView()
	gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.UI_Common_Click)
end

function CommonInputView:onOpen()
	local param = self.viewParam

	self._txttitle.text = param.title
	self._txtno.text = param.cancelBtnName
	self._txtyes.text = param.sureBtnName

	self._input:SetText(param.defaultInput)
end

function CommonInputView:_btnyesOnClick()
	local param = self.viewParam

	if param.sureCallback then
		local inputStr = self._input:GetText()

		if param.callbackObj then
			param.sureCallback(param.callbackObj, inputStr)
		else
			param.sureCallback(inputStr)
		end
	else
		self:closeThis()
	end
end

function CommonInputView:_btnnoOnClick()
	local param = self.viewParam

	self:closeThis()

	if param.cancelCallback then
		param.cancelCallack(param.callbackObj)
	end
end

function CommonInputView:_onEndEdit(inputStr)
	inputStr = GameUtil.filterRichText(inputStr or "")

	self._input:SetText(inputStr)
end

function CommonInputView:_onValueChanged()
	local inputStr = self._input:GetText()

	inputStr = string.gsub(inputStr, "\n", "")
	inputStr = GameUtil.getBriefName(inputStr, self.viewParam.characterLimit, "")

	self._input:SetText(inputStr)
end

return CommonInputView
