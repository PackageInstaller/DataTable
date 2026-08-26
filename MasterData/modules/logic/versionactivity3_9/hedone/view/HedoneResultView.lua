-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneResultView.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneResultView", package.seeall)

local HedoneResultView = class("HedoneResultView", BaseView)

function HedoneResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gowin = gohelper.findChild(self.viewGO, "#go_success")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetItem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/txt_taskdesc")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_finish")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_unfinish")
	self._gobtns = gohelper.findChild(self.viewGO, "btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HedoneResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function HedoneResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function HedoneResultView:_btncloseOnClick()
	self:closeThis()
end

function HedoneResultView:_btnquitgameOnClick()
	self:_btncloseOnClick()
end

function HedoneResultView:_btnrestartOnClick()
	HedoneGameController.instance:resetGame()

	self._isRestart = true

	self:_btncloseOnClick()
end

function HedoneResultView:_editableInitView()
	return
end

function HedoneResultView:onUpdateParam()
	self._isRestart = false
	self._isWin = self.viewParam.isWin
	self._episodeId = self.viewParam.episodeId
	self._gameId = self.viewParam.gameId
	self._gameTime = self.viewParam.gameTime
end

function HedoneResultView:onOpen()
	self:onUpdateParam()
	self:refresh()

	if self._isWin then
		if not HedoneStatHelper.GameResultStat.Success then
			local resultState = HedoneStatHelper.GameResultStat.Fail

			HedoneStatHelper.sendSettleInfo(HedoneStatHelper.OperationType.GameSettle, resultState)
		end
	end
end

function HedoneResultView:onOpenFinish()
	AudioMgr.instance:trigger((self._isWin or nil) and (AudioEnum3_9.Hedone.play_ui_pkls_endpoint_arrival or AudioEnum3_9.Hedone.play_ui_settleaccounts_lose))
end

function HedoneResultView:refresh()
	if self._isWin then
		local winDesc = HedoneConfig.instance:getHedoneGameWinDesc(self._gameId)
		local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(self._gameId)

		if targetTime < 0 then
			winDesc = GameUtil.getSubPlaceholderLuaLangOneParam(winDesc, self._gameTime)
		end

		self._txttaskdesc.text = winDesc
	end

	gohelper.setActive(self._gowin, self._isWin)
	gohelper.setActive(self._gotargetItem, self._isWin)
	gohelper.setActive(self._gofinish, self._isWin)
	gohelper.setActive(self._gofailed, not self._isWin)
	gohelper.setActive(self._gobtns, not self._isWin)
	gohelper.setActive(self._gounfinish, not self._isWin)
end

function HedoneResultView:onClose()
	if self._isRestart then
		return
	end

	ViewMgr.instance:closeView(ViewName.HedoneGameView)

	if self._isWin and self._episodeId then
		HedoneController.instance:finishEpisodeLevel(self._episodeId)
	end
end

function HedoneResultView:onDestroyView()
	return
end

return HedoneResultView
