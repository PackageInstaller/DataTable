-- chunkname: @modules/logic/seasonver/act123/model/Season123Model.lua

module("modules.logic.seasonver.act123.model.Season123Model", package.seeall)

local Season123Model = class("Season123Model", BaseModel)

function Season123Model:onInit()
	self:reInit()
end

function Season123Model:reInit()
	self._actInfo = {}
end

function Season123Model:setActInfo(msg)
	local activityId = msg.activityId
	local actMO = self._actInfo[activityId]

	if not actMO then
		actMO = Season123MO.New()
		self._actInfo[activityId] = actMO
		self._curSeasonId = activityId
	end

	actMO:updateInfo(msg)
end

function Season123Model:updateActInfoBattle(msg)
	local activityId = msg.activityId
	local actMO = self._actInfo[activityId]

	if actMO then
		actMO:updateInfoBattle(msg)
	end
end

function Season123Model:cleanCurSeasonId()
	self._curSeasonId = nil
end

function Season123Model:getActInfo(activityId)
	if not activityId then
		return nil
	end

	return self._actInfo[activityId]
end

function Season123Model:setBattleContext(actId, stage, layer, episodeId)
	self._battleContext = Season123BattleContext.New()

	self._battleContext:init(actId, stage, layer, episodeId)
end

function Season123Model:getBattleContext()
	return self._battleContext
end

function Season123Model:getSeasonHeroMO(actId, stage, layer, heroUid)
	local seasonMO = self:getActInfo(actId)

	if not seasonMO then
		return nil
	end

	local stageMO = seasonMO.stageMap[stage]

	if not stageMO then
		return nil
	end

	local episodeMO = stageMO.episodeMap[layer]

	if not episodeMO then
		return nil
	end

	local heroMap = episodeMO.heroesMap

	if not heroMap then
		return nil
	end

	return heroMap[heroUid]
end

function Season123Model:getAssistData(actId, stage)
	local seasonMO = self:getActInfo(actId)

	if not seasonMO then
		return nil
	end

	local stageMO = stage == nil and seasonMO:getCurrentStage() or seasonMO:getStageMO(stage)

	if not stageMO then
		return nil
	end

	return stageMO:getAssistHeroMO()
end

function Season123Model:isSeasonStagePosUnlock(actId, stage, slot, pos)
	local seasonMO = self:getActInfo(actId)

	if not seasonMO then
		return
	end

	local unlockIndex = self:getUnlockCardIndex(pos, slot)

	if stage and seasonMO:isStageSlotUnlock(stage, unlockIndex) then
		return true
	end

	return seasonMO.unlockIndexSet and seasonMO.unlockIndexSet[unlockIndex]
end

function Season123Model:getUnlockCardIndex(pos, slot)
	if pos == Season123EquipHeroItemListModel.MainCharPos then
		return ModuleEnum.MaxHeroCountInGroup * 2 + slot
	else
		return pos + 1 + ModuleEnum.MaxHeroCountInGroup * (slot - 1)
	end
end

function Season123Model:isEpisodeAdvance(episodeId)
	return false
end

function Season123Model:getEpisodeRetail(episodeId)
	return nil
end

function Season123Model:getCurSeasonId()
	return self._curSeasonId
end

function Season123Model:getAllItemMo(activityId)
	local seasonMo = self._actInfo[activityId]

	if seasonMo then
		return seasonMo:getAllItemMap()
	end
end

function Season123Model:getSeasonAllHeroGroup(activityId)
	local seasonMo = self._actInfo[activityId]

	if seasonMo then
		return seasonMo.heroGroupSnapshot
	end
end

function Season123Model:updateItemMap(actId, addItems, deleteItems)
	local allItemMap = self:getAllItemMo(actId)

	if GameUtil.getTabLen(addItems) > 0 then
		for index, itemData in ipairs(addItems) do
			local config = Season123Config.instance:getSeasonEquipCo(itemData.itemId)

			if config and not allItemMap[itemData.uid] and itemData.uid then
				local itemMO = Season123ItemMO.New()

				itemMO:setData(itemData)

				allItemMap[itemData.uid] = itemMO
			end
		end
	end

	if GameUtil.getTabLen(deleteItems) > 0 then
		for index, itemData in ipairs(deleteItems) do
			local config = Season123Config.instance:getSeasonEquipCo(itemData.itemId)

			if config then
				allItemMap[itemData.uid] = nil
			end
		end
	end
end

function Season123Model:getSnapshotHeroGroup(subId)
	if self._battleContext then
		local actId = self._battleContext.actId
		local seasonMO = self:getActInfo(actId)

		if not seasonMO then
			return
		end

		return seasonMO.heroGroupSnapshot[subId or seasonMO.heroGroupSnapshotSubId]
	end
end

function Season123Model:getRetailHeroGroup(subId)
	local actId = self._battleContext.actId
	local seasonMO = self:getActInfo(actId)

	if not seasonMO then
		return
	end

	return seasonMO.retailHeroGroups[subId or 1]
end

function Season123Model:isEpisodeAfterStory(actId, stage, layer)
	return false
end

function Season123Model:canPlayStageLevelup(fightResult, episodeType, exitFightGroup, actId, stage, layer)
	if fightResult ~= 1 then
		return
	end

	if episodeType ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	if exitFightGroup then
		return
	end

	actId = actId or self:getCurSeasonId()

	if self:isEpisodeAfterStory(actId, layer) then
		return
	end

	local nextCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer + 1)

	return nextCo and nextCo.stage
end

function Season123Model:addCardGetData(cardList)
	local cardGetViewName = Season123ViewHelper.getViewName(self._curSeasonId, "CelebrityCardGetView")
	local viewName = ViewName[cardGetViewName]

	for i = 1, PopupController.instance._popupList:getSize() do
		if PopupController.instance._popupList._dataList[i][2] == viewName then
			local equipData = PopupController.instance._popupList._dataList[i][3].data

			tabletool.addValues(equipData, cardList)

			PopupController.instance._popupList._dataList[i][3] = {
				is_item_id = true,
				data = equipData
			}

			return
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, viewName, {
		is_item_id = true,
		data = cardList
	})
end

function Season123Model:setUnlockAct123EquipIds(proto)
	local season123MO = self:getActInfo(proto.activityId)

	season123MO:setUnlockAct123EquipIds(proto.unlockAct123EquipIds)
end

function Season123Model:isNewEquipBookCard(equipId)
	local season123MO = self:getActInfo(self._curSeasonId)

	if not season123MO then
		return
	end

	return not season123MO.unlockAct123EquipIds[equipId]
end

function Season123Model:getAllUnlockAct123EquipIds(actId)
	local season123MO = self:getActInfo(actId)

	if not season123MO then
		return
	end

	return season123MO.unlockAct123EquipIds
end

function Season123Model:getFightCardDataList()
	local fightParam = FightModel.instance:getFightParam()
	local equips = fightParam.activity104Equips

	return Season123HeroGroupUtils.fiterFightCardDataList(equips, fightParam.trialHeroList, self:getCurSeasonId())
end

function Season123Model:hasSeason123TaskData(actId)
	local seasonMOTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123)

	if seasonMOTasks then
		for taskId, taskMO in pairs(seasonMOTasks) do
			if taskMO.config and taskMO.config.seasonId == actId and taskMO.config.isRewardView == Activity123Enum.TaskRewardViewType then
				return true
			end
		end
	else
		return false
	end
end

function Season123Model:updateTaskReward()
	for actId, seasonMO in pairs(self._actInfo) do
		seasonMO:initStageRewardConfig()
	end
end

function Season123Model:checkHasUnlockStory(actId)
	local localkey = "Season123StoryUnlock" .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local saveStr = PlayerPrefsHelper.getString(localkey, "")
	local saveUnlockStateTab = {}

	if not string.nilorempty(saveStr) then
		for _, unlockStateStr in ipairs((cjson.decode(saveStr))) do
			local param = string.split(unlockStateStr, "|")
			local id = tonumber(param[1])

			saveUnlockStateTab[id] = param[2] == "true"
		end
	end

	local allStoryConfig = Season123Config.instance:getAllStoryCo(actId) or {}

	for storyId, storyConfig in pairs(allStoryConfig) do
		local stageMO = Season123Model.instance:getActInfo(actId).stageMap[storyConfig.condition]
		local isPass = stageMO and stageMO.isPass
		local isUnlock = Season123ProgressUtils.isStageUnlock(actId, storyConfig.condition) and isPass == true

		if isUnlock and saveUnlockStateTab[storyId] ~= isUnlock then
			return true
		end
	end

	return false
end

function Season123Model:getSingleBgFolder()
	if self._curSeasonId then
		return Activity123Enum.SeasonIconFolder[self._curSeasonId]
	end
end

function Season123Model:setRetailRandomSceneId(param)
	local needRandom = param and param.needRandom

	self.retailSceneId = PlayerPrefsHelper.getNumber(self:getRetailRandomSceneKey(), -1)

	if self.retailSceneId < 0 or needRandom then
		self.retailSceneId = math.random(0, 2)

		PlayerPrefsHelper.setNumber(self:getRetailRandomSceneKey(), self.retailSceneId)
	end
end

function Season123Model:getRetailRandomSceneKey()
	return "Season123RetailRandomSceneId" .. "#" .. tostring(self._curSeasonId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function Season123Model:setGetStageBonus(msg)
	local seasonMO = self:getActInfo(msg.activityId)

	if not seasonMO then
		return
	end

	seasonMO:updateBonus(msg.stage, msg.bonusIds)
end

function Season123Model:setSnapshotByHeroGroup(subId, param)
	local actId = self:getCurSeasonId()
	local mo = self:getActInfo(actId)

	if mo then
		mo:setSnapshotByHeroGroup(subId, param)
	end
end

Season123Model.instance = Season123Model.New()

return Season123Model
