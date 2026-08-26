-- chunkname: @modules/logic/versionactivity1_9/enter/view/VersionActivityEnterBaseViewWithList1_9.lua

module("modules.logic.versionactivity1_9.enter.view.VersionActivityEnterBaseViewWithList1_9", package.seeall)

local VersionActivityEnterBaseViewWithList1_9 = class("VersionActivityEnterBaseViewWithList1_9", BaseView)

function VersionActivityEnterBaseViewWithList1_9:onInitView()
	self._goActivityItem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._goActivityItem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goActivityLine = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")
end

function VersionActivityEnterBaseViewWithList1_9:addEvents()
	return
end

function VersionActivityEnterBaseViewWithList1_9:removeEvents()
	return
end

function VersionActivityEnterBaseViewWithList1_9:_editableInitView()
	gohelper.setActive(self._goActivityItem1, false)
	gohelper.setActive(self._goActivityItem2, false)
	gohelper.setActive(self._goActivityLine, false)

	self.activityTabItemList = {}
	self.activityTabItemDict = {}
	self.openActIdList = {}
	self.noOpenActList = {}
	self.removeActList = {}
	self.actLevel2GoItem = self:getUserDataTb_()
	self.actLevel2GoItem[VersionActivity1_9Enum.ActLevel.First] = self._goActivityItem1
	self.actLevel2GoItem[VersionActivity1_9Enum.ActLevel.Second] = self._goActivityItem2
	self.actLevel2Cls = {
		[VersionActivity1_9Enum.ActLevel.First] = VersionActivity1_9EnterViewTabItem1,
		[VersionActivity1_9Enum.ActLevel.Second] = VersionActivity1_9EnterViewTabItem2
	}

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self)

	self.defaultTabIndex = 1
	self.curTabIndex = -1
	self.curActId = 0
end

function VersionActivityEnterBaseViewWithList1_9:onRefreshActivity(actId)
	if not self.curStoreId then
		local checkActId = self.curActId
		local status = ActivityHelper.getActivityStatus(checkActId)

		if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

			return
		end

		for _, actMo in ipairs(self.activityIdList) do
			if self:checkCanRemove(actMo) then
				self:removeActItem(actMo)
			end
		end

		for _, tabItem in ipairs(self.activityTabItemList) do
			local preActId = tabItem.actId

			if tabItem:updateActId() then
				self.activityTabItemDict[tabItem.actId] = tabItem

				if tabItem.actId and preActId then
					tabItem:refreshData()
				end
			end
		end

		self:refreshItemSiblingAndActive()
	end
end

function VersionActivityEnterBaseViewWithList1_9:onSelectActId(actId, tabItem)
	if self.curActId == actId then
		return
	end

	self.curActId = actId
	self.curStoreId = tabItem and tabItem.storeId

	local tabIndex = VersionActivityEnterHelper.getTabIndex(self.activityIdList, actId)

	self.viewContainer:selectActTab(tabIndex, self.curActId)
	ActivityEnterMgr.instance:enterActivity(self.curActId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.curActId
	})
end

function VersionActivityEnterBaseViewWithList1_9:initViewParam()
	self.actId = self.viewParam.actId
	self.skipOpenAnim = self.viewParam.skipOpenAnim
	self.activityIdList = self.viewParam.activityIdList
	self.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(self.activityIdList, self.viewParam.jumpActId)

	local actMo = self.activityIdList[self.defaultTabIndex]

	self.curActId = VersionActivityEnterHelper.getActId(actMo)
	self.curStoreId = actMo and actMo.storeId
end

function VersionActivityEnterBaseViewWithList1_9:onOpen()
	self:initViewParam()
	self:initActivityItemList()
	self:refreshUI()
end

function VersionActivityEnterBaseViewWithList1_9:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function VersionActivityEnterBaseViewWithList1_9:onDestroyView()
	for _, activityItem in ipairs(self.activityTabItemList) do
		activityItem:dispose()
	end

	self.activityTabItemList = nil
	self.activityTabItemDict = nil
end

function VersionActivityEnterBaseViewWithList1_9:initActivityItemList()
	for i, actMo in ipairs(self.activityIdList) do
		if not self:checkCanRemove(actMo) then
			local actId = VersionActivityEnterHelper.getActId(actMo)
			local goItem = self.actLevel2GoItem[actMo.actLevel]
			local cls = self.actLevel2Cls[actMo.actLevel]
			local activityItemGo = gohelper.cloneInPlace(goItem, actId)
			local tabItem = cls.New()

			tabItem:init(i, actMo, activityItemGo)
			tabItem:refreshSelect(self.curActId)

			local customClickHandle = self["onClickActivity" .. actId]

			if customClickHandle then
				tabItem:overrideOnClickHandle(customClickHandle, self)
			end

			table.insert(self.activityTabItemList, tabItem)

			self.activityTabItemDict[actId] = tabItem
		end
	end
end

function VersionActivityEnterBaseViewWithList1_9:refreshUI()
	for _, tabItem in ipairs(self.activityTabItemList) do
		tabItem:refreshUI()
	end

	self:refreshItemSiblingAndActive()
end

function VersionActivityEnterBaseViewWithList1_9:refreshItemSiblingAndActive()
	tabletool.clear(self.openActIdList)
	tabletool.clear(self.noOpenActList)

	for _, tabItem in ipairs(self.activityTabItemList) do
		local status = ActivityHelper.getActivityStatus(tabItem.actId)

		if status == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(self.noOpenActList, tabItem.actId)
		else
			table.insert(self.openActIdList, tabItem.actId)
		end
	end

	table.sort(self.openActIdList, self.openActItemSortFunc)

	for index, actId in ipairs(self.openActIdList) do
		local activityItem = self.activityTabItemDict[actId]

		gohelper.setSibling(activityItem.rootGo, index)
	end

	if #self.noOpenActList < 1 then
		gohelper.setActive(self._goActivityLine, false)

		return
	end

	gohelper.setActive(self._goActivityLine, true)

	local activeActLen = #self.openActIdList

	gohelper.setSibling(self._goActivityLine, activeActLen + 1)
	table.sort(self.noOpenActList, self.noOpenActItemSortFunc)

	for index, actId in ipairs(self.noOpenActList) do
		local activityItem = self.activityTabItemDict[actId]

		gohelper.setSibling(activityItem.rootGo, activeActLen + 1 + index)
	end
end

function VersionActivityEnterBaseViewWithList1_9:removeActItem(actMo)
	for i = #self.activityTabItemList, 1, -1 do
		local tabItem = self.activityTabItemList[i]

		if VersionActivityEnterHelper.checkIsSameAct(actMo, tabItem.actId) then
			table.remove(self.activityTabItemList, i)

			self.activityTabItemDict[tabItem.actId] = nil

			local rootGo = tabItem.rootGo

			tabItem:dispose()
			gohelper.destroy(rootGo)
		end
	end
end

function VersionActivityEnterBaseViewWithList1_9:checkCanRemove(actMo)
	if actMo.actType == VersionActivity1_9Enum.ActType.Single then
		local status = actMo.storeId and ActivityHelper.getActivityStatus(actMo.storeId) or ActivityHelper.getActivityStatus(actMo.actId)

		return status == ActivityEnum.ActivityStatus.Expired or status == ActivityEnum.ActivityStatus.NotOnLine
	end

	for _, v in ipairs(actMo.actId) do
		local status = ActivityHelper.getActivityStatus(v)

		if status ~= ActivityEnum.ActivityStatus.Expired and status ~= ActivityEnum.ActivityStatus.NotOnLine then
			return false
		end
	end

	return true
end

function VersionActivityEnterBaseViewWithList1_9.openActItemSortFunc(actId1, actId2)
	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)
	local displayOrder1 = act1Info.config.displayPriority
	local displayOrder2 = act2Info.config.displayPriority

	if displayOrder1 ~= displayOrder2 then
		return displayOrder1 < displayOrder2
	end

	local act1OpenTime = act1Info:getRealStartTimeStamp()
	local act2OpenTime = act2Info:getRealStartTimeStamp()

	if act1OpenTime ~= act2OpenTime then
		return act2OpenTime < act1OpenTime
	end

	return actId1 < actId2
end

function VersionActivityEnterBaseViewWithList1_9.noOpenActItemSortFunc(actId1, actId2)
	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)
	local act1OpenTime = act1Info:getRealStartTimeStamp()
	local act2OpenTime = act2Info:getRealStartTimeStamp()

	if act1OpenTime ~= act2OpenTime then
		return act1OpenTime < act2OpenTime
	end

	local displayOrder1 = act1Info.config.displayPriority
	local displayOrder2 = act2Info.config.displayPriority

	if displayOrder1 ~= displayOrder2 then
		return displayOrder1 < displayOrder2
	end

	return actId1 < actId2
end

return VersionActivityEnterBaseViewWithList1_9
