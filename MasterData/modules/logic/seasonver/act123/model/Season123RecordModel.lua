-- chunkname: @modules/logic/seasonver/act123/model/Season123RecordModel.lua

module("modules.logic.seasonver.act123.model.Season123RecordModel", package.seeall)

local Season123RecordModel = class("Season123RecordModel", BaseModel)

function Season123RecordModel:onInit()
	return
end

function Season123RecordModel:reInit()
	return
end

function Season123RecordModel:setServerDataVerifiableId(actId, stage)
	self._tmpVerifiableActId = actId
	self._tmpVerifiableStage = stage
end

function Season123RecordModel:setSeason123ServerRecordData(serverRecord)
	self:clear()

	if not serverRecord then
		return
	end

	local verifiableActId, verifiableStage = self:getServerDataVerifiableId()

	if serverRecord.activityId ~= verifiableActId or serverRecord.stage ~= verifiableStage then
		return
	end

	self:setServerDataVerifiableId()

	local stageRecords = serverRecord.stageRecords

	if not stageRecords then
		return
	end

	for i = 1, Activity123Enum.RecordItemCount do
		local recordInfo = {}
		local stageRecord = stageRecords[i]

		if stageRecord then
			recordInfo.round = stageRecord.round
			recordInfo.isBest = stageRecord.isBest

			local heroList, heroUidDict = self:_getHeroDataByServerData(stageRecord.stageRecordHeros)

			recordInfo.heroList = heroList
			recordInfo.attackStatistics = self:_geAttackStatisticsByServerData(stageRecord.attackStatistics, heroUidDict)
		else
			recordInfo.isEmpty = true
		end

		self:addAtLast(recordInfo)
	end
end

function Season123RecordModel:getServerDataVerifiableId()
	return self._tmpVerifiableActId, self._tmpVerifiableStage
end

function Season123RecordModel:getRecordList(getBest)
	local result = {}
	local recordDataList = self:getList()

	for _, recordInfo in ipairs(recordDataList) do
		local isBest = recordInfo.isBest

		if getBest and isBest or not getBest and not isBest then
			result[#result + 1] = recordInfo
		end
	end

	return result
end

function Season123RecordModel:_getHeroDataByServerData(serverHeroList)
	if not serverHeroList then
		return
	end

	local heroList = {}
	local heroUidDict = {}

	for i = 1, Activity123Enum.PickHeroCount do
		local stageRecordHero = serverHeroList[i]
		local hero = {
			heroId = 0,
			uid = 0
		}

		if stageRecordHero then
			hero.uid = stageRecordHero.heroUid
			hero.heroId = stageRecordHero.heroId
			hero.skinId = stageRecordHero.skinId
			hero.isAssist = stageRecordHero.isAssist
			hero.isBalance = stageRecordHero.isBalance
			hero.level = stageRecordHero.level
		end

		heroList[i] = hero
		heroUidDict[hero.uid] = hero
	end

	return heroList, heroUidDict
end

function Season123RecordModel:_geAttackStatisticsByServerData(serverAttackStatistics, heroUidDict)
	if not serverAttackStatistics then
		return
	end

	local result = {}

	for i, serverStatInfo in ipairs(serverAttackStatistics) do
		local statInfo = {}

		statInfo.heroUid = serverStatInfo.heroUid
		statInfo.harm = serverStatInfo.harm
		statInfo.hurt = serverStatInfo.hurt
		statInfo.heal = serverStatInfo.heal

		local cards = {}

		for j, v in ipairs(serverStatInfo.cards) do
			local card = {}

			card.skillId = v.skillId
			card.useCount = v.useCount
			cards[j] = card
		end

		statInfo.cards = cards
		statInfo.getBuffs = serverStatInfo.getBuffs

		if heroUidDict then
			if not heroUidDict[statInfo.heroUid] then
				local heroInfo = {}

				if heroInfo then
					if not heroInfo.heroId then
						local heroId = 0

						if heroInfo then
							if not heroInfo.level then
								local level = 1
								local skinId = heroInfo and heroInfo.skinId

								statInfo.entityMO = FightHelper.getEmptyFightEntityMO(statInfo.heroUid, heroId, level, skinId)
								result[i] = statInfo
							end
						end
					end
				end
			end
		end
	end

	return result
end

Season123RecordModel.instance = Season123RecordModel.New()

return Season123RecordModel
