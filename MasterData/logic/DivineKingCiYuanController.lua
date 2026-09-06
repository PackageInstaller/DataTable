-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/controller/DivineKingCiYuanController.lua

module("logic.extensions.divinekingciyuan.controller.DivineKingCiYuanController", package.seeall)

local DivineKingCiYuanController = class("DivineKingCiYuanController", BaseController)

function DivineKingCiYuanController:onInit()
	self:onReset()
end

function DivineKingCiYuanController:onReset()
	self._fmtMo = DivineKingCiYuanFmtMo.New()

	GlobalDispatcher:addListener("enterdivinekingciyuanclg", self._enterDivineKingCiYuanClg, self)
end

function DivineKingCiYuanController:openFmtView(activityId, phaseId, stageId)
	self._fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function DivineKingCiYuanController:sendStartFight(activityId, phaseId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local msg = DivineKingCiYuanModel.instance:getFightInfo(activityId)

		if msg then
			if not msg.activityId then
				local activityId = 0

				if msg then
					if not msg.isWin then
						local isWin = false

						if isWin then
							result = true

							UIStateManager.instance:push(ViewName.DivineKingCiYuanResultView, msg)
						else
							local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

							if isAoqiGodProcessType then
								local activityType = self:getActivityType()

								AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
							end
						end

						return result
					end
				end
			end
		end
	end)
	DivineKingCiYuanAgent.instance:sendPM_DivineKingCiYuanFightReq(activityId, phaseId, stageId, form)
end

function DivineKingCiYuanController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineKingCiYuanController:getActivityType()
	return GameEnum.ActivityType.DivineKingCiYuan
end

function DivineKingCiYuanController:_enterDivineKingCiYuanClg(params)
	self:enterDivineKingCiYuanClg(checknumber(params[1]))
end

function DivineKingCiYuanController:enterDivineKingCiYuanClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.DivineKingCiYuanMainView, activityId)
end

DivineKingCiYuanController.instance = DivineKingCiYuanController.New()

return DivineKingCiYuanController
