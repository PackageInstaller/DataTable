-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordEntryView.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordEntryView", package.seeall)

local M = class("HandbookRecordEntryView", ViewComponent)

M.SubToggleType = {
	Transcendency = 3,
	World = 2,
	Event = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.Record
end

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnEvent = self:getBtn("handbook_record_entry_view_210071424")
	self._btnEntries = self:getBtn("handbook_record_entry_view_-80765116")
	self._btnTranscendency = self:getBtn("handbook_record_entry_view_-1099582142")
	self._entryComp = {}
	self._entryComp[self.SubToggleType.Event] = {
		objNew = self:getGo("handbook_record_entry_view_1023172487"),
		objLock = self:getGo("handbook_record_entry_view_-668985559"),
		txtLockCondition = self:getText("handbook_record_entry_view_-1088513871")
	}
	self._entryComp[self.SubToggleType.World] = {
		objNew = self:getGo("handbook_record_entry_view_2096481857"),
		objLock = self:getGo("handbook_record_entry_view_-1544155182"),
		txtLockCondition = self:getText("handbook_record_entry_view_1200462826")
	}
	self._entryComp[self.SubToggleType.Transcendency] = {
		objNew = self:getGo("handbook_record_entry_view_-678939127"),
		objLock = self:getGo("handbook_record_entry_view_-742230960"),
		txtLockCondition = self:getText("handbook_record_entry_view_-198595954")
	}
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnEvent = nil
	self._btnEntries = nil
	self._btnTranscendency = nil
	self._entryComp = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnEvent:AddClickListener(self._onClickEvent, self)
	self._btnEntries:AddClickListener(self._onClickEntries, self)
	self._btnTranscendency:AddClickListener(self._onClickTranscendency, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnEvent:RemoveClickListener()
	self._btnEntries:RemoveClickListener()
	self._btnTranscendency:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)

	self._lockState = {}

	self:refreshLock()
	self:refreshNewTag()
end

function M:onExit()
	self:_setEvent(false)

	self._lockState = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	end
end

function M:_handleHandbookUnreadInfoChange(e)
	self:refreshNewTag()
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickEvent()
	if self:_getIsLock(self.SubToggleType.Event) then
		return
	end

	ViewMgr.instance:open(ViewName.HandbookRecordEventView)
end

function M:_onClickEntries()
	if self:_getIsLock(self.SubToggleType.World) then
		return
	end

	ViewMgr.instance:open(ViewName.HandbookRecordEntriesView)
end

function M:_onClickTranscendency()
	if self:_getIsLock(self.SubToggleType.Transcendency) then
		return
	end

	ViewMgr.instance:open(ViewName.HandbookRecordTranscendencyView)
end

function M:refreshLock()
	for typVal, compGroup in pairs(self._entryComp) do
		local lock = self:_getIsLock(typVal)

		goutil.setActive(compGroup.objLock, lock)
	end
end

function M:refreshNewTag()
	for typVal, compGroup in pairs(self._entryComp) do
		local hasNew = self:_getIsNew(typVal)

		goutil.setActive(compGroup.objNew, hasNew)
	end
end

function M:_getIsLock(subToggleTyp)
	if not self._lockState[subToggleTyp] then
		self._lockState[subToggleTyp] = false

		if subToggleTyp == self.SubToggleType.Event then
			-- block empty
		elseif subToggleTyp == self.SubToggleType.World then
			-- block empty
		elseif subToggleTyp == self.SubToggleType.Transcendency then
			-- block empty
		end
	end

	return self._lockState[subToggleTyp]
end

function M:_getIsNew(subToggleTyp)
	if subToggleTyp == self.SubToggleType.World then
		return GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Word) > 0
	else
		local count = 0
		local ids = subToggleTyp == self.SubToggleType.Event and HandbookConfig.instance:getRecordIdsEvent() or HandbookConfig.instance:getRecordIdsTranscendency()
		local unReadIdMap = GalleryModel.instance:getTypUnReadNewIds(GameEnum.UnlockTypeEnum.Event)

		for _, id in ipairs(ids or {}) do
			count = unReadIdMap[id] and count + 1 or count
		end

		return count > 0
	end
end

return M
