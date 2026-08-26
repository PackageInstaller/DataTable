-- chunkname: @modules/logic/room/controller/RoomVehicleController.lua

module("modules.logic.room.controller.RoomVehicleController", package.seeall)

local RoomVehicleController = class("RoomVehicleController", BaseController)

function RoomVehicleController:onInit()
	self:clear()
end

function RoomVehicleController:reInit()
	self:clear()
end

function RoomVehicleController:clear()
	RoomMapVehicleModel.instance:clear()
	RoomMapPathPlanModel.instance:clear()
end

function RoomVehicleController:init()
	RoomMapPathPlanModel.instance:initPath()
	RoomMapVehicleModel.instance:initVehicle()
end

function RoomVehicleController:addConstEvents()
	return
end

RoomVehicleController.instance = RoomVehicleController.New()

return RoomVehicleController
