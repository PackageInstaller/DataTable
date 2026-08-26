-- chunkname: @modules/logic/room/model/common/RoomSkinListModel.lua

module("modules.logic.room.model.common.RoomSkinListModel", package.seeall)

local RoomSkinListModel = class("RoomSkinListModel", ListScrollModel)

local function _sortSkinList(skinA, skinB)
	local skinIdA = skinA.id
	local skinIdB = skinB.id
	local priorityA = RoomConfig.instance:getRoomSkinPriority(skinIdA)
	local priorityB = RoomConfig.instance:getRoomSkinPriority(skinIdB)

	if priorityA ~= priorityB then
		return priorityB < priorityA
	end

	local rareA = RoomConfig.instance:getRoomSkinRare(skinIdA)
	local rareB = RoomConfig.instance:getRoomSkinRare(skinIdB)

	if rareA ~= rareB then
		return rareB < rareA
	end

	return skinIdA < skinIdB
end

function RoomSkinListModel:onInit()
	self:clear()
end

function RoomSkinListModel:reInit()
	return
end

function RoomSkinListModel:clear()
	self:_clearData()
	RoomSkinListModel.super.clear(self)
end

function RoomSkinListModel:_clearData()
	self:_setSelectPartId()
	self:setCurPreviewSkinId()
end

function RoomSkinListModel:_setSelectPartId(partId)
	if not partId then
		return
	end

	self._selectPartId = partId
end

function RoomSkinListModel:setRoomSkinList(partId)
	self:_setSelectPartId(partId)

	local selectPartId = self:getSelectPartId()
	local moList = {}
	local skinIdList = RoomConfig.instance:getSkinIdList(selectPartId)

	for _, skinId in ipairs(skinIdList) do
		moList[#moList + 1] = {
			id = skinId
		}
	end

	table.sort(moList, _sortSkinList)
	self:setList(moList)
end

function RoomSkinListModel:setCurPreviewSkinId(skinId)
	self._curPreviewSkinId = skinId

	if not skinId then
		return
	end

	local selectMO
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo.id == skinId then
			selectMO = mo

			break
		end
	end

	for _, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomSkinListModel:getCurPreviewSkinId()
	return self._curPreviewSkinId
end

function RoomSkinListModel:getSelectPartId()
	return self._selectPartId
end

RoomSkinListModel.instance = RoomSkinListModel.New()

return RoomSkinListModel
