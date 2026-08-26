-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaGameResultView.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameResultView", package.seeall)

local LanShouPaGameResultView = class("LanShouPaGameResultView", BaseView)

function LanShouPaGameResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._gotarget = gohelper.findChild(self.viewGO, "targets")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._gobtn = gohelper.findChild(self.viewGO, "btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_return")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
end

function LanShouPaGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
end

function LanShouPaGameResultView:_btncloseOnClick()
	self:exitGame()
end

function LanShouPaGameResultView:_btnquitgameOnClick()
	self:exitGame()
end

function LanShouPaGameResultView:exitGame()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameResultQuit)

	if ChessGameModel.instance:getGameState() == ChessGameEnum.GameState.Win then
		ChessGameController.instance:exitGame()
		Activity164Model.instance:markEpisodeFinish(self._episodeCfg.id)
	end

	Activity164Model.instance.currChessGameEpisodeId = 0

	self:closeThis()
end

function LanShouPaGameResultView:_onEscape()
	self:exitGame()
end

function LanShouPaGameResultView:_btnrestartOnClick()
	TaskDispatcher.runDelay(LanShouPaGameResultView.resetStartGame, nil, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
	self:closeThis()
end

function LanShouPaGameResultView:resetStartGame()
	LanShouPaController.instance:resetStartGame()
end

function LanShouPaGameResultView:returnPointGame()
	LanShouPaController.instance:returnPointGame(ChessGameEnum.RollBack.CheckPoint)
end

function LanShouPaGameResultView:_btnreturnOnClick()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
	TaskDispatcher.runDelay(LanShouPaGameResultView.returnPointGame, nil, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
	self:closeThis()
end

function LanShouPaGameResultView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	self._simageFailtitle = gohelper.findChildSingleImage(self.viewGO, "#go_fail/titlecn")

	gohelper.setActive(self._gotargetitem, false)

	self._taskItems = {}

	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
end

function LanShouPaGameResultView:_onHandleResetCompleted()
	return
end

function LanShouPaGameResultView:onUpdateParam()
	return
end

function LanShouPaGameResultView:onOpen()
	self._isWin = self.viewParam
	self._episodeCfg = self:_getEpisodeCfg()

	self:refreshUI()
end

function LanShouPaGameResultView:onClose()
	return
end

function LanShouPaGameResultView:refreshUI()
	if self._episodeCfg then
		self._txtclassname.text = self._episodeCfg.name

		local actId = ChessModel.instance:getActId()
		local episodeId = ChessModel.instance:getEpisodeId()
		local index = Activity164Config.instance:getEpisodeIndex(actId, episodeId)

		self._txtclassnum.text = "STAGE " .. index

		gohelper.setActive(self._gotarget, self._isWin)
		recthelper.setAnchorY(self._gobtn.transform, self._isWin and -400 or -200)

		if self._isWin then
			self:refreshWin()
		else
			self:refreshLose()
		end
	end
end

function LanShouPaGameResultView:refreshWin()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	gohelper.setActive(self._gosuccess, true)
	gohelper.setActive(self._gofail, false)
	self:refreshTaskConditions()
	gohelper.setActive(self._btnquitgame, false)
	gohelper.setActive(self._btnrestart, false)
	gohelper.setActive(self._btnreturn, false)
end

function LanShouPaGameResultView:refreshLose()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, true)
	gohelper.setActive(self._btnclose, false)
	gohelper.setActive(self._btnreturn, true)
	self:refreshTaskConditions()
end

function LanShouPaGameResultView:_getEpisodeCfg()
	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		return ChessConfig.instance:getEpisodeCo(actId, episodeId)
	end
end

function LanShouPaGameResultView:refreshTaskConditions()
	local episodeCfg = self._episodeCfg

	if not episodeCfg then
		return
	end

	local conditionsStr = episodeCfg.mainConditionStr
	local conditions = string.split(conditionsStr, "|")
	local conditionDesc = string.split(episodeCfg.mainConditionStr, "|")
	local taskLen = #conditions
	local taskItem = self:getOrCreateTaskItem(1, self._gotargetitem)

	self:refreshTaskItem(taskItem, conditionDesc[taskLen], true, true)
end

function LanShouPaGameResultView:_checkExtStarConditionFinish(str, actId)
	local params2 = GameUtil.splitString2(str, true, "|", "#")

	if params2 then
		for i, params in ipairs(params2) do
			if not ChessGameHelper.isClearConditionFinish(params, actId) then
				return false
			end
		end
	end

	return true
end

function LanShouPaGameResultView:refreshTaskItem(taskItem, descTxt, isFinish, hasResult)
	gohelper.setActive(taskItem.go, true)

	taskItem.txtTaskDesc.text = descTxt

	gohelper.setActive(taskItem.goResult, hasResult)

	if hasResult then
		gohelper.setActive(taskItem.goFinish, isFinish)
		gohelper.setActive(taskItem.goUnFinish, not isFinish)
	end
end

function LanShouPaGameResultView:getOrCreateTaskItem(index, go)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = go
		item.txtTaskDesc = gohelper.findChildText(item.go, "txt_taskdesc")
		item.goFinish = gohelper.findChild(item.go, "result/go_finish")
		item.goUnFinish = gohelper.findChild(item.go, "result/go_unfinish")
		item.goResult = gohelper.findChild(item.go, "result")
		self._taskItems[index] = item
	end

	return item
end

function LanShouPaGameResultView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simageFailtitle:UnLoadImage()
	NavigateMgr.instance:removeEscape(self.viewName, self._onEscape, self)
end

return LanShouPaGameResultView
