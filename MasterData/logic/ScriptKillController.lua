-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/controller/ScriptKillController.lua

module("logic.extensions.scriptkill.controller.ScriptKillController", package.seeall)

local ScriptKillController = class("ScriptKillController", BaseController)

function ScriptKillController:onInit()
	self:onReset()
end

function ScriptKillController:onReset()
	self._tmpActivityId = nil
	self._tmpChapterId = nil
	self._tmpSelectKiller = nil
	self._isNotNeedCost = false
	self._tempTalkActId = 0
	self._tempTalkClueId = 0
end

function ScriptKillController:getActivityId()
	return 365001
end

function ScriptKillController:sendGetInfo(activityId)
	ScriptKillingAgent.instance:sendPM_ScriptKillingInfoReq(activityId)
end

function ScriptKillController:onGetInfo(msg)
	ScriptKillModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillInfoUpdate)
end

function ScriptKillController:sendGetRankInfo(activityId)
	ScriptKillingAgent.instance:sendPM_ScriptKillingRankReq(activityId)
end

function ScriptKillController:onGetRankInfo(msg)
	ScriptKillModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillRankInfoUpdate)
end

function ScriptKillController:sendGetPrize(activityId)
	ScriptKillingAgent.instance:sendPM_ScriptKillingGainPrizeReq(activityId)
end

function ScriptKillController:onGetPrize(msg)
	ScriptKillModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillInfoUpdate)
end

function ScriptKillController:sendSuspect(activityId, chapterId, selectKiller)
	self._tmpActivityId = activityId
	self._tmpChapterId = chapterId
	self._tmpSelectKiller = selectKiller

	ScriptKillingAgent.instance:sendPM_ScriptKillingSuspectReq(activityId, chapterId, selectKiller)
end

function ScriptKillController:onSuspect(msg)
	ScriptKillModel.instance:onSuspect(self._tmpActivityId, self._tmpChapterId, self._tmpSelectKiller)

	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._tmpActivityId, self._tmpChapterId)

	if cfg and checknumber(cfg.endStoryId) > 0 then
		StoryController.instance:startStory(checknumber(cfg.endStoryId))
	end

	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillInfoUpdate)
end

function ScriptKillController:sendGetClue(activityId, clueId, isNotNeedCost)
	if not isNotNeedCost and self:checkActionPointEnougth(activityId) then
		self._isNotNeedCost = isNotNeedCost

		ScriptKillingAgent.instance:sendPM_ScriptKillingGainClueReq(activityId, clueId)
	end
end

function ScriptKillController:onGetGlue(msg)
	ScriptKillModel.instance:onGetGlue(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillGetCludeId, msg.clueId)

	if not self._isNotNeedCost then
		self:sendUseActionPoint(msg.activityId)
	end
end

function ScriptKillController:sendGetTalkClue(activityId, clueId, success)
	ScriptKillingAgent.instance:sendPM_ScriptKillingGainStagingClueReq(activityId, success)
end

function ScriptKillController:sendClearTalk(activityId)
	local newClueId = self._tempTalkClueId

	if newClueId > 0 then
		local cfg = ScriptKillConfig.instance:getClueCfgById(self._tempTalkActId, newClueId) or {}

		ScriptKillController.instance:openPopupWindowWithX(cfg.name, cfg.desc)

		self._tempTalkActId = 0
		self._tempTalkClueId = 0
	end
end

function ScriptKillController:onGetTalkGlue(msg)
	ScriptKillModel.instance:onGetTalkGlue(msg)
	ScriptKillModel.instance:clearStagingTriggerId(msg.activityId)

	self._tempTalkActId = msg.activityId
	self._tempTalkClueId = checknumber(msg.newClueId)

	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillInfoUpdate)
end

function ScriptKillController:sendUseActionPoint(activityId, num)
	if self:checkActionPointEnougth(activityId) then
		num = num or 1

		ScriptKillingAgent.instance:sendPM_ScriptKillingUseActionPointReq(activityId, num)
	end
end

function ScriptKillController:onUseActionPoint(msg)
	ScriptKillModel.instance:onUseActionPoint(msg)
	TipsFacade.instance:openCommonTips("-1行动点")
	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillInfoUpdate)
end

function ScriptKillController:checkActionPointEnougth(activityId)
	local info = ScriptKillModel.instance:getInfo(activityId) or {}

	if checknumber(info.todayActionPoint) <= 0 then
		TipsFacade.instance:openPopupWindow(lang("tip"), "行动点不足，请明天再来")

		return false
	end

	return true
end

function ScriptKillController:sendGetFormula(activityId, clueIds_i32_Ary)
	if self:checkActionPointEnougth(activityId) then
		ScriptKillingAgent.instance:sendPM_ScriptKillingFormulaReq(activityId, clueIds_i32_Ary)
	end
end

function ScriptKillController:onGetFormula(msg)
	local boo = ScriptKillModel.instance:onGetFormula(msg)
	local newClueId = checknumber(msg.newClueId)
	local stagingTriggerId = checknumber(msg.stagingTriggerId)

	if not boo then
		newClueId = 0
	end

	if newClueId > 0 then
		local cfg = ScriptKillConfig.instance:getClueCfgById(msg.activityId, newClueId) or {}

		ScriptKillController.instance:openPopupWindowWithX(cfg.name, cfg.desc)
	elseif stagingTriggerId == 0 then
		TipsFacade.instance:openCommonTips("没有关联出新线索，再思考一下吧~")
	end

	GlobalDispatcher:dispatch(GlobalNotify.ScriptKillGetFormula, stagingTriggerId)
	self:sendUseActionPoint(msg.activityId)
end

function ScriptKillController:tryShowTalkView(activityId)
	local stagingTriggerId = ScriptKillModel.instance:getStagingTriggerId(activityId)

	if stagingTriggerId > 0 then
		UIStateManager.instance:push(ViewName.ScriptkillchatView, activityId, stagingTriggerId)
	end
end

function ScriptKillController:openPopupWindow(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	TipsFacade.checkFuncType(okFunc, cencelFunc)

	return TipsFacade.instance:_openPopWindowWithName(ViewName.ScriptkillpopupView, 2, title, text, false, false, alignment, {
		okFunc,
		okFuncText
	}, {
		cencelFunc,
		cancelFuncText
	})
end

function ScriptKillController:openPopupWindowWithX(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	TipsFacade.checkFuncType(okFunc, cencelFunc)

	return TipsFacade.instance:_openPopWindowWithName(ViewName.ScriptkillpopupView, 2, title, text, true, false, alignment, {
		okFunc,
		okFuncText
	}, {
		cencelFunc,
		cancelFuncText
	})
end

ScriptKillController.instance = ScriptKillController.New()

return ScriptKillController
