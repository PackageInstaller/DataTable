-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/controller/SummerTreasureSnatchController.lua

module("logic.extensions.summertreasuresnatch.controller.SummerTreasureSnatchController", package.seeall)

local SummerTreasureSnatchController = class("SummerTreasureSnatchController", BaseController)

SummerTreasureSnatchController.BuyItemType = {
	PetExperience = 3,
	BossTimes = 1,
	Buff = 2
}
SummerTreasureSnatchController.TeamType = {
	Left = 1,
	Right = 2
}

function SummerTreasureSnatchController:onInit()
	self:onReset()
end

function SummerTreasureSnatchController:onReset()
	self._btlResultList = nil
	self._curBtlResultIdx = 0
	self._battleMsg = nil
	self._oldScore = 0
	self._newScore = 0
	self._selectBossIdx = 1
end

function SummerTreasureSnatchController:getBossIdx()
	return self._selectBossIdx
end

function SummerTreasureSnatchController:setBossIdx(bossIdx)
	self._selectBossIdx = bossIdx
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchInfoReq(activityId)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchInfoReq(activityId)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchInfoRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchInfoRes(msg)

	local gainBuffIdMap = SummerTreasureSnatchModel.instance:getBuffIdMap(msg.activityId)
	local petExperienceMap = SummerTreasureSnatchModel.instance:getPetExperienceMap(msg.activityId)
	local info = SummerTreasureSnatchModel.instance:getInfo(msg.activityId)

	for i, itemId in ipairs(info.gainItemId) do
		local cfg = SummerTreasureSnatchConfig.instance:getShopCfg(msg.activityId, itemId)

		if cfg then
			local itemType = cfg.itemType

			if itemType == self.BuyItemType.Buff then
				gainBuffIdMap[cfg.itemParam] = true
			elseif itemType == self.BuyItemType.PetExperience then
				petExperienceMap[cfg.itemParam] = true
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_SummerTreasureSnatchInfoRes, msg.activityId)
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchPvpMatchReq(activityId)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchPvpMatchReq(activityId)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchPvpMatchRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchPvpMatchRes(msg)

	local fmtMo = SummerTreasureSnatchModel.instance:getPvpFmtMo(msg.activityId)

	fmtMo:updateCfg(msg.activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchPvpFightReq(activityId, formList)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchPvpFightReq(activityId, formList)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchPvpFightRes(msg)
	local info = SummerTreasureSnatchModel.instance:getInfo(msg.activityId)

	self._oldScore = info and checknumber(info.score) or 0
	self._newScore = self._oldScore + checknumber(msg.gainScore)
	self._battleMsg = msg

	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchPvpFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummerTreasureSnatchPvpFightRes, msg.activityId)
	self:_startPvpBattle(msg.battleResult, msg.activityId)
end

function SummerTreasureSnatchController:_startPvpBattle(battleResultList, activityId)
	self._btlResultList = battleResultList
	self._curBtlResultIdx = 0

	if self._btlResultList == nil or self._btlResultList[1] == nil then
		FloatWordMgr.instance:show(lang("后端返回战斗结果为空"))

		return
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onPvpBattleEnd, self, activityId), self)
	BattleController.instance:viewUserFightMonsterBtlResultWithList(self._btlResultList, GameUtil.handler(self._onPvpNextBattle, self), false)
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
end

function SummerTreasureSnatchController:_onPvpNextBattle(idx)
	self._curBtlResultIdx = idx

	BattleFacade.instance:startSummerTreasureSnatchPvpFight(#self._btlResultList > 1)
end

function SummerTreasureSnatchController:getCurBattleResultIdx()
	return self._curBtlResultIdx - 1
end

function SummerTreasureSnatchController:_onPvpBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	self:openBattleResultView(activityId)

	return true
end

function SummerTreasureSnatchController:openBattleResultView(activityId)
	local twoFormMoList = {}
	local twoPlayerInfo = {}

	for idx = 1, self._curBtlResultIdx do
		local btlResult = self._btlResultList[idx]
		local twoPlayerView = self:_getTwoPlayerView(btlResult)

		if twoPlayerView[1] and twoPlayerView[2] then
			twoPlayerInfo[1] = self:_buildPlayerInfo(twoPlayerView[1])
			twoPlayerInfo[2] = self:_buildPlayerInfo(twoPlayerView[2])

			local twoFormMo = {}

			twoFormMo.formId = idx
			twoFormMo.isChallengerWin = btlResult.activityWinner == 0
			twoFormMo.challengeZdl = twoPlayerView[1].fightPower
			twoFormMo.beChallengeZdl = twoPlayerView[2].fightPower
			twoFormMo.challengePets = self:_buildPetList(twoPlayerView[1])
			twoFormMo.beChallengePets = self:_buildPetList(twoPlayerView[2])

			table.insert(twoFormMoList, twoFormMo)
		end
	end

	UIStateManager.instance:open(ViewName.SummerTreasureSnatchBattleSettlementView, activityId, twoPlayerInfo[1], twoPlayerInfo[2], twoFormMoList, self._oldScore, self._newScore)
end

function SummerTreasureSnatchController:_getTwoPlayerView(btlResult)
	local twoPlayerView = {}

	if btlResult and btlResult.originalStates then
		if not btlResult.originalStates.teams then
			local teams = {}

			for i = 1, 2 do
				local teamId = i - 1

				for _, team in pairs(teams) do
					if team.teamId == teamId then
						twoPlayerView[i] = team.playerView
					end
				end
			end

			return twoPlayerView
		end
	end
end

function SummerTreasureSnatchController:_buildPlayerInfo(playerView)
	local headInfo = {
		userId = playerView.id,
		userName = playerView.name,
		playerLv = playerView.playerLv,
		headIconId = playerView.headIcon,
		headFrameId = playerView.headFrame
	}

	return {
		headInfo = headInfo
	}
end

function SummerTreasureSnatchController:_buildPetList(playerView)
	local petList = {}

	for _, petView in ipairs(playerView.characterViews or {}) do
		local petInfo = {}

		petInfo.skinId = petView.curFaceId
		petInfo.raceId = petView.raceId
		petInfo.level = petView.lv
		petInfo.awakenLv = petView.awakenLv
		petInfo.awakeLevel = petView.awakenLv
		petInfo.awakenLevel = petView.awakenLv
		petInfo.petMo = FightingPowerPetMo.createPetByLevel(petInfo.raceId, petInfo.level, petInfo.awakenLv, petInfo.skinId)
		petInfo.petMo.hideZdl = true

		table.insert(petList, petInfo)
	end

	return petList
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchBossClgReq(activityId, bossId, form, buffId, isTrial)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchBossClgReq(activityId, bossId, form, buffId, isTrial)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchBossClgRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchBossClgRes(msg)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchNotifyBossClgRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchNotifyBossClgRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBossBattleEnd, self, msg))
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummerTreasureSnatchNotifyBossClgRes, msg.activityId)
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchBuyItemReq(activityId, itemId)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchBuyItemReq(activityId, itemId)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchBuyItemRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchBuyItemRes(msg)

	local activityId = msg.activityId
	local costScore = 0
	local cfg = SummerTreasureSnatchConfig.instance:getShopCfg(activityId, msg.itemId)
	local buffIdMap = SummerTreasureSnatchModel.instance:getBuffIdMap(activityId)
	local petExperienceMap = SummerTreasureSnatchModel.instance:getPetExperienceMap(activityId)

	costScore = cfg and cfg.cost or 99

	local info = SummerTreasureSnatchModel.instance:getInfo(activityId)

	info.score = info.score - costScore

	if cfg then
		local itemType = cfg.itemType

		if itemType == self.BuyItemType.Buff then
			buffIdMap[cfg.itemParam] = true
		elseif itemType == self.BuyItemType.PetExperience then
			petExperienceMap[cfg.itemParam] = true
		else
			info.weeklyBuyBossClgTimes = info.weeklyBuyBossClgTimes + 1
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_SummerTreasureSnatchBuyItemRes, msg.activityId)
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchPresetFormationReq(activityId, formList)
	SummerTreasureSnatchModel.instance:setPendingPresetForms(activityId, formList)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchPresetFormationReq(activityId, formList)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchPresetFormationRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchPresetFormationRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummerTreasureSnatchPresetFormationRes, msg.activityId)
end

function SummerTreasureSnatchController:sendPM_SummerTreasureSnatchRankViewReq(activityId, isTotalRank)
	SummerTreasureSnatchAgent.instance:sendPM_SummerTreasureSnatchRankViewReq(activityId, isTotalRank)
end

function SummerTreasureSnatchController:handlePM_SummerTreasureSnatchRankViewRes(msg)
	SummerTreasureSnatchModel.instance:handlePM_SummerTreasureSnatchRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SummerTreasureSnatchRankViewRes, msg.activityId)
end

function SummerTreasureSnatchController:enterPvpBattleClg(activityId)
	self:sendPM_SummerTreasureSnatchPvpMatchReq(activityId)
end

function SummerTreasureSnatchController:enterBossBattleClg(activityId, bossId, isTrial)
	local fmtMo = SummerTreasureSnatchModel.instance:getBossFmtMo(activityId)

	fmtMo:updateCfg(activityId, bossId, isTrial)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function SummerTreasureSnatchController:getCurWeek(activityId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local startTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local weekSeconds = 604800
	local passTime = math.max(ServerTime.now() - startTimeStamp, 0)

	return math.floor(passTime / weekSeconds) + 1
end

function SummerTreasureSnatchController:_onBossBattleEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local damage = msg.damage
	local desc = langPara("造成伤害%s", damage)

	BattleSettlementController.instance:addConditionElement(desc, true)
	UIStateManager.instance:open(ViewName.BattleSettlementSuccess)

	return true
end

function SummerTreasureSnatchController:getRemainBossTimes(activityId)
	local info = SummerTreasureSnatchModel.instance:getInfo(activityId)
	local freeClgBossNum = SummerTreasureSnatchConfig.instance:getCommonNumber("DAILY_BOSS_CLG_FREE_TIMES")

	if info then
		if not info.remainBuyBossClgTimes then
			local remainBuyBossClgTimes = 0

			if info then
				if not info.todayBossClgTimes then
					local todayBossClgTimes = 0

					if freeClgBossNum <= todayBossClgTimes then
						return remainBuyBossClgTimes
					else
						return remainBuyBossClgTimes + freeClgBossNum - todayBossClgTimes
					end
				end
			end
		end
	end
end

function SummerTreasureSnatchController:getRemainPvpTimes(activityId)
	local info = SummerTreasureSnatchModel.instance:getInfo(activityId)

	if info then
		if not info.todayPvpTimes then
			local todayPvpTimes = 0
			local maxTimes = SummerTreasureSnatchConfig.instance:getCommonNumber("DAILY_PVP_TIMES")

			return math.max(maxTimes - todayPvpTimes, 0)
		end
	end
end

function SummerTreasureSnatchController:getBossBindRaceIdMap(activityId, exceptBossId)
	local curBindRaceIdMap = {}
	local curBossBindRaceIdMap = SummerTreasureSnatchModel.instance:getBossBindRaceIdMaps(activityId)

	for bossId, bindRaceIdMap in pairs(curBossBindRaceIdMap) do
		if bossId ~= exceptBossId then
			for k, v in pairs(bindRaceIdMap) do
				curBindRaceIdMap[k] = true
			end
		end
	end

	return curBindRaceIdMap
end

function SummerTreasureSnatchController:getPetExperienceRaceIdMap(activityId)
	local petExperienceMap = SummerTreasureSnatchModel.instance:getPetExperienceMap(activityId)
	local map = {}

	for petExperienceId, v in pairs(petExperienceMap) do
		local cfg = SummerTreasureSnatchConfig.instance:getSupportPetCfg(activityId, petExperienceId)

		if cfg then
			map[cfg.raceId] = true
		end
	end

	return map
end

SummerTreasureSnatchController.instance = SummerTreasureSnatchController.New()

return SummerTreasureSnatchController
