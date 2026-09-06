-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/controller/MagicContestController.lua

module("logic.extensions.magiccontest.controller.MagicContestController", package.seeall)

local MagicContestController = class("MagicContestController", BaseController)

function MagicContestController:onInit()
	return
end

function MagicContestController:onReset()
	return
end

function MagicContestController:sendPM_MagicContestGetInfoReq(activityId)
	MagicContestAgent.instance:sendPM_MagicContestGetInfoReq(activityId)
end

function MagicContestController:handlePM_MagicContestGetInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_MagicContestGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MagicContestGetInfoRes)
end

function MagicContestController:sendPM_MagicContestSetDefenseFormReq(activityId, batType, simpleForm)
	MagicContestAgent.instance:sendPM_MagicContestSetDefenseFormReq(activityId, batType, simpleForm)
end

function MagicContestController:handlePM_MagicContestSetDefenseFormRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_MagicContestSetDefenseFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MagicContestSetDefenseFormRes, status)
end

function MagicContestController:sendPM_MagicContestStartMatchReq(activityId, type)
	MagicContestAgent.instance:sendPM_MagicContestStartMatchReq(activityId, type)
end

function MagicContestController:handlePM_MagicContestStartMatchRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_MagicContestStartMatchRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MagicContestStartMatchRes, status, msg)
end

function MagicContestController:sendPM_MagicContestChallengeReq(activityId, batType, simpleForm)
	MagicContestAgent.instance:sendPM_MagicContestChallengeReq(activityId, batType, simpleForm)
end

function MagicContestController:handlePM_MagicContestChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MagicContestChallengeRes)
end

function MagicContestController:sendPM_MagicContestSelectBuffReq(activityId, batType, buffIds)
	MagicContestAgent.instance:sendPM_MagicContestSelectBuffReq(activityId, batType, buffIds)
end

function MagicContestController:handlePM_MagicContestSelectBuffRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_MagicContestSelectBuffRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MagicContestSelectBuffRes, status)
end

function MagicContestController:sendPM_MagicContestGetRankInfoReq(activityId, type)
	MagicContestAgent.instance:sendPM_MagicContestGetRankInfoReq(activityId, type)
end

function MagicContestController:handlePM_MagicContestGetRankInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_MagicContestGetRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MagicContestGetRankInfoRes, msg)
end

function MagicContestController:handlePM_Notify_MagicContestChallengeResult(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_Notify_MagicContestChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_MagicContestChallengeResult)
end

function MagicContestController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MagicContest)
end

function MagicContestController:getSubMo(activityId)
	return MagicContestModel.instance:getSubMo(activityId)
end

function MagicContestController:enterBattle(activityId, msg)
	local fmtMo = MagicContestModel.instance:getPkFmtMo()

	fmtMo:updateCfg(activityId, msg)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function MagicContestController:enterFormation(activityId, batType)
	local customFmtMo = MagicContestModel.instance:getFormationCustomFmtMo()

	customFmtMo:updateCfg(activityId, batType)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function MagicContestController:openCommonTabRankView(activityId)
	local params = CommonTabRankParams.New()

	params:addTabData(1, ViewName.MagicContestChildRankView, "初试牛刀", {
		activityId,
		MagicContestEnum.BatType_Nor
	})
	params:addTabData(2, ViewName.MagicContestChildRankView, "巅峰对决", {
		activityId,
		MagicContestEnum.BatType_Ext
	})
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

function MagicContestController:isInBattleTime(activityId)
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInTime then
		return false
	end

	local changeCampDays = MagicSchoolController.instance:getChangeCampDays(activityId)
	local nowTimeStamp = ServerTime.now()
	local nextChangeTimeStamp = 0

	for i, v in ipairs(changeCampDays) do
		if nowTimeStamp < v then
			nextChangeTimeStamp = v

			break
		end
	end

	local data = MagicContestConfig.instance:getActivityData(activityId)

	if data then
		if not data.advanceBalanceMinutes then
			local advanceBalanceMinutes = 0

			advanceBalanceMinutes = advanceBalanceMinutes * 60

			if nextChangeTimeStamp <= nowTimeStamp + advanceBalanceMinutes then
				return false
			end

			return true
		end
	end
end

MagicContestController.instance = MagicContestController.New()

return MagicContestController
