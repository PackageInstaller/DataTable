-- chunkname: @modules/logic/versionactivity3_2/cruise/model/CruiseModel.lua

module("modules.logic.versionactivity3_2.cruise.model.CruiseModel", package.seeall)

local CruiseModel = class("CruiseModel", BaseModel)

function CruiseModel:onInit()
	self:reInit()
end

function CruiseModel:reInit()
	return
end

function CruiseModel:isCruiseUnlock()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_2Enum.ActivityId.CruiseMain]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return true
end

function CruiseModel:isCeremonyHasReward()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return ActivityType101Model.instance:isType101RewardCouldGet(actId, 1)
end

function CruiseModel:isCeremonyRewardReceived()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return not ActivityType101Model.instance:isType101RewardCouldGet(actId, 1)
end

function CruiseModel:isGuestHasReward()
	local actId = ActivityEnum.Activity.V3a2_SummonCustomPickNew
	local isOpen = SummonNewCustomPickViewModel.instance:isActivityOpen(actId)
	local isGet = SummonNewCustomPickViewModel.instance:isGetReward(actId)

	return isOpen and not isGet
end

function CruiseModel:getCurDollStage()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGlobalTask
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		return 4
	end

	for i = 1, 4 do
		local taskId = Activity215Config.instance:getStageCO(i).globalTaskId
		local taskMO = TaskModel.instance:getTaskById(taskId)

		if not taskMO then
			return i - 1
		end

		local taskCO = Activity173Config.instance:getTaskConfig(taskId)

		if taskMO.progress < taskCO.maxProgress then
			return i - 1
		end
	end

	return 4
end

CruiseModel.instance = CruiseModel.New()

return CruiseModel
