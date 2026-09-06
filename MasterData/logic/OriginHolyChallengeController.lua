-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/controller/OriginHolyChallengeController.lua

module("logic.extensions.originholychallenge.controller.OriginHolyChallengeController", package.seeall)

local OriginHolyChallengeController = class("OriginHolyChallengeController", BaseController)

function OriginHolyChallengeController:onInit()
	self:onReset()
end

function OriginHolyChallengeController:onReset()
	self._lastChallengeResult = nil
	self._isBattleEnded = false
end

function OriginHolyChallengeController:handlePM_OriginHolyChallengeGetInfoRes(msg)
	OriginHolyChallengeModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginHolyChallengeGetInfoRes)
end

function OriginHolyChallengeController:handlePM_OriginHolyChallengeChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginHolyChallengeChallengeRes)
end

function OriginHolyChallengeController:handlePM_Notify_OriginHolyChallengeChallengeResultRes(msg)
	self._lastChallengeResult = msg

	OriginHolyChallengeModel.instance:setStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_OriginHolyChallengeChallengeResultRes)

	if self._isBattleEnded then
		self:_openSettlementByResult(msg)
	end
end

function OriginHolyChallengeController:sendInfoReq(activityId)
	OriginHolyChallengeAgent.instance:sendPM_OriginHolyChallengeGetInfoReq(activityId)
end

function OriginHolyChallengeController:challenge(activityId, stageId, form_pb)
	self._lastChallengeResult = nil
	self._isBattleEnded = false

	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEnd, self))
	OriginHolyChallengeAgent.instance:sendPM_OriginHolyChallengeChallengeReq(activityId, stageId, form_pb)
end

function OriginHolyChallengeController:_openSettlementByResult(msg)
	self._lastChallengeResult = nil
	self._isBattleEnded = false

	local stageCfg = OriginHolyChallengeConfig.instance:getStage(msg.activityId, msg.stageId)

	if stageCfg then
		if not stageCfg.targetKillCount then
			local targetKillCount = 0
			local enemyCurNum = 0
			local enemyTotalNum = 0
			local enemys = BattleModel.instance:getEnemyUnits()

			for _, v in pairs(enemys) do
				if not v.attrs:isFakePet() then
					enemyTotalNum = enemyTotalNum + 1

					if v.attrs:getCurHp() <= 0 then
						enemyCurNum = enemyCurNum + 1
					end
				end
			end

			local enemyIsReach = enemyTotalNum <= enemyCurNum
			local enemyColor = enemyIsReach and "1CFF5FFF" or "FF1C21FF"
			local holyDragonAlive = checkbool(msg.holyDragonAlive)
			local holyDragonKillCount = checknumber(msg.holyDragonKillCount)
			local holyDragonKillReach = targetKillCount <= holyDragonKillCount
			local holyDragonKillColor = holyDragonKillReach and "1CFF5FFF" or "FF1C21FF"

			BattleSettlementController.instance:addConditionElement(langPara("击败敌阵所有精灵 <color=#%s>(%d/%d)</color>", enemyColor, enemyCurNum, enemyTotalNum), enemyIsReach)
			BattleSettlementController.instance:addConditionElement(lang("源起圣光飞龙存活"), holyDragonAlive)
			BattleSettlementController.instance:addConditionElement(langPara("源起圣光飞龙击杀数≥%d <color=#%s>(%d/%d)</color>", targetKillCount, holyDragonKillColor, holyDragonKillCount, targetKillCount), holyDragonKillReach)

			if msg.pass then
				UIStateManager.instance:open(ViewName.BattleSettlementSuccess)
			else
				UIStateManager.instance:open(ViewName.BattleSettlementFail)
			end
		end
	end
end

function OriginHolyChallengeController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	self._isBattleEnded = true

	local msg = self._lastChallengeResult

	if not msg then
		return true
	end

	self:_openSettlementByResult(msg)

	return true
end

function OriginHolyChallengeController:openMissionView(activityId, stageId)
	local fmtMo = OriginHolyChallengeModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginHolyChallengeController:isAllStagePassed(activityId)
	local stageCfgs = OriginHolyChallengeConfig.instance:getStages(activityId) or {}

	for _, v in ipairs(stageCfgs) do
		if OriginHolyChallengeModel.instance:getPassStage(activityId) < v.stageId then
			return false
		end
	end

	return true
end

OriginHolyChallengeController.instance = OriginHolyChallengeController.New()

return OriginHolyChallengeController
