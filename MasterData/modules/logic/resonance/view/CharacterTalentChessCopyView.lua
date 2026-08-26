-- chunkname: @modules/logic/resonance/view/CharacterTalentChessCopyView.lua

module("modules.logic.resonance.view.CharacterTalentChessCopyView", package.seeall)

local CharacterTalentChessCopyView = class("CharacterTalentChessCopyView", RoomLayoutInputBaseView)

function CharacterTalentChessCopyView:_editableInitView()
	CharacterTalentChessCopyView.super._editableInitView(self)

	self._txttip = gohelper.findChildText(self.viewGO, "tips/txt_tips")

	local tipicon = gohelper.findChildImage(self.viewGO, "tips/txt_tips/icon")

	self._txttitlecn.text = luaLang("character_copy_talentLayout_title_cn")
	self._txtinputlang.text = luaLang("character_copy_talentLayout_title_cn")
	self._txttitleen.text = luaLang("character_copy_talentLayout_title_en")
	self._txttip.text = luaLang("character_copy_talentLayout_tip")
	self._gocaret = gohelper.findChild(self.viewGO, "message/#input_signature/textarea/Caret")

	local color = GameUtil.parseColor("#686664")

	self._txttip.color = color
	tipicon.color = color
end

function CharacterTalentChessCopyView:addEvents()
	CharacterTalentChessCopyView.super.addEvents(self)
	self.addEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onUseShareCode, self)
end

function CharacterTalentChessCopyView:removeEvents()
	CharacterTalentChessCopyView.super.removeEvents(self)
	self.addEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onUseShareCode, self)
end

function CharacterTalentChessCopyView:onOpen()
	self._heroMo = self.viewParam.heroMo
end

function CharacterTalentChessCopyView:_btnsureOnClick()
	local inputStr = self._inputsignature:GetText()

	if string.nilorempty(inputStr) then
		local typecn = HeroResonaceModel.instance:getSpecialCn(self._heroMo)

		ToastController.instance:showToast(ToastEnum.CharacterTalentCopyCodeNull, typecn)

		return
	end

	self._heroMo = self._heroMo or self.viewParam.heroMo

	local isCanUse, toast = HeroResonaceModel.instance:canUseLayoutShareCode(self._heroMo, inputStr)

	if isCanUse then
		ViewMgr.instance:openView(ViewName.CharacterTalentUseLayoutView, {
			heroMo = self._heroMo,
			code = inputStr
		})
	elseif toast then
		GameFacade.showToast(toast)
	else
		local typecn = HeroResonaceModel.instance:getSpecialCn(self._heroMo)

		ToastController.instance:showToast(ToastEnum.CharacterTalentShareCodeFailPastedUseLackCube, typecn)
	end
end

function CharacterTalentChessCopyView:_btncleannameOnClick()
	self._inputsignature:SetText("")
	transformhelper.setLocalPosXY(self._txttext.transform, 0, 0)
	transformhelper.setLocalPosXY(self._gocaret.transform, 0, 0)
end

function CharacterTalentChessCopyView:_onInputNameEndEdit()
	self:_checkLimit()
end

function CharacterTalentChessCopyView:_onInputNameValueChange()
	self:_checkLimit()
end

function CharacterTalentChessCopyView:_onUseShareCode()
	self:closeThis()
end

function CharacterTalentChessCopyView:_checkLimit()
	local inputValue = self._inputsignature:GetText()
	local limit = CommonConfig.instance:getConstNum(ConstEnum.CharacterTalentLayoutCopyCodeLimit)
	local newInput = GameUtil.utf8sub(inputValue, 1, math.min(GameUtil.utf8len(inputValue), limit))

	if newInput ~= inputValue then
		self._inputsignature:SetText(newInput)
	end
end

return CharacterTalentChessCopyView
