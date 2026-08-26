-- chunkname: @modules/logic/fight/model/data/FightFieldDataMgr.lua

module("modules.logic.fight.model.data.FightFieldDataMgr", package.seeall)

local FightFieldDataMgr = FightDataClass("FightFieldDataMgr", FightDataMgrBase)

function FightFieldDataMgr:onConstructor()
	self.deckNum = 0
	self.maxRoundOffset = 0
end

function FightFieldDataMgr:onStageChanged()
	return
end

function FightFieldDataMgr:updateData(fightData)
	self.version = fightData.version
	self.fightActType = fightData.fightActType or FightEnum.FightActType.Normal
	self.curRound = fightData.curRound
	self.maxRound = fightData.maxRound
	self.isFinish = fightData.isFinish
	self.curWave = fightData.curWave
	self.battleId = fightData.battleId
	self.magicCircle = FightDataUtil.coverData(fightData.magicCircle, self.magicCircle)
	self.isRecord = fightData.isRecord
	self.episodeId = fightData.episodeId
	self.episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.lastChangeHeroUid = fightData.lastChangeHeroUid
	self.progress = fightData.progress
	self.progressMax = fightData.progressMax
	self.param = FightDataUtil.coverData(fightData.param, self.param)
	self.indicatorDict = self:buildIndicators(fightData)
	self.enemyIndicatorDict = self:buildEnemyIndicators(fightData)
	self.playerFinisherInfo = FightDataUtil.coverData(fightData.attacker.playerFinisherInfo, self.playerFinisherInfo)
	self.customData = FightDataUtil.coverData(fightData.customData, self.customData)
	self.fightTaskBox = FightDataUtil.coverData(fightData.fightTaskBox, self.fightTaskBox)
	self.progressDic = FightDataUtil.coverData(fightData.progressDic, self.progressDic)
end

function FightFieldDataMgr:buildIndicators(fightData)
	local dic = {}

	if fightData.attacker then
		for _, indicator in ipairs(fightData.attacker.indicators) do
			local id = tonumber(indicator.inticatorId)

			dic[id] = {
				id = id,
				num = indicator.num
			}
		end
	end

	return FightDataUtil.coverData(dic, self.indicatorDict)
end

function FightFieldDataMgr:buildEnemyIndicators(fightData)
	local dic = {}

	if fightData.attacker then
		for _, indicator in ipairs(fightData.defender.indicators) do
			local id = tonumber(indicator.inticatorId)

			dic[id] = {
				id = id,
				num = indicator.num
			}
		end
	end

	return FightDataUtil.coverData(dic, self.enemyIndicatorDict)
end

function FightFieldDataMgr:getIndicatorNum(id)
	if self.indicatorDict then
		return (self.indicatorDict or nil) and (self.indicatorDict.num or 0)
	end
end

function FightFieldDataMgr:isDouQuQu()
	return self.fightActType == FightEnum.FightActType.Act174
end

function FightFieldDataMgr:isSeason2()
	return self.fightActType == FightEnum.FightActType.Season2
end

function FightFieldDataMgr:isDungeonType(type)
	return self.episodeCo and self.episodeCo.type == type
end

function FightFieldDataMgr:isPaTa()
	return self:isDungeonType(DungeonEnum.EpisodeType.TowerBoss) or self:isDungeonType(DungeonEnum.EpisodeType.TowerLimited) or self:isDungeonType(DungeonEnum.EpisodeType.TowerPermanent) or self:isDungeonType(DungeonEnum.EpisodeType.TowerBossTeach)
end

function FightFieldDataMgr:isTowerLimited()
	return self:isDungeonType(DungeonEnum.EpisodeType.TowerLimited)
end

function FightFieldDataMgr:is3_3PaTa()
	return self:isDungeonType(DungeonEnum.EpisodeType.TowerCompose)
end

function FightFieldDataMgr:isAct183()
	return self:isDungeonType(DungeonEnum.EpisodeType.Act183)
end

function FightFieldDataMgr:isRouge2()
	return self:isDungeonType(DungeonEnum.EpisodeType.Rouge2) or self:isDungeonType(DungeonEnum.EpisodeType.Rouge2Boss)
end

function FightFieldDataMgr:dirSetDeckNum(value)
	self.deckNum = value
end

function FightFieldDataMgr:changeDeckNum(value)
	self.deckNum = self.deckNum + value
end

function FightFieldDataMgr:is191DouQuQu()
	return self.customData and self.customData[FightCustomData.CustomDataType.Act191]
end

function FightFieldDataMgr:isShelter()
	return self:isDungeonType(DungeonEnum.EpisodeType.Shelter)
end

function FightFieldDataMgr:isSurvival()
	return self:isDungeonType(DungeonEnum.EpisodeType.Survival)
end

function FightFieldDataMgr:isRouge2Boss()
	return self:isDungeonType(DungeonEnum.EpisodeType.Rouge2Boss)
end

function FightFieldDataMgr:isV3_2ZongMao()
	return self:isDungeonType(DungeonEnum.EpisodeType.V3_2ZongMao) or self:isDungeonType(DungeonEnum.EpisodeType.BossRushActMode)
end

function FightFieldDataMgr:isSouDaChe()
	return self:isDungeonType(DungeonEnum.EpisodeType.Sodache)
end

function FightFieldDataMgr:clearData()
	self.param = nil
end

return FightFieldDataMgr
