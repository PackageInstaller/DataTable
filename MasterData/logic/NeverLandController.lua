-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/controller/NeverLandController.lua

module("logic.extensions.neverland.controller.NeverLandController", package.seeall)

local NeverLandController = class("NeverLandController", BaseController)

function NeverLandController:ctor()
	return
end

function NeverLandController:onInit()
	self:onReset()
end

function NeverLandController:onReset()
	return
end

function NeverLandController:sendPM_NeverLandInfoReq(activityId)
	NeverLandAgent.instance:sendPM_NeverLandInfoReq(activityId)
end

function NeverLandController:handlePM_NeverLandInfoRes(status, msg)
	NeverLandModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NeverLandInfoRes, msg)
end

function NeverLandController:sendPM_NeverLandChallengeReq(activityId, mode, form)
	NeverLandAgent.instance:sendPM_NeverLandChallengeReq(activityId, mode, form)
	NeverLandModel.instance:setChallengeMode(mode)
end

function NeverLandController:handlePM_NeverLandNotifyChallengeResultRes(status, msg)
	if status == 0 then
		local score = msg.score
		local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.NeverLand)
		local mode = NeverLandModel.instance:getChallengeModel()

		if mode == "attack" then
			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.NeverLandAttackChallenge, score)
		else
			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.NeverLandDefendChallenge, score)
		end
	end
end

function NeverLandController:handlePM_NeverLandChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function NeverLandController:sendPM_NeverLandUpgradeBuffLvReq(activityId, buffId)
	NeverLandAgent.instance:sendPM_NeverLandUpgradeBuffLvReq(activityId, buffId)
end

function NeverLandController:handlePM_NeverLandUpgradeBuffLvRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NeverLandUpgradeBuffLvRes, msg)
end

function NeverLandController:sendPM_NeverLandGetRankReq(activityId, mode)
	NeverLandAgent.instance:sendPM_NeverLandGetRankReq(activityId, mode)
end

function NeverLandController:handlePM_NeverLandGetRankRes(status, msg)
	NeverLandModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NeverLandGetRankRes, status)
end

function NeverLandController:isBuffMaxLevel(activityId, buffId, level)
	local cfg = NeverLandConfig.instance:getBuffCfgById(activityId, buffId, level + 1)

	return not checkbool(cfg)
end

function NeverLandController:openNeverLandAttackForm(activityId)
	local mo = NeverLandModel.instance:getChallengeAttackFmtMo(activityId)

	CustomFmtController.instance:showMissionView(mo)
end

function NeverLandController:openNeverLandDefendForm(activityId)
	local mo = NeverLandModel.instance:getChallengeDefendFmtMo(activityId)

	CustomFmtController.instance:showMissionView(mo)
end

function NeverLandController:fightResult(activityId)
	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local function comFunc()
			UIJumper.instance:pushOneStack(ViewName.NeverLandView, true)
		end

		local function succHandler()
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
			comFunc()
		end

		local function failHandler()
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
			comFunc()
		end

		if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
			succHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
			succHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
			failHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
			failHandler()
		end

		return true
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(handleBattleEnd), self)
end

NeverLandController.instance = NeverLandController.New()

return NeverLandController
