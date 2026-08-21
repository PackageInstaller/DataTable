-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/agent/HouseAgent.lua

module("logic.extensions.house.agent.HouseAgent", package.seeall)

local M = class("HouseAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:_onReset()
	self._waitingRequest = {}
end

function M:sendGetSelfHouseInfoRequest()
	local req = HouseExtension_pb.GetSelfHouseInfoRequest()

	self:sendMsg(req)
end

function M:handleGetSelfHouseInfoReply(status, msg)
	if status == 0 then
		HouseWorkerModel.instance:initJobScheduleByAgent(msg.jobSchedules)
		GlobalDispatcher:dispatchEvent(EventType.ON_REPLY_GET_SELF_HOUSE_INFO)
	end
end

function M:sendSetJobScheduleRequest(schedule)
	local req = HouseExtension_pb.SetJobScheduleRequest()

	for i, v in ipairs(schedule) do
		local scheduleNo = HouseExtension_pb.JobScheduleNO()

		scheduleNo.job = v.job
		scheduleNo.index = v.index
		scheduleNo.hero = v.hero
		scheduleNo.bunk = v.bunk

		for k1, v1 in ipairs(v.schedule) do
			table.insert(scheduleNo.schedule, v1)
		end

		table.insert(req.jobSchedules, scheduleNo)
		print(string.format("<color=#009A61>准备排班更改,job[%d]index[%d]hero[%d]bunk[%d]</color>", v.job, v.index, v.hero, v.bunk))
	end

	table.insert(self._waitingRequest, schedule)
	self:sendMsg(req)
end

function M:handleSetJobScheduleReply(status, msg)
	if status == 0 then
		HouseWorkerModel.instance:updateJobSchedule(self._waitingRequest[1])
		ContainmentModel.instance:onUpdateJobSchedule(self._waitingRequest[1])
		GlobalDispatcher:dispatchEvent(EventType.ChangeHouseWorkerSucceed)
	end

	table.remove(self._waitingRequest, 1)
end

function M:SendJobHeroChangeRequest(jobCode, heroList)
	local req = HouseExtension_pb.JobHeroChangeRequest()

	req.job = jobCode

	for i, v in ipairs(heroList) do
		table.insert(req.hero, v)
	end

	self:sendMsg(req)
end

function M:handleJobHeroChangeReply(status, msg)
	if status == 0 then
		HouseWorkerModel.instance:updateJobScheduleByChangeHero(msg.jobSchedules)
		ContainmentModel.instance:onUpdateJobSchedule(msg.jobSchedules)
		GlobalDispatcher:dispatchEvent(EventType.ChangeHouseWorkerSucceed)
	end
end

function M:SendSetWorkScheduleRequest(jobCode, indexList)
	local req = HouseExtension_pb.SetWorkScheduleRequest()

	req.job = jobCode

	for i, v in ipairs(indexList) do
		printWarn(i, v)
		table.insert(req.index, v)
	end

	self:sendMsg(req)
end

function M:handleSetWorkScheduleReply(status, msg)
	if status == 0 then
		HouseWorkerModel.instance:updateJobScheduleBySetSchedule(msg.jobSchedules)
		ContainmentModel.instance:onUpdateJobSchedule(msg.jobSchedules)
		GlobalDispatcher:dispatchEvent(EventType.ChangeHouseWorkerSucceed)
	end
end

function M:SendSetHolidayRequest(scheduleList)
	local req = HouseExtension_pb.SetHolidayRequest()

	for i, v in ipairs(scheduleList) do
		table.insert(req.jobSchedules, v)
	end

	self:sendMsg(req)
end

function M:handleSetHolidayReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendGetHeroFeatureRequest()
	local req = HouseExtension_pb.GetHeroFeatureRequest()

	self:sendMsg(req)
end

function M:handleGetHeroFeatureReply(status, msg)
	if status == 0 then
		for _, NO in ipairs(msg.heroFeatures or {}) do
			HeroHouseFeatureModel.instance:updateHeroFeatureByAgent(NO)
		end

		GlobalDispatcher:dispatchEvent(EventType.HERO_MOOD_UPDATE)
	end
end

function M:sendGetSingleHeroFeatureRequest(heroId)
	local req = HouseExtension_pb.GetSingleHeroFeatureRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function M:handleGetSingleHeroFeatureReply(status, msg)
	if status == 0 then
		HeroHouseFeatureModel.instance:updateHeroFeatureByAgent(msg.heroFeatures)
		HouseDispatcher:dispatchEvent(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, msg.heroFeatures.heroId)
		GlobalDispatcher:dispatchEvent(EventType.HERO_MOOD_UPDATE)
	end
end

function M:sendGetFurnituresRequest()
	local req = HouseExtension_pb.GetFurnituresRequest()

	self:sendMsg(req)
end

function M:handleGetFurnituresReply(status, msg)
	if status == 0 then
		HouseFurnitureModel.instance:updateFurnituresByAgent(msg.furnitures)
		HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_FURNITURES_UPDATE)
	end
end

function M:handleFurnitureChangePush(status, msg)
	if status == 0 then
		local bunkFurnChange = HouseFurnitureModel.instance:updateFurnituresByAgent(msg.furnitures)

		HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_FURNITURES_UPDATE, bunkFurnChange)
	end
end

function M:sendSaveFurnituresRequest(zoneId, furnitureList)
	local req = HouseExtension_pb.SaveFurnituresRequest()

	req.zoneId = zoneId

	for i, furnitureMo in ipairs(furnitureList) do
		local furniture = HouseExtension_pb.Furniture()

		furniture.id = furnitureMo.furnitureId
		furniture.pos.x = furnitureMo.coordX
		furniture.pos.y = furnitureMo.coordY
		furniture.angle = furnitureMo.angle
		furniture.uuid = furnitureMo.uuid

		table.insert(req.furnitures, furniture)
	end

	self:sendMsg(req)
end

function M:handleSaveFurnituresReply(status, msg)
	if status == 0 then
		local zoneId = msg.zoneId

		if msg:HasField("zoneInfo") then
			local zoneInfo = msg.zoneInfo

			LivingFacilitiesZoneController.instance:refreshAgentDataByZoneId(zoneId, zoneInfo)
		end

		LivingFacilitiesZoneController.instance:refreshAtmospheres(msg.atmospheres)
		HouseFurnitureModel.instance:setCanSaveFurniture(false)
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_1"))
		HouseDispatcher:dispatchEvent(HouseEventType.ON_SAVE_FURNITURES_REPLY, zoneId)
	end
end

function M:sendGetFurnitureTemplateRequest(type)
	local req = HouseExtension_pb.GetFurnitureTemplateRequest()

	req.type = type

	self:sendMsg(req)
end

function M:handleGetFurnitureTemplateReply(status, msg)
	if status == 0 then
		local type = msg.type
		local template = msg.template

		LivingFacilitiesZoneModel.instance:refreshTemple(type, template)
		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_TEMPLE_REFRESH)
	end
end

function M:sendSaveFurnitureTemplateRequest(type, id, name, furnitureList)
	local req = HouseExtension_pb.SaveFurnitureTemplateRequest()

	req.type = type
	req.id = id
	req.name = name

	for i, furnitureMo in ipairs(furnitureList) do
		local furniture = HouseExtension_pb.Furniture()

		furniture.id = furnitureMo.furnitureId
		furniture.pos.x = furnitureMo.coordX
		furniture.pos.y = furnitureMo.coordY
		furniture.angle = furnitureMo.angle

		table.insert(req.furnitures, furniture)
	end

	LivingFacilitiesZoneModel.instance:setCacheTemple(name, furnitureList)
	self:sendMsg(req)
end

function M:handleSaveFurnitureTemplateReply(status, msg)
	if status == 0 then
		local type = msg.type
		local id = msg.id

		LivingFacilitiesZoneModel.instance:refreshTempleById(type, id)
		LivingFacilitiesZoneController.instance:setStorageTemplateHash(type, id)
		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_TEMPLE_REFRESH)
	end
end

function M:sendDeleteFurnitureTemplateRequest(type, id)
	local req = HouseExtension_pb.DeleteFurnitureTemplateRequest()

	req.type = type
	req.id = id

	self:sendMsg(req)
end

function M:handleDeleteFurnitureTemplateReply(status, msg)
	if status == 0 then
		local type = msg.type
		local id = msg.id

		LivingFacilitiesZoneModel.instance:deleteTemple(type, id)
		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_TEMPLE_DELETE)
	end
end

function M:sendHouseListTaskRequest()
	local req = HouseExtension_pb.HouseListTaskRequest()

	self:sendMsg(req)
end

function M:handleHouseListTaskReply(status, msg)
	if status == 0 then
		HouseTaskController.instance:onHouseListTaskReply(msg.tasks)
	end
end

function M:sendHouseRewardRequest(tasksIds)
	local req = HouseExtension_pb.HouseRewardRequest()

	for _, taskId in ipairs(tasksIds or {}) do
		table.insert(req.id, taskId)
	end

	self:sendMsg(req)
end

function M:handleHouseRewardReply(status, msg)
	if status == 0 then
		HouseTaskController.instance:onTaskRewardReceived(msg.tasks, msg.level, msg.exp)
	end
end

function M:handleHouseRefreshTaskPush(status, msg)
	print("<color=#00FFFF>小屋任务刷新推送</color>")

	if status == 0 then
		HouseTaskController.instance:onRefreshTaskPush(msg.refresh)
	end
end

function M:sendReceiveLevelRewardRequest()
	local req = HouseExtension_pb.ReceiveLevelRewardRequest()

	self:sendMsg(req)
end

function M:handleReceiveLevelRewardReply(status, msg)
	if status == 0 then
		HouseTaskController.instance:onReceiveLevelRewardReply(msg.received)
	end
end

function M:sendDecomposeFurnituresRequest(uuids)
	local req = HouseExtension_pb.DecomposeFurnituresRequest()

	for _, id in ipairs(uuids) do
		table.insert(req.furnitures, id)
	end

	self:sendMsg(req)
end

function M:handleDecomposeFurnituresReply(status, msg)
	if status == 0 then
		RoomBackpackController.instance:HandleRecycleReply()
	end
end

function M:handleHouseExpChangePush(status, msg)
	if status == 0 then
		HouseTaskController.instance:onHouseExpChangePush(msg.level, msg.exp)
	end
end

function M:sendHeroThoughtEduRequest(heroId)
	local req = HouseExtension_pb.HeroThoughtEduRequest()

	req.heroId = heroId
	self._nowThoughtEduHeroId = heroId

	self:sendMsg(req)
end

function M:handleHeroThoughtEduReply(status, msg)
	if status == 0 then
		local heroId = self._nowThoughtEduHeroId

		HouseController.instance:onHeroThoughtEduSuccess(heroId)
	end

	self._nowThoughtEduHeroId = nil
end

function M:sendMakeFurnitureRequest(uuid, count)
	local req = HouseExtension_pb.MakeFurnitureRequest()

	req.paper = uuid
	req.count = count

	self:sendMsg(req)
end

function M:handleMakeFurnitureReply(status, msg)
	if status == 0 then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FURNITURE_PRODUCT_FINISH)
	end
end

M.instance = M.New()

return M
