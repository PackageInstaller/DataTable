-- chunkname: @modules/logic/room/controller/RoomHandBookController.lua

module("modules.logic.room.controller.RoomHandBookController", package.seeall)

local RoomHandBookController = class("RoomHandBookController", BaseController)

RoomHandBookController.instance = RoomHandBookController.New()

return RoomHandBookController
