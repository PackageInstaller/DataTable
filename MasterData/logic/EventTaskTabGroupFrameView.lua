-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/EventTaskTabGroupFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.EventTaskTabGroupFrameView", package.seeall)

local EventTaskTabGroupFrameView = class("EventTaskTabGroupFrameView", EventTaskTabFrameView)

function EventTaskTabGroupFrameView:bindEvents()
	EventTaskTabGroupFrameView.super.bindEvents(self)

	self._groupCol = self:getGo("groupCol")

	local groupScrollerview = self:getGo("groupCol/groupScrollerview")
	local groupScrollercell = self:getGo("groupCol/groupScrollercell")

	self._groupScrollList = ScrollerList.create(groupScrollerview, groupScrollercell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
end

function EventTaskTabGroupFrameView:buildUI()
	EventTaskTabGroupFrameView.super.buildUI(self)
end

function EventTaskTabGroupFrameView:onExit()
	EventTaskTabGroupFrameView.super.onExit(self)

	self._groupId = 1
end

function EventTaskTabGroupFrameView:onEnter()
	EventTaskTabGroupFrameView.super.onEnter(self)

	self._groupId = 1
end

function EventTaskTabGroupFrameView:_updateTabScrollerList()
	local groupData = {}
	local pageIdList = self._eventTaskMgr:getPageIdList()
	local data = self._tabDataList[self._curTabIdx]

	if not data then
		printError("config from export_任务页签  in  yh运营-活动任务.xlsx 没有配置")
		self._tabScrollList:reloadData(self._tabDataList)

		return
	end

	if not data.groupId then
		local groupIds = {}
		local tabNames = string.split(data.groupName, "#")

		if #groupIds > 1 then
			GameUtil.SetActive(self._groupCol, true)
			self._groupScrollList:reloadData(tabNames)

			for _, data in ipairs(self._tabDataList) do
				if data.groupId == self._groupId then
					table.insert(groupData, data)
				end
			end
		else
			GameUtil.SetActive(self._groupCol, false)

			self._groupId = 0
		end

		self._tabScrollList:reloadData(self._tabDataList)
	end
end

function EventTaskTabGroupFrameView:_setIsCellRed(cell, data)
	local redPoint = goutil.findChild(cell, "redPoint")
	local result = self._eventTaskMgr:getIsRedOfPageAndGroup(data.pageId, self._groupId)

	GameUtil.SetActive(redPoint, result)
end

function EventTaskTabGroupFrameView:_updateGroupCell(view, cell, info)
	local btn = cell.gameObject
	local redpoint = goutil.findChild(cell, "redpoint")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local UIChangeGroup = cell:GetComponent(typeof(UIChangeGroup))

	txtName.text = info

	UIChangeGroup:SetState(self._groupId == cell.data and 1 or 0)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickGroup, self, cell.data))

	local isLightRed = self._eventTaskMgr:getIsRedOfGroup(cell.data)

	GameUtil.SetActive(redpoint, isLightRed)
end

function EventTaskTabGroupFrameView:_clearGroupCell(cell)
	local btn = cell.gameObject

	GameUtil.rmClickHandler(btn)
end

function EventTaskTabGroupFrameView:_showTabAt()
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

	if checknumber(self._groupId) <= 0 then
		self._groupId = 1
	end

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, self._eventTaskMgr, data.pageId, self._groupId, data.viewParams)
	else
		self:showTabAt(self._contentCol, data.viewName, self._eventTaskMgr, data.pageId, self._groupId)
	end
end

function EventTaskTabGroupFrameView:_onClickTab(data, idx)
	self._groupId = 1
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function EventTaskTabGroupFrameView:_onClickGroup(idx)
	if self._groupId ~= idx then
		self._groupId = idx

		GlobalDispatcher:dispatch(GlobalNotify.PM_EventTaskGroupUpdate, self._groupId)
		self:_updateTabScrollerList()
	end
end

return EventTaskTabGroupFrameView
