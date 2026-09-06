-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/controller/CiyuanshenglongController.lua

module("logic.extensions.ciyuanshenglong.controller.CiyuanshenglongController", package.seeall)

local CiyuanshenglongController = class("CiyuanshenglongController", BaseController)

function CiyuanshenglongController:onInit()
	self:onReset()
end

function CiyuanshenglongController:onReset()
	self.ciyuanshenglongFmtMo = CiyuanshenglongFmtMo.New()
end

function CiyuanshenglongController:handlePM_CiYuanHolyDragonClgGetInfoRes(msg)
	CiyuanshenglongModel.instance:handlePM_CiYuanHolyDragonClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CIYUANSHENGLONG_INFO_UPDATE)
end

function CiyuanshenglongController:sendPM_CiYuanHolyDragonClgGetHistoryRankReq(activityId)
	CiYuanHolyDragonClgAgent.instance:sendPM_CiYuanHolyDragonClgGetHistoryRankReq(activityId)
end

function CiyuanshenglongController:handlePM_CiYuanHolyDragonClgGetHistoryRankRes(activityId)
	CiyuanshenglongModel.instance:handlePM_CiYuanHolyDragonClgGetHistoryRankRes(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.CIYUANSHENGLONG_RANK_UPDATE)
end

function CiyuanshenglongController:sendPM_CiYuanHolyDragonClgGetDailyRankReq(activityId)
	CiYuanHolyDragonClgAgent.instance:sendPM_CiYuanHolyDragonClgGetDailyRankReq(activityId)
end

function CiyuanshenglongController:handlePM_CiYuanHolyDragonClgGetDailyRankRes(activityId)
	CiyuanshenglongModel.instance:handlePM_CiYuanHolyDragonClgGetDailyRankRes(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.CIYUANSHENGLONG_RANK_UPDATE)
end

function CiyuanshenglongController:openMissionView(activityId, stageId)
	local params = {}

	params.activityId = activityId
	params.stageId = stageId

	self.ciyuanshenglongFmtMo:initParams(params)
	CustomFmtController.instance:showMissionView(self.ciyuanshenglongFmtMo)
end

function CiyuanshenglongController:sendStartFight(activityId, creepsMasterId, simpleForm)
	UIJumper.instance:pushOneStack(ViewName.CiyuanshenglongchallengemainView, true)
	UIJumper.instance:pushOneStack(ViewName.CiyuanshenglongchallengefightView, true)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	CiYuanHolyDragonClgAgent.instance:sendPM_CiYuanHolyDragonClgFightReq(activityId, creepsMasterId, simpleForm)
end

function CiyuanshenglongController:handlePM_CiYuanHolyDragonClgNotifyFightResultRes(msg)
	CiyuanshenglongModel.instance:handlePM_CiYuanHolyDragonClgNotifyFightResultRes(msg)
end

function CiyuanshenglongController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local fightScore = CiyuanshenglongModel.instance.fightScore
	local fightScoreMax = CiyuanshenglongModel.instance.fightScoreMax
	local title = ""

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		title = lang("aceteamcontroller__4")
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		title = lang("aceteamcontroller__6")
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		local var_11_0 = lang("aceteamcontroller__6")
	end

	TipsFacade.instance:openTipWindowValidX(title, langPara("<size=28>\n本次挑战积分\n<color=#eb4642>%s</color>\n\n本关今日最高积分\n<color=#eb4642>%s</color></size>", fightScore, fightScoreMax), function()
		BattleController.instance:endBattle()
	end, lang("tip_know"), UnityEngine.TextAnchor.MiddleCenter)

	return true
end

CiyuanshenglongController.instance = CiyuanshenglongController.New()

return CiyuanshenglongController
