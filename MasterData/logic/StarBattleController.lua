-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/controller/StarBattleController.lua

module("logic.extensions.starbattle.controller.StarBattleController", package.seeall)

local StarBattleController = class("StarBattleController", BaseController)

function StarBattleController:onInit()
	self:onReset()
end

function StarBattleController:onReset()
	self._defFmtMoMap = {}
	self._stageFmtMoMap = {}
	self._bossFmtMoMap = {}
	self._lastVerifyRaceId = 0
	self.ciList = nil
end

function StarBattleController:getCurrentPeriodId(activityId)
	local periodId = 1
	local cfgs = StarBattleConfig.instance:getPeriodCfgs(activityId)

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			if GameUtil.checkIsInTimePeriod(cfg.openTime, cfg.endTime) then
				periodId = cfg.periodId

				break
			end
		end
	end

	return periodId
end

function StarBattleController:getInfoKey(activityId, periodId)
	local actId = checknumber(activityId)
	local perId = checknumber(periodId)

	if actId > 0 and perId > 0 then
		return string.format("%s_%s", actId, perId)
	end
end

function StarBattleController:_getDefFmtMo(activityId, periodId)
	local key = self:getInfoKey(activityId, periodId)

	if key then
		local fmtMo = self._defFmtMoMap[key]

		if not fmtMo then
			fmtMo = StarBattleDefFmtMo.New()
			self._defFmtMoMap[key] = fmtMo
		end

		return fmtMo
	end
end

function StarBattleController:_getStageFmtMo(activityId, periodId)
	local key = self:getInfoKey(activityId, periodId)

	if key then
		local fmtMo = self._stageFmtMoMap[key]

		if not fmtMo then
			fmtMo = StarBattleStageFmtMo.New()
			self._stageFmtMoMap[key] = fmtMo
		end

		return fmtMo
	end
end

function StarBattleController:_getBossFmtMo(activityId, periodId)
	local key = self:getInfoKey(activityId, periodId)

	if key then
		local fmtMo = self._bossFmtMoMap[key]

		if not fmtMo then
			fmtMo = StarBattleBossFmtMo.New()
			self._bossFmtMoMap[key] = fmtMo
		end

		return fmtMo
	end
end

function StarBattleController:showDefMissionFormation(activityId, periodId, isNew)
	local fmtMo = self:_getDefFmtMo(activityId, periodId)

	if fmtMo then
		fmtMo:initParams(activityId, periodId, isNew)
		CustomFmtController.instance:showMissionFormationView(fmtMo)
	end
end

function StarBattleController:showStageMissionView(activityId, periodId, stageId)
	local fmtMo = self:_getStageFmtMo(activityId, periodId)

	if fmtMo then
		fmtMo:initParams(activityId, periodId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function StarBattleController:showBossMissionView(activityId, periodId, bossId)
	local fmtMo = self:_getBossFmtMo(activityId, periodId)

	if fmtMo then
		fmtMo:initParams(activityId, periodId, bossId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function StarBattleController:getInfo(activityId, periodId)
	StarBattleAgent.instance:sendPM_StarBattleInfoReq(activityId, periodId)
end

function StarBattleController:handleGetInfo(msg)
	StarBattleModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleGetInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleGainDefensePrize)
	self:refreshRPInfo(msg.activityId, msg.periodId)
end

function StarBattleController:saveDefense(activityId, form, periodId)
	StarBattleAgent.instance:sendPM_StarBattlesetDefenseReq(activityId, form, periodId)
end

function StarBattleController:handleSaveDefense(msg)
	StarBattleModel.instance:onSaveDefense(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleSaveDefense)
	TipsFacade.instance:openCommonTips("保存成功！")
end

function StarBattleController:startStageChallenge(activityId, stageId, form, periodId)
	StarBattleAgent.instance:sendPM_StarBattleStageChallengeReq(activityId, stageId, form, periodId)
end

function StarBattleController:handleNotifyStageChallenge(msg)
	StarBattleModel.instance:onNotifyStageChallenge(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleNotifyStageChallenge)

	if not msg.periodId then
		self.ciList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self.ciList)

		if msg.periodId == 2 or msg.periodId == 3 then
			BattleFacade.instance:registerResultHandler(nil, nil)
			BattleFacade.instance:registerResultHandler(function()
				ViewMgr.instance:open(ViewName.StarBattleStageResultView, msg)

				return true
			end)
		elseif (msg.periodId == 1 or msg.periodId == 4) and msg.isWin then
			BattleFacade.instance:registerResultHandler(nil, nil)
			BattleFacade.instance:registerResultHandler(function()
				ViewMgr.instance:open(ViewName.StarBattleStageResultView, msg)

				return true
			end)
		end
	end
end

function StarBattleController:startBossChallenge(activityId, form, bossId, periodId)
	StarBattleAgent.instance:sendPM_StarBattleBossChallengeReq(activityId, form, bossId, periodId)
end

function StarBattleController:handleNotifyBossChallenge(msg)
	StarBattleModel.instance:onNotifyBossChallenge(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleNotifyBossChallenge)
	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.StarBattleBossResultView, msg)

		return true
	end)
end

function StarBattleController:signIn(activityId, periodId)
	StarBattleAgent.instance:sendPM_StarBattleSignInReq(activityId, periodId)
end

function StarBattleController:handleSignIn(msg)
	StarBattleModel.instance:onSignIn(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleSignIn)
	self:refreshRPInfo(msg.activityId, msg.periodId)
end

function StarBattleController:gainProgressPrize(activityId, progressId, periodId)
	StarBattleAgent.instance:sendPM_StarBattleGainProgressPrizeReq(activityId, progressId, periodId)
end

function StarBattleController:handleGainProgressPrize(msg)
	StarBattleModel.instance:onGainProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleGainProgressPrize)
	self:refreshRPInfo(msg.activityId, msg.periodId)
end

function StarBattleController:getRankView(activityId, rankId, periodId)
	StarBattleAgent.instance:sendPM_StarBattleRankViewReq(activityId, rankId, periodId)
end

function StarBattleController:handleGetRankView(msg)
	StarBattleModel.instance:onGetRankView(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleGetRankView)
end

function StarBattleController:verifyRace(activityId, raceId, periodId)
	self._lastVerifyRaceId = raceId

	StarBattleAgent.instance:sendPM_StarBattleVerifyRaceReq(activityId, raceId, periodId)
end

function StarBattleController:handleVerifyRace(msg)
	local addScore = 0
	local info = StarBattleModel.instance:getBaseInfo(msg.activityId, msg.periodId)

	if info then
		addScore = checknumber(msg.totalScore) - checknumber(info.totalScore)
	end

	StarBattleModel.instance:onVerifyRace(msg)

	if addScore > 0 then
		local raceName = MaterialMgr.getMaterialsName(MatType.Pet, self._lastVerifyRaceId)
		local addRadio = 0
		local periodCfg = StarBattleConfig.instance:getPeriodCfg(msg.activityId, msg.periodId)

		if periodCfg then
			local cfg = StarBattleConfig.instance:getFormationRaceCfgByRaceId(periodCfg.formationRacePlanId, self._lastVerifyRaceId)

			if cfg then
				addRadio = cfg.scorePercent or 0
			end
		end

		local showTips = string.format("检测到您拥有<color=#eb4642>%s</color>,可获得<color=#eb4642>%s%%</color>的积分加成,现为您补发已通关关卡的额外积分：%s", raceName, addRadio, addScore)

		TipsFacade:openTipWindowNoX("额外加成", showTips, function()
			GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleVerifyRace)
		end, "确定")
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_StarBattleVerifyRace)
	end
end

function StarBattleController:oneClickGainDefensePrize(activityId, periodId, prizeType, raceId)
	StarBattleAgent.instance:sendPM_StarBattleOneClickGainDefensePrizeReq(activityId, periodId, prizeType, raceId)
end

function StarBattleController:handleOneClickGainDefensePrize(msg)
	self:getInfo(msg.activityId, msg.periodId)
end

function StarBattleController:recordLastTab(activityId, periodId, tab)
	local key = string.format("starBattle_lastTab_%s_%s", activityId, periodId)

	GameUtil.saveUserData(key, tab)
end

function StarBattleController:getLastTab(activityId, periodId)
	local key = string.format("starBattle_lastTab_%s_%s", activityId, periodId)

	return checknumber(GameUtil.getUserData(key))
end

function StarBattleController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function StarBattleController:refreshRPInfo(activityId, periodId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_STAR_BATTLE_BUFF, false, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_STAR_BATTLE_DEF_PRIZE, false, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_STAR_BATTLE_BOSS_PRIZE, false, true)

	local isShowBuff = false
	local isShowDefPrize = false
	local isShowBossPrize = false
	local info = StarBattleModel.instance:getBaseInfo(activityId, periodId)

	if info then
		if not info.isBeginner then
			if not info.maxDefenseZdl then
				local maxZdl = 0

				if not info.defenseRaceInfos then
					local defenseRaceInfos = {}

					if not info.hasGainDefencePrizeIds then
						local hasGainDefencePrizeIds = {}
						local defenseRaceInfoMap = {}

						for _, defRaceInfo in ipairs(defenseRaceInfos) do
							local raceInfo = {}

							raceInfo.raceId = defRaceInfo.raceId
							raceInfo.maxZdl = defRaceInfo.maxZdl
							raceInfo.hasGainDefenceRacePrizeIdMap = {}

							if not defRaceInfo.hasGainDefenceRacePrizeIds then
								local hasGainDefenceRacePrizeIds = {}

								for i, prizeId in ipairs(hasGainDefenceRacePrizeIds) do
									raceInfo.hasGainDefenceRacePrizeIdMap[prizeId] = true
								end

								defenseRaceInfoMap[defRaceInfo.raceId] = raceInfo
							end
						end

						local hasGainDefencePrizeIdMap = {}

						for _, prizeId in ipairs(hasGainDefencePrizeIds) do
							hasGainDefencePrizeIdMap[prizeId] = true
						end

						local periodCfg = StarBattleConfig.instance:getPeriodCfg(activityId, periodId)

						for i, prizeCfg in ipairs(info.isBeginner and StarBattleConfig.instance:getDefensePrizeCfgs(periodCfg.newDefensePlanId) or StarBattleConfig.instance:getDefensePrizeCfgs(periodCfg.oldDefensePlanId)) do
							if not prizeCfg.range then
								local range = 0

								if maxZdl >= prizeCfg.range and not hasGainDefencePrizeIdMap[i] then
									isShowDefPrize = true

									break
								end

								local isNeedShow = false
								local raceCfgs = StarBattleConfig.instance:getDefenseRacePrizeCfgs(prizeCfg.defenseRacePlanId)

								for _, raceCfg in pairs(raceCfgs) do
									local raceInfo = defenseRaceInfoMap[raceCfg.raceId]

									if raceInfo and range <= raceInfo.maxZdl and not raceInfo.hasGainDefenceRacePrizeIdMap[i] then
										isNeedShow = true

										break
									end
								end

								if isNeedShow then
									isShowDefPrize = true

									break
								end
							end
						end

						local buffCfgs = StarBattleConfig.instance:getBuffCfgs(periodCfg.buffPlanId) or {}

						if not info.signInDays then
							local signInDays = 0

							if not info.isTodaySignIn then
								local isTodaySignIn = false
								local buffCfg = StarBattleConfig.instance:getBuffCfgByDays(periodCfg.buffPlanId, signInDays)

								isShowBuff = not isTodaySignIn and not ((buffCfg or nil) and (buffCfg.buffId or 0) >= #buffCfgs)

								if not info.hasGainBossProgressIds then
									local hasGainBossProgressIds = {}
									local totalBossDamage = checknumber(info.totalBossDamage)
									local hasGainBossProgressMap = {}

									for _, progressId in ipairs(hasGainBossProgressIds) do
										hasGainBossProgressMap[progressId] = true
									end

									local bossPrizeCfgs = StarBattleConfig.instance:getBossProgressPrizeCfgs(periodCfg.progressPlanId)

									for _, prizeCfg in ipairs(bossPrizeCfgs) do
										if totalBossDamage >= checknumber(prizeCfg.totalDamage) and not hasGainBossProgressMap[prizeCfg.progressId] then
											isShowBossPrize = true

											break
										end
									end

									RedPointController.instance:setRedPointInfo(RedPointModel.ID_STAR_BATTLE_DEF_PRIZE, isShowDefPrize, true)
									RedPointController.instance:setRedPointInfo(RedPointModel.ID_STAR_BATTLE_BUFF, isShowBuff, true)
									RedPointController.instance:setRedPointInfo(RedPointModel.ID_STAR_BATTLE_BOSS_PRIZE, isShowBossPrize, true)
								end
							end
						end
					end
				end
			end
		end
	end
end

StarBattleController.instance = StarBattleController.New()

return StarBattleController
