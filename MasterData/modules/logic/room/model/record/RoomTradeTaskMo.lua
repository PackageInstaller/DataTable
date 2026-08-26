-- chunkname: @modules/logic/room/model/record/RoomTradeTaskMo.lua

module("modules.logic.room.model.record.RoomTradeTaskMo", package.seeall)

local RoomTradeTaskMo = class("RoomTradeTaskMo")

function RoomTradeTaskMo:ctor()
	self.id = nil
	self.progress = nil
	self.hasFinish = nil
	self.new = nil
	self.finishTime = nil
	self.co = nil
end

function RoomTradeTaskMo:initMo(Info, co)
	self.id = Info.id
	self.progress = Info.progress
	self.hasFinish = Info.hasFinish
	self.new = Info.new
	self.finishTime = Info.finishTime
	self.co = co
end

function RoomTradeTaskMo:setNew(isNew)
	self.new = false
end

function RoomTradeTaskMo:isFinish()
	if self.co then
		return self.progress >= self.co.maxProgress
	end
end

function RoomTradeTaskMo:isNormalTask()
	return true
end

return RoomTradeTaskMo
