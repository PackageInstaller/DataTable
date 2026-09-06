-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGetVotesView.lua

module("logic.extensions.goddesscontest.view.GoddessContestGetVotesView", package.seeall)

local GoddessContestGetVotesView = class("GoddessContestGetVotesView", ViewComponent)
local TabType = {
	Close = 2,
	Open = 1
}

function GoddessContestGetVotesView:ctor()
	GoddessContestGetVotesView.super.ctor(self)
end

function GoddessContestGetVotesView:unbindEvents()
	GoddessContestGetVotesView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)

	for i, v in ipairs(self._tabCellList) do
		GameUtil.rmClickHandler(v.go)
	end
end

function GoddessContestGetVotesView:bindEvents()
	GoddessContestGetVotesView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)

	for i, v in ipairs(self._tabCellList) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickTab, self, i))
	end
end

function GoddessContestGetVotesView:buildUI()
	GoddessContestGetVotesView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTips = self:getBtn("btnTip")
	self._petCon = self:getGo("mask/role/petCon")
	self._txtTime = self:getTxt("timeTips/txt")
	self._tabCellList = {}

	for i = 1, 4 do
		local data = {}

		data.go = self:getGo("tabcon/tabcell_" .. i)
		data.lock = goutil.findChild(data.go, "lockGo")
		data.select = goutil.findChild(data.go, "select")
		data.state = TabType.Open

		table.insert(self._tabCellList, data)
	end

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemScrollListDic = {}
end

function GoddessContestGetVotesView:onExit()
	GoddessContestGetVotesView.super.onExit(self)
	self._scrollList:dispose()

	for _, v in ipairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil

	removetimer(self._tickSpine, self)

	if self._advertisementTween then
		self._advertisementTween:Kill(false)

		self._advertisementTween = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function GoddessContestGetVotesView:onEnter()
	GoddessContestGetVotesView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._curIndex = 1

	local timeList = GoddessContestModel.instance:handleTaskData(self._activityId)

	for i, v in ipairs(timeList) do
		if GameUtil.checkIsInTimePeriod(timeList[i].startTime, timeList[i].endTime) then
			self._curIndex = math.max(self._curIndex, i)
		end
	end

	self._curPetIdx = 1
	self._petPhotoShows = {}

	self:_initView()
	self:_playPetSpine()
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
	settimer(5, self._tickSpine, self)
end

function GoddessContestGetVotesView:_initView()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Goddess_Contest, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtTime then
		self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	local timeList = GoddessContestModel.instance:handleTaskData(self._activityId)

	for i, v in ipairs(self._tabCellList) do
		local startTime, endTime = timeList[i].startTime, timeList[i].endTime
		local isInTime = GameUtil.checkIsInTimePeriod(startTime, endTime)

		GameUtil.SetActive(v.lock, not isInTime)

		if not isInTime then
			v.state = TabType.Close or TabType.Open
		end
	end

	self._fansGroupGoddess = {}

	local fanCfgs = GoddessContestConfig.instance:getFanGroupCfgsByActId(self._activityId)

	for i, v in ipairs(fanCfgs) do
		for _, value in ipairs(v.fansGroupGoddess) do
			table.insert(self._fansGroupGoddess, tostring(value))
		end
	end
end

function GoddessContestGetVotesView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function GoddessContestGetVotesView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GoddessContestGetVotesView:_onUpdateData()
	self:_onUpdateTaskData()
end

function GoddessContestGetVotesView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_updateTabList()
end

function GoddessContestGetVotesView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in pairs(queue) do
		local list = {}
		local beginTime

		for idx, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = EventTaskSummaryController.instance:calcTaskState(self._activityId, data.taskId)

			table.insert(list, tab)

			beginTime = data.completionStartTime
		end

		table.sort(list, function(a, b)
			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)

		self._taskDataQueue[pageId] = list
	end

	table.sort(self._taskDataQueue, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.data.taskId < b.data.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
end

function GoddessContestGetVotesView:_updateTaskScrollerList()
	local list = {}
	local fitterList = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	local timeList = GoddessContestModel.instance:handleTaskData(self._activityId)
	local startTime = timeList[self._curIndex].startTime

	for _, v in ipairs(list) do
		if v.data.completionStartTime == startTime then
			table.insert(fitterList, v)
		end
	end

	self._taskLists = fitterList

	self._scrollList:reloadData(self._taskLists)
end

function GoddessContestGetVotesView:_updateTabList()
	for i, v in ipairs(self._tabCellList) do
		GameUtil.SetActive(v.lock, v.state == TabType.Close)
		GameUtil.SetActive(v.select, i == self._curIndex)
	end
end

function GoddessContestGetVotesView:_updateCell(view, goCell, temData, tag)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	cell.txtTitle.text = data.title
	cell.txtDesc.text = data.desc

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	if cell.itemScrollerview and cell.itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[cell.go] then
			local itemScrollList = ScrollerList.create(cell.itemScrollerview, cell.itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[cell.go] = self._itemScrollListDic[cell.go]

			self._itemScrollListDic[cell.go]:reloadData(prizeStrArr)
			self._itemScrollListDic[cell.go]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(cell.btnReceive, temData.state == 1)
	GameUtil.SetActive(cell.btnGoto, temData.state == 2)
	GameUtil.SetActive(cell.receive, temData.state == 3)
	GameUtil.SetActive(cell.txtProgress.gameObject, temData.state ~= 3)
	GameUtil.SetActive(cell.tag, data.periodType == "daily")
	GameUtil.addClickHandler(cell.btnGoto, function()
		self:_onClickGoto(data)
	end, self)
	GameUtil.addClickHandler(cell.btnReceive, function()
		self:_onClickRecieve(data.taskId)
	end, self)
end

function GoddessContestGetVotesView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgress = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.btnReceive = goutil.findChild(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.receive = goutil.findChild(cell.go, "receive")
	cell.tag = goutil.findChild(cell.go, "tag")
	cell.itemScrollerview = goutil.findChild(cell.go, "itemScrollerview")
	cell.itemScrollercell = goutil.findChild(cell.go, "itemScrollercell")

	GameUtil.rmClickHandler(cell.btnReceive)
	GameUtil.rmClickHandler(cell.btnGoto)

	local itemScrollList = self._itemScrollListDic[cell.go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[cell.go] = nil
	end

	return cell
end

function GoddessContestGetVotesView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GoddessContestGetVotesView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GoddessContestGetVotesView:_playPetSpine()
	local petId = self._fansGroupGoddess[self._curPetIdx]
	local petPhotoShow = PetPhotoShow.Get(self._petCon)

	petPhotoShow:showPetEffect(petId, true, 3, "bag")
	table.insert(self._petPhotoShows, petPhotoShow)
end

function GoddessContestGetVotesView:_tickSpine()
	self._curPetIdx = self._curPetIdx + 1

	local len = #self._fansGroupGoddess

	if len < self._curPetIdx then
		self._curPetIdx = 1
	end

	local image = self._petCon:GetComponent(typeof(UnityEngine.UI.RawImage))
	local sequence = DG.Tweening.DOTween.Sequence()
	local twenner = image:DOFade(0, 0.5):SetEase(DG.Tweening.Ease.InQuart)

	local function startHandler()
		self:_playPetSpine()
	end

	local twenner2 = image:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InQuart):OnStart(startHandler)

	sequence:Append(twenner)
	sequence:Append(twenner2)

	self._advertisementTween = sequence
end

function GoddessContestGetVotesView:_onClickClose()
	self:close()
end

function GoddessContestGetVotesView:_onClickGoto(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function GoddessContestGetVotesView:_onClickRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

function GoddessContestGetVotesView:_onClickTab(idx)
	if self._tabCellList[idx].state == TabType.Close then
		local timeList = GoddessContestModel.instance:handleTaskData(self._activityId)

		if timeList and timeList[idx] then
			local timeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(timeList[idx].startTime), GameUtil.string2time(timeList[idx].endTime))

			FloatWordMgr.instance:show(string.format("开启时间为%s", timeStr))
		end

		return
	end

	self._curIndex = idx

	self:_onUpdate()

	for i, v in ipairs(self._tabCellList) do
		GameUtil.SetActive(v.select, i == idx)
	end
end

function GoddessContestGetVotesView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "getvotes_rule")
end

return GoddessContestGetVotesView
