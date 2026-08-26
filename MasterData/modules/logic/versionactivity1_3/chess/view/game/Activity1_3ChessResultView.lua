-- chunkname: @modules/logic/versionactivity1_3/chess/view/game/Activity1_3ChessResultView.lua

module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessResultView", package.seeall)

local Activity1_3ChessResultView = class("Activity1_3ChessResultView", BaseView)

function Activity1_3ChessResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._txtclassnameen = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname/#txt_classnameen")
	self._goMainTargetItem = gohelper.findChild(self.viewGO, "targets/#go_targetitem0")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_return")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
end

function Activity1_3ChessResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
end

function Activity1_3ChessResultView:_btncloseOnClick()
	self:_btnquitgameOnClick()
end

function Activity1_3ChessResultView:_onEscape()
	self:_btnquitgameOnClick()
end

function Activity1_3ChessResultView:_btnquitgameOnClick()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)

	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessGameModel.instance:getResult() and not Activity1_3ChessController.instance:isEnterPassedEpisode() then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.FinishNewEpisode, episodeId)
	end

	local actId = Va3ChessModel.instance:getActId()

	Activity122Rpc.instance:sendGetActInfoRequest(actId)
	self:closeThis()
end

function Activity1_3ChessResultView:_btnrestartOnClick()
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickReset)
	self:closeThis()
end

function Activity1_3ChessResultView:_btnreturnOnClick()
	Stat1_3Controller.instance:bristleStatStart()
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickRead)
	self:closeThis()
end

function Activity1_3ChessResultView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	gohelper.setActive(self._gotargetitem, false)
	gohelper.setActive(self._goMainTargetItem, false)

	self._taskItems = {}

	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
end

function Activity1_3ChessResultView:_onHandleResetCompleted()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ResetGameByResultView)
end

function Activity1_3ChessResultView:onUpdateParam()
	return
end

function Activity1_3ChessResultView:onOpen()
	self._isWin = self.viewParam.result
	self._episodeCfg = self:_getEpisodeCfg()

	self:refreshUI()
end

function Activity1_3ChessResultView:refreshUI()
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

function Activity1_3ChessResultView:refreshWin()
	gohelper.setActive(self._gosuccess, true)
	gohelper.setActive(self._gofail, false)
	self:refreshTaskConditions()
	gohelper.setActive(self._btnquitgame.gameObject, false)
	gohelper.setActive(self._btnrestart.gameObject, false)
	gohelper.setActive(self._btnreturn.gameObject, false)
end

function Activity1_3ChessResultView:refreshLose()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, true)
	gohelper.setActive(self._btnclose, false)
end

function Activity1_3ChessResultView:_getEpisodeCfg()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)
	end
end

function Activity1_3ChessResultView:refreshTaskConditions()
	local episodeCfg = self._episodeCfg

	if not episodeCfg then
		return
	end

	local conditionsStr = episodeCfg.starCondition
	local conditions = string.split(conditionsStr, "|")
	local conditionDesc = string.split(episodeCfg.conditionStr, "|")
	local taskLen = #conditions
	local taskItem = self:getOrCreateTaskItem(taskLen, true)

	self:refreshTaskItem(taskItem, conditions[taskLen], conditionDesc[taskLen], true, true)

	if not string.nilorempty(episodeCfg.extStarCondition) then
		self:refreshTaskItem(self:getOrCreateTaskItem(taskLen + 1), episodeCfg.extStarCondition, episodeCfg.extConditionStr, true)
	end
end

function Activity1_3ChessResultView:refreshTaskItem(taskItem, condition, descTxt, hasResult, defaultFinish)
	gohelper.setActive(taskItem.go, true)

	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local desc
	local isFinish = false
	local conditions = string.split(condition, "|")

	if #conditions > 1 then
		local finishedCount = 0

		for i = 1, #conditions do
			local params = string.splitToNumber(conditions[i], "#")

			isFinish = Va3ChessMapUtils.isClearConditionFinish(params, actId)

			if isFinish then
				finishedCount = finishedCount + 1
			end

			isFinish = finishedCount == #conditions
		end

		desc = string.format("%s (%s/%s)", descTxt, finishedCount, #conditions)
	elseif not string.nilorempty(condition) then
		local params = string.splitToNumber(condition, "#")

		desc = descTxt or Va3ChessMapUtils.getClearConditionDesc(params, actId)
		isFinish = Va3ChessMapUtils.isClearConditionFinish(params, actId)
	else
		desc = descTxt or luaLang("chessgame_clear_normal")
		isFinish = Va3ChessGameModel.instance:getResult() == true
	end

	taskItem.txtTaskDesc.text = desc

	gohelper.setActive(taskItem.goResult, hasResult)

	if hasResult then
		if defaultFinish then
			isFinish = true
		end

		gohelper.setActive(taskItem.goFinish, isFinish)
		gohelper.setActive(taskItem.goUnFinish, not isFinish)
	end
end

function Activity1_3ChessResultView:getOrCreateTaskItem(index, isMainTask)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace((isMainTask or nil) and (self._goMainTargetItem or self._gotargetitem), "taskitem_" .. tostring(index))
		item.txtTaskDesc = gohelper.findChildText(item.go, "txt_taskdesc")
		item.goFinish = gohelper.findChild(item.go, "result/go_finish")
		item.goUnFinish = gohelper.findChild(item.go, "result/go_unfinish")
		item.goResult = gohelper.findChild(item.go, "result")
		self._taskItems[index] = item
	end

	return item
end

function Activity1_3ChessResultView:onClose()
	return
end

function Activity1_3ChessResultView:onDestroyView()
	self._simagebg1:UnLoadImage()
	NavigateMgr.instance:removeEscape(self.viewName, self._onEscape, self)
end

return Activity1_3ChessResultView
