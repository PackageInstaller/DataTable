-- chunkname: @modules/logic/room/define/RoomRecordEnum.lua

module("modules.logic.room.define.RoomRecordEnum", package.seeall)

local RoomRecordEnum = _M

RoomRecordEnum.View = {
	HandBook = 3,
	Task = 1,
	Log = 2
}
RoomRecordEnum.LogType = {
	Normal = 2,
	Custom = 3,
	Time = 4,
	Speical = 1
}
RoomRecordEnum.Dir = {
	Left = 1,
	Right = 2
}
RoomRecordEnum.Relation = {
	Close = 1,
	Both = 3,
	Estrange = 2
}
RoomRecordEnum.AnimName = {
	Log2Task = "2to1",
	HandBook2Log = "3to2",
	HandBook2Task = "3to1",
	Task2Log = "1to2",
	Log2HandBook = "2to3",
	Task2HandBook = "1to3"
}
RoomRecordEnum.AnimTime = 0.16

return RoomRecordEnum
