-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameMain.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameMain", package.seeall)

local ActivityChessGameMain = class("ActivityChessGameMain", BaseView)

function ActivityChessGameMain:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagechessboard = gohelper.findChildSingleImage(self.viewGO, "scroll/viewport/#go_content/#simage_chessboard")
	self._txtcurround = gohelper.findChildText(self.viewGO, "roundbg/anim/curround/#txt_curround")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_restart")
	self._gocontent = gohelper.findChild(self.viewGO, "scroll/viewport/#go_content")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_tasklist/#go_taskitem")
	self._gooptip = gohelper.findChild(self.viewGO, "#go_optip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityChessGameMain:addEvents()
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function ActivityChessGameMain:removeEvents()
	self._btnrestart:RemoveClickListener()
end

function ActivityChessGameMain:_editableInitView()
	local mapId = ActivityChessGameModel.instance:getMapId()
	local actId = ActivityChessGameModel.instance:getActId()
	local mapCo = Activity109Config.instance:getMapCo(actId, mapId)

	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._conditionItems = {}
end

function ActivityChessGameMain:onDestroyView()
	return
end

function ActivityChessGameMain:onOpen()
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.SetViewVictory, self.onSetViewVictory, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.SetViewFail, self.onSetViewFail, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.CurrentRoundUpdate, self.refreshRound, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.CurrentConditionUpdate, self.refreshConditions, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.GameMapDataUpdate, self.refreshUI, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.SetCenterHintText, self.setUICenterHintText, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.ResetGameByResultView, self.handleResetByResult, self)
	self:refreshUI()
end

function ActivityChessGameMain:onClose()
	UIBlockMgr.instance:endBlock(ActivityChessGameMain.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(self.delayRestartGame, self)

	if self.viewContainer:isManualClose() then
		Activity109ChessController.instance:statEnd(StatEnum.Result.Abort)
	end

	Activity109ChessController.instance:dispatchEvent(ActivityEvent.Play109EntryViewOpenAni)
end

function ActivityChessGameMain:onSetViewVictory()
	Activity109ChessController.instance:statEnd(StatEnum.Result.Success)

	local actId = Activity109ChessModel.instance:getActId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		local episodeCfg = Activity109Config.instance:getEpisodeCo(actId, episodeId)

		if episodeCfg and episodeCfg.storyClear == 0 then
			ActivityChessGameMain.openWinResult()

			return
		end

		local story = episodeCfg.storyClear

		if not StoryModel.instance:isStoryHasPlayed(story) then
			StoryController.instance:playStories({
				story
			}, nil, ActivityChessGameMain.openWinResult)
		else
			ActivityChessGameMain.openWinResult()
		end
	end
end

function ActivityChessGameMain.openWinResult()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()
	local v1 = "OnChessWinPause" .. episodeId
	local v2 = GuideEvent[v1]
	local v3 = GuideEvent.OnChessWinContinue
	local v4 = ActivityChessGameMain._openSuccessView
	local v5

	GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)
end

function ActivityChessGameMain._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.ActivityChessGameResultView, {
		result = true
	})
end

function ActivityChessGameMain:onSetViewFail()
	Activity109ChessController.instance:statEnd(StatEnum.Result.Fail)
	ViewMgr.instance:openView(ViewName.ActivityChessGameResultView, {
		result = false
	})
end

function ActivityChessGameMain:refreshUI()
	self:refreshRound()
	self:refreshConditions()
end

function ActivityChessGameMain:refreshRound()
	local actId = Activity109ChessModel.instance:getActId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if not actId or not episodeId then
		return
	end

	local episodeCfg = Activity109Config.instance:getEpisodeCo(actId, episodeId)

	self._txtcurround.text = string.format("%s/<size=36>%s</size>", tostring(ActivityChessGameModel.instance:getRound()), episodeCfg.maxRound)
end

function ActivityChessGameMain:refreshConditions()
	self:hideAllConditions()

	local actId = Activity109ChessModel.instance:getActId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if not actId or not episodeId then
		return
	end

	local episodeCfg = Activity109Config.instance:getEpisodeCo(actId, episodeId)
	local conditionsStr = episodeCfg.extStarCondition
	local conditions = string.split(conditionsStr, "|")
	local conditionDesc = string.split(episodeCfg.conditionStr, "|")
	local taskLen = #conditions + 1

	logNormal("taskLen : " .. tostring(taskLen))

	for i = 1, taskLen do
		local taskItem = self:getOrCreateConditionItem(i)

		if i == 1 then
			self:refreshConditionItem(taskItem, nil, conditionDesc[i])
		else
			self:refreshConditionItem(taskItem, conditions[i - 1], conditionDesc[i])
		end
	end
end

function ActivityChessGameMain:refreshConditionItem(taskItem, condition, descTxt)
	gohelper.setActive(taskItem.go, true)

	local actId = Activity109ChessModel.instance:getActId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()
	local desc
	local isFinish = false

	if not string.nilorempty(condition) then
		local params = string.splitToNumber(condition, "#")

		desc = descTxt or ActivityChessMapUtils.getClearConditionDesc(params, actId)
		isFinish = ActivityChessMapUtils.isClearConditionFinish(params, actId)
	else
		desc = descTxt or luaLang("chessgame_clear_normal")
		isFinish = ActivityChessGameModel.instance:getResult() == true
	end

	taskItem.txtTaskDesc.text = desc

	if not taskItem.goFinish.activeSelf and isFinish then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.StarLight)
	end

	gohelper.setActive(taskItem.goFinish, isFinish)
	gohelper.setActive(taskItem.goUnFinish, not isFinish)
end

function ActivityChessGameMain:setUICenterHintText(param)
	local visible = param.visible

	gohelper.setActive(self._gooptip, visible)
end

function ActivityChessGameMain:getOrCreateConditionItem(index)
	local item = self._conditionItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gotaskitem, "taskitem_" .. tostring(index))
		item.txtTaskDesc = gohelper.findChildText(item.go, "txt_desc")
		item.goFinish = gohelper.findChild(item.go, "star/go_finish")
		item.goUnFinish = gohelper.findChild(item.go, "star/go_unfinish")
		self._conditionItems[index] = item
	end

	return item
end

function ActivityChessGameMain:hideAllConditions()
	for _, itemObj in pairs(self._conditionItems) do
		gohelper.setActive(itemObj.go, false)
	end
end

function ActivityChessGameMain:onResultQuit()
	self:closeThis()
end

function ActivityChessGameMain:handleResetByResult()
	self._animRoot:Play("open", 0, 0)
end

ActivityChessGameMain.UI_RESTART_BLOCK_KEY = "ActivityChessGameMainDelayRestart"

function ActivityChessGameMain:_btnrestartOnClick()
	local function yesFunc()
		Activity109ChessController.instance:statEnd(StatEnum.Result.Reset)
		UIBlockMgr.instance:startBlock(ActivityChessGameMain.UI_RESTART_BLOCK_KEY)
		self._animRoot:Play("excessive", 0, 0)
		TaskDispatcher.runDelay(self.delayRestartGame, self, 0.56)
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, yesFunc)
end

function ActivityChessGameMain:delayRestartGame()
	UIBlockMgr.instance:endBlock(ActivityChessGameMain.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(self.delayRestartGame, self)

	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if episodeId then
		Activity109ChessController.instance:startNewEpisode(episodeId)
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameReset)
end

return ActivityChessGameMain
