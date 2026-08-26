-- chunkname: @modules/logic/room/model/record/RoomHandBookBackListModel.lua

module("modules.logic.room.model.record.RoomHandBookBackListModel", package.seeall)

local RoomHandBookBackListModel = class("RoomHandBookBackListModel", ListScrollModel)

function RoomHandBookBackListModel:init()
	local moList = {}
	local list = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.UtmStickers)

	for index, itemMO in ipairs(list) do
		local mo = RoomHandBookBackMo.New()

		mo:init(itemMO)
		table.insert(moList, mo)
	end

	local emptymo = RoomHandBookBackMo.New()

	emptymo:setEmpty()
	table.insert(moList, emptymo)
	table.sort(moList, RoomHandBookBackListModel.sort)

	local selectId = RoomHandBookModel.instance:getSelectMoBackGroundId()

	for index, mo in ipairs(moList) do
		if selectId and selectId == mo.id then
			self._selectIndex = index

			RoomHandBookBackModel.instance:setSelectMo(mo)

			break
		elseif mo:isEmpty() then
			self._selectIndex = index

			RoomHandBookBackModel.instance:setSelectMo(mo)

			break
		end
	end

	self:setList(moList)
end

function RoomHandBookBackListModel.sort(x, y)
	local xvalue = x:checkIsUse() and 3 or x:isEmpty() and 2 or 1
	local yvalue = y:checkIsUse() and 3 or y:isEmpty() and 2 or 1

	if xvalue ~= yvalue then
		return yvalue < xvalue
	else
		return x.id < y.id
	end
end

function RoomHandBookBackListModel:getSelectIndex()
	return self._selectIndex or 1
end

RoomHandBookBackListModel.instance = RoomHandBookBackListModel.New()

return RoomHandBookBackListModel
