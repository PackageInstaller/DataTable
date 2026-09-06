-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/controller/WuDiClgController.lua

module("logic.extensions.wudiclg.controller.WuDiClgController", package.seeall)

local WuDiClgController = class("WuDiClgController", BaseController)

function WuDiClgController:ctor()
	return
end

function WuDiClgController:onInit()
	GlobalDispatcher:addListener("enterwudiclg", self._enterWuDiClg, self)
end

function WuDiClgController:sendPM_WuDiClgGetInfoReq(activityId)
	WuDiChallengeAgent.instance:sendPM_WuDiClgGetInfoReq(activityId)
end

function WuDiClgController:handlePM_WuDiClgGetInfoRes(msg)
	WuDiClgModel.instance:handlePM_WuDiClgGetInfoRes(msg)
	self:_updateExtClgRed(msg.activityId)
	self:_updateNorClgRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgGetInfoRes)
end

function WuDiClgController:sendPM_WuDiClgExtremeFightReq(activityId, stageId, form)
	WuDiChallengeAgent.instance:sendPM_WuDiClgExtremeFightReq(activityId, stageId, form)
end

function WuDiClgController:handlePM_WuDiClgExtremeFightRes(status, msg)
	if status == 0 then
		BattleFacade.instance:registerResultHandler(self._handlerBattleEndInExt, self)
		WuDiClgModel.instance:handlePM_WuDiClgExtremeFightRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgExtremeFightRes, status)
end

function WuDiClgController:sendPM_WuDiClgExtremeFightConfirmReq(activityId, confirmNum, save)
	WuDiChallengeAgent.instance:sendPM_WuDiClgExtremeFightConfirmReq(activityId, confirmNum, save)
end

function WuDiClgController:handlePM_WuDiClgExtremeFightConfirmRes(status, msg)
	if status == 0 then
		WuDiClgModel.instance:handlePM_WuDiClgExtremeFightConfirmRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgExtremeFightConfirmRes, status)
end

function WuDiClgController:sendPM_WuDiClgResetExtremeClgReq(activityId)
	WuDiChallengeAgent.instance:sendPM_WuDiClgResetExtremeClgReq(activityId)
end

function WuDiClgController:handlePM_WuDiClgResetExtremeClgRes(msg)
	WuDiClgModel.instance:handlePM_WuDiClgResetExtremeClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgResetExtremeClgRes)
end

function WuDiClgController:sendPM_WuDiClgGainExtremePrizeReq(activityId)
	WuDiChallengeAgent.instance:sendPM_WuDiClgGainExtremePrizeReq(activityId)
end

function WuDiClgController:handlePM_WuDiClgGainExtremePrizeRes(msg)
	WuDiClgModel.instance:handlePM_WuDiClgGainExtremePrizeRes(msg)
	self:_updateExtClgRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgGainExtremePrizeRes)
end

function WuDiClgController:sendPM_WuDiClgNormalFightReq(activityId, dataBitId, form)
	WuDiChallengeAgent.instance:sendPM_WuDiClgNormalFightReq(activityId, dataBitId, form)
end

function WuDiClgController:handlePM_WuDiClgNormalFightRes(status, msg)
	if status == 0 then
		WuDiClgModel.instance:handlePM_WuDiClgNormalFightRes(msg)
		BattleFacade.instance:startWuDiClgNorBattle()
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineKingDragonChallengeRes, status)
end

function WuDiClgController:sendPM_WuDiClgGainNormalProgressPrizeReq(activityId, dataBitId)
	WuDiChallengeAgent.instance:sendPM_WuDiClgGainNormalProgressPrizeReq(activityId, dataBitId)
end

function WuDiClgController:handlePM_WuDiClgGainNormalProgressPrizeRes(msg)
	WuDiClgModel.instance:handlePM_WuDiClgGainNormalProgressPrizeRes(msg)
	self:_updateNorClgRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgGainNormalProgressPrizeRes)
end

function WuDiClgController:handlePM_WuDiClgNotifyExtremeFightResultRes(msg)
	WuDiClgModel.instance:handlePM_WuDiClgNotifyExtremeFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgNotifyExtremeFightResultRes)
end

function WuDiClgController:handlePM_WuDiClgNotifyNormalFightResultRes(msg)
	WuDiClgModel.instance:handlePM_WuDiClgNotifyNormalFightResultRes(msg)

	if msg.win then
		local activityId = msg.activityId
		local groupId = 0
		local dataBitId = msg.dataBitId
		local infoList = {}

		for idx, v in ipairs(msg.ruleResult) do
			local info = GameUtil.pbToTable(v)

			table.insert(infoList, info)
		end

		self:saveDetailInfoListOfNorClg(activityId, groupId, dataBitId, infoList)
	end

	GlobalDispatcher:dispatch(GlobalNotify.WuDiClgNotifyNormalFightResultRes)
end

function WuDiClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function WuDiClgController:getActivityType()
	return GameEnum.ActivityType.WuDiClg
end

function WuDiClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function WuDiClgController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function WuDiClgController:getSkinId(activityId)
	return WuDiClgConfig.instance:getWdcCommonValue(activityId, "skinId")
end

function WuDiClgController:_enterWuDiClg(params)
	self:enterWuDiClg(checknumber(params[1]))
end

function WuDiClgController:enterWuDiClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.WuDiClgMainView, activityId)
end

function WuDiClgController:_updateExtClgRed(activityId)
	activityId = checknumber(activityId)

	local isNeedRed = false

	if self:isInActivityTime(activityId) then
		local result = self:getTryGetPrizeExtClgResultAndTips(activityId)

		if result == GameEnum.ResultCode.Success then
			isNeedRed = true
		end
	end

	local redId = RedPointModel.ID_WuDiClg_Ext

	RedPointController.instance:setRedPointInfo(redId, isNeedRed)
end

function WuDiClgController:_updateNorClgRed(activityId)
	activityId = checknumber(activityId)

	local redId = RedPointModel.ID_WuDiClg_Nor

	RedPointController.instance:setRedPointInfo(redId, (self:isInActivityTime(activityId) and self:isHavePrizeCanGainOfNorClg(activityId) or nil) and true)
end

function WuDiClgController:enterBattleOfNorClg(activityId, groupId, dataBitId)
	local customFmtMo = WuDiClgModel.instance:getWuDiClgCustomFmtMoOfNor()

	customFmtMo:updateCfg(activityId, groupId, dataBitId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function WuDiClgController:enterBattleOfExtClg(activityId, stageId)
	local customFmtMo = WuDiClgModel.instance:getWuDiClgCustomFmtMoOfExt()

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function WuDiClgController:_handlerBattleEndInExt()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local result = false
	local msg = WuDiClgModel.instance:getExtFightResultRes()

	if msg then
		local activityId = msg.activityId
		local activityType = self:getActivityType()
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = self:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		local stageId = msg.stageId
		local confirmNum = checknumber(msg.confirmNum)
		local stageData = WuDiClgConfig.instance:getWdcExtStageData(activityId, stageId)

		if stageData then
			if not stageData.groupAttackCount then
				local isPass = confirmNum > 0

				if isPass then
					ViewMgr.instance:open(ViewName.WuDiClgExtSuccessView, msg)
				else
					ViewMgr.instance:open(ViewName.WuDiClgExtFailView, msg)
				end

				result = true
			end
		end
	end

	return result
end

function WuDiClgController:enterWuDiClgNorResultView()
	local msg = WuDiClgModel.instance:getFightResultResOfNorClg()

	if msg == nil then
		BattleController.instance:endBattle()
	else
		local activityId = msg.activityId
		local groupId = 0
		local dataBitId = msg.dataBitId

		local function callBack()
			BattleController.instance:endBattle()
		end

		UIStateManager.instance:push(ViewName.WuDiClgNorDetailView, activityId, groupId, dataBitId, callBack)
	end
end

function WuDiClgController:getTryEnterExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间内"
	elseif self:isHasGainExtremeClgPrize() then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已通关"
	end

	return result, tips
end

function WuDiClgController:getTryFightExtClgResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainExtremeClgPrize() or self:isPassAllOfExtStage(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "所有关卡已通关"
	end

	return result, tips
end

function WuDiClgController:getTryRefreshExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:getPassCountOfExtStage(activityId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "无需重置"
	elseif self:isHasGainExtremeClgPrize() or self:isPassAllOfExtStage(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "所有关卡已通关"
	end

	return result, tips
end

function WuDiClgController:getTryGetPrizeExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainExtremeClgPrize() then
		result = GameEnum.ResultCode.Error
		tips = "奖励已领取"
	elseif not self:isPassAllOfExtStage(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "存在未通关关卡"
	end

	return result, tips
end

function WuDiClgController:getAllLockedRaceIdOfExtStage(activityId)
	local raceIdPool = {}
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(activityId)

	for _, data in ipairs(cfg) do
		local list = self:getLockedRaceIdListOfExtStage(data.stageId)

		for _, raceId in ipairs(list) do
			raceIdPool[raceId] = raceId
		end
	end

	return (TableUtil.toList(raceIdPool))
end

function WuDiClgController:getLockedRaceIdListOfExtStage(stageId)
	return WuDiClgModel.instance:getLockedRaceIdListOfExtStage(stageId)
end

function WuDiClgController:getTheRaceStageIdOfExtStage(activityId, raceId)
	local stageId = 0
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(activityId)

	for _, data in ipairs(cfg) do
		local list = self:getLockedRaceIdListOfExtStage(data.stageId)

		if table.indexof(list, raceId) then
			stageId = data.stageId

			break
		end
	end

	return stageId
end

function WuDiClgController:getTotalStageCountOfExtStage(activityId)
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(activityId)

	return #cfg
end

function WuDiClgController:isPassAllOfExtStage(activityId)
	local result = true
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(activityId)

	for _, data in ipairs(cfg) do
		if not self:isPassOfExtStage(data.stageId) then
			result = false

			break
		end
	end

	return result
end

function WuDiClgController:getPassCountOfExtStage(activityId)
	local result = 0
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(activityId)

	for _, data in ipairs(cfg) do
		if self:isPassOfExtStage(data.stageId) then
			result = result + 1
		end
	end

	return result
end

function WuDiClgController:isPassOfExtStage(stageId)
	return WuDiClgModel.instance:isPassOfExtStage(stageId)
end

function WuDiClgController:isHasGainExtremeClgPrize()
	return WuDiClgModel.instance:isHasGainExtremeClgPrize()
end

function WuDiClgController:isHavePrizeCanGainOfNorClg(activityId)
	local result = false
	local cfg = WuDiClgConfig.instance:getWdcNorProgressCfg(activityId)

	for _, data in ipairs(cfg) do
		if self:isCanGainPrizeOfNorClg(activityId, data.dataBitId) then
			result = true

			break
		end
	end

	return result
end

function WuDiClgController:getTryEnterNorClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间内"
	end

	return result, tips
end

function WuDiClgController:getTryFightNorClgResultAndTips(activityId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfNorClg(dataBitId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	return result, tips
end

function WuDiClgController:getNormalClgTodayGroupId()
	return WuDiClgModel.instance:getNormalClgTodayGroupId()
end

function WuDiClgController:isPassOfNorClg(dataBitId)
	local list = WuDiClgModel.instance:getPassBitIdListOfNorClg()

	return table.indexof(list, dataBitId) ~= false
end

function WuDiClgController:isCanGainPrizeOfNorClg(activityId, dataBitId)
	return self:isEnoughGainPrizeOfNorClg(activityId, dataBitId) and not self:isHasGainPrizeOfNorClg(dataBitId)
end

function WuDiClgController:isEnoughGainPrizeOfNorClg(activityId, dataBitId)
	local data = WuDiClgConfig.instance:getWdcNorProgressData(activityId, dataBitId)
	local cur = self:getProgressOfNorClg()

	return cur >= data.progress
end

function WuDiClgController:isHasGainPrizeOfNorClg(dataBitId)
	local list = WuDiClgModel.instance:getProgressPrizeGainedBitIdListOfNorClg()

	return table.indexof(list, dataBitId) ~= false
end

function WuDiClgController:getProgressOfNorClg()
	return WuDiClgModel.instance:getProgressOfNorClg()
end

function WuDiClgController:getTotalScoreOfDetailOfNorClg(activityId, groupId, dataBitId)
	local result = 0
	local infoList = self:getDetailInfoListOfNorClg(activityId, groupId, dataBitId)

	for _, info in ipairs(infoList) do
		result = result + info.soulCount
	end

	return result
end

function WuDiClgController:getDetailInfoListOfNorClg(activityId, groupId, dataBitId)
	local key = self:getDetailInfoListKeyOfNorClg(activityId, groupId, dataBitId)
	local value = GameUtil.getUserDayData(key)
	local infoList = GameUtil.jsonToTable(value)

	return infoList or {}
end

function WuDiClgController:saveDetailInfoListOfNorClg(activityId, groupId, dataBitId, infoList)
	local key = self:getDetailInfoListKeyOfNorClg(activityId, groupId, dataBitId)
	local value = GameUtil.jsonToString(infoList)

	GameUtil.saveUserDayData(key, value)
end

function WuDiClgController:getDetailInfoListKeyOfNorClg(activityId, groupId, dataBitId)
	return string.format("WuDiClgNor_%s_%s_%s", activityId, groupId, dataBitId)
end

WuDiClgController.instance = WuDiClgController.New()

return WuDiClgController
