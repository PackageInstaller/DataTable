-- chunkname: @modules/logic/room/model/map/path/RoomMapPathPlanModel.lua

module("modules.logic.room.model.map.path.RoomMapPathPlanModel", package.seeall)

local RoomMapPathPlanModel = class("RoomMapPathPlanModel", BaseModel)

function RoomMapPathPlanModel:onInit()
	self:_clearData()
end

function RoomMapPathPlanModel:reInit()
	self:_clearData()
end

function RoomMapPathPlanModel:clear()
	RoomMapPathPlanModel.super.clear(self)
	self:_clearData()
end

function RoomMapPathPlanModel:_clearData()
	return
end

function RoomMapPathPlanModel:init()
	self:clear()
end

function RoomMapPathPlanModel:initPath()
	local resIds = {}
	local vehicleCfgList = RoomConfig.instance:getVehicleConfigList()

	for _, cfg in ipairs(vehicleCfgList) do
		table.insert(resIds, cfg.resId)
	end

	local resAreaMOMap = RoomResourceHelper.getResourcePointAreaMODict(nil, resIds)
	local moList = {}

	for resourceId, areaMO in pairs(resAreaMOMap) do
		local tempAreaList = areaMO:findeArea()

		for index, area in ipairs(tempAreaList) do
			local id = resourceId * 1000 + index
			local mo = RoomMapPathPlanMO.New()

			mo:init(id, resourceId, area)
			table.insert(moList, mo)
		end
	end

	self:setList(moList)
end

function RoomMapPathPlanModel:getPlanMOByXY(x, y, resId)
	local list = self:getList()

	for i = 1, #list do
		local planMO = list[i]

		if planMO.resourceId == resId and planMO:getNodeByXY(x, y) then
			return planMO
		end
	end
end

RoomMapPathPlanModel.instance = RoomMapPathPlanModel.New()

return RoomMapPathPlanModel
