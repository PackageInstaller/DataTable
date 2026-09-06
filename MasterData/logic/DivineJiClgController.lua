-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/controller/DivineJiClgController.lua

module("logic.extensions.divinejiclg.controller.DivineJiClgController", package.seeall)

local DivineJiClgController = class("DivineJiClgController", BaseController)

function DivineJiClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinejiclgmainview", self._enterEventOpenView, self)
end

function DivineJiClgController:onReset()
	self._fmtExtremeMo = DivineJiClgExtremeFmtMo.New()
	self._fmtNormalMo = DivineJiClgNormalFmtMo.New()
end

function DivineJiClgController:openExtremeClgFmtView(activityId, stageId)
	self._fmtExtremeMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtExtremeMo)
end

function DivineJiClgController:openNormalClgFmtView(activityId, creepsMasterId, teamOrderId)
	self._fmtNormalMo:initParams(activityId, creepsMasterId, teamOrderId)
	CustomFmtController.instance:showMissionView(self._fmtNormalMo)
end

function DivineJiClgController:sendExtremeClgStartFight(activityId, fmtMo, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onExtremeBattleEnd, self, activityId))
	DivineJiClgAgent.instance:sendPM_DivineJiExtremeFightReq(activityId, fmtMo.stageId, form)
end

function DivineJiClgController:sendNormalClgStartFight(activityId, fmtMo, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNormalBattleEnd, self, activityId))
	DivineJiClgAgent.instance:sendPM_DivineJiNormalFightReq(activityId, fmtMo.teamOrderId, form)
end

function DivineJiClgController:_onExtremeBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local fightInfo = DivineJiClgModel.instance:getExtremeFightResult(activityId)

	if fightInfo and fightInfo.win then
		UIStateManager.instance:push(ViewName.DivineJiBattleResultlView, fightInfo)

		return true
	end

	return false
end

function DivineJiClgController:onDivineJiNotifyExtremeFightResultRes(msg)
	DivineJiClgModel.instance:onDivineJiNotifyExtremeFightResultRes(msg)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

	if isAoqiGodProcessType then
		local info = DivineJiClgModel.instance:getActivityInfo(msg.activityId)
		local hasPass = info.hasPassedExtremeClg

		if isAoqiGodProcessType and hasPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineJiClg, msg.activityId)
		end
	end
end

function DivineJiClgController:_onNormalBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	DivineJiClgAgent.instance:sendPM_DivineJiClgGetInfoReq(activityId)

	return false
end

function DivineJiClgController:setSliderValue(progBar, progText, cfg, progress)
	local curProgStep = 1
	local curValue = 0

	progress = checknumber(progress) and progress or 0

	if progText then
		progText.text = "<color=#F8D200FF>" .. tostring(progress) .. "</color>"
	end

	if progBar then
		local perValue = 1 / #cfg
		local isTooBigger = progress > 0

		for i = 1, #cfg do
			if i - 1 > 0 then
				if not cfg[i - 1].progress then
					local preStep = 0
					local nextStep = cfg[i].progress

					if preStep < progress and progress <= nextStep then
						local baseValue = perValue * (i - 1)

						curValue = baseValue + (progress - preStep) / (nextStep - preStep) * perValue
						curProgStep = i
						isTooBigger = false

						break
					end
				end
			end
		end

		curValue = isTooBigger and 1 or curValue
		curProgStep = isTooBigger and #cfg or curProgStep
		progBar.value = curValue
	end

	return curProgStep
end

function DivineJiClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivineJiClgMainView, actId)
end

DivineJiClgController.instance = DivineJiClgController.New()

return DivineJiClgController
