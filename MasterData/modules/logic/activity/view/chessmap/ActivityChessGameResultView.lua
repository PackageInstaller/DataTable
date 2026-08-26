-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameResultView.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameResultView", package.seeall)

local ActivityChessGameResultView = class("ActivityChessGameResultView", BaseView)

function ActivityChessGameResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargets = gohelper.findChild(self.viewGO, "#go_targets")
	self._gotargetitem = gohelper.findChild(self.viewGO, "#go_targets/#go_targetitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_success/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityChessGameResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function ActivityChessGameResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function ActivityChessGameResultView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	self._openTime = Time.time
	self._taskItems = {}
end

function ActivityChessGameResultView:onDestroyView()
	self._simagebg1:UnLoadImage()
end

function ActivityChessGameResultView:onOpen()
	local isWin = self.viewParam.result

	if isWin then
		self:refreshWin()
	else
		self:refreshLose()
	end
end

function ActivityChessGameResultView:onClose()
	return
end

function ActivityChessGameResultView:refreshWin()
	gohelper.setActive(self._gosuccess, true)
	gohelper.setActive(self._gofail, false)
	self:refreshTaskConditions()
	gohelper.setActive(self._btnquitgame.gameObject, false)
	gohelper.setActive(self._btnrestart.gameObject, false)
end

function ActivityChessGameResultView:refreshLose()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, true)
	self:refreshTaskConditions()
end

function ActivityChessGameResultView:refreshTaskConditions()
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

	for i = 1, taskLen do
		local taskItem = self:getOrCreateTaskItem(i)

		if i == 1 then
			self:refreshTaskItem(taskItem, nil, conditionDesc[i])
		else
			self:refreshTaskItem(taskItem, conditions[i - 1], conditionDesc[i])
		end
	end
end

function ActivityChessGameResultView:refreshTaskItem(taskItem, condition, descTxt)
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

	gohelper.setActive(taskItem.goFinish, isFinish)
	gohelper.setActive(taskItem.goUnFinish, not isFinish)
end

function ActivityChessGameResultView:getOrCreateTaskItem(index)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gotargetitem, "taskitem_" .. tostring(index))
		item.txtTaskDesc = gohelper.findChildText(item.go, "txt_taskdesc")
		item.goFinish = gohelper.findChild(item.go, "result/go_finish")
		item.goUnFinish = gohelper.findChild(item.go, "result/go_unfinish")
		self._taskItems[index] = item
	end

	return item
end

function ActivityChessGameResultView:handleResetCompleted()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.ResetGameByResultView)
end

function ActivityChessGameResultView:_btnquitgameOnClick()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameResultQuit)

	local actId = Activity109ChessModel.instance:getActId()

	Activity109Rpc.instance:sendGetAct109InfoRequest(actId)
	self:closeThis()
end

function ActivityChessGameResultView:_btnrestartOnClick()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if episodeId then
		Activity109ChessController.instance:startNewEpisode(episodeId, self.handleResetCompleted, self)
	end

	self:closeThis()
end

function ActivityChessGameResultView:_btncloseOnClick()
	if Time.time - (self._openTime or 0) >= 1 then
		self:_btnquitgameOnClick()
	end
end

return ActivityChessGameResultView
