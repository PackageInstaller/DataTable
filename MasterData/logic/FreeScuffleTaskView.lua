-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleTaskView.lua

module("logic.extensions.freescuffle.view.FreeScuffleTaskView", package.seeall)

local FreeScuffleTaskView = class("FreeScuffleTaskView", ViewComponent)

function FreeScuffleTaskView:buildUI()
	FreeScuffleTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local taskScrView = goutil.findChild(self.mainGO, "taskCol/scrView")
	local taskScrCell = goutil.findChild(self.mainGO, "taskCol/scrCell")

	self._itemScrCell = goutil.findChild(self.mainGO, "taskCol/itemScrCell")
	self._taskScrollerList = ScrollerList.create(taskScrView, taskScrCell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)
end

function FreeScuffleTaskView:bindEvents()
	FreeScuffleTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FreeScuffleTaskView:unbindEvents()
	FreeScuffleTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FreeScuffleTaskView:onEnter()
	FreeScuffleTaskView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._group = params[2]

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._coinItem = self._subMo:getCostCoinItem()

	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleTaskInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGainTaskPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleTaskNotifyRes, self._onUpdate, self)
	FreeScuffleController.instance:sendPM_FreeScuffleTaskInfoReq(self._activityId)
end

function FreeScuffleTaskView:onExit()
	FreeScuffleTaskView.super.onExit(self)
	self:_onClearTaskCol()
end

function FreeScuffleTaskView:_onUpdate()
	self:_updateTaskColUI()
end

function FreeScuffleTaskView:_updateTaskColUI()
	local cfg = FreeScuffleConfig.instance:getTaskDataListByGroup(self._activityId, self._group) or {}
	local taskInfoList = {}

	for _, data in ipairs(cfg) do
		local info = {}

		info.taskId = data.taskId
		info.state = self._subMo:getTaskState(data.taskId)
		info.data = data

		table.insert(taskInfoList, info)
	end

	table.sort(taskInfoList, function(a, b)
		if a.state == b.state then
			return a.taskId < b.taskId
		end

		return a.state < b.state
	end)
	self._taskScrollerList:reloadData(taskInfoList)
end

function FreeScuffleTaskView:_onClearTaskCol()
	self._taskScrollerList:dispose()
end

function FreeScuffleTaskView:_updateTaskCell(view, cell, info, tag)
	local taskId = info.taskId
	local state = info.state
	local data = info.data
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")

	if goutil.isNil(txtDesc) then
		txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	end

	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	txtTitle.text = data.title
	txtDesc.text = data.desc

	if txtProgress then
		local curProgress = self._subMo:getProgressTask(taskId)
		local maxProgress = data.maxProgress

		txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)
	end

	local prizeStrArr = {}

	if not string.nilorempty(data.prize) then
		prizeStrArr = string.split(data.prize, "#")
	end

	if checknumber(data.increaseCoin) > 0 then
		local matStr = string.format("%s:%s:%s", self._coinItem.matType, self._coinItem.matId, data.increaseCoin)

		table.insert(prizeStrArr, matStr)
	end

	if not self._itemScrollerListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		if #prizeStrArr > 0 then
			self._itemScrollerListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		else
			itemScrollList:dispose()
		end

		GameUtil.SetActive(txtProgress.gameObject, state == GameEnum.PrizeState.IsNotEnough)
		GameUtil.SetActive(itemScrView, #prizeStrArr > 0)
		GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
		GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough and not string.nilorempty(data.jumpTo))
		GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
		GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
		GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnReceive, self, data.taskId))
	end
end

function FreeScuffleTaskView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local itemScrollList = self._itemScrollerListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnGoto)
	GameUtil.rmClickHandler(btnReceive)
end

function FreeScuffleTaskView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function FreeScuffleTaskView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function FreeScuffleTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:_onClickBtnClose()
	end
end

function FreeScuffleTaskView:_onClickBtnReceive(taskId)
	if self._subMo:isHasGainOfTask(taskId) then
		FloatWordMgr.instance:show("已领取")

		return
	elseif not self._subMo:isEnoughOfTask(taskId) then
		FloatWordMgr.instance:show("未满足要求")

		return
	end

	FreeScuffleController.instance:sendPM_FreeScuffleGainTaskPrizeReq(self._activityId, taskId)
end

return FreeScuffleTaskView
