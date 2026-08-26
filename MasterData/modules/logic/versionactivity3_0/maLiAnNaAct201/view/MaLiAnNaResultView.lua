-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaResultView.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaResultView", package.seeall)

local MaLiAnNaResultView = class("MaLiAnNaResultView", BaseView)

function MaLiAnNaResultView:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._txtstage = gohelper.findChildText(self.viewGO, "#go_top/#txt_stage")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_top/#txt_name")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_finish")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._btnsuccessClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MaLiAnNaResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnsuccessClick:AddClickListener(self._btnsuccessClickOnClick, self)
end

function MaLiAnNaResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnsuccessClick:RemoveClickListener()
end

function MaLiAnNaResultView:_btnquitgameOnClick()
	self:_exitGame()
end

function MaLiAnNaResultView:_btnrestartOnClick()
	self._isReset = true

	Activity201MaLiAnNaGameController.instance:restartGame()
	self:closeThis()
end

function MaLiAnNaResultView:_btnsuccessClickOnClick()
	self:_exitGame()
end

function MaLiAnNaResultView:_editableInitView()
	return
end

function MaLiAnNaResultView:onUpdateParam()
	return
end

function MaLiAnNaResultView:onOpen()
	self._isReset = false

	local episodeId = Activity201MaLiAnNaGameController.instance:getCurEpisodeId()
	local config = Activity201MaLiAnNaConfig.instance:getEpisodeCo(VersionActivity3_0Enum.ActivityId.MaLiAnNa, episodeId)

	self._txtname.text = config.name
	self._txtstage.text = Activity201MaLiAnNaModel.instance:getEpisodeIndex(episodeId)
	self.isWin = self.viewParam.isWin

	gohelper.setActive(self._btnsuccessClick.gameObject, self.isWin)
	gohelper.setActive(self._btnrestart.gameObject, not self.isWin)
	gohelper.setActive(self._btnquitgame.gameObject, not self.isWin)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._gosuccess, false)
	TaskDispatcher.runDelay(self._refreshView, self, 0.5)
end

function MaLiAnNaResultView:_refreshView()
	gohelper.setActive(self._gofail, not self.isWin)
	gohelper.setActive(self._gosuccess, self.isWin)

	if self.isWin then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_pkls_challenge_fail)
	end
end

function MaLiAnNaResultView:onClose()
	if not self._isReset then
		ViewMgr.instance:closeView(ViewName.Activity201MaLiAnNaGameView)

		if self.isWin then
			Activity201MaLiAnNaController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnBackToLevel)
			Activity201MaLiAnNaController.instance:dispatchEvent(Activity201MaLiAnNaEvent.EpisodeFinished)
		end
	end
end

function MaLiAnNaResultView:_exitGame()
	self:closeThis()
end

function MaLiAnNaResultView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshView, self)
end

return MaLiAnNaResultView
