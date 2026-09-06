-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjtaskView.lua

module("logic.extensions.xingjiang.view.XjtaskView", package.seeall)

local XjtaskView = class("XjtaskView", ViewComponent)

function XjtaskView:ctor()
	XjtaskView.super.ctor(self)
end

function XjtaskView:unbindEvents()
	XjtaskView.super.unbindEvents(self)
end

function XjtaskView:bindEvents()
	XjtaskView.super.bindEvents(self)
end

function XjtaskView:buildUI()
	XjtaskView.super.buildUI(self)

	self._pageTableview = goutil.findChild(self.mainGO, "pageCol/pageTableview")
	self._pageTablecell = goutil.findChild(self.mainGO, "pageCol/pageTablecell")
	self._tableview = goutil.findChild(self.mainGO, "contentCol/tableview")
	self._tablecell = goutil.findChild(self.mainGO, "contentCol/tablecell")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "tip/txtTip")
	self._txtPageTips = MaterialMgr.findGraphicText(self.mainGO, "txtPageTips")
	self._pageScrollList = ScrollerList.create(self._pageTableview, self._pageTablecell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))
	self._taskScrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
end

function XjtaskView:onExit()
	XjtaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self._pageScrollList:dispose()
	self._taskScrollList:dispose()

	self._txtPageTips.text = ""
end

function XjtaskView:onEnter()
	XjtaskView.super.onEnter(self)

	self._activityId = XingJiangModel.instance.curActId
	self._taskPageCfg = XingJiangConfig.instance:getTaskPageCfg(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)

	self._selectPage = self._selectPage or 1

	self:_sendInfoReq()
end

function XjtaskView:_sendInfoReq()
	XingJiangController.instance:sendInfoReq(self._activityId)
end

function XjtaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function XjtaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function XjtaskView:_onUpdateUI()
	self:_updatePageScrollerList()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function XjtaskView:_onUpdatePlaneUI()
	local pageData = self._taskPageCfg[self._selectPage]

	if not string.nilorempty(pageData.pageTips) and self._txtPageTips then
		self._txtPageTips.text = pageData.pageTips
	end
end

function XjtaskView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = XingJiangConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in ipairs(queue) do
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
	end
end

function XjtaskView:_calcTaskState(taskId)
	local taskData = XingJiangConfig.instance:getTaskData(self._activityId, taskId)
	local taskInfo = XingJiangModel.instance:getTaskInfo(taskId)

	return (taskInfo or nil) and (taskInfo.prizeGained == true and 3 or checknumber(taskInfo.curProgress) >= taskData.maxProgress and 1 or 2)
end

function XjtaskView:_getTaskCurProgress(taskId)
	local taskInfo = XingJiangModel.instance:getTaskInfo(taskId)

	return (taskInfo or nil) and taskInfo.curProgress
end

function XjtaskView:_getTaskCompletionStatus(pageId)
	local list = self._taskDataQueue[pageId]
	local hasGainNum = 0

	for _, tab in ipairs(list) do
		if tab.state == 3 then
			hasGainNum = hasGainNum + 1
		end
	end

	local totalTaskNum = #list

	return hasGainNum, totalTaskNum
end

function XjtaskView:_isHaveTaskCanGain(pageId)
	local isCanGain = fasle

	for _, tab in ipairs(self._taskDataQueue[pageId]) do
		if tab.state == 1 then
			isCanGain = true

			break
		end
	end

	return isCanGain
end

function XjtaskView:_updateTaskScrollerList()
	self._taskScrollList:reloadData(self._taskDataQueue[self._selectPage])
end

function XjtaskView:_updateTaskCell(view, cell, cfg, tag)
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

	local curProgress = self:_getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	GameUtil.SetActive(txtProgress, state ~= 3)

	if txtProgress then
		txtProgress.text = string.format("<color=#20B376FF>%s</color>", curProgress) .. "/" .. checknumber(maxProgress)
	end

	if rewardItem and not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, rewardItem, urlOrGo, luaCls, isOne)
	end

	GameUtil.SetActive(btnRecieve, state == 1)
	GameUtil.SetActive(btnGoto, state == 2)
	GameUtil.SetActive(receive, state == 3)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function XjtaskView:_clearTaskCell(cell)
	local mainGo = cell
	local rewardItem = goutil.findChild(mainGo, "rewards/item")

	MaterialMgr.resetAll(rewardItem)
end

function XjtaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function XjtaskView:_onClickBtnRecieve(taskId)
	XingJiangController.instance:sendGetTaskReq(self._activityId, taskId)
end

function XjtaskView:_updatePageScrollerList()
	self._pageScrollList:reloadData(self._taskPageCfg)
end

function XjtaskView:_updatePageCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local selectGo = goutil.findChild(mainGo, "select")
	local redpoint = goutil.findChild(mainGo, "redpoint")
	local txtPageName = goutil.findChildTextComponent(mainGo, "txtPageName")

	if not string.nilorempty(data.pagePicture) and icon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = GameUrl.getItemIconUrl(data.pagePicture)

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
end

function XjtaskView:_clearPageCell(cell)
	local mainGo = cell
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

return XjtaskView
