-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/controller/SaintKnightTaskController.lua

module("logic.extensions.saintknighttask.controller.SaintKnightTaskController", package.seeall)

local SaintKnightTaskController = class("SaintKnightTaskController", BaseController)
local TeamInviteTemplateId = 97
local JoinTeamState = {
	Full = 1,
	Success = 0
}

function SaintKnightTaskController:ctor()
	return
end

function SaintKnightTaskController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
	self:onReset()
end

function SaintKnightTaskController:onReset()
	return
end

function SaintKnightTaskController:sendCollectionTasksGetInfoReq(actId)
	SaintKnightTasksAgent.instance:sendPM_CollectionTasksGetInfoReq(actId)
end

function SaintKnightTaskController:handleCollectionTasksGetInfoRes(msg)
	SaintKnightTaskModel.instance:handleCollectionTasksGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskCollectionTasksGetInfoRes)
end

function SaintKnightTaskController:sendCollectionTasksGetRankInfoReq(actId, rankId)
	SaintKnightTasksAgent.instance:sendPM_CollectionTasksGetRankInfoReq(actId, rankId)
end

function SaintKnightTaskController:handleCollectionTasksGetRankInfoRes(msg)
	SaintKnightTaskModel.instance:handleCollectionTasksGetRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskCollectionTasksGetRankInfoRes)
end

function SaintKnightTaskController:sendCollectionTasksGainPrizeReq(actId)
	SaintKnightTasksAgent.instance:sendPM_CollectionTasksGainPrizeReq(actId)
end

function SaintKnightTaskController:handleCollectionTasksGainPrizeRes(msg)
	SaintKnightTaskModel.instance:handleCollectionTasksGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskCollectionTasksGainPrizeRes)
end

function SaintKnightTaskController:sendSK_GetPersonTaskReq(actId)
	SaintKnightTasksAgent.instance:sendPM_SK_GetPersonTaskReq(actId)
end

function SaintKnightTaskController:handleSK_GetPersonTaskRes(status, msg)
	if status == 0 then
		SaintKnightTaskModel.instance:handleSK_GetPersonTaskRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SKTaskGetPersonTaskRes, status, msg)
end

function SaintKnightTaskController:sendSK_GainPersonTaskPrizeReq(actId, taskId)
	SaintKnightTasksAgent.instance:sendPM_SK_GainPersonTaskPrizeReq(actId, taskId)
end

function SaintKnightTaskController:handleSK_GainPersonTaskPrizeRes(msg)
	SaintKnightTaskModel.instance:handleSK_GainPersonTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskGainPersonTaskPrizeRes)
end

function SaintKnightTaskController:sendWorldTasksGetInfoReq(actId)
	SaintKnightTasksAgent.instance:sendPM_WorldTasksGetInfoReq(actId)
end

function SaintKnightTaskController:handleWorldTasksGetInfoRes(msg)
	SaintKnightTaskModel.instance:handleWorldTasksGetInfoRes(msg)
	self:updateWorldTasksPrizeRed(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskWorldTasksGetInfoRes)
end

function SaintKnightTaskController:sendWorldTasksGainPrizeReq(actId, worldTaskPlanId, index)
	SaintKnightTasksAgent.instance:sendPM_WorldTasksGainPrizeReq(actId, worldTaskPlanId, index)
end

function SaintKnightTaskController:handleWorldTasksGainPrizeRes(msg)
	SaintKnightTaskModel.instance:handleWorldTasksGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskWorldTasksGainPrizeRes)
end

function SaintKnightTaskController:sendSKVerifyFormZdlReq(actId, form)
	SaintKnightTasksAgent.instance:sendPM_SKVerifyFormZdlReq(actId, form)
end

function SaintKnightTaskController:handleSKVerifyFormZdlRes(msg)
	SaintKnightTaskModel.instance:handleSKVerifyFormZdlRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskWorldTasksVerifyFormZdlRes)
end

function SaintKnightTaskController:sendSKGainVerifyPrizeReq(actId)
	SaintKnightTasksAgent.instance:sendPM_SKGainVerifyPrizeReq(actId)
end

function SaintKnightTaskController:handleSKGainVerifyPrizeRes(msg)
	SaintKnightTaskModel.instance:handleSKGainVerifyPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskWorldTasksGainVerifyPrizeRes)
end

function SaintKnightTaskController:sendSK_GainTeamPrizeReq(actId)
	SaintKnightTasksAgent.instance:sendPM_SK_GainTeamPrizeReq(actId)
end

function SaintKnightTaskController:handleSK_GainTeamPrizeRes(msg)
	SaintKnightTaskModel.instance:handleSK_GainTeamPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskGainTeamPrizeRes, msg)
end

function SaintKnightTaskController:sendSK_JoinTeamReq(activityId, captainId)
	SaintKnightTasksAgent.instance:sendPM_SK_JoinTeamReq(activityId, captainId)
end

function SaintKnightTaskController:handleSK_JoinTeamRes(msg)
	local state = checknumber(msg.state)
	local isSuccess = state == JoinTeamState.Success

	if isSuccess then
		SaintKnightTaskModel.instance:handleSK_JoinTeamRes(msg)
		FloatWordMgr.instance:show("加入队伍成功")
		self:sendSK_GetPersonTaskReq(msg.activityId)
	elseif state == JoinTeamState.Full then
		FloatWordMgr.instance:show("队伍已满")
	else
		FloatWordMgr.instance:show("加入队伍失败")
	end

	GlobalDispatcher:dispatch(GlobalNotify.SKTaskJoinTeamRes, msg)
end

function SaintKnightTaskController:loadSaintKnightTask()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	self:_preloadPersonTaskInfo()
	self:updateSaintKnightTaskRed()
end

function SaintKnightTaskController:_preloadPersonTaskInfo()
	local activityId = self:getActivityId()

	if activityId <= 0 then
		return
	end

	if not self:isInActivityTimeAsSkt(activityId) then
		return
	end

	self:sendSK_GetPersonTaskReq(activityId)
end

function SaintKnightTaskController:dailyRefresh()
	self:_preloadPersonTaskInfo()
	self:updateSaintKnightTaskRed()
end

function SaintKnightTaskController:updateSaintKnightTaskRed()
	self:updateSKTWorldTaskFirstRed()
	self:updateSKTPersonTaskFirstRed()
end

function SaintKnightTaskController:updateSKTWorldTaskFirstRed()
	local totalRedId = SaintKnightTaskConfig.instance:getSktWorldTaskFirstRed()

	if totalRedId == 0 then
		return
	end

	RedPointController.instance:setRedPointInfo(totalRedId, false)

	local activityId = self:getActivityId()

	if activityId <= 0 then
		return
	end

	local actData = SaintKnightTaskConfig.instance:getSktActData(activityId)

	if actData == nil or actData.worldTaskPlanIdArray == nil then
		return
	end

	local function handle(value)
		if not value and not RedPointModel.instance:isActive(totalRedId) then
			RedPointController.instance:setRedPointInfo(totalRedId, true)
		end
	end

	for _, worldTaskPlanId in ipairs(actData.worldTaskPlanIdArray) do
		if RedPointModel.instance:isActive(totalRedId) then
			break
		end

		self:isNeedFirstRedAsWorldTasksPlan(activityId, worldTaskPlanId, handle)
	end
end

function SaintKnightTaskController:updateSKTPersonTaskFirstRed()
	local totalRedId = SaintKnightTaskConfig.instance:getSktPersonTaskFirstRed()

	if totalRedId == 0 then
		return
	end

	RedPointController.instance:setRedPointInfo(totalRedId, false)

	local activityId = self:getActivityId()

	if activityId <= 0 then
		return
	end

	local actData = SaintKnightTaskConfig.instance:getSktActData(activityId)

	if actData == nil or actData.personTaskPlanIdArray == nil then
		return
	end

	local function handle(value)
		if not value and not RedPointModel.instance:isActive(totalRedId) then
			RedPointController.instance:setRedPointInfo(totalRedId, true)
		end
	end

	for _, personTaskPlanId in ipairs(actData.personTaskPlanIdArray) do
		if RedPointModel.instance:isActive(totalRedId) then
			break
		end

		self:isNeedFirstRedAsPersonTasksPlan(activityId, personTaskPlanId, handle)
	end
end

function SaintKnightTaskController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function SaintKnightTaskController:getActivityType()
	return GameEnum.ActivityType.SaintKnightTask
end

function SaintKnightTaskController:isInActivityTimeAsSkt(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function SaintKnightTaskController:isNeedFirstRedAsPersonTasksPlan(activityId, personTaskPlanId, handle)
	if not self:isUnlockByTimeAsPersonTasksPlan(personTaskPlanId) then
		return false
	end

	local key = self:getFirstRedKeyAsPersonTasksPlan(activityId, personTaskPlanId)

	return GameUtil.getUserData(key, handle) ~= true
end

function SaintKnightTaskController:setFirstRedAsPersonTasksPlan(activityId, personTaskPlanId)
	if not self:isUnlockByTimeAsPersonTasksPlan(personTaskPlanId) then
		return
	end

	local key = self:getFirstRedKeyAsPersonTasksPlan(activityId, personTaskPlanId)

	GameUtil.saveUserData(key, true)
end

function SaintKnightTaskController:getFirstRedKeyAsPersonTasksPlan(activityId, personTaskPlanId)
	return "SKT" .. "PersonTasksPlan" .. "FirstRed" .. activityId .. personTaskPlanId
end

function SaintKnightTaskController:isUnlockByTimeAsPersonTasksPlan(personTaskPlanId)
	return self:getTimePeriodAsPersonTasksPlan(personTaskPlanId) == GameUtil.inTimePeriod
end

function SaintKnightTaskController:getTimePeriodAsPersonTasksPlan(personTaskPlanId)
	local data = SaintKnightTaskConfig.instance:getSktPersonTaskPlanData(personTaskPlanId)

	if data then
		return GameUtil.getTimePeriod(data.openTime, nil)
	else
		return GameUtil.errorTimePeriod
	end
end

function SaintKnightTaskController:isCanGetPrizeAsAllPersonTask(activityId)
	local isCanGet = false
	local actData = SaintKnightTaskConfig.instance:getSktActData(activityId)

	if actData == nil or actData.personTaskPlanIdArray == nil then
		return isCanGet
	end

	for _, personTaskPlanId in ipairs(actData.personTaskPlanIdArray) do
		if self:isCanGetPrizeAsPersonTasksPlan(personTaskPlanId) then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

function SaintKnightTaskController:isCanGetPrizeAsPersonTasksPlan(personTaskPlanId)
	local isCanGet = false
	local taskCfg = SaintKnightTaskConfig.instance:getSktPersonTaskCfg(personTaskPlanId)

	for taskId, data in pairs(taskCfg) do
		if self:isCanGetPrizeAsPersonTask(taskId) then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

function SaintKnightTaskController:isCanGetPrizeAsPersonTask(taskId)
	return self:isEnoughGetPrizeAsPersonTask(taskId) and not self:isHasGainPrizeAsPersonTask(taskId)
end

function SaintKnightTaskController:isEnoughGetPrizeAsPersonTask(taskId)
	local data = SaintKnightTaskConfig.instance:getSktPersonTaskData(taskId)
	local progress = SaintKnightTaskModel.instance:getProgressAsPersonTask(taskId)

	return progress >= data.maxProgress
end

function SaintKnightTaskController:isHasGainPrizeAsPersonTask(taskId)
	return SaintKnightTaskModel.instance:isHasGainPrizeAsPersonTask(taskId)
end

function SaintKnightTaskController:isCanGetPrizeAsAllTeamTask(activityId)
	local prizeCfg = SaintKnightTaskConfig.instance:getSktTeamPrizeCfg(activityId)

	for prizeId, _ in pairs(prizeCfg) do
		if self:isCanGetPrizeAsTeamTask(activityId, prizeId) then
			return true
		end
	end

	return false
end

function SaintKnightTaskController:isCanGetPrizeAsTeamTask(activityId, prizeId)
	return self:isEnoughGetPrizeAsTeamTask(activityId, prizeId) and not self:isHasGainPrizeAsTeamTask(prizeId)
end

function SaintKnightTaskController:isEnoughGetPrizeAsTeamTask(activityId, prizeId)
	local data = SaintKnightTaskConfig.instance:getSktTeamPrizeData(activityId, prizeId)
	local progress = SaintKnightTaskModel.instance:getTeamProgress(activityId)

	return progress >= data.progress
end

function SaintKnightTaskController:isHasGainPrizeAsTeamTask(prizeId)
	return SaintKnightTaskModel.instance:isHasGainPrizeAsTeam(prizeId)
end

function SaintKnightTaskController:getTeamInviteTemplateId()
	return TeamInviteTemplateId
end

function SaintKnightTaskController:getTeamInviteDataT(activityId)
	activityId = checknumber(activityId)

	return {
		tpId = self:getTeamInviteTemplateId(),
		params = {
			activityId = activityId,
			captainId = tostring(RoleModel.instance:getUserId()),
			captainName = RoleModel.instance:getUserName(),
			teamScore = SaintKnightTaskModel.instance:getTeamProgress(activityId)
		}
	}
end

function SaintKnightTaskController:getMyScoreAsTeamTask(activityId)
	local teamConfig = SaintKnightTaskConfig.instance:getSktTeamConfigData(activityId)

	if teamConfig == nil then
		return 0
	end

	return MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, teamConfig.activityItemId)
end

function SaintKnightTaskController:_onChatItemClick(tpId, chatMo)
	if tpId ~= self:getTeamInviteTemplateId() then
		return
	end

	self:openJoinTeamConfirmFromChat(chatMo)
end

function SaintKnightTaskController:openJoinTeamConfirmFromChat(chatMo)
	local activityId = chatMo:getParam("activityId", true)
	local captainId = chatMo:getParam("captainId", false)

	if not self:isInActivityTimeAsSkt(activityId) then
		FloatWordMgr.instance:show("活动已过期~")

		return
	end

	self:_openJoinTeamConfirm({
		activityId = activityId,
		captainId = captainId,
		captainName = chatMo:getParam("captainName", false),
		teamScore = chatMo:getParam("teamScore", true)
	})
end

function SaintKnightTaskController:_openJoinTeamConfirm(context)
	local activityId = checknumber(context.activityId)
	local captainId = context.captainId

	if not self:isInActivityTimeAsSkt(activityId) then
		FloatWordMgr.instance:show("活动已过期~")

		return
	end

	if captainId == nil or tostring(captainId) == "" then
		FloatWordMgr.instance:show("队伍信息已失效")

		return
	end

	if tostring(captainId) == tostring(RoleModel.instance:getUserId()) then
		FloatWordMgr.instance:show("无法加入自己的队伍")

		return
	end

	if not self:_checkCanJoinTeamFromInvite() then
		return
	end

	local captainName = context.captainName
	local teamScore = checknumber(context.teamScore)
	local myScore = self:getMyScoreAsTeamTask(activityId)
	local content = string.format("是否加入【%s】的梦梦任务队伍？\n注：加入后无法退出，请谨慎确认无误\n队伍积分：%s\n我的积分：%s", captainName or "", teamScore, myScore)

	local function sureFunc()
		if not SaintKnightTaskController.instance:_checkCanJoinTeamFromInvite() then
			return
		end

		SaintKnightTaskController.instance:sendSK_JoinTeamReq(activityId, captainId)
	end

	TipsFacade.instance:openPopupWindow("提示", content, sureFunc, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function SaintKnightTaskController:_checkCanJoinTeamFromInvite()
	if not SaintKnightTaskModel.instance:isPersonTaskInfoLoaded() then
		FloatWordMgr.instance:show("数据加载中，请稍后")

		return false
	end

	if SaintKnightTaskModel.instance:isInTeam() then
		FloatWordMgr.instance:show("你已加入队伍，无法重复加入")

		return false
	end

	return true
end

function SaintKnightTaskController:isNeedFirstRedAsWorldTasksPlan(activityId, worldTaskPlanId, handle)
	if not self:isUnlockByTimeAsWorldTasksPlan(worldTaskPlanId) then
		return false
	end

	local key = self:getFirstRedKeyAsWorldTasksPlan(activityId, worldTaskPlanId)

	return GameUtil.getUserData(key, handle) ~= true
end

function SaintKnightTaskController:setFirstRedAsWorldTasksPlan(activityId, worldTaskPlanId)
	if not self:isUnlockByTimeAsWorldTasksPlan(worldTaskPlanId) then
		return
	end

	local key = self:getFirstRedKeyAsWorldTasksPlan(activityId, worldTaskPlanId)

	GameUtil.saveUserData(key, true)
end

function SaintKnightTaskController:getFirstRedKeyAsWorldTasksPlan(activityId, worldTaskPlanId)
	return "SKT" .. "WorldTasksPlan" .. "FirstRed" .. activityId .. worldTaskPlanId
end

function SaintKnightTaskController:updateWorldTasksPrizeRed(msg)
	local redId = SaintKnightTaskConfig.instance:getSktWorldTaskPrizeRed()
	local isCanGet = self:isCanGetPrizeInWorldTasks(checknumber(msg.actId))

	RedPointController.instance:setRedPointInfo(redId, isCanGet)
end

function SaintKnightTaskController:isUnlockByTimeAsWorldTasksPlan(worldTaskPlanId)
	return self:getTimePeriodAsWorldTasksPlan(worldTaskPlanId) == GameUtil.inTimePeriod
end

function SaintKnightTaskController:getTimePeriodAsWorldTasksPlan(worldTaskPlanId)
	local data = SaintKnightTaskConfig.instance:getSktWorldTaskPlanData(worldTaskPlanId)

	if data then
		return GameUtil.getTimePeriod(data.openTime, nil)
	else
		return GameUtil.errorTimePeriod
	end
end

function SaintKnightTaskController:isCanGetPrizeInWorldTasks(activityId)
	local isCanGet = false
	local actData = SaintKnightTaskConfig.instance:getSktActData(activityId)

	if actData == nil or actData.worldTaskPlanIdArray == nil then
		return isCanGet
	end

	for _, worldTaskPlanId in ipairs(actData.worldTaskPlanIdArray) do
		if self:isCanGetPrizeInWorldTasksPlan(worldTaskPlanId) then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

function SaintKnightTaskController:isCanGetPrizeInWorldTasksPlan(worldTaskPlanId)
	local isCanGet = false
	local cfg = SaintKnightTaskConfig.instance:getSktWorldTaskPrizeCfgById(worldTaskPlanId)

	for _, data in ipairs(cfg) do
		if self:isCanGetPrizeInWorldTasksDetail(worldTaskPlanId, data.index) then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

function SaintKnightTaskController:isCanGetPrizeInWorldTasksDetail(worldTaskPlanId, index)
	return self:isEnoughGetPrizeInWorldTasks(worldTaskPlanId, index) and not self:isHasGainPrizeInWorldTasks(worldTaskPlanId, index)
end

function SaintKnightTaskController:isEnoughGetPrizeInWorldTasks(worldTaskPlanId, index)
	return self:isEnoughGetPrizeProgressInWorldTasks(worldTaskPlanId, index) and self:isEnoughGetPrizeCondInWorldTasks(worldTaskPlanId)
end

function SaintKnightTaskController:isEnoughGetPrizeProgressInWorldTasks(worldTaskPlanId, index)
	local data = SaintKnightTaskConfig.instance:getSktWorldTaskPrizeDataById(worldTaskPlanId, index)
	local progress = SaintKnightTaskModel.instance:getWorldTasksGainUserNum(worldTaskPlanId)

	return progress >= data.progress
end

function SaintKnightTaskController:isEnoughGetPrizeCondInWorldTasks(worldTaskPlanId)
	local data = SaintKnightTaskConfig.instance:getSktWorldTaskPlanData(worldTaskPlanId)

	return BagModel.instance:isExistRaceId(data.raceId)
end

function SaintKnightTaskController:isHasGainPrizeInWorldTasks(worldTaskPlanId, index)
	return SaintKnightTaskModel.instance:isHasGainPrizeInWorldTasks(worldTaskPlanId, index)
end

function SaintKnightTaskController:enterFormationAsSkt(activityId)
	local customFmtMo = SaintKnightTaskModel.instance:getSktFmtCustomFmtMo()

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

SaintKnightTaskController.instance = SaintKnightTaskController.New()

return SaintKnightTaskController
