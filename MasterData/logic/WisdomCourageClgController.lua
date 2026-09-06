-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/controller/WisdomCourageClgController.lua

module("logic.extensions.wisdomcourageclg.controller.WisdomCourageClgController", package.seeall)

local WisdomCourageClgController = class("WisdomCourageClgController", BaseController)

function WisdomCourageClgController:onInit()
	return
end

function WisdomCourageClgController:onReset()
	return
end

function WisdomCourageClgController:sendPM_WisdomCourageClgBossInfoReq(activityId)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgBossInfoReq(activityId)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgBossInfoRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_WisdomCourageClgBossInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WisdomCourageClgBossInfoRes)
end

function WisdomCourageClgController:sendPM_WisdomCourageClgBossChallengeReq(activityId, bossId, simulated, form)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgBossChallengeReq(activityId, bossId, simulated, form)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgBossChallengeRes(msg)
	return
end

function WisdomCourageClgController:sendPM_WisdomCourageClgBossRankInfoReq(activityId)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgBossRankInfoReq(activityId)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgBossRankInfoRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_WisdomCourageClgBossRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WisdomCourageClgBossRankInfoRes, msg)
end

function WisdomCourageClgController:sendPM_WisdomCourageClgSupportInfoReq(activityId)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgSupportInfoReq(activityId)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgSupportInfoRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_WisdomCourageClgSupportInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WisdomCourageClgSupportInfoRes)
end

function WisdomCourageClgController:sendPM_WisdomCourageClgSupportChallengeReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getWisdomCourageClgMo(activityId)
		local msg = mo:getSupportClgFinishResMsg()

		if msg.isWin then
			UIStateManager.instance:push(ViewName.WisdomCourageClgSupportResultPopView, activityId)

			result = true
		end

		return result
	end)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgSupportChallengeReq(activityId, stageId, form)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgSupportChallengeRes(msg)
	return
end

function WisdomCourageClgController:sendPM_WisdomCourageClgSupportConfirmReq(activityId, save)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgSupportConfirmReq(activityId, save)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgSupportConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getWisdomCourageClgMo(msg.activityId)

		mo:handlePM_WisdomCourageClgSupportConfirmRes(msg)

		if msg:HasField("changeSetId") then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WisdomCourageClgSupportConfirmRes, status, msg)
end

function WisdomCourageClgController:sendPM_WisdomCourageClgSupportResetReq(activityId)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgSupportResetReq(activityId)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgSupportResetRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_WisdomCourageClgSupportResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WisdomCourageClgSupportResetRes)
end

function WisdomCourageClgController:sendPM_WisdomCourageClgSupportRankInfoReq(activityId)
	WisdomCourageClgAgent.instance:sendPM_WisdomCourageClgSupportRankInfoReq(activityId)
end

function WisdomCourageClgController:handlePM_WisdomCourageClgSupportRankInfoRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_WisdomCourageClgSupportRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WisdomCourageClgSupportRankInfoRes, msg)
end

function WisdomCourageClgController:handlePM_NotifyWisdomCourageClgBossChallengeFinishRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_NotifyWisdomCourageClgBossChallengeFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyWisdomCourageClgBossChallengeFinishRes)
end

function WisdomCourageClgController:handlePM_NotifyWisdomCourageClgSupportChallengeFinishRes(msg)
	local mo = self:getWisdomCourageClgMo(msg.activityId)

	mo:handlePM_NotifyWisdomCourageClgSupportChallengeFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyWisdomCourageClgSupportChallengeFinishRes)
end

function WisdomCourageClgController:getActivityId()
	return 456001
end

function WisdomCourageClgController:getActivityType()
	return GameEnum.ActivityType.WisdomCourageClg
end

function WisdomCourageClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function WisdomCourageClgController:getWisdomCourageClgMo(activityId)
	return WisdomCourageClgModel.instance:getWisdomCourageClgMo(activityId)
end

function WisdomCourageClgController:enterBattleInBoss(activityId, bossId, isSweep)
	local fmtMo = WisdomCourageClgModel.instance:getWisdomCourageClgBossFmtMo()

	fmtMo:updateCfg(activityId, bossId, isSweep)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function WisdomCourageClgController:enterBattleInSupport(activityId, stageId)
	local fmtMo = WisdomCourageClgModel.instance:getWisdomCourageClgSupportFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function WisdomCourageClgController:openCommonTabRank(activityId, defaultKey)
	local params = CommonTabRankParams.New()

	params:addTabData(ViewName.WisdomCourageClgBossViewRankChildView, ViewName.WisdomCourageClgBossViewRankChildView, "勇气榜", {
		activityId
	})
	params:addTabData(ViewName.WisdomCourageClgSupportViewRankChildView, ViewName.WisdomCourageClgSupportViewRankChildView, "智慧榜", {
		activityId
	})
	params:setDafaultOpenTab(defaultKey)
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

WisdomCourageClgController.instance = WisdomCourageClgController.New()

return WisdomCourageClgController
