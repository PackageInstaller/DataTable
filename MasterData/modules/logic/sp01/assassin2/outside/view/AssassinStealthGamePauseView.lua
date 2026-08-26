-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGamePauseView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGamePauseView", package.seeall)

local AssassinStealthGamePauseView = class("AssassinStealthGamePauseView", BaseView)

function AssassinStealthGamePauseView:onInitView()
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btnback = gohelper.findChildClickWithAudio(self.viewGO, "root/btnLayout/#btn_back", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btnreset = gohelper.findChildClickWithAudio(self.viewGO, "root/btnLayout/#btn_reset", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btnexit = gohelper.findChildClickWithAudio(self.viewGO, "root/btnLayout/#btn_exit", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btnabandon = gohelper.findChildClickWithAudio(self.viewGO, "root/btnLayout/#btn_abandon", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGamePauseView:addEvents()
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btnabandon:AddClickListener(self._btnabandonOnClick, self)
	self._btnclick:AddClickListener(self.closeThis, self)
end

function AssassinStealthGamePauseView:removeEvents()
	self._btnback:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnexit:RemoveClickListener()
	self._btnabandon:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGamePauseView:_btnbackOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.StealthGameConfirmBack, MsgBoxEnum.BoxType.Yes_No, self._confirmBack, nil, nil, self, nil)
end

function AssassinStealthGamePauseView:_confirmBack()
	AssassinStealthGameController.instance:recoverAssassinStealthGame()
	self:closeThis()
end

function AssassinStealthGamePauseView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.StealthGameConfirmReset, MsgBoxEnum.BoxType.Yes_No, self._confirmReset, nil, nil, self, nil)
end

function AssassinStealthGamePauseView:_confirmReset()
	AssassinStealthGameController.instance:resetGame()
	self:closeThis()
end

function AssassinStealthGamePauseView:_btnexitOnClick()
	AssassinStealthGameController.instance:exitGame()
	self:closeThis()
end

function AssassinStealthGamePauseView:_btnabandonOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.StealthGameConfirmAbandon, MsgBoxEnum.BoxType.Yes_No, self._confirmAbandon, nil, nil, self, nil)
end

function AssassinStealthGamePauseView:_confirmAbandon()
	AssassinStealthGameController.instance:abandonGame()
	self:closeThis()
end

function AssassinStealthGamePauseView:_editableInitView()
	gohelper.setActive(self._btnexit, false)
end

function AssassinStealthGamePauseView:onUpdateParam()
	return
end

function AssassinStealthGamePauseView:onOpen()
	return
end

function AssassinStealthGamePauseView:onClose()
	return
end

function AssassinStealthGamePauseView:onDestroyView()
	return
end

return AssassinStealthGamePauseView
