-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/controller/KingNuoyaChallengeController.lua

module("logic.extensions.kingnuoya.controller.KingNuoyaChallengeController", package.seeall)

local KingNuoyaChallengeController = class("KingNuoyaChallengeController", BaseController)

function KingNuoyaChallengeController:onInit()
	self:onReset()
end

function KingNuoyaChallengeController:onReset()
	self._fmtMo = KingNuoyaFmtMo.New()
	self.isTypeFinish = false
end

function KingNuoyaChallengeController:getActivityId()
	return 321001
end

function KingNuoyaChallengeController:sendGetInfo(activityId)
	KingNuoYaChallengeAgent.instance:sendPM_KingNuoYaChallengeInfoReq(activityId)
end

function KingNuoyaChallengeController:handlePM_KingNuoYaChallengeInfoRes(msg)
	KingNuoyaChallengeModel.instance:handlePM_KingNuoYaChallengeInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KingNuoyaChallengeUpdate)
end

function KingNuoyaChallengeController:openFmtView(activityId, curType, curStepId, challengeId, currBuffId)
	self.lastType = curType

	self._fmtMo:initParams(activityId, curType, curStepId, challengeId, currBuffId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function KingNuoyaChallengeController:sendStartFight(activityId, type, stepId, stageId, buffId, simpleForm)
	local tb = KingNuoyaChallengeModel.instance:getInfo(activityId) or {}

	if not tb.finishedType then
		local finishedType = {}
		local info = tb.info

		if info and info.curType == type then
			if table.indexof(finishedType, type == KingNuoyaChallengeModel.TYPE_DAY and KingNuoyaChallengeModel.TYPE_NIGHT or KingNuoyaChallengeModel.TYPE_DAY) == false then
				local endTimeMillis = checknumber(info.endTimeMillis) / 1000
				local now = ServerTime.now()

				if endTimeMillis < now then
					TipsFacade.instance:openCommonTips("当前挑战已经超时，请退出布阵重新选择关卡")
					GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

					return
				end
			end
		end

		UIJumper.instance:pushOneStack(ViewName.KingnuoyachallengeView, true)
		UIJumper.instance:pushOneStack(ViewName.KingnuoyachallengeselectView, true)
		KingNuoYaChallengeAgent.instance:sendPM_KingNuoYaChallengeReq(activityId, type, stepId, stageId, buffId, simpleForm)
	end
end

function KingNuoyaChallengeController:onGetFighMsg(msg)
	local isWin = msg.isWin

	self.isTypeFinish = false

	if isWin then
		self.isTypeFinish = msg.isTypeFinish
	end
end

KingNuoyaChallengeController.instance = KingNuoyaChallengeController.New()

return KingNuoyaChallengeController
