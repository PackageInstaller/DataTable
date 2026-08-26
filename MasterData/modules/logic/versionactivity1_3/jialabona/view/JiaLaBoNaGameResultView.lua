-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaGameResultView.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameResultView", package.seeall)

local JiaLaBoNaGameResultView = class("JiaLaBoNaGameResultView", BaseView)

function JiaLaBoNaGameResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._gotargetmian = gohelper.findChild(self.viewGO, "targets/#go_targetitem0")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_return")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
end

function JiaLaBoNaGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
end

function JiaLaBoNaGameResultView:_btncloseOnClick()
	self:exitGame()
end

function JiaLaBoNaGameResultView:_btnquitgameOnClick()
	self:exitGame()
end

function JiaLaBoNaGameResultView:exitGame()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)

	if Va3ChessGameModel.instance:getResult() and not JiaLaBoNaController.instance:isEnterBforeClear() then
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.ClearNewEpisode, episodeId)
	end

	local actId = Va3ChessModel.instance:getActId()

	Activity120Rpc.instance:sendGetActInfoRequest(actId)
	self:closeThis()
end

function JiaLaBoNaGameResultView:_onEscape()
	self:exitGame()
end

function JiaLaBoNaGameResultView:_btnrestartOnClick()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
	TaskDispatcher.runDelay(JiaLaBoNaGameResultView.resetStartGame, nil, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
	self:closeThis()
end

function JiaLaBoNaGameResultView.resetStartGame()
	JiaLaBoNaController.instance:resetStartGame()
end

function JiaLaBoNaGameResultView.returnPointGame()
	JiaLaBoNaController.instance:returnPointGame(true)
end

function JiaLaBoNaGameResultView:_btnreturnOnClick()
	Stat1_3Controller.instance:jiaLaBoNaStatStart()
	Stat1_3Controller.instance:jiaLaBoNaMarkUseRead()
	JiaLaBoNaGameResultView.returnPointGame()
end

function JiaLaBoNaGameResultView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	self._simageFailtitle = gohelper.findChildSingleImage(self.viewGO, "#go_fail/titlecn")

	gohelper.setActive(self._gotargetitem, false)
	gohelper.setActive(self._gotargetmian, false)

	self._taskItems = {}

	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
end

function JiaLaBoNaGameResultView:_onHandleResetCompleted()
	return
end

function JiaLaBoNaGameResultView:onUpdateParam()
	return
end

function JiaLaBoNaGameResultView:onOpen()
	self._isWin = self.viewParam.result
	self._episodeCfg = self:_getEpisodeCfg()

	self:refreshUI()
end

function JiaLaBoNaGameResultView:onClose()
	return
end

function JiaLaBoNaGameResultView:refreshUI()
	if self._episodeCfg then
		self._txtclassname.text = self._episodeCfg.name
		self._txtclassnum.text = self._episodeCfg.orderId

		if self._isWin then
			self:refreshWin()
		else
			self:refreshLose()
		end
	end
end

function JiaLaBoNaGameResultView:refreshWin()
	gohelper.setActive(self._gosuccess, true)
	gohelper.setActive(self._gofail, false)
	self:refreshTaskConditions()
	gohelper.setActive(self._btnquitgame, false)
	gohelper.setActive(self._btnrestart, false)
	gohelper.setActive(self._btnreturn, false)
end

function JiaLaBoNaGameResultView:refreshLose()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, true)
	gohelper.setActive(self._btnclose, false)
	gohelper.setActive(self._btnreturn, true)

	local failReason = Va3ChessGameModel.instance:getFailReason()

	if not JiaLaBoNaEnum.ResultLangResPath[failReason] then
		self._simageFailtitle:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(JiaLaBoNaEnum.ResultLangResPath[failReason]))
	end
end

function JiaLaBoNaGameResultView:_getEpisodeCfg()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)
	end
end

function JiaLaBoNaGameResultView:refreshTaskConditions()
	local episodeCfg = self._episodeCfg

	if not episodeCfg then
		return
	end

	local actId = Va3ChessModel.instance:getActId()
	local conditionsStr = episodeCfg.mainConfition
	local conditions = string.split(conditionsStr, "|")
	local conditionDesc = string.split(episodeCfg.mainConditionStr, "|")
	local taskLen = #conditions
	local params = string.splitToNumber(conditions[taskLen], "#")
	local isFinish = Va3ChessMapUtils.isClearConditionFinish(params, actId)
	local taskItem = self:getOrCreateTaskItem(1, self._gotargetmian)

	self:refreshTaskItem(taskItem, conditionDesc[taskLen], isFinish, true)

	if not string.nilorempty(episodeCfg.extStarCondition) then
		local isExtFinish = self:_checkExtStarConditionFinish(episodeCfg.extStarCondition, actId)

		self:refreshTaskItem(self:getOrCreateTaskItem(2, self._gotargetitem), episodeCfg.conditionStr, isExtFinish, true)
	end
end

function JiaLaBoNaGameResultView:_checkExtStarConditionFinish(str, actId)
	local params2 = GameUtil.splitString2(str, true, "|", "#")

	if params2 then
		for i, params in ipairs(params2) do
			if not Va3ChessMapUtils.isClearConditionFinish(params, actId) then
				return false
			end
		end
	end

	return true
end

function JiaLaBoNaGameResultView:refreshTaskItem(taskItem, descTxt, isFinish, hasResult)
	gohelper.setActive(taskItem.go, true)

	taskItem.txtTaskDesc.text = descTxt

	gohelper.setActive(taskItem.goResult, hasResult)

	if hasResult then
		gohelper.setActive(taskItem.goFinish, isFinish)
		gohelper.setActive(taskItem.goUnFinish, not isFinish)
	end
end

function JiaLaBoNaGameResultView:getOrCreateTaskItem(index, go)
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

function JiaLaBoNaGameResultView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simageFailtitle:UnLoadImage()
	NavigateMgr.instance:removeEscape(self.viewName, self._onEscape, self)
end

return JiaLaBoNaGameResultView
