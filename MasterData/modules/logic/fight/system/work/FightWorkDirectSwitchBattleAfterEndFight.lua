-- chunkname: @modules/logic/fight/system/work/FightWorkDirectSwitchBattleAfterEndFight.lua

module("modules.logic.fight.system.work.FightWorkDirectSwitchBattleAfterEndFight", package.seeall)

local FightWorkDirectSwitchBattleAfterEndFight = class("FightWorkDirectSwitchBattleAfterEndFight", FightWorkItem)

function FightWorkDirectSwitchBattleAfterEndFight:onStart()
	local config = lua_fight_direct_switch_battle_when_end.configDict[FightDataHelper.fieldMgr.battleId]

	if config.nextEpisodeId ~= 0 then
		if not config.nextEpisodeId then
			local nextEpisodeId = FightDataHelper.fieldMgr.episodeId
			local nextBattleId = config.nextBattleId

			FightMsgMgr.sendMsg(FightMsgId.RestartGame)

			local flow = self:com_registWorkDoneFlowSequence()

			flow:registWork(FightWorkClearBeforeRestart)
			flow:registWork(FightWorkFunction, self.clearFight, self)
			flow:registWork(FightWorkChangeFightScene, nextEpisodeId, nextBattleId)
			flow:registWork(FightWorkFunction, self.startNewFight, self, nextEpisodeId, nextBattleId)
			flow:start()
		end
	end
end

function FightWorkDirectSwitchBattleAfterEndFight:startNewFight(nextEpisodeId, nextBattleId)
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
		logError(string.format("FightWorkDirectSwitchBattleAfterEndFight:startNewFight error battleId:%s,episodeId:%s", nextBattleId, nextEpisodeId))
	end
end

function FightWorkDirectSwitchBattleAfterEndFight:clearFight()
	FightModel.instance:clear()
end

return FightWorkDirectSwitchBattleAfterEndFight
