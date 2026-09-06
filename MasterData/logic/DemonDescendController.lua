-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/controller/DemonDescendController.lua

module("logic.extensions.demondescend.controller.DemonDescendController", package.seeall)

local DemonDescendController = class("DemonDescendController", BaseController)

function DemonDescendController:onInit()
	return
end

function DemonDescendController:onReset()
	return
end

function DemonDescendController:sendPM_DemonDescendInfoReq(activityId)
	DemonDescendAgent.instance:sendPM_DemonDescendInfoReq(activityId)
end

function DemonDescendController:handlePM_DemonDescendInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendInfoRes)
end

function DemonDescendController:sendPM_DemonDescendUnlockBuffReq(activityId, buffId)
	DemonDescendAgent.instance:sendPM_DemonDescendUnlockBuffReq(activityId, buffId)
end

function DemonDescendController:handlePM_DemonDescendUnlockBuffRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendUnlockBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendUnlockBuffRes)
end

function DemonDescendController:sendPM_DemonDescendGainProgressPrizeReq(activityId, progressId)
	DemonDescendAgent.instance:sendPM_DemonDescendGainProgressPrizeReq(activityId, progressId)
end

function DemonDescendController:handlePM_DemonDescendGainProgressPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendGainProgressPrizeRes, msg)
end

function DemonDescendController:sendPM_DemonDescendCheckInReq(activityId)
	DemonDescendAgent.instance:sendPM_DemonDescendCheckInReq(activityId)
end

function DemonDescendController:handlePM_DemonDescendCheckInRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendCheckInRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendCheckInRes)
end

function DemonDescendController:sendPM_DemonDescendResetBuffReq(activityId)
	DemonDescendAgent.instance:sendPM_DemonDescendResetBuffReq(activityId)
end

function DemonDescendController:handlePM_DemonDescendResetBuffRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendResetBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendResetBuffRes)
end

function DemonDescendController:sendPM_DemonDescendStageChallengeReq(activityId, form, stageId)
	DemonDescendAgent.instance:sendPM_DemonDescendStageChallengeReq(activityId, form, stageId)
end

function DemonDescendController:handlePM_DemonDescendStageChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendStageChallengeRes)
end

function DemonDescendController:handlePM_DemonDescendNotifyStageChallengeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendNotifyStageChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendNotifyStageChallengeRes)
end

function DemonDescendController:sendPM_DemonDescendBossChallengeReq(activityId, form, buffId, isTrial)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local subMo = self:getSubMo(activityId)
		local msg = subMo:getBossResMsg()
		local damage = checknumber(msg.damage)

		BattleSettlementController.instance:addConditionElement(langPara("对敌方精灵造成的总伤害<color=#%s>%s</color>点", SettlementTarget.Colors.Fail, damage))
		UIStateManager.instance:open(ViewName.BattleSettlementSuccess)

		return true
	end)
	DemonDescendAgent.instance:sendPM_DemonDescendBossChallengeReq(activityId, form, buffId, isTrial)
end

function DemonDescendController:handlePM_DemonDescendBossChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendBossChallengeRes)
end

function DemonDescendController:handlePM_DemonDescendNotifyBossChallengeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendNotifyBossChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendNotifyBossChallengeRes)
end

function DemonDescendController:sendPM_DemonDescendRankViewReq(activityId)
	DemonDescendAgent.instance:sendPM_DemonDescendRankViewReq(activityId)
end

function DemonDescendController:handlePM_DemonDescendRankViewRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DemonDescendRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DemonDescendRankViewRes, msg)
end

function DemonDescendController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DemonDescend)
end

function DemonDescendController:getSubMo(activityId)
	return DemonDescendModel.instance:getSubMo(activityId)
end

function DemonDescendController:enterStageBattle(activityId, stageId)
	local fmtMo = DemonDescendModel.instance:getStageFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DemonDescendController:enterBossBattle(activityId, buffIdList, isTrial)
	local fmtMo = DemonDescendModel.instance:getBossFmtMo()

	fmtMo:updateCfg(activityId, buffIdList, isTrial)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DemonDescendController:openCommonTabRankView(activityId)
	local params = CommonTabRankParams.New()

	params:addTabData(ViewName.DemonDescendBossChildRankView, ViewName.DemonDescendBossChildRankView, "恶魔降临", {
		activityId
	})
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

DemonDescendController.instance = DemonDescendController.New()

return DemonDescendController
