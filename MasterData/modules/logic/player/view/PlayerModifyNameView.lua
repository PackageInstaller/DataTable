-- chunkname: @modules/logic/player/view/PlayerModifyNameView.lua

module("modules.logic.player.view.PlayerModifyNameView", package.seeall)

local PlayerModifyNameView = class("PlayerModifyNameView", BaseView)

function PlayerModifyNameView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_leftbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._inputsignature = gohelper.findChildTextMeshInputField(self.viewGO, "message/#input_signature")
	self._txttext = gohelper.findChildText(self.viewGO, "message/#input_signature/textarea/#txt_text")
	self._txttip = gohelper.findChildText(self.viewGO, "tips/#txt_tip")
	self._btncleanname = gohelper.findChildButtonWithAudio(self.viewGO, "message/#btn_cleanname")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerModifyNameView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btncleanname:AddClickListener(self._onBtnClean, self)
	self._inputsignature:AddOnValueChanged(self._onEndEdit, self)
end

function PlayerModifyNameView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
	self._btncleanname:RemoveClickListener()
	self._inputsignature:RemoveOnValueChanged()
end

function PlayerModifyNameView:_btncloseOnClick()
	self:closeThis()
end

function PlayerModifyNameView:onClickModalMask()
	return
end

function PlayerModifyNameView:_btnsureOnClick()
	if PlayerModel.instance:getExtraRename() < 1 and not PlayerModel.instance:getCanRename() then
		GameFacade.showToast(ToastEnum.PlayerModifyExtraName)

		return
	end

	self:checkLimit()

	local nickname = self._inputsignature:GetText()

	if string.nilorempty(nickname) then
		return
	end

	PlayerRpc.instance:sendRenameRequest(nickname)
end

function PlayerModifyNameView:_onEndEdit()
	self:checkLimit()
end

function PlayerModifyNameView:_onBtnClean()
	self._inputsignature:SetText("")
end

function PlayerModifyNameView:checkLimit()
	local inputValue = self._inputsignature:GetText()
	local limit = CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)

	inputValue = GameUtil.utf8sub(inputValue, 1, math.min(GameUtil.utf8len(inputValue), limit))

	self._inputsignature:SetText(inputValue)
	gohelper.setActive(self._btncleanname, not string.nilorempty(inputValue))
end

function PlayerModifyNameView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function PlayerModifyNameView:onUpdateParam()
	return
end

function PlayerModifyNameView:onOpen()
	self.addEventCb(self, PlayerController.instance, PlayerEvent.ChangePlayerName, self._onNameChanged, self)

	self._txttip.text = PlayerModel.instance:getExtraRename() > 0 and luaLang("p_player_rename_tip_extra") or PlayerModel.instance:getCanRename() and luaLang("p_player_rename_tip") or luaLang("p_player_rename_tip_no_count")

	gohelper.setActive(self._btncleanname, false)
end

function PlayerModifyNameView:onClose()
	return
end

function PlayerModifyNameView:_onNameChanged()
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
	self:closeThis()
end

function PlayerModifyNameView:onDestroyView()
	return
end

return PlayerModifyNameView
