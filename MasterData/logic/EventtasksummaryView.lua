-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/EventtasksummaryView.lua

module("logic.extensions.eventtasksummary.view.EventtasksummaryView", package.seeall)

local EventtasksummaryView = class("EventtasksummaryView", ViewComponent)

function EventtasksummaryView:ctor()
	EventtasksummaryView.super.ctor(self)
end

function EventtasksummaryView:unbindEvents()
	EventtasksummaryView.super.unbindEvents(self)
end

function EventtasksummaryView:bindEvents()
	EventtasksummaryView.super.bindEvents(self)
end

function EventtasksummaryView:buildUI()
	EventtasksummaryView.super.buildUI(self)

	self._pageTableview = goutil.findChild(self.mainGO, "pageCol/pageTableview")
	self._pageTablecell = goutil.findChild(self.mainGO, "pageCol/pageTablecell")
	self._tableview = goutil.findChild(self.mainGO, "contentCol/tableview")
	self._tablecell = goutil.findChild(self.mainGO, "contentCol/tablecell")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "tip/txtTip")
	self._txtPageTips = MaterialMgr.findGraphicText(self.mainGO, "txtPageTips")
	self._pageScrollList = ScrollerList.create(self._pageTableview, self._pageTablecell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))
	self._taskScrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
end

function EventtasksummaryView:onExit()
	EventtasksummaryView.super.onExit(self)

	if self._txtPageTips then
		self._txtPageTips.text = ""
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self._pageScrollList:dispose()
	self._taskScrollList:dispose()
end

function EventtasksummaryView:onEnter()
	EventtasksummaryView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._taskPageCfg = EventTaskSummaryConfig.instance:getTaskPageCfg(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)

	self._selectPage = self._selectPage or 1

	self:_sendInfoReq()
end

function EventtasksummaryView:_sendInfoReq()
	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGetInfoReq(self._activityId)
end

function EventtasksummaryView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EventtasksummaryView:_onUpdateData()
	self:_onUpdateTaskData()
end

function EventtasksummaryView:_onUpdateUI()
	self:_updatePageScrollerList()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function EventtasksummaryView:_onUpdatePlaneUI()
	local pageData = self._taskPageCfg[self._selectPage]

	if self._txtPageTips then
		self._txtPageTips.text = ""
	end

	if pageData and not string.nilorempty(pageData.pageTips) and self._txtPageTips then
		self._txtPageTips.text = pageData.pageTips
	end
end

function EventtasksummaryView:_onUpdateTaskData()
	self._taskDataQueue = {}
	self._pageTaskDataQueue = {}
	self._visibleTaskPageCfg = {}

	local queue = EventTaskSummaryConfig.instance:getVisibleTaskQueue(self._activityId, EventTaskSummaryModel.instance:getPlayerTypeTag(self._activityId))
	local pageIdList = table.keys(queue)

	table.sort(pageIdList, function(a, b)
		return a < b
	end)

	for _, pageId in ipairs(pageIdList) do
		local taskList = queue[pageId]
		local pageCfg = self._taskPageCfg[pageId]

		if pageCfg then
			table.insert(self._visibleTaskPageCfg, pageCfg)
		end

		local list = {}

		for _, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = self:_calcTaskState(data.taskId)

			table.insert(list, tab)
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

		for i, v in ipairs(list) do
			local typeId = v.data.typeId

			self._pageTaskDataQueue[pageId] = self._pageTaskDataQueue[pageId] or {}
			self._pageTaskDataQueue[pageId][typeId] = self._pageTaskDataQueue[pageId][typeId] or {}

			table.insert(self._pageTaskDataQueue[pageId][typeId], v)
		end
	end

	local selectPageVisible = false

	for _, pageId in ipairs(pageIdList) do
		if pageId == self._selectPage then
			selectPageVisible = true

			break
		end
	end

	if not selectPageVisible then
		self._selectPage = pageIdList[1]
	end
end

function EventtasksummaryView:_calcTaskState(taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local taskInfo = EventTaskSummaryModel.instance:getTaskInfo(taskId)

	return (taskInfo or nil) and (taskInfo.hasGainPrize == true and 3 or checknumber(taskInfo.curProgress) >= taskData.maxProgress and 1 or 2)
end

function EventtasksummaryView:_getTaskCurProgress(taskId)
	local taskInfo = EventTaskSummaryModel.instance:getTaskInfo(taskId)

	return (taskInfo or nil) and taskInfo.curProgress
end

function EventtasksummaryView:_getTaskCompletionStatus(pageId)
	if not self._taskDataQueue[pageId] then
		local list = {}
		local hasGainNum = 0

		for _, tab in ipairs(list) do
			if tab.state == 3 then
				hasGainNum = hasGainNum + 1
			end
		end

		local totalTaskNum = #list

		return hasGainNum, totalTaskNum
	end
end

function EventtasksummaryView:_isHaveTaskCanGain(pageId)
	local isCanGain = false

	for _, tab in ipairs(self._taskDataQueue[pageId] or {}) do
		if tab.state == 1 then
			isCanGain = true

			break
		end
	end

	return isCanGain
end

function EventtasksummaryView:_updateTaskScrollerList()
	if not self._pageTaskDataQueue[self._selectPage] then
		local list = {}

		for typeId, taskDataList in pairs(self._pageTaskDataQueue[self._selectPage]) do
			if #taskDataList > 0 then
				if taskDataList[1].state == 3 then
					table.insert(list, taskDataList[#taskDataList])
				else
					table.insert(list, taskDataList[1])
				end
			end
		end

		self._taskScrollList:reloadData(list)
	end
end

function EventtasksummaryView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnRecieve = goutil.findChild(mainGo, "btnRecieve")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receive = goutil.findChild(mainGo, "receive")
	local rewardItem = goutil.findChild(mainGo, "rewards/item")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local isNeedTitle = not string.nilorempty(data.title) and txtTitle

	if isNeedTitle then
		txtTitle.text = data.title
	end

	local isNeedDesc = not string.nilorempty(data.desc) and txtDesc

	if isNeedDesc then
		txtDesc.text = data.desc
	end

	local maxProgress = data.maxProgress
	local curProgress = math.min(self:_getTaskCurProgress(data.taskId), maxProgress)

	GameUtil.SetActive(txtProgress, state ~= 3)

	if txtProgress then
		txtProgress.text = string.format("<color=#20B376FF>%s/%s</color>", curProgress, maxProgress)
	end

	local prizeStrArr = string.split(data.prize, "#")
	local prizeStr = prizeStrArr[1]

	if rewardItem and not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(data.prize, rewardItem, urlOrGo, luaCls, isOne)
	end

	GameUtil.SetActive(btnRecieve, state == 1)
	GameUtil.SetActive(btnGoto, state == 2)
	GameUtil.SetActive(receive, state == 3)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function EventtasksummaryView:_clearTaskCell(cell)
	local mainGo = cell
	local rewardItem = goutil.findChild(mainGo, "rewards/item")

	MaterialMgr.resetAll(rewardItem)
end

function EventtasksummaryView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	ViewAutoShowController.instance:saveCurModalView()
	GotoMgr.gotoByString(data.jumpTo)
end

function EventtasksummaryView:_onClickBtnRecieve(taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)

	if not self._pageTaskDataQueue[self._selectPage] then
		if not self._pageTaskDataQueue[self._selectPage][taskData.typeId] then
			local taskDataList = {}
			local taskIdList = {}

			for _, info in ipairs(taskDataList) do
				if info.state == GameEnum.PrizeState.IsCanGet then
					table.insert(taskIdList, info.data.taskId)
				end
			end

			if #taskIdList > 0 then
				EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGainTaskPrizeReq(self._activityId, taskIdList)
			end
		end
	end
end

function EventtasksummaryView:_updatePageScrollerList()
	self._pageScrollList:reloadData(self._visibleTaskPageCfg or {})
end

function EventtasksummaryView:_updatePageCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local selectGo = goutil.findChild(mainGo, "select")
	local redpoint = goutil.findChild(mainGo, "redpoint")
	local txtPageName = goutil.findChildTextComponent(mainGo, "txtPageName")
	local txtPageNameColorChange = goutil.findChildComponent(mainGo, "txtPageName", ComponentType.UITextColorChange)

	if not string.nilorempty(data.pagePicture) and icon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/%s.png", data.pagePicture)

		local function handler()
			return
		end

		uGuiUtil.setSpriteToImage(icon, spriteType, spriteName, handler)
	end

	if txtPageName then
		txtPageName.text = data.pageName
	end

	local isCanGain = self:_isHaveTaskCanGain(data.pageId)

	GameUtil.SetActive(redpoint, isCanGain)

	local isSelected = data.pageId == self._selectPage

	GameUtil.SetActive(selectGo, isSelected)

	local function handler()
		self._selectPage = data.pageId

		self:_onUpdate()
	end

	GameUtil.addClickHandler(mainGo, handler)

	if txtPageNameColorChange then
		txtPageNameColorChange:SetState(isSelected and 1 or 0)
	end
end

function EventtasksummaryView:_clearPageCell(cell)
	local mainGo = cell
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

return EventtasksummaryView
