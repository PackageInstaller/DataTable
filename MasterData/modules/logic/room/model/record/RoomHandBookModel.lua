-- chunkname: @modules/logic/room/model/record/RoomHandBookModel.lua

module("modules.logic.room.model.record.RoomHandBookModel", package.seeall)

local RoomHandBookModel = class("RoomHandBookModel", BaseModel)

function RoomHandBookModel:onInit()
	self._moList = nil
	self._selectMo = nil
	self._isreverse = false
end

function RoomHandBookModel:getSelectMo()
	return self._selectMo
end

function RoomHandBookModel:setSelectMo(mo)
	self._selectMo = mo
end

function RoomHandBookModel:checkCritterShowMutateBtn(id)
	return
end

function RoomHandBookModel:checkCritterRelationShip()
	return
end

function RoomHandBookModel:onGetInfo(msg)
	self._moList = msg.bookInfos
	self._moDict = {}

	for index, handbookInfo in ipairs(self._moList) do
		self._moDict[handbookInfo.id] = handbookInfo
	end
end

function RoomHandBookModel:getMoById(id)
	return self._moDict and self._moDict[id]
end

function RoomHandBookModel:getCount()
	return (self._moList or nil) and (#self._moList or 0)
end

function RoomHandBookModel:setScrollReverse()
	self._isreverse = not self._isreverse

	RoomHandBookListModel.instance:reverseCardBack(self._isreverse)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.reverseIcon)
end

function RoomHandBookModel:getReverse()
	return self._isreverse
end

function RoomHandBookModel:getSelectMoBackGroundId()
	if self._selectMo and self._selectMo:getBackGroundId() then
		return self._selectMo:getBackGroundId()
	end
end

function RoomHandBookModel:setBackGroundId(info)
	local backgroundId = info.backgroundId

	if self._selectMo then
		self._selectMo:setBackGroundId(backgroundId)
	end
end

RoomHandBookModel.instance = RoomHandBookModel.New()

return RoomHandBookModel
