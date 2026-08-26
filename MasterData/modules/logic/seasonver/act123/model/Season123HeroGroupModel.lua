-- chunkname: @modules/logic/seasonver/act123/model/Season123HeroGroupModel.lua

module("modules.logic.seasonver.act123.model.Season123HeroGroupModel", package.seeall)

local Season123HeroGroupModel = class("Season123HeroGroupModel", BaseModel)

function Season123HeroGroupModel:release()
	self.curUnlockIndexSet = nil
	self.curUnlockSlotSet = nil
	self.animRecord = nil
	self.multiplication = nil
end

function Season123HeroGroupModel:init(actId, layer, episodeId, stage)
	self.activityId = actId
	self.layer = layer
	self.episodeId = episodeId
	self.stage = stage
	self.multiplication = 1
	self.unlockTweenKey = Activity123Enum.AnimRecord.UnlockTweenPos .. tostring(self.stage)
	self.animRecord = Season123UnlockLocalRecord.New()

	self.animRecord:init(self.activityId, PlayerPrefsKey.Season123UnlockAnimAlreadyPlay)
	self:initUnlockIndex()
	self:initMultiplication()
end

function Season123HeroGroupModel:initUnlockIndex()
	self.curUnlockIndexSet = {}
	self.curUnlockSlotSet = {}

	local episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)

	if not episodeCO then
		return
	end

	if episodeCO.type == DungeonEnum.EpisodeType.Season123 then
		local seasonMO = Season123Model.instance:getActInfo(self.activityId)

		if not seasonMO then
			return
		end

		self.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(self.activityId)

		for unlockIndex, _ in pairs(self.curUnlockIndexSet) do
			self.curUnlockIndexSet[unlockIndex] = true

			self:checkAddUnlockSlot(unlockIndex)
		end
	end
end

function Season123HeroGroupModel:initMultiplication()
	local localTimes = PlayerPrefsHelper.getNumber(self:getMultiplicationKey(), 1)

	if self:isEpisodeSeason123Retail() then
		local ticketNum = self:getMultiplicationTicket()

		self.multiplication = math.min(localTimes, ticketNum)
	else
		self.multiplication = localTimes
	end
end

function Season123HeroGroupModel:getMultiplicationKey()
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), self.episodeId)
end

function Season123HeroGroupModel:saveMultiplication()
	PlayerPrefsHelper.setNumber(self:getMultiplicationKey(), self.multiplication)
end

function Season123HeroGroupModel:getMultiplicationTicket()
	local actId = self.activityId
	local ticketId = Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.UttuTicketsCoin)

	if ticketId then
		local currencyMO = CurrencyModel.instance:getCurrency(ticketId)

		return (currencyMO or nil) and (currencyMO.quantity or 0)
	end

	return 0
end

function Season123HeroGroupModel:checkAddUnlockSlot(unlockIndex)
	local slot

	if unlockIndex >= 1 and unlockIndex <= Activity123Enum.MainCharPos then
		slot = 1
	elseif unlockIndex > Activity123Enum.MainCharPos and unlockIndex <= Activity123Enum.MainCharPos * 2 then
		slot = 2
	end

	if slot and not self.curUnlockSlotSet[slot] then
		self.curUnlockSlotSet[slot] = true
	end
end

function Season123HeroGroupModel:isSeasonChapter()
	local curEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not curEpisodeId or curEpisodeId == 0 then
		return false
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(curEpisodeId)

	if episodeCo.type == DungeonEnum.EpisodeType.Season123 then
		return true
	end

	return false
end

function Season123HeroGroupModel:getMainPosEquipId(slot)
	local mainRolePos = ModuleEnum.MaxHeroCountInGroup + 1
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local character_uid = "-100000"

	if curGroupMO then
		if curGroupMO.isReplay then
			local equipData = curGroupMO.replay_activity104Equip_data[character_uid]

			if equipData and equipData[slot] then
				return equipData[slot].equipId
			end
		else
			local equipMO = curGroupMO.activity104Equips[mainRolePos - 1]

			if equipMO and equipMO.equipUid[slot] then
				return tonumber(equipMO.equipUid[slot])
			end
		end
	end
end

function Season123HeroGroupModel:getItemIdByUid(equipUid)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return 0
	end

	local itemId = seasonMO:getItemIdByUid(equipUid)

	if not itemId then
		return 0
	end

	return itemId
end

function Season123HeroGroupModel:buildAidHeroGroup()
	local battleContext = Season123Model.instance:getBattleContext()

	if battleContext then
		local actId = battleContext.actId
		local seasonMO = Season123Model.instance:getActInfo(actId)

		if not seasonMO then
			return
		end

		local battleCO = HeroGroupModel.instance.battleConfig

		if not battleCO then
			return
		end

		local configAids = string.splitToNumber(battleCO.aid, "#")

		if #configAids > 0 or battleCO.trialLimit > 0 then
			local tempHeroGroupSnapshot = {}
			local heroGroupSnapshot = seasonMO.heroGroupSnapshot

			for i, v in ipairs(heroGroupSnapshot) do
				tempHeroGroupSnapshot[i] = HeroGroupModel.instance:generateTempGroup(v)

				tempHeroGroupSnapshot[i]:setTemp(true)
				Season123HeroGroupUtils.formation104Equips(tempHeroGroupSnapshot[i])
			end

			self.tempHeroGroupSnapshot = tempHeroGroupSnapshot
		end
	end
end

function Season123HeroGroupModel:getCurrentHeroGroup()
	local context = Season123Model.instance:getBattleContext()

	if not context then
		return
	end

	local seasonMO = Season123Model.instance:getActInfo(context.actId)

	if not seasonMO then
		return
	end

	local subId = Season123HeroGroupModel.instance:isEpisodeSeason123(context.episodeId) and seasonMO.heroGroupSnapshotSubId or 1
	local battleCO = HeroGroupModel.instance.battleConfig

	if battleCO then
		local configAids = string.splitToNumber(battleCO.aid, "#")

		if #configAids > 0 or battleCO.trialLimit > 0 then
			return self.tempHeroGroupSnapshot[subId]
		end
	end

	if self:isEpisodeSeason123Retail(context.episodeId) then
		return Season123Model.instance:getRetailHeroGroup(subId)
	elseif self:isEpisodeSeason123(context.episodeId) then
		return Season123Model.instance:getSnapshotHeroGroup(subId)
	end
end

function Season123HeroGroupModel:isContainGroupCardUnlockTweenPos(pos)
	local layerCO = Season123Config.instance:getSeasonEpisodeCo(self.activityId, self.stage, self.layer - 1)

	if not layerCO then
		return true
	end

	local list = string.splitToNumber(layerCO.unlockEquipIndex, "#")

	if not tabletool.indexOf(list, pos) then
		return true
	end

	return self.animRecord:contain(pos, self.unlockTweenKey)
end

function Season123HeroGroupModel:saveGroupCardUnlockTweenPos(pos)
	self.animRecord:add(pos, self.unlockTweenKey)
end

function Season123HeroGroupModel:isEquipCardPosUnlock(slot, pos)
	local posIndex = Season123Model.instance:getUnlockCardIndex(pos, slot)

	return self.curUnlockIndexSet[posIndex] == true
end

function Season123HeroGroupModel:isSlotNeedShow(slot)
	return self.curUnlockSlotSet[slot] == true
end

function Season123HeroGroupModel:isEpisodeSeason123(episodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId or self.episodeId)

	if episodeCO and episodeCO.type == DungeonEnum.EpisodeType.Season123 then
		return true
	end

	return false
end

function Season123HeroGroupModel:isEpisodeSeason123Retail(episodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId or self.episodeId)

	if episodeCO and episodeCO.type == DungeonEnum.EpisodeType.Season123Retail then
		return true
	end

	return false
end

function Season123HeroGroupModel:isCardPosLimit(itemId, pos)
	local posDict, posStr = Season123Config.instance:getCardLimitPosDict(itemId)

	if posDict == nil or posDict[pos + 1] then
		return false
	end

	return true, posStr
end

function Season123HeroGroupModel.filterRule(actId, ruleList)
	local rule = Season123Config.instance:getSeasonConstStr(actId, Activity123Enum.Const.HideRule)
	local hideRuleList = string.splitToNumber(rule, "#")
	local hideRuleDict = {}

	for i, ruleId in ipairs(hideRuleList) do
		hideRuleDict[ruleId] = true
	end

	local filterRuleList = {}

	for _, v in ipairs(ruleList) do
		local ruleId = v[2]

		if not hideRuleDict[ruleId] then
			table.insert(filterRuleList, v)
		end
	end

	return filterRuleList
end

Season123HeroGroupModel.instance = Season123HeroGroupModel.New()

return Season123HeroGroupModel
