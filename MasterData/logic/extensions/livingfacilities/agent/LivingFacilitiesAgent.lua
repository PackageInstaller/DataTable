-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/agent/LivingFacilitiesAgent.lua

module("logic.extensions.livingfacilities.agent.LivingFacilitiesAgent", package.seeall)

local M = class("LivingFacilitiesAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetHouseInfoRequest()
	local msg = HouseExtension_pb.GetHouseInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetHouseInfoReply(status, msg)
	if status == 0 then
		local unlockZones = msg.unlockZones
		local activeLiveZones = msg.activeLiveZones

		LivingFacilitiesZoneController.instance:refreshByAgent(unlockZones, activeLiveZones)
		LivingFacilitiesZoneController.instance:refreshAtmospheres(msg.atmospheres)
		HouseTaskController.instance:getHouseInfoReply(msg)
		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_UNLOCK_INFO_REFRESH, unlockZones)
	end
end

function M:sendActiveZoneRequest(zoneId)
	local msg = HouseExtension_pb.ActiveZoneRequest()

	msg.zoneId = zoneId

	self:sendMsg(msg)
end

function M:handleActiveZoneReply(status, msg)
	if status == 0 then
		local zoneId = msg.zoneId
		local cfgZone = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

		if cfgZone and cfgZone.roomType == HouseEnum.RoomType.Living then
			LivingFacilitiesZoneController.instance:refreshActiveStatusByZoneId(zoneId)
			LivingFacilitiesZoneController.instance:setCurrentZoneId(zoneId)
		end

		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_ZONE_ACTIVE, zoneId)
	end
end

function M:sendGetLiveZoneInfoRequest(zoneId)
	local msg = HouseExtension_pb.GetLiveZoneInfoRequest()

	msg.zoneId = zoneId

	self:sendMsg(msg)
end

function M:handleGetLiveZoneInfoReply(status, msg)
	if status == 0 then
		local zoneInfo = msg.zoneInfo

		LivingFacilitiesZoneController.instance:refreshAgentDataByZoneId(zoneInfo.zoneId, zoneInfo)
		LivingFacilitiesZoneController.instance:getTempleListByType(zoneInfo.type)
	end
end

function M:sendSetZoneNameRequest(zoneId, name)
	local msg = HouseExtension_pb.SetZoneNameRequest()

	msg.zoneId = zoneId
	msg.name = name

	self:sendMsg(msg)
end

function M:handleSetZoneNameReply(status, msg)
	if status == 0 then
		local zoneId = msg.zoneId
		local name = msg.name
		local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(zoneId)

		zoneMo:setName(name)
	end
end

function M:sendSetScheduleRequest(hero, schedule)
	local msg = HouseExtension_pb.SetScheduleRequest()

	msg.hero = hero

	for k, v in ipairs(schedule) do
		table.insert(msg.schedule, v)
	end

	self:sendMsg(msg)
end

function M:handleSetScheduleReply(status, msg)
	if status == 0 then
		local hero = msg.hero
		local schedule = msg.schedule

		HouseWorkerModel.instance:updateScheduleByHeroScheduleChange(hero, schedule)
		GlobalDispatcher:dispatchEvent(EventType.ChangeHouseWorkerSucceed)
	end
end

function M:sendSetRestScheduleRequest(job, index, schedule)
	local msg = HouseExtension_pb.SetRestScheduleRequest()

	msg.job = job
	msg.index = index

	for k, v in ipairs(schedule) do
		table.insert(msg.schedule, v)
	end

	self:sendMsg(msg)
end

function M:handleSetRestScheduleReply(status, msg)
	if status == 0 then
		HouseWorkerModel.instance:updateScheduleByWorkerScheduleChange(msg.job, msg.index, msg.schedule)
		GlobalDispatcher:dispatchEvent(EventType.ChangeHouseWorkerSucceed)
	end
end

function M:sendChangeZoneTypeRequest(zoneId, type)
	local msg = HouseExtension_pb.ChangeZoneTypeRequest()

	msg.zoneId = zoneId
	msg.type = type

	self:sendMsg(msg)
end

function M:handleChangeZoneTypeReply(status, msg)
	if status == 0 then
		local zoneInfo = msg.zoneInfo

		LivingFacilitiesZoneController.instance:refreshAgentDataByZoneId(zoneInfo.zoneId, zoneInfo)
		LivingFacilitiesZoneController.instance:refreshAtmospheres(msg.atmospheres)
	end
end

function M:sendSetBunkRequest(bunkInfoList)
	local msg = HouseExtension_pb.SetBunkRequest()

	for i = 1, #bunkInfoList do
		local bunkInfo = bunkInfoList[i]
		local bunkNO = HouseExtension_pb.BunkInfo()

		bunkNO.furniture = bunkInfo.furnitureUUId
		bunkNO.index = bunkInfo.index
		bunkNO.hero = bunkInfo.heroId

		table.insert(msg.bunks, bunkNO)
	end

	self:sendMsg(msg)
end

function M:handleSetBunkReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendAddGoodsStoreRequest()
	local msg = HouseExtension_pb.AddGoodsStoreRequest()

	self:sendMsg(msg)
end

function M:handleAddGoodsStoreReply(status, msg)
	if status == 0 then
		RoomBackpackModel.instance:setGoodsStore(msg.store)
	end
end

function M:handleSpRoomStoreAddPush(status, msg)
	if status == 0 then
		for _, NO in ipairs(msg.spRoomProducts or {}) do
			local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(NO.zoneId)

			zoneMo:updateProductByAgent(NO, true)
		end

		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_PRODUCT_UPDATE)
	end
end

function M:sendReceiveSpRoomStoreRequest(zoneId)
	local req = HouseExtension_pb.ReceiveSpRoomStoreRequest()

	req.zoneId = zoneId
	self._cacheZoneId = zoneId

	self:sendMsg(req)
end

function M:handleReceiveSpRoomStoreReply(status, msg)
	if status == 0 then
		self:sendGetLiveZoneInfoRequest(self._cacheZoneId)
	end
end

M.instance = M.New()

return M
