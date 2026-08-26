-- chunkname: @modules/logic/room/model/layout/RoomLayoutBgResListModel.lua

module("modules.logic.room.model.layout.RoomLayoutBgResListModel", package.seeall)

local RoomLayoutBgResListModel = class("RoomLayoutBgResListModel", ListScrollModel)

function RoomLayoutBgResListModel:onInit()
	self:clear()
end

function RoomLayoutBgResListModel:reInit()
	self:clear()
end

function RoomLayoutBgResListModel:init(coverId)
	local list = {}
	local coverCfgList = RoomConfig.instance:getPlanCoverConfigList()

	for i = 1, #coverCfgList do
		local mo = RoomLayoutBgResMO.New()
		local cfg = coverCfgList[i]

		mo:init(cfg.id, cfg)

		if cfg.id == coverId then
			table.insert(list, 1, mo)
		else
			table.insert(list, mo)
		end
	end

	self._selectId = nil

	self:setList(list)
end

function RoomLayoutBgResListModel:_refreshSelect()
	local selectMO = self:getById(self._selectId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomLayoutBgResListModel:getSelectMO()
	return self:getById(self._selectId)
end

function RoomLayoutBgResListModel:setSelect(id)
	self._selectId = id

	self:_refreshSelect()
end

RoomLayoutBgResListModel.instance = RoomLayoutBgResListModel.New()

return RoomLayoutBgResListModel
