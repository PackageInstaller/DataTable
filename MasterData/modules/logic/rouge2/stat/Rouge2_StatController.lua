-- chunkname: @modules/logic/rouge2/stat/Rouge2_StatController.lua

module("modules.logic.rouge2.stat.Rouge2_StatController", package.seeall)

local Rouge2_StatController = class("Rouge2_StatController", BaseController)

function Rouge2_StatController:onInit()
	self:quitMap()
end

function Rouge2_StatController:reInit()
	self:onInit()
end

function Rouge2_StatController:addConstEvents()
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onNodeEventStatusChange, self._onNodeEventStatusChange, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onBeforeSendMoveRpc, self._beforeMoveEvent, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onBeforeNormalToMiddle, self.statExitLayer, self)
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
end

function Rouge2_StatController:clear()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onNodeEventStatusChange, self._onNodeEventStatusChange, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onBeforeSendMoveRpc, self._beforeMoveEvent, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onBeforeNormalToMiddle, self.statExitLayer, self)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
end

function Rouge2_StatController:statSelectDifficulty()
	StatController.instance:track(StatEnum.EventName.Rouge2SelectDifficulty, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty()
	})
end

function Rouge2_StatController:statSelectCareer()
	StatController.instance:track(StatEnum.EventName.Rouge2SelectCareer, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Career] = self:getCareerName()
	})
end

function Rouge2_StatController:_onNodeEventStatusChange(eventId, curStatus)
	if curStatus ~= RougeMapEnum.EventState.Finish then
		return
	end

	self:statFinishEvent(eventId)
end

function Rouge2_StatController:statFinishEvent(eventId)
	StatController.instance:track(StatEnum.EventName.Rouge2CompleteEvent, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getCurLayerId(),
		[StatEnum.EventProperties.Career] = self:getCareerName(),
		[StatEnum.EventProperties.Attribute] = self:getCurAttrArray(),
		[StatEnum.EventProperties.CareerLevel] = self:getCareerLv(),
		[StatEnum.EventProperties.ActiveSkill] = self:getActiveSkillNameList(),
		[StatEnum.EventProperties.CollectList] = self:getRelicsNameList(),
		[StatEnum.EventProperties.BuffList] = self:getBuffNameList(),
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.ReviveNum] = self:getRevivalCoin(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getOutsideTalentInfo(),
		[StatEnum.EventProperties.Formula] = self:getFormulaName(),
		[StatEnum.EventProperties.DungeonEventId] = eventId,
		[StatEnum.EventProperties.DungeonEventName] = self:getEventName(eventId),
		[StatEnum.EventProperties.DungeonEventType] = self:getEventTypeName(eventId)
	})
end

function Rouge2_StatController:_beforeMoveEvent()
	self:statOccurEvent()
end

function Rouge2_StatController:statOccurEvent()
	local canArriveNameList = {}
	local canArriveIdList = {}
	local canArriveTypeList = {}
	local dict = Rouge2_MapModel.instance:getNodeDict()

	for _, nodeInfo in pairs(dict) do
		if nodeInfo.arriveStatus == Rouge2_MapEnum.Arrive.CanArrive then
			table.insert(canArriveIdList, nodeInfo.eventId)

			local eventName = self:getEventName(nodeInfo.eventId)
			local typename = self:getEventTypeName(nodeInfo.eventId)

			if eventName then
				table.insert(canArriveNameList, eventName)
			end

			if typename then
				table.insert(canArriveTypeList, typename)
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.Rouge2OccurEvent, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getCurLayerId(),
		[StatEnum.EventProperties.OccurEventID] = canArriveIdList,
		[StatEnum.EventProperties.OccurEventName] = canArriveNameList,
		[StatEnum.EventProperties.OccurEventType] = canArriveTypeList
	})
end

function Rouge2_StatController:statSelectDrop(dropType, dropId, dropName, dropList)
	StatController.instance:track(StatEnum.EventName.Rouge2SelectDrop, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getCurLayerId(),
		[StatEnum.EventProperties.Career] = self:getCareerName(),
		[StatEnum.EventProperties.Attribute] = self:getCurAttrArray(),
		[StatEnum.EventProperties.CareerLevel] = self:getCareerLv(),
		[StatEnum.EventProperties.ActiveSkill] = self:getActiveSkillNameList(),
		[StatEnum.EventProperties.CollectList] = self:getRelicsNameList(),
		[StatEnum.EventProperties.BuffList] = self:getBuffNameList(),
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.ReviveNum] = self:getRevivalCoin(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getOutsideTalentInfo(),
		[StatEnum.EventProperties.Formula] = self:getFormulaName(),
		[StatEnum.EventProperties.DropType] = dropType,
		[StatEnum.EventProperties.DropId] = tostring(dropId),
		[StatEnum.EventProperties.DropName] = dropName,
		[StatEnum.EventProperties.DropList] = dropList
	})
end

function Rouge2_StatController:statExitLayer()
	StatController.instance:track(StatEnum.EventName.Rouge2ExitLayer, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getCurLayerId(),
		[StatEnum.EventProperties.Career] = self:getCareerName(),
		[StatEnum.EventProperties.Attribute] = self:getCurAttrArray(),
		[StatEnum.EventProperties.CareerLevel] = self:getCareerLv(),
		[StatEnum.EventProperties.ActiveSkill] = self:getActiveSkillNameList(),
		[StatEnum.EventProperties.CollectList] = self:getRelicsNameList(),
		[StatEnum.EventProperties.BuffList] = self:getBuffNameList(),
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.ReviveNum] = self:getRevivalCoin(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getOutsideTalentInfo(),
		[StatEnum.EventProperties.Formula] = self:getFormulaName(),
		[StatEnum.EventProperties.UseTime] = self:getNormalLayerUseTime()
	})

	self._enterLayerMapTime = nil
end

function Rouge2_StatController:statEnd(endResult)
	StatController.instance:track(StatEnum.EventName.Rouge2Settlement, {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getCurLayerId(),
		[StatEnum.EventProperties.Career] = self:getCareerName(),
		[StatEnum.EventProperties.Attribute] = self:getCurAttrArray(),
		[StatEnum.EventProperties.CareerLevel] = self:getCareerLv(),
		[StatEnum.EventProperties.ActiveSkill] = self:getActiveSkillNameList(),
		[StatEnum.EventProperties.CollectList] = self:getRelicsNameList(),
		[StatEnum.EventProperties.BuffList] = self:getBuffNameList(),
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.ReviveNum] = self:getRevivalCoin(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getOutsideTalentInfo(),
		[StatEnum.EventProperties.Formula] = self:getFormulaName(),
		[StatEnum.EventProperties.UseTime] = self:getUseTime(),
		[StatEnum.EventProperties.DungeonResult] = self:getRougeResult(endResult),
		[StatEnum.EventProperties.InterrruptReason] = self:getInterruptReason(endResult),
		[StatEnum.EventProperties.SuccessHeroGroup] = self:getSuccessHeroGroup(),
		[StatEnum.EventProperties.CompletedEventNum] = self:getCompletedEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = self:getCompletedEventID(),
		[StatEnum.EventProperties.CompletedEntrustId] = self:getCompletedEntrustId(),
		[StatEnum.EventProperties.CompletedEntrustNum] = self:getCompletedEntrustNum(),
		[StatEnum.EventProperties.CompletedLayers] = self:getCompletedLayers(),
		[StatEnum.EventProperties.TotalCollectionNum] = self:getCompletedCollectionNum(),
		[StatEnum.EventProperties.TotalGoldNum] = self:getCompletedCoinNum(),
		[StatEnum.EventProperties.DungeonPoints] = self:getCompletedScores(),
		[StatEnum.EventProperties.Exp] = self:getCompletedAddExp(),
		[StatEnum.EventProperties.RewardGoldNum] = self:getStoreCoinNum(),
		[StatEnum.EventProperties.MaterialReward] = self:getMaterialReward(),
		[StatEnum.EventProperties.BadgeName] = self:getBadgeName()
	})
end

function Rouge2_StatController:statUpgradeOutsideTalent(talentId)
	local talentCo = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)
	local talentName = talentCo and talentCo.name

	StatController.instance:track(StatEnum.EventName.Rogue2UpgradeOutsideTalent, {
		[StatEnum.EventProperties.OutsideTalentId] = tostring(talentId),
		[StatEnum.EventProperties.OutsideTalentName] = talentName
	})
end

function Rouge2_StatController:statUnlockIllustration(type, itemList)
	if itemList then
		if type == Rouge2_StatController.FavoriteType.Collection then
			for _, itemId in ipairs(itemList) do
				local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
				local itemName = itemCo and itemCo.name

				StatController.instance:track(StatEnum.EventName.Rouge2UnlockIllustration, {
					[StatEnum.EventProperties.IllustrationType] = type,
					[StatEnum.EventProperties.CollectionId] = itemId,
					[StatEnum.EventProperties.CollectionName] = itemName
				})
			end
		elseif type == Rouge2_StatController.FavoriteType.Formula then
			for _, formulaId in ipairs(itemList) do
				local formulaCo = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)
				local formulaName = formulaCo and formulaCo.name

				StatController.instance:track(StatEnum.EventName.Rouge2UnlockIllustration, {
					[StatEnum.EventProperties.IllustrationType] = type,
					[StatEnum.EventProperties.FormulaId] = formulaId,
					[StatEnum.EventProperties.Formula] = formulaName
				})
			end
		end
	end
end

function Rouge2_StatController:statDiceReRoll()
	local info = self:_getDiceAndDropCommonInfo()
	local interactJson = Rouge2_MapModel.instance:getCurInteractiveJson()
	local checkResult = interactJson and interactJson.checkRes
	local fromType = interactJson and interactJson.fromType
	local fromTypeCn = "事件检定重投"

	if fromType == Rouge2_MapEnum.InteractFromType.Event then
		local eventCo = Rouge2_MapModel.instance:getCurEvent()
		local eventId = eventCo and eventCo.id
		local eventType = eventCo and eventCo.type

		info[StatEnum.EventProperties.DungeonEventId] = eventId
		info[StatEnum.EventProperties.DungeonEventName] = self:getEventName(eventId)
		info[StatEnum.EventProperties.DungeonEventType] = self:getEventTypeName(eventId)

		if Rouge2_MapHelper.isStoreEvent(eventType) then
			fromTypeCn = "商店盗窃检定"
		end
	elseif fromType == Rouge2_MapEnum.InteractFromType.Career1Reward then
		fromTypeCn = "拨弦手-获得宝藏检定"
	end

	info[StatEnum.EventProperties.ReRollType] = fromTypeCn or ""
	info[StatEnum.EventProperties.ReRollResult] = checkResult and Rouge2_StatController.ReRollResult[checkResult]

	StatController.instance:track(StatEnum.EventName.Rouge2ReRoll, info)
end

function Rouge2_StatController:statDropRefresh(dropType, itemDataType, beforeDropList, afterDropList)
	local info = self:_getDiceAndDropCommonInfo()

	info[StatEnum.EventProperties.ReRollType] = "掉落刷新"
	info[StatEnum.EventProperties.DropType] = dropType
	info[StatEnum.EventProperties.BeforeDropList] = Rouge2_BackpackHelper.getItemNameList(itemDataType, beforeDropList)
	info[StatEnum.EventProperties.AfterDropList] = Rouge2_BackpackHelper.getItemNameList(itemDataType, afterDropList)

	StatController.instance:track(StatEnum.EventName.Rouge2ReRoll, info)
end

function Rouge2_StatController:_getDiceAndDropCommonInfo()
	return {
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getCurLayerId(),
		[StatEnum.EventProperties.Career] = self:getCareerName(),
		[StatEnum.EventProperties.Attribute] = self:getCurAttrArray(),
		[StatEnum.EventProperties.ActiveSkill] = self:getActiveSkillNameList(),
		[StatEnum.EventProperties.CollectList] = self:getRelicsNameList(),
		[StatEnum.EventProperties.BuffList] = self:getBuffNameList(),
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.ReviveNum] = self:getRevivalCoin(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getOutsideTalentInfo(),
		[StatEnum.EventProperties.Formula] = self:getFormulaName()
	}
end

function Rouge2_StatController:getSeason()
	local seasonCo = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.Season]

	if seasonCo then
		if not seasonCo.value then
			local season = 0

			return tonumber(season)
		end
	end
end

function Rouge2_StatController:getVersion()
	local versionCo = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.Version]

	if versionCo then
		if not versionCo.value then
			local version = ""

			return string.splitToNumber(version, "#")
		end
	end
end

function Rouge2_StatController:getGameNum()
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()

	return rougeInfo and rougeInfo.gameNum
end

function Rouge2_StatController:getDifficulty()
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.difficulty
end

function Rouge2_StatController:getCareerName()
	local careerId = Rouge2_Model.instance:getCareerId()
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)

	return (careerCo or nil) and (careerCo.name or careerId)
end

function Rouge2_StatController:getCurLayerId()
	return Rouge2_MapModel.instance:getLayerId()
end

function Rouge2_StatController:getCurAttrArray()
	local attrArray = {}
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()
	local attrGroupInfo = rougeInfo and rougeInfo:getAttrGroupInfo()
	local attrInfoList = attrGroupInfo and attrGroupInfo._attrInfoList

	if attrInfoList then
		for _, attrInfo in ipairs(attrInfoList) do
			local attrCo = attrInfo:getCofig()
			local attrValue = attrInfo:getValue()
			local var_25_0 = {}

			if attrCo then
				var_25_0.name = attrCo.name or ""
			end

			var_25_0.num = attrValue or 0

			table.insert(attrArray, var_25_0)
		end
	end

	return attrArray
end

function Rouge2_StatController:getCareerLv()
	local careerId = Rouge2_Model.instance:getCareerId()

	return Rouge2_TalentModel.instance:getCareerLevel(careerId)
end

function Rouge2_StatController:getActiveSkillNameList()
	local skillNameList = {}
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if skillList then
		for _, skillMo in ipairs(skillList) do
			local skillCo = skillMo:getConfig()

			if skillCo then
				table.insert(skillNameList, skillCo.name)
			end
		end
	end

	return skillNameList
end

function Rouge2_StatController:getRelicsNameList()
	local relicsNameList = {}
	local relicsList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.Relics)

	if relicsList then
		for _, relicsMo in ipairs(relicsList) do
			local relicsCo = relicsMo:getConfig()

			if relicsCo then
				table.insert(relicsNameList, relicsCo.name)
			end
		end
	end

	return relicsNameList
end

function Rouge2_StatController:getBuffNameList()
	local buffNameList = {}
	local buffList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.Buff)

	if buffList then
		for _, buffMo in ipairs(buffList) do
			local buffCo = buffMo:getConfig()

			if buffCo then
				table.insert(buffNameList, buffCo.name)
			end
		end
	end

	local attrBuffList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.AttrBuff)

	if attrBuffList then
		for _, buffMo in ipairs(attrBuffList) do
			local buffCo = buffMo:getConfig()

			if buffCo then
				table.insert(buffNameList, buffCo.name)
			end
		end
	end

	return buffNameList
end

function Rouge2_StatController:getCoin()
	return Rouge2_Model.instance:getCoin()
end

function Rouge2_StatController:getRevivalCoin()
	return Rouge2_Model.instance:getRevivalCoin()
end

function Rouge2_StatController:getOutsideTalentInfo()
	local namelist = {}
	local activeTalentDict = Rouge2_TalentModel.instance:getHadUnlockTalentDict()

	for talentId, status in pairs(activeTalentDict) do
		local talentCo = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)
		local talentDesc = talentCo and talentCo.desc

		table.insert(namelist, talentDesc)
	end

	return namelist
end

function Rouge2_StatController:getFormulaName()
	local alchemyInfo = Rouge2_Model.instance:getCurAlchemyInfo()
	local formulaId = alchemyInfo and alchemyInfo:getFormulaId()

	if formulaId then
		::label_33_0::

		local formulaCo = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

		return (formulaCo or nil) and (formulaCo.name or "")
	end
end

function Rouge2_StatController:getEventName(eventId)
	local eventCo = Rouge2_MapConfig.instance:getRougeEvent(eventId)

	return (eventCo or nil) and (eventCo.name or "")
end

function Rouge2_StatController:getEventTypeName(eventId)
	local eventCo = Rouge2_MapConfig.instance:getRougeEvent(eventId)
	local eventType = eventCo and eventCo.type
	local eventTypeCo = eventType and lua_rouge2_event_type.configDict[eventType]

	return (eventTypeCo or nil) and (eventTypeCo.name or "")
end

function Rouge2_StatController:getUseTime()
	local time = 0

	if self:checkIsReset() or not self.startTime then
		return time
	end

	if self.startTime then
		time = ServerTime.now() - self.startTime
	end

	return time
end

function Rouge2_StatController:getNormalLayerUseTime()
	local time = self._enterLayerMapTime and ServerTime.now() - self._enterLayerMapTime or 0

	return time or 0
end

function Rouge2_StatController:_onPushEndFight()
	local fightRecordMO = FightModel.instance:getRecordMO()
	local result = fightRecordMO and fightRecordMO.fightResult

	if result then
		self._failResult = result
	end
end

function Rouge2_StatController:getRougeResult(endResult)
	local result

	if endResult then
		if endResult == Rouge2_StatController.EndResult.Close then
			result = "主动返回退出"
		elseif endResult == Rouge2_StatController.EndResult.Abort then
			result = "重置"
		end
	else
		local endId = Rouge2_Model.instance:getEndId()

		result = endId and endId ~= 0 and "成功" or "失败"
	end

	return result
end

function Rouge2_StatController:getInterruptReason(endResult)
	local result

	if endResult then
		if endResult == Rouge2_StatController.EndResult.Close then
			result = "主动放弃探索"
		end
	else
		local endId = Rouge2_Model.instance:getEndId()

		if not endId or endId == 0 then
			local eventMo = Rouge2_MapModel.instance:getCurEvent()
			local eventid = eventMo and eventMo.id

			if self._failResult then
				if self._failResult == FightEnum.FightResult.Abort then
					result = "战斗主动退出"

					if eventid then
						result = eventid and result .. eventid or result .. 0
					end
				elseif self._failResult == FightEnum.FightResult.Fail then
					result = "战斗失败"

					if eventid then
						result = eventid and result .. eventid or result .. 0
					end
				end
			else
				result = "战斗主动退出"

				if eventid then
					result = eventid and result .. eventid or result .. 0
				end
			end
		end
	end

	return result
end

function Rouge2_StatController:getSuccessHeroGroup()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local endHeroIdList = resultInfo and resultInfo.endHeroId

	if not endHeroIdList then
		return
	end

	local heroNameList = {}

	for _, endHeroId in ipairs(endHeroIdList) do
		local heroCo = HeroConfig.instance:getHeroCO(endHeroId)

		if heroCo then
			if not heroCo.name then
				local heroName = ""

				table.insert(heroNameList, heroName)
			end
		end
	end

	return heroNameList
end

function Rouge2_StatController:getCompletedEventNum()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if not resultInfo then
		return
	end

	if resultInfo.finishEventId and #resultInfo.finishEventId > 0 then
		return #resultInfo.finishEventId
	end
end

function Rouge2_StatController:getCompletedEventID()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if not resultInfo then
		return
	end

	if resultInfo.finishEventId and #resultInfo.finishEventId > 0 then
		local finishEventIdList = {}

		tabletool.addValues(finishEventIdList, resultInfo.finishEventId)

		return finishEventIdList
	end
end

function Rouge2_StatController:getCompletedEntrustId()
	local recordInfo = Rouge2_MapModel.instance:getGameRecordInfo()

	return recordInfo and recordInfo:getFinishEntrustIdList()
end

function Rouge2_StatController:getCompletedEntrustNum()
	local entrustIdList = self:getCompletedEntrustId()

	return entrustIdList and #entrustIdList
end

function Rouge2_StatController:getCompletedLayers()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if not resultInfo then
		return
	end

	local count, score = resultInfo:getLayerCountAndScore()

	return tonumber(count)
end

function Rouge2_StatController:getCompletedCollectionNum()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local collectionNum = reviewInfo and reviewInfo:getItemCount(Rouge2_Enum.BagType.Relics) or 0

	return tonumber(collectionNum) or 0
end

function Rouge2_StatController:getCompletedCoinNum()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	return resultInfo and tonumber(resultInfo.gainCoin)
end

function Rouge2_StatController:getCompletedScores()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	return resultInfo and tonumber(resultInfo.finalScore)
end

function Rouge2_StatController:getCompletedAddExp()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	return resultInfo and resultInfo.addCareerExp
end

function Rouge2_StatController:getStoreCoinNum()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	return resultInfo and resultInfo.addCurrency
end

function Rouge2_StatController:getMaterialReward()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if not resultInfo then
		return
	end

	local rewardList = {}

	if resultInfo.gainMaterial then
		for _, materialId in ipairs(resultInfo.gainMaterial) do
			local materialCo = Rouge2_OutSideConfig.instance:getMaterialConfig(materialId)

			if materialCo then
				table.insert(rewardList, {
					materialnum = 1,
					materialid = materialId,
					materialname = materialCo.name
				})
			end
		end
	end

	return rewardList
end

function Rouge2_StatController:getBadgeName()
	local result = {}
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if not resultInfo then
		return
	end

	if resultInfo.badge2Score then
		for id, value in pairs(resultInfo.badge2Score) do
			local co = Rouge2_Config.instance:getRougeBadgeCO(value[1])

			if co and co.name then
				table.insert(result, co.name)
			end
		end
	end

	return result
end

function Rouge2_StatController:statStart()
	if self._isStart then
		return
	end

	self.startTime = ServerTime.now()
	self._isStart = true
	self._isReset = false
	self._failResult = nil
end

function Rouge2_StatController:statEnterLayerMap()
	self._enterLayerMapTime = self._enterLayerMapTime or ServerTime.now()
end

function Rouge2_StatController:quitMap()
	self._isStart = false
	self._enterLayerMapTime = nil
end

function Rouge2_StatController:checkIsReset()
	return self._isReset
end

function Rouge2_StatController:setReset()
	self._isReset = true
end

Rouge2_StatController.EndResult = {
	Abort = 4,
	Close = 3,
	Fail = 2,
	AbortRechallenge = 5,
	Success = 1
}
Rouge2_StatController.FavoriteType = {
	Formula = "配方图鉴",
	Collection = "造物图鉴"
}
Rouge2_StatController.ReRollResult = {
	[Rouge2_MapEnum.AttrCheckResult.None] = "无检定",
	[Rouge2_MapEnum.AttrCheckResult.Succeed] = "成功",
	[Rouge2_MapEnum.AttrCheckResult.Failure] = "失败",
	[Rouge2_MapEnum.AttrCheckResult.BigSucceed] = "大成功"
}
Rouge2_StatController.instance = Rouge2_StatController.New()

return Rouge2_StatController
