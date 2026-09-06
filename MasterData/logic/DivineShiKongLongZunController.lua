-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/controller/DivineShiKongLongZunController.lua

module("logic.extensions.divineshikonglongzunmainview.controller.DivineShiKongLongZunController", package.seeall)

local DivineShiKongLongZunController = class("DivineShiKongLongZunController", BaseController)

function DivineShiKongLongZunController:ctor()
	return
end

function DivineShiKongLongZunController:onInit()
	GlobalDispatcher:addListener("enterdivineshikonglongzun", self._enterDivineShiKongLongZun, self)
end

function DivineShiKongLongZunController:onReset()
	return
end

function DivineShiKongLongZunController:_enterDivineShiKongLongZun(params)
	self:enterDivineShiKongLongZun(checknumber(params[1]))
end

function DivineShiKongLongZunController:enterDivineShiKongLongZun(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.DivineShiKongLongZunMainView, activityId)
end

function DivineShiKongLongZunController:sendPM_DivineTSDragonLordClgGetInfoReq(activityId)
	DivineShiKongLongZunAgent.instance:sendPM_DivineTSDragonLordClgGetInfoReq(activityId)
end

function DivineShiKongLongZunController:handlePM_DivineTSDragonLordClgGetInfoRes(msg)
	DivineShiKongLongZunModel.instance:handlePM_DivineTSDragonLordClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineTSDragonLordClgGetInfoRes)
end

function DivineShiKongLongZunController:sendPM_DivineTSDragonLordClgChallengeReq(activityId, stageId, teamIndex, form)
	DivineShiKongLongZunAgent.instance:sendPM_DivineTSDragonLordClgChallengeReq(activityId, stageId, teamIndex, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, activityId))
end

function DivineShiKongLongZunController:handlePM_Notify_DivineTSDragonLordClgChallengeEndRes(msg)
	DivineShiKongLongZunModel.instance:handlePM_Notify_DivineTSDragonLordClgChallengeEndRes(msg)

	local curModel = DivineShiKongLongZunModel.instance:GetModel(msg.activityId)

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		DivineShiKongLongZunModel.instance:addChangeSetId(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_DivineTSDragonLordClgChallengeEndRes)
end

function DivineShiKongLongZunController:sendPM_DivineTSDragonLordClgConfirmScoreReq(activityId, stageId, teamIndex, replace)
	DivineShiKongLongZunAgent.instance:sendPM_DivineTSDragonLordClgConfirmScoreReq(activityId, stageId, teamIndex, replace)
end

function DivineShiKongLongZunController:handlePM_DivineTSDragonLordClgConfirmScoreRes(status, msg)
	if status == 0 then
		DivineShiKongLongZunModel.instance:handlePM_DivineTSDragonLordClgConfirmScoreRes(msg)

		if msg:HasField("changeSetId") then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			DivineShiKongLongZunModel.instance:addChangeSetId(msg.changeSetId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineTSDragonLordClgConfirmScoreRes, status, msg)
end

function DivineShiKongLongZunController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineShiKongLongZunController:getActivityType()
	return GameEnum.ActivityType.DivineShiKongLongZun
end

function DivineShiKongLongZunController:isInActivityTime(activityId)
	return ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
end

function DivineShiKongLongZunController:getPassExpression(activityId, stageId)
	local cur = DivineShiKongLongZunConfig.instance:getPassExpression(activityId, stageId)

	if string.find(cur, "|") ~= nil then
		local expStr = string.gsub(cur, "|", "/")

		expStr = string.gsub(expStr, "A", "曙光")
		expStr = string.gsub(expStr, "B", "黑暗")

		return expStr
	elseif string.find(cur, "&") ~= nil then
		local arr = string.split(cur, "=")

		if checknumber(arr[#arr]) ~= nil then
			return string.format("曙光=黑暗=%d", (checknumber(arr[#arr])))
		end
	else
		cur = string.gsub(cur, "A", "曙光")
		cur = string.gsub(cur, "B", "黑暗")

		return cur
	end
end

function DivineShiKongLongZunController:enterBattleClg(activityId, stageId, teamId)
	local customFmtMo = DivineShiKongLongZunModel.instance:getCustomFmtMo(activityId)
	local stageData = DivineShiKongLongZunConfig.instance:getStageData(activityId, stageId)

	customFmtMo:updateCfg(activityId, stageId, teamId, (stageData.teams and #stageData.teams > 0 or nil) and stageData.teams[teamId])
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineShiKongLongZunController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function DivineShiKongLongZunController:getSkinId(activityId)
	return DivineShiKongLongZunConfig.instance:getCommonValue(activityId, "skinId")
end

function DivineShiKongLongZunController:_onResFightEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local model = DivineShiKongLongZunModel.instance:GetModel(activityId)
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end

	if model.resPassStage then
		FloatWordMgr.instance:show("恭喜通过当前关卡！")

		return
	end

	local showEndView = checknumber(model.resScore[1]) ~= 0 or checknumber(model.resScore[2]) ~= 0

	if showEndView then
		UIStateManager.instance:push(ViewName.DivineShiKongLongZunFightEndShowView, activityId)
	else
		UIStateManager.instance:push(ViewName.BattleSettlementFailSimple)
	end

	return true
end

DivineShiKongLongZunController.instance = DivineShiKongLongZunController.New()

return DivineShiKongLongZunController
