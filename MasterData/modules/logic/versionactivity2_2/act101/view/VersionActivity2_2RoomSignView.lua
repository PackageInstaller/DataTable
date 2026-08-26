-- chunkname: @modules/logic/versionactivity2_2/act101/view/VersionActivity2_2RoomSignView.lua

module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignView", package.seeall)

local VersionActivity2_2RoomSignView = class("VersionActivity2_2RoomSignView", BaseView)

function VersionActivity2_2RoomSignView:onInitView()
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "timebg/#txt_LimitTime")
	self._goScroll = gohelper.findChild(self.viewGO, "#scroll_ItemList")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_ItemList/Viewport/Content")
	self.itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_2RoomSignView:addEvents()
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self._onRefresh, self)
end

function VersionActivity2_2RoomSignView:removeEvents()
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self._onRefresh, self)
end

function VersionActivity2_2RoomSignView:_editableInitView()
	return
end

function VersionActivity2_2RoomSignView:_onRefresh()
	self:refreshView()
end

function VersionActivity2_2RoomSignView:onUpdateParam()
	self:refreshView()
end

function VersionActivity2_2RoomSignView:onOpen()
	local parentGO = self.viewParam.parent

	self._actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)

	self.isFirstOpen = true

	self:refreshView()
	self:moveLast()
end

function VersionActivity2_2RoomSignView:refreshView()
	if self.isFirstOpen then
		self.isFirstOpen = false

		self:refreshItemListDelay()
	else
		self:refreshItemList()
	end

	self:_showDeadline()
end

function VersionActivity2_2RoomSignView:refreshItemList()
	if self.curIndex then
		return
	end

	local mo = Activity125Model.instance:getById(self._actId)
	local list = mo:getEpisodeList()
	local count = #list

	for i = 1, math.max(#self.itemList, count) do
		local item = self.itemList[i]

		if not item then
			local itemIconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._goContent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemIconGO, VersionActivity2_2RoomSignItem)
			item._index = i
			self.itemList[i] = item
		end

		item:onUpdateMO(list[i], mo)
	end
end

function VersionActivity2_2RoomSignView:refreshItemListDelay()
	self.curIndex = 0

	TaskDispatcher.cancelTask(self._refreshCurItem, self)
	TaskDispatcher.runRepeat(self._refreshCurItem, self, 0.06)
end

function VersionActivity2_2RoomSignView:_refreshCurItem()
	self.curIndex = self.curIndex + 1

	local mo = Activity125Model.instance:getById(self._actId)
	local list = mo:getEpisodeList()
	local data = list[self.curIndex]

	if data then
		self:refreshItem(self.curIndex, data, mo)
	else
		self.curIndex = nil

		TaskDispatcher.cancelTask(self._refreshCurItem, self)
	end
end

function VersionActivity2_2RoomSignView:refreshItem(index, data, mo)
	local item = self.itemList[index]

	if not item then
		local itemIconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._goContent)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(itemIconGO, VersionActivity2_2RoomSignItem)
		item._index = index
		self.itemList[index] = item
	end

	item:onUpdateMO(data, mo)
end

function VersionActivity2_2RoomSignView:moveLast()
	local mo = Activity125Model.instance:getById(self._actId)
	local list = mo:getEpisodeList()
	local index = 1

	for i, v in ipairs(list) do
		if mo:isEpisodeDayOpen(v.id) and not mo:isEpisodeFinished(v.id) then
			index = i

			break
		end
	end

	local startSpace = 0
	local maxScrollX = self:getMaxScrollX()
	local cellWidth = 476
	local cellSpaceH = 30
	local scrollPixel = math.max(0, startSpace + (index - 1) * (cellWidth + cellSpaceH))
	local posX = math.min(maxScrollX, scrollPixel)

	recthelper.setAnchorX(self._goContent.transform, -posX)
end

function VersionActivity2_2RoomSignView:getMaxScrollX()
	local viewportW = recthelper.getWidth(self._goScroll.transform)
	local mo = Activity125Model.instance:getById(self._actId)
	local list = mo:getEpisodeList()
	local count = #list
	local maxContentW = 506 * count - 12

	recthelper.setWidth(self._goContent.transform, maxContentW)

	return math.max(0, maxContentW - viewportW)
end

function VersionActivity2_2RoomSignView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function VersionActivity2_2RoomSignView:_onRefreshDeadline()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function VersionActivity2_2RoomSignView:onClose()
	return
end

function VersionActivity2_2RoomSignView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshCurItem, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self.itemList = nil
end

return VersionActivity2_2RoomSignView
