-- chunkname: @modules/versionactivitybase/enterview/view/new/VersionActivityEnterBaseViewWithListNew.lua

module("modules.versionactivitybase.enterview.view.new.VersionActivityEnterBaseViewWithListNew", package.seeall)

local VersionActivityEnterBaseViewWithListNew = class("VersionActivityEnterBaseViewWithListNew", BaseView)

function VersionActivityEnterBaseViewWithListNew:onInitView()
	self.tabLevelSetting = {}
	self.activityTabItemList = {}
	self.activityTabItemDict = {}
	self.openActIdList = {}
	self.noOpenActList = {}
	self.curActId = 0
	self.defaultTabIndex = 1

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityEnterBaseViewWithListNew:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.DragOpenAct, self.onDragOpenAct, self)
	self:childAddEvents()
end

function VersionActivityEnterBaseViewWithListNew:removeEvents()
	self:childRemoveEvents()
end

function VersionActivityEnterBaseViewWithListNew:onRefreshActivity(actId)
	if not self.curStoreId then
		local checkActId = self.curActId
		local status = ActivityHelper.getActivityStatus(checkActId)

		if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

			return
		end

		for _, actSetting in ipairs(self.activitySettingList) do
			local isShowActTab = not VersionActivityEnterHelper.isActTabCanRemove(actSetting)
			local tabItem = self.activityTabItemDict[actSetting.actId]

			if tabItem then
				gohelper.setActive(tabItem.go, isShowActTab)
			end
		end

		for _, tabItem in ipairs(self.activityTabItemList) do
			if tabItem:updateActId() and tabItem.go.activeSelf then
				self.activityTabItemDict[tabItem.actId] = tabItem
			end
		end

		self:sortTabItemList()
	end
end

function VersionActivityEnterBaseViewWithListNew:onSelectActId(actId, tabItem)
	if self.curActId == actId or not tabItem.go.activeSelf then
		return
	end

	self.curActId = actId
	self.curStoreId = tabItem and tabItem.storeId

	local tabIndex = VersionActivityEnterHelper.getTabIndex(self.activitySettingList, actId)

	self.viewContainer:selectActTab(tabIndex, self.curActId)
	ActivityEnterMgr.instance:enterActivity(self.curActId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.curActId
	})
	self:refreshBtnVisible()
end

function VersionActivityEnterBaseViewWithListNew:onDragOpenAct(moveLeft)
	local selectSiblingIndex

	for i, v in ipairs(self.activityTabItemList) do
		if v.isSelect then
			selectSiblingIndex = gohelper.getSibling(v.go)

			break
		end
	end

	if not selectSiblingIndex then
		return
	end

	local nextIndex, nextItem

	for i, v in ipairs(self.activityTabItemList) do
		if not v.isSelect then
			local siblingIndex = gohelper.getSibling(v.go)

			if moveLeft then
				if selectSiblingIndex < siblingIndex and (not nextIndex or siblingIndex < nextIndex) then
					nextIndex = siblingIndex
					nextItem = v
				end
			elseif siblingIndex < selectSiblingIndex and (not nextIndex or nextIndex < siblingIndex) then
				nextIndex = siblingIndex
				nextItem = v
			end
		end
	end

	if nextItem then
		nextItem:onClick()
		self:moveContent(nextItem)
	end
end

function VersionActivityEnterBaseViewWithListNew:moveContent(nextItem)
	return
end

function VersionActivityEnterBaseViewWithListNew:removeActItem(actSetting)
	for i = #self.activityTabItemList, 1, -1 do
		local tabItem = self.activityTabItemList[i]

		if VersionActivityEnterHelper.checkIsSameAct(actSetting, tabItem.actId) then
			table.remove(self.activityTabItemList, i)

			self.activityTabItemDict[tabItem.actId] = nil

			local go = tabItem.go

			tabItem:dispose()
			gohelper.destroy(go)
		end
	end
end

function VersionActivityEnterBaseViewWithListNew:childAddEvents()
	logError("override VersionActivityEnterBaseViewWithListNew:childAddEvents")
end

function VersionActivityEnterBaseViewWithListNew:childRemoveEvents()
	logError("override VersionActivityEnterBaseViewWithListNew:childRemoveEvents")
end

function VersionActivityEnterBaseViewWithListNew:playVideo()
	return
end

function VersionActivityEnterBaseViewWithListNew:refreshRedDot()
	return
end

function VersionActivityEnterBaseViewWithListNew:refreshBtnVisible(isOnOpen)
	logError("override VersionActivityEnterBaseViewWithListNew:refreshBtnVisible")
end

function VersionActivityEnterBaseViewWithListNew:onUpdateParam()
	self:initViewParam()
	self:refreshUI()

	local item = self.activityTabItemDict[self.curActId]

	if item then
		self.curActId = nil

		item:onClick()
	end
end

function VersionActivityEnterBaseViewWithListNew:onOpen()
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local go = tabSetting.go

		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goActivityLine, false)
	self:initViewParam()
	self:createActivityTabItem()
	self:playVideo()
	self:refreshUI()
	self:refreshRedDot()
	self:refreshBtnVisible(true)
end

function VersionActivityEnterBaseViewWithListNew:initViewParam()
	self.actId = self.viewParam.actId
	self.skipOpenAnim = self.viewParam.skipOpenAnim
	self.activitySettingList = self.viewParam.activitySettingList
	self.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(self.activitySettingList, self.viewParam.jumpActId)

	local actSetting = self.activitySettingList[self.defaultTabIndex]

	self.curActId = VersionActivityEnterHelper.getActId(actSetting)
	self.curStoreId = actSetting and actSetting.storeId
end

function VersionActivityEnterBaseViewWithListNew:setTabLevelSetting(itemLevel, goItem, itemCls)
	if gohelper.isNil(goItem) or not itemLevel or not itemCls then
		return
	end

	self.tabLevelSetting = self.tabLevelSetting or {}
	self.tabLevelSetting[itemLevel] = self:getUserDataTb_()
	self.tabLevelSetting[itemLevel].go = goItem
	self.tabLevelSetting[itemLevel].cls = itemCls
end

function VersionActivityEnterBaseViewWithListNew:setActivityLineGo(goLine)
	if gohelper.isNil(goLine) then
		return
	end

	self._goActivityLine = goLine
end

function VersionActivityEnterBaseViewWithListNew:getItemGoAndCls(level)
	if not level then
		logError("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, level is nil")

		return
	end

	if self.tabLevelSetting then
		local tabSetting = self.tabLevelSetting[level]

		if not tabSetting then
			logError(string.format("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, no tabSetting, level:%s", level))

			return
		end

		return tabSetting.go, tabSetting.cls
	end
end

function VersionActivityEnterBaseViewWithListNew:createActivityTabItem()
	for i, actSetting in ipairs(self.activitySettingList) do
		local isShowActTab = not VersionActivityEnterHelper.isActTabCanRemove(actSetting)

		if isShowActTab then
			local actId = VersionActivityEnterHelper.getActId(actSetting)
			local goTab, cls = self:getItemGoAndCls(actSetting.actLevel)

			if goTab and cls then
				local newTabGo = gohelper.cloneInPlace(goTab, actId)
				local tabItem = MonoHelper.addNoUpdateLuaComOnceToGo(newTabGo, cls)

				tabItem:setData(i, actSetting)
				tabItem:refreshSelect(self.curActId)

				local customClick = self["onClickActivity" .. actId]

				if customClick then
					tabItem:setClickFunc(customClick, self)
				end

				self.activityTabItemDict[actId] = tabItem

				table.insert(self.activityTabItemList, tabItem)
			end
		end
	end
end

function VersionActivityEnterBaseViewWithListNew:refreshUI()
	self:sortTabItemList()

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem.go.activeSelf then
			tabItem:refreshUI()
		end
	end
end

local function openActSortFunc(actId1, actId2)
	local act1Info = ActivityModel.instance:getActMO(actId1)
	local act2Info = ActivityModel.instance:getActMO(actId2)

	if act1Info then
		if not act1Info.config.displayPriority then
			local displayOrder1 = 0

			if act2Info then
				if not act2Info.config.displayPriority then
					local displayOrder2 = 0

					if displayOrder1 ~= displayOrder2 then
						return displayOrder1 < displayOrder2
					end

					local act1OpenTime = act1Info and act1Info:getRealStartTimeStamp() or 0
					local act2OpenTime = act2Info and act2Info:getRealStartTimeStamp() or 0

					if act1OpenTime ~= act2OpenTime then
						return act2OpenTime < act1OpenTime
					end

					return actId1 < actId2
				end
			end
		end
	end
end

local function noOpenActSortFunc(actId1, actId2)
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

function VersionActivityEnterBaseViewWithListNew:sortTabItemList()
	tabletool.clear(self.openActIdList)
	tabletool.clear(self.noOpenActList)

	for _, tabItem in ipairs(self.activityTabItemList) do
		if tabItem.go.activeSelf then
			local status = ActivityHelper.getActivityStatus(tabItem.actId)

			if status == ActivityEnum.ActivityStatus.NotOpen then
				table.insert(self.noOpenActList, tabItem.actId)
			else
				table.insert(self.openActIdList, tabItem.actId)
			end
		end
	end

	table.sort(self.openActIdList, openActSortFunc)

	for index, actId in ipairs(self.openActIdList) do
		local activityItem = self.activityTabItemDict[actId]

		gohelper.setSibling(activityItem.go, index)
	end

	if #self.noOpenActList < 1 then
		gohelper.setActive(self._goActivityLine, false)

		return
	end

	gohelper.setActive(self._goActivityLine, true)

	local activeActLen = #self.openActIdList

	gohelper.setSibling(self._goActivityLine, activeActLen + 1)
	table.sort(self.noOpenActList, noOpenActSortFunc)

	for index, actId in ipairs(self.noOpenActList) do
		local activityItem = self.activityTabItemDict[actId]

		gohelper.setSibling(activityItem.go, activeActLen + 1 + index)
	end
end

function VersionActivityEnterBaseViewWithListNew:onDestroyView()
	for _, activityItem in ipairs(self.activityTabItemList) do
		activityItem:dispose()
	end

	self.activityTabItemList = nil
	self.activityTabItemDict = nil
end

return VersionActivityEnterBaseViewWithListNew
