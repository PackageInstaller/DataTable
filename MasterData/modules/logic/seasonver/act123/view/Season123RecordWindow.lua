-- chunkname: @modules/logic/seasonver/act123/view/Season123RecordWindow.lua

module("modules.logic.seasonver.act123.view.Season123RecordWindow", package.seeall)

local Season123RecordWindow = class("Season123RecordWindow", BaseView)
local CAN_DISPLAY_ITEM_COUNT = 5
local ITEM_DELAY_ACTIVE_INTERVAL_TIME = 0.06
local BLOCK_TIME_EXTEND = 0.2

function Season123RecordWindow:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gobestrecorditem = gohelper.findChild(self.viewGO, "#go_bestrecorditem")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_recordlist/Viewport/Content")
	self._gorecorditem = gohelper.findChild(self.viewGO, "#scroll_recordlist/Viewport/Content/#go_recorditem")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123RecordWindow:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123RecordWindow:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season123RecordWindow:_btncloseOnClick()
	self:onClickModalMask()
end

function Season123RecordWindow:onClickModalMask()
	self:closeThis()
end

function Season123RecordWindow:_editableInitView()
	gohelper.setActive(self._gorecorditem, false)
end

function Season123RecordWindow:onOpen()
	local bestRecordDataList = Season123RecordModel.instance:getRecordList(true)

	if bestRecordDataList and #bestRecordDataList > 0 then
		local bestRecordItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobestrecorditem, Season123RecordWindowItem)

		bestRecordItem:onUpdateMO(bestRecordDataList[1])
		gohelper.setActive(self._gobestrecorditem, true)
	else
		gohelper.setActive(self._gobestrecorditem, false)
	end

	local normalRecordDataList = Season123RecordModel.instance:getRecordList(false)

	if normalRecordDataList and #normalRecordDataList > 0 then
		gohelper.setActive(self._goempty, false)
		UIBlockMgr.instance:startBlock(self.viewName .. "itemPlayAnim")
		gohelper.CreateObjList(self, self._onRecordItemLoad, normalRecordDataList, self._goContent, self._gorecorditem, Season123RecordWindowItem)

		local totalTime = CAN_DISPLAY_ITEM_COUNT * ITEM_DELAY_ACTIVE_INTERVAL_TIME + BLOCK_TIME_EXTEND

		TaskDispatcher.runDelay(self._onItemPlayAnimFinish, self, totalTime)
	else
		gohelper.setActive(self._goempty, true)
	end
end

function Season123RecordWindow:_onRecordItemLoad(cellComponent, data, index)
	if not data then
		return
	end

	local tmpIndex = index
	local isPlayOpenAnim = true

	if index > CAN_DISPLAY_ITEM_COUNT then
		tmpIndex = CAN_DISPLAY_ITEM_COUNT
		isPlayOpenAnim = false
	end

	local delayTime = tmpIndex * ITEM_DELAY_ACTIVE_INTERVAL_TIME

	if not data.isEmpty then
		cellComponent:onLoad(delayTime, isPlayOpenAnim)
	end

	cellComponent:onUpdateMO(data)
end

function Season123RecordWindow:_onItemPlayAnimFinish()
	UIBlockMgr.instance:endBlock(self.viewName .. "itemPlayAnim")
end

function Season123RecordWindow:onClose()
	TaskDispatcher.cancelTask(self._onItemPlayAnimFinish, self)
	self:_onItemPlayAnimFinish()
end

function Season123RecordWindow:onDestroyView()
	return
end

return Season123RecordWindow
