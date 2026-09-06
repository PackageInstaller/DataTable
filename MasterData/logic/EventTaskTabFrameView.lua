-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/EventTaskTabFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.EventTaskTabFrameView", package.seeall)

local EventTaskTabFrameView = class("EventTaskTabFrameView", ViewComponent)

function EventTaskTabFrameView:buildUI()
	EventTaskTabFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function EventTaskTabFrameView:bindEvents()
	EventTaskTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EventTaskTabFrameView:unbindEvents()
	EventTaskTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EventTaskTabFrameView:onEnter()
	EventTaskTabFrameView.super.onEnter(self)
	self:setActId()

	self._activityType = EventTaskSummaryController.instance:getActivityTypeByActivityId(self._activityId)

	if self._activityId <= 0 then
		self:close()

		return
	end

	if self._eventTaskMgr == nil then
		self._eventTaskMgr = EventTaskMgr.New()
	end

	self._eventTaskMgr:onEnter(self._activityId)

	self._curTabIdx = 1

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.PM_EventTaskTabChildExit, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_EventTaskTabUpdate, self._onUpdate, self)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function EventTaskTabFrameView:onExit()
	EventTaskTabFrameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_EventTaskTabChildExit, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_EventTaskTabUpdate, self._onUpdate, self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
	self._eventTaskMgr:onExit()
end

function EventTaskTabFrameView:destroyUI()
	self._eventTaskMgr:onDestroy()

	self._eventTaskMgr = nil
end

function EventTaskTabFrameView:setActId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		printError("活动id错误")
		self:close()

		return
	end
end

function EventTaskTabFrameView:_onSetUI()
	return
end

function EventTaskTabFrameView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EventTaskTabFrameView:_onUpdateData()
	self:_updateTabData()
end

function EventTaskTabFrameView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function EventTaskTabFrameView:_updateTabData()
	local dataList = {}
	local pageIdList = self._eventTaskMgr:getPageIdList()

	for tabIdx, pageId in ipairs(pageIdList) do
		local data = EventTaskSummaryConfig.instance:getTaskPageData(self._activityId, pageId)

		if data then
			table.insert(dataList, data)
		end
	end

	if self._curTabIdx > #dataList then
		self._curTabIdx = 1
		self._oldTabIdx = nil
	end

	self._tabDataList = dataList
end

function EventTaskTabFrameView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function EventTaskTabFrameView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.pageName

	self:_setIsCellRed(cell, data)
	UIChangeGroup:SetState(self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function EventTaskTabFrameView:_setIsCellRed(cell, data)
	local redPoint = goutil.findChild(cell, "redPoint")
	local result, tips = self._eventTaskMgr:getTryLightRedOfPage(data.pageId)

	GameUtil.SetActive(redPoint, result == GameEnum.ResultCode.Success)
end

function EventTaskTabFrameView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function EventTaskTabFrameView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function EventTaskTabFrameView:_showTabAt()
	local data = self._tabDataList[self._curTabIdx]

	if data == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == self._curTabIdx and self._oldPageId == data.pageId then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = self._curTabIdx
	self._oldPageId = data.pageId

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, self._eventTaskMgr, data.pageId, data.viewParams)
	else
		self:showTabAt(self._contentCol, data.viewName, self._eventTaskMgr, data.pageId)
	end
end

function EventTaskTabFrameView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
	self._oldPageId = nil
end

return EventTaskTabFrameView
