-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142ResultView.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142ResultView", package.seeall)

local Activity142ResultView = class("Activity142ResultView", BaseView)

function Activity142ResultView:onInitView()
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._goMainTargetItem = gohelper.findChild(self.viewGO, "targets/#go_targetitem0")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Activity142ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity142ResultView:_btncloseOnClick()
	self:_btnquitgameOnClick()
end

function Activity142ResultView:_onEscape()
	self:_btnquitgameOnClick()
end

function Activity142ResultView:_btnquitgameOnClick()
	Va3ChessController.instance:reGetActInfo(self._gameResultQuit, self)
end

function Activity142ResultView:_gameResultQuit()
	self:closeThis()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)
end

function Activity142ResultView:_editableInitView()
	self._targetItemList = {}

	gohelper.setActive(self._gotargetitem, false)
	gohelper.setActive(self._goMainTargetItem, false)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
end

function Activity142ResultView:onUpdateParam()
	return
end

function Activity142ResultView:onOpen()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		self._episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)
	end

	self:refreshUI()
end

function Activity142ResultView:refreshUI()
	if not self._episodeCfg then
		return
	end

	self._txtclassname.text = self._episodeCfg.name
	self._txtclassnum.text = self._episodeCfg.orderId

	self:refreshTaskConditions()
end

function Activity142ResultView:refreshTaskConditions()
	if not self._episodeCfg then
		return
	end

	local strMainCondition = self._episodeCfg.mainConfition
	local mainConditionList = string.split(strMainCondition, "|")
	local taskLen = #mainConditionList
	local taskItem = self:getOrCreateTaskItem(taskLen, true)

	self:refreshTaskItem(taskItem, strMainCondition, self._episodeCfg.mainConditionStr, true)

	if not string.nilorempty(self._episodeCfg.extStarCondition) then
		local extraTaskItem = self:getOrCreateTaskItem(taskLen + 1)

		self:refreshTaskItem(extraTaskItem, self._episodeCfg.extStarCondition, self._episodeCfg.conditionStr, true)
	end
end

function Activity142ResultView:getOrCreateTaskItem(index, isMainTask)
	local item = self._targetItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace((isMainTask or nil) and (self._goMainTargetItem or self._gotargetitem), "taskitem_" .. tostring(index))
		item.txtTaskDesc = gohelper.findChildText(item.go, "txt_taskdesc")
		item.goFinish = gohelper.findChild(item.go, "result/go_finish")
		item.goUnFinish = gohelper.findChild(item.go, "result/go_unfinish")
		item.goResult = gohelper.findChild(item.go, "result")
		self._targetItemList[index] = item
	end

	return item
end

function Activity142ResultView:refreshTaskItem(taskItem, conditionStr, descTxt, hasResult)
	gohelper.setActive(taskItem.go, true)

	taskItem.txtTaskDesc.text = descTxt

	local tmpResult = hasResult and not string.nilorempty(conditionStr)

	gohelper.setActive(taskItem.goResult, tmpResult)

	if tmpResult then
		local actId = Va3ChessModel.instance:getActId()
		local isFinish = Activity142Helper.checkConditionIsFinish(conditionStr, actId)

		gohelper.setActive(taskItem.goFinish, isFinish)
		gohelper.setActive(taskItem.goUnFinish, not isFinish)
	end
end

function Activity142ResultView:onClose()
	return
end

function Activity142ResultView:onDestroyView()
	NavigateMgr.instance:removeEscape(self.viewName, self._onEscape, self)
end

return Activity142ResultView
