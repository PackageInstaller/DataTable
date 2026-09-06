-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/controller/ShenJiChallengeController.lua

module("logic.extensions.shenjichallenge.controller.ShenJiChallengeController", package.seeall)

local ShenJiChallengeController = class("ShenJiChallengeController", BaseController)

function ShenJiChallengeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.KingJiChallengeNotifySelectClgRes, self._onNotifySelectClgRes, self)
	GlobalDispatcher:addListener(GlobalNotify.KingJiChallengeNotifyBossClgRes, self._onNotifyBossClgRes, self)
end

function ShenJiChallengeController:_onNotifySelectClgRes()
	local params = {}

	params.clgType = ShenJiChallengeModel.SelectStage

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.ShenJiChallenge, params)
end

function ShenJiChallengeController:_onNotifyBossClgRes(actId, isEmulate, isWin)
	local actCfg = ShenJiChallengeConfig.instance:getActivityCfg(actId)

	if not isEmulate and isWin then
		if actCfg then
			if not actCfg.dailyLimit then
				local dailyLimit = false

				if not dailyLimit then
					UIJumper.instance:pushOneStack(ViewName.OriginMoonShadowKingBossPassView, true, actId)
				else
					UIJumper.instance:pushOneStack(ViewName.ShenJiBossPassView, true, actId)
				end
			end
		end
	end
end

function ShenJiChallengeController:openSelectMissionView(activityId, stageId)
	local customFmtMo = ShenJiChallengeModel.instance:getSelectCustomFmtMo()

	customFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function ShenJiChallengeController:openBossMissionView(activityId, bossId, isEmulate)
	local customFmtMo = ShenJiChallengeModel.instance:getBossCustomFmtMo()

	customFmtMo:initParams(activityId, bossId, isEmulate)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function ShenJiChallengeController:openExtraBattleResultView(params)
	if params.clgType == ShenJiChallengeModel.SelectStage then
		local num = ShenJiChallengeModel.instance:getChangeBuffValue()

		if num > 0 then
			if not ColorConst.Green then
				local colorStr = ColorConst.Red
				local text = ""
				local activityId = ShenJiChallengeModel.instance:getCurActivityId()
				local rewardName = ShenJiChallengeConfig.instance:getCommonValue(activityId, "rewardName")

				text = string.format(lang("本局获得%s\n\n<color=#%s>%d</color>"), rewardName, colorStr, num)

				local alignment = UnityEngine.TextAnchor.MiddleCenter

				TipsFacade.instance:openTipWindowNoX(lang("tip"), text, nil, nil, alignment)
			end
		end
	elseif params.clgType == ShenJiChallengeModel.BossStage then
		self:openBossBattleResultView(params)
	end
end

function ShenJiChallengeController:openBossBattleResultView(params)
	if params.clgType == ShenJiChallengeModel.BossStage then
		local bossLeftHp = 0
		local bossTotalHp = params.bossTotalHp

		if params.isEmulate then
			local curHp = params.bossCurHp
			local changeHp = ShenJiChallengeModel.instance:getOutputDamage()

			bossLeftHp = Mathf.Max(curHp - changeHp, 0)

			UIStateManager.instance:push(ViewName.ShenJiBossHpView, params.isEmulate, bossLeftHp, bossTotalHp)
		else
			local newBossId = ShenJiChallengeModel.instance:getBossId()
			local battleBossId = params.bossId

			bossLeftHp = newBossId == battleBossId and ShenJiChallengeModel.instance:getBossCurHp() or 0

			local cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(params.activityId)
			local maxNum = cfgActivity.fightBossTimes
			local curNum = ShenJiChallengeModel.instance:getBossChallengeTimes()
			local isBossWin = ShenJiChallengeModel.instance:getBossIsWin()

			UIStateManager.instance:push(ViewName.ShenJiBossHpView, params.isEmulate, bossLeftHp, bossTotalHp, isBossWin, curNum, maxNum)
		end
	end
end

function ShenJiChallengeController:sendPM_ShenJiChallengeBossClgReq(actId, bossId, form, isEmulate)
	local params = {}

	params.clgType = ShenJiChallengeModel.BossStage
	params.bossId = bossId
	params.bossTotalHp = ShenJiChallengeModel.instance:getBossTotalHp()
	params.bossCurHp = ShenJiChallengeModel.instance:getBossCurHp()
	params.isEmulate = isEmulate
	params.activityId = actId

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.ShenJiChallenge, params)
	ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeBossClgReq(actId, bossId, form, isEmulate)
end

ShenJiChallengeController.instance = ShenJiChallengeController.New()

return ShenJiChallengeController
