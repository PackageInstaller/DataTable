-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/controller/DragonKingChallengeController.lua

module("logic.extensions.dragonking.controller.DragonKingChallengeController", package.seeall)

local DragonKingChallengeController = class("DragonKingChallengeController", BaseController)

function DragonKingChallengeController:onInit()
	self:onReset()
end

function DragonKingChallengeController:onReset()
	self.dragonKingFmtMo = DragonKingFmtMo.New()
end

function DragonKingChallengeController:getActivityId()
	local activityType = 315

	return (ActivityDefineController.instance:getActivityIdByType(activityType))
end

function DragonKingChallengeController:sendGetRankInfoReq(activityId)
	DragonKingChallengeAgent.instance:sendPM_DragonKingClgGetRankReq(activityId)
end

function DragonKingChallengeController:handlePM_DragonKingClgGetRankRes(msg)
	DragonKingChallengeModel.instance:handlePM_DragonKingClgGetRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingChallengeUpdate)
end

function DragonKingChallengeController:sendGetInfo(activityId)
	DragonKingChallengeAgent.instance:sendPM_DragonKingClgGetInfoReq(activityId)
end

function DragonKingChallengeController:handlePM_DragonKingClgGetInfoRes(msg)
	DragonKingChallengeModel.instance:handlePM_DragonKingClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingChallengeUpdate)
end

function DragonKingChallengeController:sendGetPrize(activityId, id)
	DragonKingChallengeAgent.instance:sendPM_DragonKingClgGainProgressPrizeReq(activityId, id)
end

function DragonKingChallengeController:handlePM_DragonKingClgGainProgressPrizeRes(msg)
	DragonKingChallengeModel.instance:handlePM_DragonKingClgGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingChallengeUpdate)
end

function DragonKingChallengeController:openFmtView(activityId, stageId, list)
	self.dragonKingFmtMo:initParams(activityId, stageId, list)
	CustomFmtController.instance:showMissionView(self.dragonKingFmtMo)
end

function DragonKingChallengeController:sendStartFight(activityId, stageId, form_pb, guardCreepsId_i32_Ary)
	UIJumper.instance:pushOneStack(ViewName.DragonkingchallengeView, true)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	DragonKingChallengeAgent.instance:sendPM_DragonKingClgFightReq(activityId, stageId, form_pb, guardCreepsId_i32_Ary)
end

function DragonKingChallengeController:onGetFighMsg(msg)
	self._activityId = msg.activityId
	self._stageId = msg.stageId
	self._winScore = msg.winScore
	self._isWin = msg.win

	DragonKingChallengeModel.instance:updateStageInfo(msg)
end

function DragonKingChallengeController:onBattleEnd()
	if self._isWin then
		TipsFacade.instance:openTipWindowValidX(lang("tip"), langPara("恭喜你，本局获得积分\n\n<size=35><color=#20b376>%s</color></size>", self._winScore), function()
			BattleController.instance:endBattle()
		end, lang("tip_know"), UnityEngine.TextAnchor.MiddleCenter)
	else
		TipsFacade.instance:openTipWindowValidX(lang("tip"), "对不起，挑战失败", function()
			BattleController.instance:endBattle()
		end, lang("tip_know"), UnityEngine.TextAnchor.MiddleCenter)
	end

	return true
end

DragonKingChallengeController.instance = DragonKingChallengeController.New()

return DragonKingChallengeController
