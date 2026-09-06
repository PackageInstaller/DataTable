-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/controller/DivineinfinitefutureclgController.lua

module("logic.extensions.divineinfinitefutureclg.controller.DivineinfinitefutureclgController", package.seeall)

local DivineinfinitefutureclgController = class("DivineinfinitefutureclgController", BaseController)

function DivineinfinitefutureclgController:ctor()
	return
end

function DivineinfinitefutureclgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivineinfinitefutureclg", self._enterDivineInfiniteFutureClg, self)
end

function DivineinfinitefutureclgController:onReset()
	self._fightEndMsg = nil
end

function DivineinfinitefutureclgController:getActivityType()
	return GameEnum.ActivityType.Divineinfinitefutureclg
end

function DivineinfinitefutureclgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineinfinitefutureclgController:isInActivityTime(activityId)
	return ActivityDefineController.instance:isInActivityTimeById(self:getActivityType(), activityId)
end

function DivineinfinitefutureclgController:_enterDivineInfiniteFutureClg(params)
	params = params or {}

	self:enterDivineInfiniteFutureClg(checknumber(params[1]))
end

function DivineinfinitefutureclgController:enterDivineInfiniteFutureClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(lang("不在活动开启时间内"))

		return
	end

	UIStateManager.instance:push(ViewName.DivineinfinitefutureclgmainView, activityId)
end

function DivineinfinitefutureclgController:checkPassAoqiGodProcessResult(activityId)
	if not ActivityDefineController.instance:isAoqiGodProcessType(activityId) then
		return true
	end

	local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self:getActivityType(), activityId)

	return result == GameEnum.ResultCode.Success
end

function DivineinfinitefutureclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(214)
end

function DivineinfinitefutureclgController:handlePM_DivineInfiniteFutureClgValidRes(msg)
	DivineinfinitefutureclgModel.instance:onClgValidRes(msg)

	local stageCfgs = DivineinfinitefutureclgConfig.instance:getStageCfgs(msg.activityId) or {}

	if ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId) and msg.curPassStageId >= #stageCfgs then
		AoqiGodController.instance:doHandleChallengeFinishReady(self:getActivityType(), msg.activityId)
	end
end

function DivineinfinitefutureclgController:handlePM_NotifyDivineInfiniteFutureFightEndRes(msg)
	self._fightEndMsg = msg

	BattleFacade.instance:registerResultHandler(self._onBattleResult, self)
end

function DivineinfinitefutureclgController:_onBattleResult()
	if not self._fightEndMsg then
		return false
	end

	local msg = self._fightEndMsg

	self._fightEndMsg = nil

	if not msg.win then
		return false
	end

	UIStateManager.instance:push(ViewName.DivineinfinitefutureclgresultView, msg)

	return true
end

function DivineinfinitefutureclgController:checkIsInOpenTime(activityId)
	local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(activityId)
	local arr = string.split(actCfg.openTime, ":")
	local hour = checknumber(arr[1])
	local min = checknumber(arr[2])
	local sec = checknumber(arr[3])
	local nowDate = ServerTime.nowDateServerLook()
	local zeroTime = GameUtil.date2time(nowDate.year, nowDate.month, nowDate.day, 0, 0, 0)
	local endTime = GameUtil.date2time(nowDate.year, nowDate.month, nowDate.day, hour, min, sec)
	local nowTime = GameUtil.date2time(nowDate.year, nowDate.month, nowDate.day, nowDate.hour, nowDate.min, nowDate.sec)

	return nowTime < zeroTime or endTime < nowTime
end

DivineinfinitefutureclgController.instance = DivineinfinitefutureclgController.New()

return DivineinfinitefutureclgController
