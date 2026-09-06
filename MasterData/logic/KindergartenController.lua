-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/controller/KindergartenController.lua

module("logic.extensions.kindergarten.controller.KindergartenController", package.seeall)

local KindergartenController = class("KindergartenController", BaseController)

function KindergartenController:ctor()
	return
end

function KindergartenController:onInit()
	self:onReset()
end

function KindergartenController:onReset()
	return
end

function KindergartenController:getActivityType()
	return GameEnum.ActivityType.Kindergarten
end

function KindergartenController:getClassRoomLevel(activityId, classRoomId)
	local info = KindergartenModel.instance:getInfo(activityId)

	if info then
		for i, v in ipairs(info.classroomList) do
			if v.classroomId == classRoomId then
				if v.unlockFacilityId <= 0 then
					return 1
				end

				local roomCfg = KindergartenConfig.instance:getClassRoomCfg(activityId, v.classroomId)
				local planCfgs = KindergartenConfig.instance:getFacilityPlanCfgs(roomCfg.facilityPlanId)
				local unlockFacilityId = math.min(v.unlockFacilityId, #planCfgs)

				return planCfgs[unlockFacilityId].classroomLv
			end
		end
	end

	return 1
end

function KindergartenController:getGartenLevel(activityId)
	local classRoomLvs = {}
	local cfgs = KindergartenConfig.instance:getClassRoomCfgs(activityId)

	for i, cfg in ipairs(cfgs) do
		classRoomLvs[cfg.classroomId] = KindergartenController.instance:getClassRoomLevel(activityId, cfg.classroomId)
	end

	local maxLevel = -1

	for k, lv in pairs(classRoomLvs) do
		if maxLevel == -1 or lv < maxLevel then
			maxLevel = lv
		end
	end

	local cfgs = KindergartenConfig.instance:getLevelCfgs(activityId)
	local kindergartenLevel = 0

	for i, v in ipairs(cfgs) do
		if maxLevel == v.needClassroomLv then
			kindergartenLevel = v.level

			break
		end
	end

	return kindergartenLevel
end

function KindergartenController:isFacilityUnlock(activityId, classRoomId, facilityId)
	local info = KindergartenModel.instance:getInfo(activityId)

	if info then
		for i, v in ipairs(info.classroomList) do
			if v.classroomId == classRoomId and facilityId <= v.unlockFacilityId then
				return true
			end
		end
	end

	return false
end

function KindergartenController:getFaciltyUnlockId(activityId, classRoomId)
	local info = KindergartenModel.instance:getInfo(activityId)

	if info then
		for i, v in ipairs(info.classroomList) do
			if v.classroomId == classRoomId then
				return v.unlockFacilityId
			end
		end
	end

	return 0
end

function KindergartenController:getUnlockKindergartenLevel(activityId, classId)
	local cfgs = KindergartenConfig.instance:getLevelCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if classId <= v.classCount then
			return v.level
		end
	end

	return 1
end

function KindergartenController:sendPM_KindergartenSetAutoReq(activityId, pointScheduleList, isAuto)
	self._tempIsAuto = isAuto

	KindergartenAgent.instance:sendPM_KindergartenSetAutoReq(activityId, pointScheduleList, isAuto)
end

function KindergartenController:handlePM_KindergartenSetAutoRes(msg)
	KindergartenModel.instance:setAutoRes(msg, self._tempIsAuto)
	GlobalDispatcher:dispatch(GlobalNotify.KindergartenSetAutoRes)

	self._tempIsAuto = nil
end

KindergartenController.instance = KindergartenController.New()

return KindergartenController
