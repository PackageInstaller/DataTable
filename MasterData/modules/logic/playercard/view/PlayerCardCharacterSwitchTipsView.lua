-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchTipsView.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchTipsView", package.seeall)

local PlayerCardCharacterSwitchTipsView = class("PlayerCardCharacterSwitchTipsView", BaseView)

function PlayerCardCharacterSwitchTipsView:onInitView()
	self._btntouchClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_touchClose")
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buy")
	self._toggletip = gohelper.findChildToggle(self.viewGO, "centerTip/#toggle_tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCharacterSwitchTipsView:addEvents()
	self._btntouchClose:AddClickListener(self._btntouchCloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._toggletip:AddOnValueChanged(self._toggleTipOnClick, self)
end

function PlayerCardCharacterSwitchTipsView:removeEvents()
	self._btntouchClose:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._toggletip:RemoveOnValueChanged()
end

function PlayerCardCharacterSwitchTipsView:_btntouchCloseOnClick()
	self:closeThis()
end

function PlayerCardCharacterSwitchTipsView:_btncloseOnClick()
	local isTipOn = self._toggletip.isOn

	if isTipOn then
		PlayerCardModel.instance:setCharacterSwitchFlag(false)
	end

	PlayerCardCharacterSwitchListModel.instance:changeMainHeroByParam(self.characterParam, false)
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function PlayerCardCharacterSwitchTipsView:_btnbuyOnClick()
	local isTipOn = self._toggletip.isOn

	if isTipOn then
		PlayerCardModel.instance:setCharacterSwitchFlag(true)
	end

	PlayerCardCharacterSwitchListModel.instance:changeMainHeroByParam(self.characterParam, true)
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function PlayerCardCharacterSwitchTipsView:_toggleTipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function PlayerCardCharacterSwitchTipsView:_editableInitView()
	self._toggletip.isOn = false

	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function PlayerCardCharacterSwitchTipsView:onUpdateParam()
	return
end

function PlayerCardCharacterSwitchTipsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	self.characterParam = self.viewParam.heroParam

	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function PlayerCardCharacterSwitchTipsView:onClose()
	return
end

function PlayerCardCharacterSwitchTipsView:onDestroyView()
	self._simagetipbg:UnLoadImage()
end

return PlayerCardCharacterSwitchTipsView
