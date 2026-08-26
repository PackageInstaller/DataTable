-- chunkname: @modules/logic/room/model/common/RoomReportTypeListModel.lua

module("modules.logic.room.model.common.RoomReportTypeListModel", package.seeall)

local RoomReportTypeListModel = class("RoomReportTypeListModel", ListScrollModel)

function RoomReportTypeListModel.sortFunc(a, b)
	return a.id < b.id
end

function RoomReportTypeListModel:initType(reportTypeList)
	table.sort(reportTypeList, self.sortFunc)
	self:setList(reportTypeList)
end

function RoomReportTypeListModel:setSelectId(selectId)
	if self.selectId == selectId then
		return
	end

	self._selectId = selectId

	self:_refreshSelect()
end

function RoomReportTypeListModel:isSelect(id)
	return self._selectId == id
end

function RoomReportTypeListModel:getSelectId()
	return self._selectId
end

function RoomReportTypeListModel:clearSelect()
	self._selectId = nil
end

function RoomReportTypeListModel:_refreshSelect()
	local selectMO = self:getById(self._selectId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

RoomReportTypeListModel.instance = RoomReportTypeListModel.New()

return RoomReportTypeListModel
