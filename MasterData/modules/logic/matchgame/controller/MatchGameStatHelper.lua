-- chunkname: @modules/logic/matchgame/controller/MatchGameStatHelper.lua

module("modules.logic.matchgame.controller.MatchGameStatHelper", package.seeall)

local MatchGameStatHelper = class("MatchGameStatHelper")

function MatchGameStatHelper:enterGame(episodeId)
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
	self.episodeId = episodeId
	self.chainIndex = 0
	self.chainArray = {}
	self.feverIndex = 0
	self.feverArray = {}
end

function MatchGameStatHelper:recordDragAction(chainIndex, selectItemList, gameInfoMo, curDragDamage, curRoundCount, curWaveCount)
	self.chainIndex = chainIndex + 1

	local normal_bead = 0
	local poison_bead = 0
	local seal_bead = 0

	for _, elementItem in ipairs(selectItemList) do
		if elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
			if elementItem.comp.curBuffType == MatchGameFightEnum.BuffType.None then
				normal_bead = normal_bead + 1
			end

			if elementItem.comp.curBuffType == MatchGameFightEnum.BuffType.Poison then
				poison_bead = poison_bead + 1
			end

			if elementItem.comp.curBuffType == MatchGameFightEnum.BuffType.Seal then
				seal_bead = seal_bead + 1
			end
		end
	end

	local chainData = {
		index = self.chainIndex,
		round = curRoundCount,
		wave = curWaveCount,
		damage = curDragDamage,
		secs = gameInfoMo.maxRoundTime,
		cnt = #selectItemList,
		legal = #selectItemList >= MatchGameFightEnum.MinMatchCount,
		normal = normal_bead,
		poison = poison_bead,
		seal = seal_bead
	}

	table.insert(self.chainArray, chainData)
end

function MatchGameStatHelper:recordFever(curRoundCount, curWaveCount, curFeverClickNum, curFeverAllMatchNum)
	self.feverIndex = self.feverIndex + 1

	local feverData = {
		index = self.feverIndex,
		round = curRoundCount,
		wave = curWaveCount,
		click = curFeverClickNum,
		cnt = curFeverAllMatchNum
	}

	table.insert(self.feverArray, feverData)
end

function MatchGameStatHelper:endGame(episodeId, isPass, stars, roundCount, score, maxRoundDamage, endReason)
	local heroIdList = {}
	local heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()

	if heroFightInfoMap then
		for _, heroFightMo in pairs(heroFightInfoMap) do
			local heroId = heroFightMo and heroFightMo.id

			table.insert(heroIdList, heroId)
		end
	end

	local useTime = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime
	local matchGameEpisodeObj = {
		score = score,
		max_round_dmg = maxRoundDamage,
		max_chain_num = MatchGameFightModel.instance:getMaxChainNum(),
		skills = MatchGameFightModel.instance:getTotalSkillUseNum(),
		total_cure = MatchGameFightModel.instance:getTotalCureNum(),
		total_damage = MatchGameFightModel.instance:getTotalHeroDamage(),
		weak_num = MatchGameFightModel.instance:getWeakAttackNum(),
		characters = heroIdList
	}

	StatController.instance:track(StatEnum.EventName.MatchGameEnd, {
		[StatEnum.EventProperties.EpisodeId_Num] = episodeId,
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.OperationType] = endReason,
		[StatEnum.EventProperties.IsWin] = isPass,
		[StatEnum.EventProperties.Star] = stars,
		[StatEnum.EventProperties.TotalRound] = roundCount,
		[StatEnum.EventProperties.MatchGameEpisodeObj] = matchGameEpisodeObj,
		[StatEnum.EventProperties.MatchGameChainInfo] = self.chainArray,
		[StatEnum.EventProperties.MatchGameFeverInfo] = self.feverArray
	})
end

function MatchGameStatHelper:raising(operationType, targetID, level)
	StatController.instance:track(StatEnum.EventName.MatchGameRaising, {
		[StatEnum.EventProperties.OperationType] = operationType,
		[StatEnum.EventProperties.OptionId] = targetID,
		[StatEnum.EventProperties.AfterLevel] = level or 0
	})
end

function MatchGameStatHelper:statEntryClick(viewName, clickType)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.ButtonName] = clickType
	})
end

function MatchGameStatHelper:statEpisodeClick(viewName, clickType, episodeId)
	local status = MatchGameModel.instance:getEpisodeStatus(episodeId)
	local isUnlock = status >= MatchGameEnum.EpisodeStatus.Unlock
	local episodeMo = MatchGameModel.instance:getEpisodeInfoById(episodeId)
	local starNum = episodeMo and episodeMo.starNum

	starNum = starNum or 0

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.ButtonName] = clickType,
		[StatEnum.EventProperties.EpisodeId_Num] = episodeId,
		[StatEnum.EventProperties.IsUnlock] = isUnlock,
		[StatEnum.EventProperties.Star] = starNum
	})
end

function MatchGameStatHelper:statResultClick(viewName, clickType, episodeId, isSuccess)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.ButtonName] = clickType,
		[StatEnum.EventProperties.EpisodeId_Num] = episodeId,
		[StatEnum.EventProperties.IsWin] = isSuccess
	})
end

MatchGameStatHelper.instance = MatchGameStatHelper.New()

return MatchGameStatHelper
