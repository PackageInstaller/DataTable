-- chunkname: @modules/logic/room/model/record/RoomHandBookBackModel.lua

module("modules.logic.room.model.record.RoomHandBookBackModel", package.seeall)

local RoomHandBookBackModel = class("RoomHandBookBackModel", BaseModel)

function RoomHandBookBackModel:onInit()
	return
end

function RoomHandBookBackModel:getSelectMo()
	return self._selectMo
end

function RoomHandBookBackModel:setSelectMo(mo)
	self._selectMo = mo
end

RoomHandBookBackModel.instance = RoomHandBookBackModel.New()

return RoomHandBookBackModel
