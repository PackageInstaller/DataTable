-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/controller/JiuClgController.lua

module("logic.extensions.jiuclg.controller.JiuClgController", package.seeall)

local JiuClgController = class("JiuClgController", BaseController)

function JiuClgController:onInit()
	GlobalDispatcher:addListener("enterjiuclg", self._enterJiuClg, self)
end

function JiuClgController:sendPM_JiuClgExtremeFightReq(activityId, phaseId, stageId, form, posList)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._openExtremeBattleResultView, self, activityId, phaseId, stageId))
	JiuClgAgent.instance:sendPM_JiuClgExtremeFightReq(activityId, form)

	self._posList = posList
end

function JiuClgController:sendPM_JiuClgNormalFightReq(activityId, form)
	JiuClgAgent.instance:sendPM_JiuClgNormalFightReq(activityId, form)
end

function JiuClgController:sendPM_JiuClgExtremeFightConfirmReq(activityId, confirmNum, save, lockRaces)
	JiuClgAgent.instance:sendPM_JiuClgExtremeFightConfirmReq(activityId, confirmNum, save, lockRaces)
end

function JiuClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function JiuClgController:getActivityType()
	return GameEnum.ActivityType.JiuClg
end

function JiuClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function JiuClgController:_enterJiuClg(params)
	self:enterJiuClg(checknumber(params[1]))
end

function JiuClgController:enterJiuClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.JiuClgMainView, activityId)
end

function JiuClgController:_openExtremeBattleResultView(activityId, phaseId, stageId)
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = self:getActivityType()

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		UIStateManager.instance:push(ViewName.JiuClgResultView, activityId, phaseId, stageId)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall or BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)

		self._posList = nil
	end

	return true
end

function JiuClgController:openMissionView(clgState, activityId, phaseId, stageId, isUiJumper)
	if clgState == JiuClgModel.ExtremeClg then
		local fmtMo = JiuClgModel.instance:getExtremeFmtMo(activityId)

		fmtMo:initParams(activityId, phaseId, stageId)

		if isUiJumper then
			UIJumper.instance:pushOneStack(ViewName.CustomMissionView, true, fmtMo)
		else
			CustomFmtController.instance:showMissionView(fmtMo)
		end
	else
		local fmtMo = JiuClgModel.instance:getNormalFmtMo(activityId)

		fmtMo:initParams(activityId, phaseId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function JiuClgController:resetExtremeChallenge(activityId, phaseId, stageId)
	local confirmNum = JiuClgModel.instance:getExtremeConfirmNum(activityId)
	local save = false
	local isUiJumper = true

	JiuClgAgent.instance:sendPM_JiuClgExtremeFightConfirmReq(activityId, confirmNum, save)
	JiuClgController.instance:openMissionView(JiuClgModel.ExtremeClg, activityId, phaseId, stageId, isUiJumper)
end

function JiuClgController:getExtremePosList()
	return self._posList
end

JiuClgController.instance = JiuClgController.New()

return JiuClgController
