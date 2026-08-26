-- chunkname: @modules/logic/social/view/SocialRemarkTipView.lua

module("modules.logic.social.view.SocialRemarkTipView", package.seeall)

local SocialRemarkTipView = class("SocialRemarkTipView", BaseView)

function SocialRemarkTipView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "main/bg/#simage_left")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "main/bg/#simage_right")
	self._inputsignature = gohelper.findChildTextMeshInputField(self.viewGO, "main/bg/textArea/#input_signature")
	self._btncleanname = gohelper.findChildButtonWithAudio(self.viewGO, "main/bg/textArea/#btn_cleanname")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "main/bg/btnnode/#btn_cancel")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "main/bg/btnnode/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialRemarkTipView:addEvents()
	self._btncleanname:AddClickListener(self._clickClean, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self._btnconfirm:AddClickListener(self._clickConfirm, self)
	self._inputsignature:AddOnValueChanged(self._onValueChange, self)
end

function SocialRemarkTipView:removeEvents()
	self._btncleanname:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._inputsignature:RemoveOnValueChanged()
end

function SocialRemarkTipView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "main/bg/#simage_bg2")
end

function SocialRemarkTipView:_clickConfirm()
	FriendRpc.instance:changeDesc(self.viewParam.userId, self._inputsignature:GetText())
	self:closeThis()
end

function SocialRemarkTipView:onOpen()
	self._inputsignature:SetText(self.viewParam.desc)
	gohelper.setActive(self._btncleanname, not string.nilorempty(self.viewParam.desc))
end

function SocialRemarkTipView:_clickClean()
	self._inputsignature:SetText("")
end

function SocialRemarkTipView:_onValueChange()
	local inputValue = self._inputsignature:GetText()
	local limit = CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)
	local newInput = GameUtil.utf8sub(inputValue, 1, math.min(GameUtil.utf8len(inputValue), limit))

	gohelper.setActive(self._btncleanname, not string.nilorempty(newInput))

	if newInput == inputValue then
		return
	end

	self._inputsignature:SetText(newInput)
end

return SocialRemarkTipView
