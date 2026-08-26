-- chunkname: @modules/logic/room/model/layout/RoomLayoutListModel.lua

module("modules.logic.room.model.layout.RoomLayoutListModel", package.seeall)

local RoomLayoutListModel = class("RoomLayoutListModel", ListScrollModel)

function RoomLayoutListModel:onInit()
	self:clear()
end

function RoomLayoutListModel:reInit()
	self:clear()
end

function RoomLayoutListModel:init()
	local list = {}
	local tRoomLayoutModel = RoomLayoutModel.instance
	local maxCount = tRoomLayoutModel:getMaxPlanCount()

	for i = 0, maxCount do
		local mo = tRoomLayoutModel:getById(i)

		if not mo then
			mo = RoomLayoutMO.New()

			mo:init(i)
			mo:setName("name_" .. i)
			mo:setEmpty(true)
		else
			mo:setEmpty(false)
		end

		table.insert(list, mo)
	end

	self:setList(list)
end

function RoomLayoutListModel:_refreshSelect()
	local selectMO = self:getById(self._selectId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomLayoutListModel:getSelectMO()
	return self:getById(self._selectId)
end

function RoomLayoutListModel:setSelect(id)
	self._selectId = id

	self:_refreshSelect()
end

function RoomLayoutListModel:refreshList()
	self:onModelUpdate()
end

function RoomLayoutListModel:initScelect(isSelectEmpty)
	local tempId = 0

	if isSelectEmpty == true then
		local listMO = self:getList()

		for i, mo in ipairs(listMO) do
			if mo:isEmpty() then
				tempId = mo.id

				break
			end
		end
	end

	self:setSelect(tempId)
end

RoomLayoutListModel.instance = RoomLayoutListModel.New()

return RoomLayoutListModel
