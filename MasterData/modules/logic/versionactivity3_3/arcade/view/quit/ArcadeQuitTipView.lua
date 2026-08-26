-- chunkname: @modules/logic/versionactivity3_3/arcade/view/quit/ArcadeQuitTipView.lua

module("modules.logic.versionactivity3_3.arcade.view.quit.ArcadeQuitTipView", package.seeall)

local ArcadeQuitTipView = class("ArcadeQuitTipView", BaseView)

function ArcadeQuitTipView:onInitView()
	self._goquitshowview = gohelper.findChild(self.viewGO, "#go_quitshowview")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_quitgame", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_restart", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._btnhome = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_home", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/btn/#btn_cancel", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeQuitTipView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnhome:AddClickListener(self._btnhomeOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function ArcadeQuitTipView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnhome:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function ArcadeQuitTipView:_btnquitgameOnClick()
	if self._isInSide then
		GameFacade.showMessageBox(MessageBoxIdDefine.ExitArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmQuitGame, nil, nil, self, nil, nil)
	else
		ArcadeController.instance:onExitHall()
		self:closeThis()
	end
end

function ArcadeQuitTipView:_confirmQuitGame()
	ArcadeGameController.instance:closeGameView()
	self:closeThis()
end

function ArcadeQuitTipView:_btnrestartOnClick()
	if not self._isInSide then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.ResetArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmRestart, nil, nil, self, nil, nil)
end

function ArcadeQuitTipView:_confirmRestart()
	ArcadeGameController.instance:endGame(ArcadeGameEnum.SettleType.Abandon, false, true)
	self:closeThis()
end

function ArcadeQuitTipView:_btnhomeOnClick()
	if not self._isInSide then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.AbandonArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmAbandon, nil, nil, self, nil, nil)
end

function ArcadeQuitTipView:_confirmAbandon()
	ArcadeGameController.instance:endGame(ArcadeGameEnum.SettleType.Abandon, false)
	self:closeThis()
end

function ArcadeQuitTipView:_btncancelOnClick()
	self:closeThis()
end

function ArcadeQuitTipView:onClickModalMask()
	self:closeThis()
end

function ArcadeQuitTipView:_editableInitView()
	return
end

function ArcadeQuitTipView:onUpdateParam()
	return
end

function ArcadeQuitTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)

	self._isInSide = self.viewParam.isInSide

	if self._isInSide then
		ArcadeGameController.instance:pauseGame()
	end

	self:_refreshBtn()
end

function ArcadeQuitTipView:_refreshBtn()
	if self._isInSide then
		local isInGuideLevel = ArcadeGameModel.instance:getIsInGuideLevel()
		local isShow = not isInGuideLevel

		gohelper.setActive(self._btnrestart.gameObject, isShow)
		gohelper.setActive(self._btnhome.gameObject, isShow)
	else
		gohelper.setActive(self._btnrestart.gameObject, false)
		gohelper.setActive(self._btnhome.gameObject, false)
	end
end

function ArcadeQuitTipView:onClose()
	if self._isInSide then
		ArcadeGameController.instance:resumeGame()
	end
end

function ArcadeQuitTipView:onDestroyView()
	return
end

return ArcadeQuitTipView
