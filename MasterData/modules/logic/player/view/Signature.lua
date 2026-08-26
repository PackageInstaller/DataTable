-- chunkname: @modules/logic/player/view/Signature.lua

module("modules.logic.player.view.Signature", package.seeall)

local Signature = class("Signature", BaseView)

function Signature:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_leftbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._inputsignature = gohelper.findChildTextMeshInputField(self.viewGO, "message/#input_signature")
	self._txttext = gohelper.findChildText(self.viewGO, "message/#input_signature/textarea/#txt_text")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Signature:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
end

function Signature:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
end

function Signature:_btncloseOnClick()
	self:closeThis()
end

function Signature:_btnsureOnClick()
	local newSignature = self._inputsignature:GetText()
	local oldSignature = PlayerModel.instance:getPlayinfo().signature

	if newSignature == oldSignature then
		self:closeThis()

		return
	end

	PlayerRpc.instance:sendSetSignatureRequest(newSignature, self._modifiedSuccess, self)
end

function Signature:_modifiedSuccess(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function Signature:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnsure.gameObject, AudioEnum.UI.UI_Common_Click)
	self._inputsignature:SetCharacterLimit(CommonConfig.instance:getConstNum(ConstEnum.PlayerENameLimit))
end

function Signature:onUpdateParam()
	return
end

function Signature:onOpen()
	local text = PlayerModel.instance:getPlayinfo().signature

	self._inputsignature:SetText(text)
	NavigateMgr.instance:addEscape(ViewName.Signature, self._btncloseOnClick, self)
end

function Signature:onClose()
	return
end

function Signature:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return Signature
