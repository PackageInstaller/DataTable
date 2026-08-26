-- chunkname: @modules/logic/rouge2/bossbattle/controller/Rouge2_BossBattleController.lua

module("modules.logic.rouge2.bossbattle.controller.Rouge2_BossBattleController", package.seeall)

local Rouge2_BossBattleController = class("Rouge2_BossBattleController", BaseController)

function Rouge2_BossBattleController:enterFight(bossId)
	if not Rouge2_FightRecordController.instance:hasUseSaveIndex() then
		local minDiffName, minDiff = Rouge2_FightRecordController.instance:getMainRecordDifficultyName()

		GameFacade.showToast(ToastEnum.Rouge2CantBossBattle, minDiffName, minDiff)

		return
	end

	local episodeCo = self:getEpisodeCoByBossId(bossId)
	local episodeId = episodeCo and episodeCo.id
	local chapterId = episodeCo and episodeCo.chapterId

	HeroGroupTrialModel.instance:clear()
	DungeonFightController.instance:enterFight(chapterId, episodeId, Rouge2_OutsideEnum.BossMultiplication)
end

function Rouge2_BossBattleController:startFight()
	local result = FightController.instance:setFightHeroSingleGroup()

	if not result then
		return
	end

	local fightParam = FightModel.instance:getFightParam()

	DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, Rouge2_OutsideEnum.BossMultiplication)
end

function Rouge2_BossBattleController:generateTempHeroGroup(battleId, episodeId)
	local tempgroupMO = HeroGroupMO.New()
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		local curBattleTrialHeros = HeroGroupHandler.getTrialHeros(episodeId)
		local roleNum = battleCO.roleNum
		local playerMax = battleCO.playerMax

		tempgroupMO:initWithBattle(HeroGroupMO.New(), (not string.nilorempty(battleCO.aid) or nil) and string.splitToNumber(battleCO.aid, "#"), roleNum, playerMax, nil, (not string.nilorempty(curBattleTrialHeros) or nil) and GameUtil.splitString2(curBattleTrialHeros, true))
	end

	local saveInfo = Rouge2_FightRecordController.instance:getUseSaveInfo()
	local localData = self:_saveInfo2GroupInfo(saveInfo)

	tempgroupMO:initByLocalData(localData)

	return tempgroupMO
end

function Rouge2_BossBattleController:_saveInfo2GroupInfo(saveInfo)
	local groupInfo = {}

	groupInfo.clothId = 0
	groupInfo.params = ""
	groupInfo.heroList = {}
	groupInfo.equips = {}
	groupInfo.version = HeroGroupEnum.saveTrialVersion

	local reviewInfo = saveInfo and saveInfo:getReviewInfo()

	for i = 1, Rouge2_OutsideEnum.BossShowHeroCount do
		local teamInfo = reviewInfo and reviewInfo:getLastTeamInfoByIndex(i)
		local heroUid = teamInfo and teamInfo:getHeroUid()
		local isTrial = teamInfo and teamInfo:isTrial()

		groupInfo.heroList[i] = heroUid or 0

		if isTrial then
			groupInfo.trialDict = groupInfo.trialDict or {}
			groupInfo.trialDict[i] = groupInfo.trialDict[i] or {}
			groupInfo.trialDict[i][1] = teamInfo:getTrialId()
		else
			local equipUidList = teamInfo and teamInfo:getEquipUidList()

			if equipUidList then
				local equipUid = equipUidList[1]

				if equipUid then
					::label_4_0::

					local equipMo = EquipModel.instance:getEquip(equipUid)

					groupInfo.equips[i] = equipMo and equipUid or "0"
				end
			end
		end
	end

	return groupInfo
end

function Rouge2_BossBattleController:getCurSaveTrialHeroIdStr()
	local saveInfo = Rouge2_FightRecordController.instance:getUseSaveInfo()
	local reviewInfo = saveInfo and saveInfo:getReviewInfo()
	local trailIdStrList = {}

	for i = 1, Rouge2_OutsideEnum.BossShowHeroCount do
		local teamInfo = reviewInfo and reviewInfo:getLastTeamInfoByIndex(i)
		local isTrial = teamInfo and teamInfo:isTrial()

		if isTrial then
			local trialIdStr = teamInfo:getTrialIdStr()

			table.insert(trailIdStrList, trialIdStr)
		end
	end

	return table.concat(trailIdStrList, "|") or ""
end

function Rouge2_BossBattleController:onExitHeroGroup(selectEpisodeId)
	selectEpisodeId = selectEpisodeId or HeroGroupModel.instance.episodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, Rouge2_BossBattleController._onEnterMainSceneDone, selectEpisodeId)
end

function Rouge2_BossBattleController._onEnterMainSceneDone(selectEpisodeId)
	Rouge2_Controller.instance:enterDungeonView()
	Rouge2_ViewHelper.openEnterView({
		openMain = true,
		openMainCallback = function()
			Rouge2_ViewHelper.openBossBattleView()
			Rouge2_ViewHelper.openBossBattleDetailView({
				selectEpisodeId = selectEpisodeId
			})
		end
	})
end

function Rouge2_BossBattleController:onExistFight(episodeCo)
	local episodeId = episodeCo and episodeCo.id

	self:onExitHeroGroup(episodeId)
end

function Rouge2_BossBattleController:getBossFightConfig(bossId)
	local episodeCo = self:getEpisodeCoByBossId(bossId)

	if not episodeCo then
		return
	end

	local allBossIdList = self:getBossIdListByBattleId(episodeCo.battleId)
	local monsterId = allBossIdList and allBossIdList[1]

	if not monsterId then
		logError(string.format("怪物数量为0 bossId = %s", bossId))

		return
	end

	return lua_monster.configDict[monsterId]
end

function Rouge2_BossBattleController:getEpisodeCoByBossId(bossId)
	local bossRushCo = Rouge2_BossBattleConfig.instance:getBossConfig(bossId)
	local episodeId = bossRushCo and bossRushCo.levelId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError(string.format("关卡配置不存在 bossId = %s, episodeId = %s", bossId, episodeId))
	end

	return episodeCo
end

function Rouge2_BossBattleController:getBossIdListByBattleId(battleId)
	local battleCo = lua_battle.configDict[battleId]

	if not battleCo then
		logError(string.format("战斗配置不存在 battleId = %s", battleId))

		return
	end

	local allBossIdList = {}
	local monsterGroupIds = string.splitToNumber(battleCo.monsterGroupIds, "#")

	for _, groupId in ipairs(monsterGroupIds) do
		local monsterGroupCo = lua_monster_group.configDict[groupId]

		if not monsterGroupCo then
			logError(string.format("怪物组配置不存在 groupId = %s", groupId))
		else
			local bossIdList = string.splitToNumber(monsterGroupCo.bossId, "#")

			tabletool.addValues(allBossIdList, bossIdList)
		end
	end

	return allBossIdList
end

function Rouge2_BossBattleController:checkIsNewHighestScore(bossId, score)
	score = score or 0

	local battleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()
	local bossInfo = battleInfo and battleInfo:getBossInfoById(bossId)

	return bossInfo and score > bossInfo:getMaxScore()
end

function Rouge2_BossBattleController:getCurBossBattleScore()
	return FightLocalDataMgr.instance.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.Rouge2Boss) or 0
end

function Rouge2_BossBattleController:getRoundMaxDamage()
	local extraStr = FightResultModel.instance:getExtraStr()
	local extraList = GameUtil.splitString2(extraStr, false, "|", ":")

	if extraList then
		for type, extraInfo in pairs(extraList) do
			if extraInfo[1] == "maxHurt" then
				return tonumber(extraInfo[2])
			end
		end
	end

	return 0
end

Rouge2_BossBattleController.instance = Rouge2_BossBattleController.New()

return Rouge2_BossBattleController
