-- chunkname: @IQIGame\\Module\\GameChapter\\GameChapterModule.lua

GameChapterModule = {}

function GameChapterModule.SetupCurChapterType(chapterType)
	GameChapterModule.CurSelectChapterType = chapterType
end

function GameChapterModule.SetupCurChapterUserData(data)
	GameChapterModule.CurSelectChapterUserData = data
end

function GameChapterModule.ClearCache()
	GameChapterModule.CurSelectChapterType = nil
	GameChapterModule.CurSelectChapterUserData = nil
	GameChapterModule.CurSelectPlayingMethodType = nil
	GameChapterModule.lastSelectChapterTagId = nil
	GameChapterModule.ToggleType = nil
end

function GameChapterModule.SetPlayingMethodDuoTag(tag)
	GameChapterModule.CurSelectPlayingMethodType = tag
end

function GameChapterModule.Initialize()
	GameChapterModule.ClearCache()
end

function GameChapterModule.IsUnlockByJump(type, chapterId)
	if type == Constant.ChapterPassType.TYPE_MAINLINE then
		-- block empty
	elseif type == Constant.ChapterPassType.TYPE_RESOURCES then
		if chapterId == nil then
			return ResourceChapterModule.GetAllResourceChapters()[1]:SubStageIsUnLock()
		else
			return ResourceChapterModule.ChapterList[chapterId]:IsOpen() and ResourceChapterModule.ChapterList[chapterId]:SubStageIsUnLock()
		end
	elseif type == Constant.ChapterPassType.TYPE_EQUIP then
		if chapterId == nil then
			return EquipChapterModule.GetAllResourceChapters()[1]:SubStageIsUnLock()
		else
			return EquipChapterModule.ChapterList[chapterId]:SubStageIsUnLock()
		end
	elseif type == Constant.ChapterPassType.TYPE_BOSS then
		if chapterId == nil then
			return BossChapterModule.GetAllResourceChapters()[1]:SubStageIsUnLock()
		else
			return BossChapterModule.ChapterList[chapterId]:SubStageIsUnLock()
		end
	elseif type == Constant.ChapterPassType.TYPE_OTHER then
		-- block empty
	end
end

function GameChapterModule.EnterDupByChapterType(enterDupData)
	if StoryModule.IsStoring then
		EventDispatcher.Dispatch(EventID.StoryStartFight)
		EventDispatcher.AddSingleEventListener(EventID.OnNormalFightInStoryOverEvent, function()
			BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0.5)
		end)
	end

	local agentSkill = {}

	if enterDupData.isCanGointoBattle then
		agentSkill = FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill
	end

	local allAttackOrderDict = FormationModule.GetAllAttackOrderDict()

	if enterDupData.Units then
		for _, unit in pairs(enterDupData.Units) do
			unit.order = allAttackOrderDict[unit.val]
		end
	end

	local needSave = true

	if enterDupData.ChapterType == Constant.ChapterPassType.TYPE_MAINLINE then
		net_plotStage.enterFight(enterDupData.StoryBattleID, enterDupData.Units, agentSkill)

		needSave = false
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_RESOURCES then
		ResourceChapterModule.EnterDup(enterDupData.PassId, enterDupData.FightCount, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_EQUIP then
		EquipChapterModule.EnterDup(enterDupData.PassId, enterDupData.FightCount, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_BOSS or enterDupData.ChapterType == Constant.ChapterPassType.Type_GhostBoss then
		BossChapterModule.EnterDup(enterDupData.PassId, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		TowerChapterModule.RpcEnterDup(enterDupData.PassId, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_Favor then
		net_favorable.enterDup(enterDupData.PassId, enterDupData.HeroID)

		GameChapterModule.currentFavorDupCfg = CfgWorldMapItemTable[enterDupData.passId]
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_Maze then
		MazeModule.OnEncounterMonsterEvent(enterDupData.StoryBattleID)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_BattleActivity then
		net_activityDup.enterDup(enterDupData.PassId, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_Challenge then
		net_challengeDup.enterDup(enterDupData.PassId, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_SummerActivity then
		SummerActivityModule.EnterMingleDup(enterDupData.PassId, enterDupData.FightCount, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.TYPE_Ghost then
		net_generalDup.enterMingleDup(enterDupData.PassId, enterDupData.FightCount, enterDupData.Units, agentSkill)
	elseif enterDupData.ChapterType == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		ChallengeWorldBossModule.OnEnterStage(enterDupData.PassId, enterDupData.Units, agentSkill)
	else
		net_randomDup.enterDup(enterDupData.PassId, enterDupData.Units, agentSkill)
	end

	if needSave then
		GameChapterModule.CurSelectChapterCfg = FormationModule.GetChapterConfigByType(enterDupData.ChapterType, enterDupData.PassId, enterDupData.StoryBattleID)
		GameChapterModule.lastEnterChapterData = enterDupData

		GameChapterModule.SetupCurChapterType(enterDupData.ChapterType)
	end
end

function GameChapterModule.NotifyDupComplete(star, shows)
	local fightResult = star == Constant.FightResult.ATTACKER_WIN and star or Constant.FightResult.DEFENDER_WIN

	GameChapterModule.LevelEndResult({
		fightResult,
		1,
		shows
	})
end

function GameChapterModule.Shutdown()
	GameChapterModule.CurSelectChapterUserData = nil
	GameChapterModule.CurSelectChapterCfg = nil
	GameChapterModule.CurSelectChapterType = nil
end

function GameChapterModule.LevelEndResult(items)
	return
end

function GameChapterModule.CacheFightUnits(fightInfo)
	GameChapterModule.fightOverUnits = fightInfo.units
end

function GameChapterModule.EnterDup(chapterType)
	return
end

function GameChapterModule.BattleOver()
	return
end

function GameChapterModule.GetStageRewards()
	return
end

function GameChapterModule.GetIsIdenticalActivityTag(dupTagCfg)
	local cfg
	local dupDatas = {}

	if dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		cfg = CfgDailyDupChapterTable
	elseif dupTagCfg.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		cfg = CfgEquipDupChapterTable
	end

	for k, v in pairs(cfg) do
		if #dupTagCfg.FilterIds > 0 then
			if table.indexOf(dupTagCfg.FilterIds, k) ~= -1 then
				table.insert(dupDatas, v)
			end
		else
			table.insert(dupDatas, v)
		end
	end

	if table.len(dupDatas) <= 1 then
		return false
	end

	local activityTag

	for _, v in ipairs(dupDatas) do
		if activityTag == nil then
			activityTag = v.ActivityTag
		elseif activityTag ~= v.ActivityTag then
			return false
		end
	end

	return true, activityTag
end
