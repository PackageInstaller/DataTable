-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/controller/KingIsaacClgController.lua

module("logic.extensions.kingisaacclg.controller.KingIsaacClgController", package.seeall)

local KingIsaacClgController = class("KingIsaacClgController", BaseController)

function KingIsaacClgController:ctor()
	return
end

function KingIsaacClgController:onInit()
	return
end

function KingIsaacClgController:onReset()
	return
end

function KingIsaacClgController:sendPM_KingIsaacClgInfoReq(activityId)
	KingIsaacClgAgent.instance:sendPM_KingIsaacClgInfoReq(activityId)
end

function KingIsaacClgController:handlePM_KingIsaacClgInfoRes(msg)
	local data = self:getKicData(msg.activityId)

	data:handlePM_KingIsaacClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_KingIsaacClgInfoRes)
end

function KingIsaacClgController:sendPM_KingIsaacClgChallengeReq(activityId, stageId, form)
	KingIsaacClgAgent.instance:sendPM_KingIsaacClgChallengeReq(activityId, stageId, form)
end

function KingIsaacClgController:handlePM_KingIsaacClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_KingIsaacClgChallengeRes)
end

function KingIsaacClgController:handlePM_NotifyKingIsaacClgChallengeEndRes(msg)
	local data = self:getKicData(msg.activityId)

	data:handlePM_NotifyKingIsaacClgChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyKingIsaacClgChallengeEndRes)
end

function KingIsaacClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function KingIsaacClgController:getActivityType()
	return GameEnum.ActivityType.KingIsaacClg
end

function KingIsaacClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KingIsaacClgController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function KingIsaacClgController:getSkinId(activityId)
	return KingIsaacClgConfig.instance:getKicCommonValue(activityId, "skinId")
end

function KingIsaacClgController:getKicData(activityId)
	return KingIsaacClgModel.instance:getKicData(activityId)
end

function KingIsaacClgController:getTryEnterKingIsaacClgStageResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	elseif self:isHasPassAllStage(activityId, stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "所有挑战已完成"
	elseif self:isHasPassStage(activityId, stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "对应关卡已通关"
	elseif not self:isUnlockStageOfTime(activityId, stageId) then
		result = GameEnum.ResultCode.NotUnlockCond
		tips = "关卡未开启"
	elseif not self:isHasPassPreStage(activityId, stageId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "未通关上一关卡"
	end

	return result, tips
end

function KingIsaacClgController:enterBattle(activityId, stageId)
	local customFmtMo = KingIsaacClgModel.instance:getKicCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KingIsaacClgController:isHasPassAllStage(activityId)
	local max = self:getStageIdOfMaxPass(activityId)
	local stageCount = self:getStageCount(activityId)

	return stageCount <= max
end

function KingIsaacClgController:isHasPassStage(activityId, stageId)
	local max = self:getStageIdOfMaxPass(activityId)

	return stageId <= max
end

function KingIsaacClgController:isHasPassPreStage(activityId, stageId)
	local preStageId = Mathf.Max(stageId - 1, 0)

	return self:isHasPassStage(activityId, preStageId)
end

function KingIsaacClgController:getStageIdOfMaxPass(activityId)
	local data = self:getKicData(activityId)

	return data:getStageIdOfMaxPass()
end

function KingIsaacClgController:isUnlockStageOfTime(activityId, stageId)
	local stageData = KingIsaacClgConfig.instance:getKicStageData(activityId, stageId)

	if stageData then
		return GameUtil.getTimePeriod(stageData.startTime, nil) == GameUtil.inTimePeriod
	else
		return false
	end
end

function KingIsaacClgController:getStageCount(activityId)
	local cfg = KingIsaacClgConfig.instance:getKicStageCfg(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function KingIsaacClgController:getClgResMsg(activityId)
	local data = self:getKicData(activityId)

	return data:getClgResMsg()
end

KingIsaacClgController.instance = KingIsaacClgController.New()

return KingIsaacClgController
