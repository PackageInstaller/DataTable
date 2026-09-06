-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcardspack/controller/MonthCardPackController.lua

module("logic.extensions.monthcardspack.controller.MonthCardPackController", package.seeall)

local MonthCardPackController = class("MonthCardPackController", BaseController)

function MonthCardPackController:onInit()
	self:onReset()
end

function MonthCardPackController:onReset()
	self._curReqActivityId = 0
end

function MonthCardPackController:loadActivityInfo()
	self:checkCurrActivity()

	local activityId = MonthCardPackModel.instance:getActivityId()

	if activityId == 0 then
		return
	end

	self:requestMonthCardPackGetInfo(activityId)
end

function MonthCardPackController:getActivityId()
	local activities = MonthCardPackConfig.instance:getActivities()

	for i = 1, #activities do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MonthCardPack, activities[i].activityId) then
			return activities[i].activityId
		end
	end

	return 0
end

function MonthCardPackController:checkRedPoint()
	if MonthCardPackModel.instance:getRemainTimes() == 0 or MonthCardPackModel.instance:getWholeLimitNums() == 0 then
		return false
	end

	local isClickTabRedpoint = checknumber(UnityEngine.PlayerPrefs.GetInt("monthcard_pack_" .. RoleModel.instance:getUserId())) ~= 0

	if isClickTabRedpoint then
		return false
	end

	return true
end

function MonthCardPackController:setClickTabRedpoint()
	UnityEngine.PlayerPrefs.SetInt("monthcard_pack_" .. RoleModel.instance:getUserId(), 1)
end

function MonthCardPackController:checkCurrActivity()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		MonthCardPackModel.instance:setActivityId(0)
		MonthCardPackModel.instance:setActivityInfo()

		return
	end

	local activityId = MonthCardPackModel.instance:getActivityId()

	if activityId == currActivityId then
		return
	end

	MonthCardPackModel.instance:setActivityId(currActivityId)
	MonthCardPackModel.instance:setActivityInfo()
end

function MonthCardPackController:requestMonthCardPackGetInfo(activityId)
	if self._curReqActivityId ~= 0 then
		return
	end

	self._curReqActivityId = activityId

	MonthCardPackAgent.instance:sendPM_MonthCardPackGetInfoReq(activityId)
end

function MonthCardPackController:onMonthCardPackGetInfo(status, msg)
	local curReqActivityId = self._curReqActivityId

	self._curReqActivityId = 0

	if curReqActivityId == 0 then
		return
	end

	local curAcId = self:getActivityId()

	if status ~= 0 or curAcId ~= curReqActivityId then
		return
	end

	MonthCardPackModel.instance:setActivityInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMonthCardPackInfo)
	RedPointModel.instance:updateAllRedPoint()
end

MonthCardPackController.instance = MonthCardPackController.New()

return MonthCardPackController
