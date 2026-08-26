-- chunkname: @modules/logic/fight/system/work/FightWorkDirectStartNewFightAfterEndFight.lua

module("modules.logic.fight.system.work.FightWorkDirectStartNewFightAfterEndFight", package.seeall)

local FightWorkDirectStartNewFightAfterEndFight = class("FightWorkDirectStartNewFightAfterEndFight", FightWorkItem)

function FightWorkDirectStartNewFightAfterEndFight:onStart()
	local curEpisodeId = FightDataHelper.fieldMgr.episodeId
	local nextEpisodeId, nextBattleId = self:getNextEpisodeIdByCurEpisodeId(curEpisodeId)

	FightMsgMgr.sendMsg(FightMsgId.RestartGame)

	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(FightWorkClearBeforeRestart)
	flow:registWork(FightWorkFunction, self.clearFight, self)
	self:_addTransition(curEpisodeId, flow)
	flow:registWork(FightWorkChangeFightScene, nextEpisodeId, nextBattleId)
	flow:registWork(FightWorkFunction, self.startNewFight, self, nextEpisodeId, nextBattleId)
	flow:start()
end

function FightWorkDirectStartNewFightAfterEndFight:startNewFight(nextEpisodeId, nextBattleId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(nextEpisodeId)
	local chapterId = episodeConfig.chapterId

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, nextEpisodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeId(nextEpisodeId)

	fightParam:setDungeon(chapterId, nextEpisodeId)

	fightParam.chapterId = chapterId

	HeroGroupModel.instance:setParam(nextBattleId, nextEpisodeId)
	HeroGroupTrialModel.instance:setTrialByBattleId(nextBattleId)

	local result = FightController.instance:setFightHeroSingleGroup()

	if result then
		DungeonRpc.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam)
	else
		logError(string.format("FightWorkDirectStartNewFightAfterEndFight:startNewFight error battleId:%s,episodeId:%s", nextBattleId, nextEpisodeId))
	end
end

function FightWorkDirectStartNewFightAfterEndFight:getNextEpisodeIdByCurEpisodeId(curEpisodeId)
	if curEpisodeId == VersionActivity2_8BossEnum.AutoEnterNextEpisodeFight then
		local nextEpisodeId = VersionActivity2_8BossEnum.StoryBossLastEpisode
		local battleId = DungeonConfig.instance:getEpisodeBattleId(nextEpisodeId)

		return nextEpisodeId, battleId
	end
end

function FightWorkDirectStartNewFightAfterEndFight.directStartNewFight(curEpisodeId)
	if curEpisodeId == VersionActivity2_8BossEnum.AutoEnterNextEpisodeFight and DungeonModel.instance:hasPassLevelAndStory(curEpisodeId) then
		return true
	end
end

function FightWorkDirectStartNewFightAfterEndFight:clearFight()
	FightModel.instance:clear()
end

function FightWorkDirectStartNewFightAfterEndFight:_addTransition(curEpisodeId, flow)
	if curEpisodeId == VersionActivity2_8BossEnum.AutoEnterNextEpisodeFight then
		local instance = VersionActivity2_8DungeonBossController.instance

		flow:registWork(FightWorkFunction, instance.openVersionActivity2_8BossStoryEyeView, instance)
		flow:registWork(FightWorkDelayTimer, 0.5)
	end
end

return FightWorkDirectStartNewFightAfterEndFight
