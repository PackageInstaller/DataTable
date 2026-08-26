-- chunkname: @modules/logic/season/model/Activity104Model.lua

module("modules.logic.season.model.Activity104Model", package.seeall)

local Activity104Model = class("Activity104Model", ListScrollModel)

function Activity104Model:onInit()
	self:reInit()
end

function Activity104Model:reInit()
	self._activity104MoDic = {}
	self._getCardList = nil
end

function Activity104Model:setActivity104Info(info)
	self._activity104MoDic[info.activityId] = self._activity104MoDic[info.activityId] or Activity104Mo.New()

	self._activity104MoDic[info.activityId]:init(info)
end

function Activity104Model:tryGetActivityInfo(actId, callback, callbackObj)
	local mo = self:getActivityInfo(actId, true)

	if not mo then
		Activity104Rpc.instance:sendGet104InfosRequest(actId, callback, callbackObj)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end

	return mo
end

function Activity104Model:getActivityInfo(actId, noError)
	local mo = self._activity104MoDic[actId]

	if not mo and not noError then
		-- block empty
	end

	return mo
end

function Activity104Model:updateItemChange(info)
	if not info.activityId then
		local actId = self:getCurSeasonId()
		local mo = self:getActivityInfo(actId)

		if mo then
			mo:updateItems(info)
		end
	end
end

function Activity104Model:updateActivity104Info(info)
	local mo = self:getActivityInfo(info.activityId)

	if not mo then
		return
	end

	mo:reset(info)
	mo:setBattleFinishLayer(info.layer)

	self.settleType = info.settleType
	self.curBattleRetail = info.retail
end

function Activity104Model:enterAct104Battle(episodeId, layer)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	self:setBattleFinishLayer(layer)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
end

function Activity104Model:onStartAct104BattleReply(info)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(info.episodeId)

	self:setBattleFinishLayer(info.layer)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, info.episodeId)
end

function Activity104Model:setBattleFinishLayer(layer)
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo:setBattleFinishLayer(layer)
end

function Activity104Model:getBattleFinishLayer()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getBattleFinishLayer()
end

function Activity104Model:getAllEpisodeMO()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.episodes
end

function Activity104Model:getLastRetails()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getLastRetails()
end

function Activity104Model:getAllItemMo()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.activity104Items
end

function Activity104Model:getItemEquipUid(itemId)
	if itemId == 0 then
		return 0
	end

	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	for _, v in pairs(mo.activity104Items) do
		if v.itemId == itemId then
			return v.uid
		end
	end

	return 0
end

function Activity104Model:getItemIdByUid(uid)
	if uid == "0" then
		return 0
	end

	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	for _, v in pairs(mo.activity104Items) do
		if v.uid == uid then
			return v.itemId
		end
	end

	return 0
end

function Activity104Model:getAllSpecialMo()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.specials
end

function Activity104Model:getSeasonAllHeroGroup()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.heroGroupSnapshot
end

function Activity104Model:isSeasonGMChapter(chapterId)
	local id = chapterId or DungeonModel.instance.curSendChapterId

	return id == 9991
end

function Activity104Model:isSeasonChapter()
	local actId = self:getCurSeasonId()
	local curEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not curEpisodeId or curEpisodeId == 0 then
		return false
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(curEpisodeId)

	if episodeCo and self:isSeasonEpisodeType(episodeCo.type) then
		return true
	end

	return false
end

function Activity104Model:getEpisodeState(layer)
	local episode = self:getAllEpisodeMO()

	return (episode[layer] or nil) and (episode[layer].state or 0)
end

function Activity104Model:getCurSeasonId()
	return Activity104Enum.CurSeasonId
end

function Activity104Model:isSeasonDataReady()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId, true)

	return mo ~= nil
end

function Activity104Model:getSeasonCurSnapshotSubId()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.heroGroupSnapshotSubId
end

function Activity104Model:setSeasonCurSnapshotSubId(actId, subId)
	actId = actId or self:getCurSeasonId()
	subId = subId or 1

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo.heroGroupSnapshotSubId = subId

	local groupMO = self:getSnapshotHeroGroupBySubId(subId)

	HeroSingleGroupModel.instance:setSingleGroup(groupMO)

	local list = HeroSingleGroupModel.instance:getList()

	for i = 1, #list do
		list[i]:setAid(groupMO.aidDict and groupMO.aidDict[i])

		if groupMO.trialDict and groupMO.trialDict[i] then
			list[i]:setTrial(unpack(groupMO.trialDict[i]))
		else
			list[i]:setTrial()
		end
	end
end

function Activity104Model:getSnapshotHeroGroupBySubId(subId)
	local actId = self:getCurSeasonId()

	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getSnapshotHeroGroupBySubId(subId)
end

function Activity104Model:setSnapshotByFightGroup(actId, subId, param)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo.heroGroupSnapshot[subId] = mo.heroGroupSnapshot[subId] or {}

	local heroGroupMo = mo.heroGroupSnapshot[subId]

	heroGroupMo.heroList = {}

	for _, v in ipairs(param.fightGroup.heroList) do
		table.insert(heroGroupMo.heroList, v)
	end

	for _, subHero in ipairs(param.fightGroup.subHeroList) do
		table.insert(heroGroupMo.heroList, subHero)
	end

	heroGroupMo.clothId = param.fightGroup.clothId
	heroGroupMo.equips = {}

	for pos, v in ipairs(param.fightGroup.equips) do
		if heroGroupMo.equips[pos - 1] == nil then
			heroGroupMo.equips[pos - 1] = HeroGroupEquipMO.New()
		end

		heroGroupMo.equips[pos - 1]:init({
			index = pos - 1,
			equipUid = v.equipUid
		})
	end

	heroGroupMo.activity104Equips = {}

	for pos, v in ipairs(param.fightGroup.activity104Equips) do
		if heroGroupMo.activity104Equips[pos - 1] == nil then
			heroGroupMo.activity104Equips[pos - 1] = HeroGroupActivity104EquipMo.New()
		end

		heroGroupMo.activity104Equips[pos - 1]:init({
			index = pos - 1,
			equipUid = v.equipUid
		})
	end

	heroGroupMo:clearAidHero()
end

function Activity104Model:getAllHeroGroupSnapshot(actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.heroGroupSnapshot
end

function Activity104Model:replaceHeroList(actId, subId, herolist)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo.heroGroupSnapshot[subId].heroList = herolist
end

function Activity104Model:resetSnapshotHeroGroupEquip(actId, subId, index, equipUid)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	for _, v in pairs(mo.heroGroupSnapshot[subId].equips) do
		if v.index == index then
			v.equipUid = equipUid
		end
	end
end

function Activity104Model:resetSnapshotHeroGroupHero(actId, subId, index, heroId)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo.heroGroupSnapshot[subId].heroList[index] = heroId
end

function Activity104Model:getAct104CurLayer(actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo or not mo.episodes then
		return 0, 1
	end

	local layer = 1
	local nextlayer = 1

	for _, v in pairs(mo.episodes) do
		if layer <= v.layer and v.state == 1 then
			layer = SeasonConfig.instance:getSeasonEpisodeCo(actId, v.layer + 1) and v.layer + 1 or v.layer
			nextlayer = v.layer + 1
		end
	end

	return layer, nextlayer
end

function Activity104Model:isLayerPassed(actId, layer)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo or not mo.episodes then
		return false
	end

	local state = self:getEpisodeState(layer)

	return state == 1
end

function Activity104Model:getAct104CurStage(actId, layer)
	actId = actId or self:getCurSeasonId()
	layer = layer or self:getAct104CurLayer(actId)

	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

	return (co or nil) and (co.stage or 0)
end

function Activity104Model:isStagePassed(stage)
	local actId = self:getCurSeasonId()
	local layer = self:getAct104CurLayer(actId)
	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

	if co then
		if not co.stage then
			local curStage = 0
			local isLayerPassed = self:getEpisodeState(layer) == 1

			if stage < curStage then
				return true
			end

			if curStage == stage and isLayerPassed then
				return true
			end

			return false
		end
	end
end

function Activity104Model:getMaxLayer(actId)
	actId = actId or self:getCurSeasonId()

	local seasonCos = SeasonConfig.instance:getSeasonEpisodeCos(actId)
	local layer = 0

	for _, v in pairs(seasonCos) do
		if layer < v.layer then
			layer = v.layer
		end
	end

	return layer
end

function Activity104Model:getMaxStage(actId)
	actId = actId or self:getCurSeasonId()

	local maxLayer = self:getMaxLayer(actId)
	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, maxLayer)

	return (co or nil) and (co.stage or 0)
end

function Activity104Model:isSpecialOpen(actId)
	actId = actId or self:getCurSeasonId()

	if not self:isEnterSpecial(actId) then
		return false
	end

	local co = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SpecialOpenLayer)
	local openLayer = co and co.value1

	return self:isLayerPassed(actId, openLayer)
end

function Activity104Model:isEnterSpecial(actId)
	actId = actId or self:getCurSeasonId()

	local startTime = ActivityModel.instance:getActStartTime(actId) / 1000
	local co = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SpecialOpenDayCount)
	local openDayCount = co and co.value1 - 1
	local specialStartTime = openDayCount * 86400 + startTime

	if specialStartTime <= ServerTime.now() then
		return true
	end

	return false
end

function Activity104Model:isSpecialLayerOpen(actId, layer)
	actId = actId or self:getCurSeasonId()

	local config = SeasonConfig.instance:getSeasonSpecialCo(actId, layer)
	local startTime = ActivityModel.instance:getActStartTime(actId) / 1000
	local openDayCount = config.openDay - 1
	local specialStartTime = openDayCount * 86400 + startTime
	local leftTime = specialStartTime - ServerTime.now()

	if leftTime > 0 then
		return false, leftTime
	end

	return true
end

function Activity104Model:isSeasonSlotUnlock(actId, subId, slot)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	local unlockSlots = mo.unlockEquipIndexs

	for _, v in pairs(unlockSlots) do
		if v ~= 9 and v >= 4 * slot then
			return true
		end
	end

	return false
end

function Activity104Model:isSeasonPosUnlock(actId, subId, slot, pos)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	local unlockSlots = mo.unlockEquipIndexs
	local index = pos == 4 and 9 or pos + 1 + 4 * (slot - 1)

	for _, v in pairs(unlockSlots) do
		if v == index then
			return true
		end
	end

	return false
end

function Activity104Model:isSeasonLayerSlotUnlock(actId, subId, layer, slot)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local unlockSlots = {}

	if layer > 1 then
		for i = 2, layer do
			local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(self:getCurSeasonId(), i - 1)
			local slots = string.splitToNumber(episodeCo.unlockEquipIndex, "#")

			for _, slot in pairs(slots) do
				table.insert(unlockSlots, slot)
			end
		end
	end

	for _, v in pairs(unlockSlots) do
		if v ~= 9 and v >= 4 * slot then
			return true
		end
	end

	return false
end

function Activity104Model:isSeasonLayerPosUnlock(actId, subId, layer, slot, pos)
	actId = actId or self:getCurSeasonId()
	subId = subId or self:getSeasonCurSnapshotSubId(actId)

	local unlockSlots = {}

	if layer > 1 then
		for i = 2, layer do
			local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(self:getCurSeasonId(), i - 1)
			local slots = string.splitToNumber(episodeCo.unlockEquipIndex, "#")

			for _, slot in pairs(slots) do
				table.insert(unlockSlots, slot)
			end
		end
	end

	local index = pos == 4 and 9 or pos + 1 + 4 * (slot - 1)

	for _, v in pairs(unlockSlots) do
		if v == index then
			return true
		end
	end

	return false
end

function Activity104Model:getSeasonHeroGroupEquipId(actId, subId, slot, pos)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo then
		return 0
	end

	local groupMo = mo:getSnapshotHeroGroupBySubId(subId)

	if groupMo and groupMo.activity104Equips[pos] then
		local uid = groupMo.activity104Equips[pos].equipUid[slot]

		return self:getItemIdByUid(uid), uid
	end

	return 0
end

function Activity104Model:getAct104Retails(actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo.retails
end

function Activity104Model:replaceAct104Retails(info)
	if not info.actId then
		local actId = self:getCurSeasonId()
		local mo = self:getActivityInfo(actId)

		if not mo then
			return
		end

		mo:replaceRetails(info.retails)

		mo.retailStage = info.retailStage
	end
end

function Activity104Model:getRetailStage(actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	if mo.retailStage == 0 then
		mo.retailStage = self:getAct104CurStage(actId)
	end

	return mo.retailStage
end

function Activity104Model:getRetailEpisodeTag(episodeId)
	local tag = ""
	local actId = self:getCurSeasonId()
	local retailCos = SeasonConfig.instance:getSeasonRetailCos(actId)

	for _, v in pairs(retailCos) do
		local episodeIds = string.splitToNumber(v.retailEpisodeIdPool, "#")
		local tags = string.split(v.enemyTag, "#")

		for i = 1, #episodeIds do
			if episodeIds[i] == episodeId then
				tag = tags[i] or ""

				return tag
			end
		end
	end

	return tag
end

function Activity104Model:getEpisodeRetail(episodeId)
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if mo then
		for _, v in pairs(mo.retails) do
			if v.id == episodeId then
				return v
			end
		end
	end

	return {}
end

function Activity104Model:isLastDay(actId)
	actId = actId or self:getCurSeasonId()

	local remainTime = ActivityModel.instance:getRemainTime(actId)

	return remainTime < 86400
end

function Activity104Model:isAllSpecialLayerFinished()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo or not mo.specials then
		return true
	end

	local maxLayer = self:getMaxSpecialLayer()

	for _, v in pairs(mo.specials) do
		if v.state == 0 then
			return false
		end
	end

	return true
end

function Activity104Model:getAct104SpecialInitLayer()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo or not mo.specials then
		return 0
	end

	local maxLayer = 1
	local layer

	for _, v in pairs(mo.specials) do
		if v.state == 0 then
			layer = layer and math.min(v.layer, layer) or v.layer
		end

		if self:isSpecialLayerOpen(actId, v.layer) then
			maxLayer = math.max(v.layer, maxLayer)
		end
	end

	if layer == nil then
		layer = maxLayer
	end

	return layer
end

function Activity104Model:getMaxSpecialLayer()
	local spCos = SeasonConfig.instance:getSeasonSpecialCos(self:getCurSeasonId())
	local layer = 0

	for _, v in pairs(spCos) do
		if layer < v.layer then
			layer = v.layer
		end
	end

	return layer
end

function Activity104Model:isSpecialLayerPassed(layer)
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo or not mo.specials then
		return false
	end

	for _, v in pairs(mo.specials) do
		if v.layer == layer then
			return v.state == 1
		end
	end

	return false
end

function Activity104Model:isNewStage()
	local stage = self:getAct104CurStage()
	local layer = self:getAct104CurLayer()
	local nextCo = SeasonConfig.instance:getSeasonEpisodeCo(self:getCurSeasonId(), layer - 1)

	if not nextCo then
		return false
	end

	local nextStage = nextCo.stage

	return stage ~= nextStage
end

function Activity104Model:isNextLayerNewStage(layer)
	local actId = self:getCurSeasonId()
	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

	if co then
		if not co.stage then
			local stage = 0
			local nextCo = SeasonConfig.instance:getSeasonEpisodeCo(self:getCurSeasonId(), layer + 1)

			if not nextCo then
				return false
			end

			local nextStage = nextCo.stage

			return stage ~= nextStage
		end
	end
end

function Activity104Model:isEpisodeAdvance(episodeId)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if config.type ~= DungeonEnum.EpisodeType.SeasonRetail then
		return false
	end

	local retails = self:getAct104Retails()

	for _, v in pairs(retails) do
		if v.id == episodeId and v.advancedId ~= 0 and v.advancedRare ~= 0 then
			return true
		end
	end

	return false
end

function Activity104Model:onReceiveGetUnlockActivity104EquipIdsReply(proto)
	local mo = self:getActivityInfo(proto.activityId)

	mo:setUnlockActivity104EquipIds(proto.unlockActivity104EquipIds)
end

function Activity104Model:isNew104Equip(equipId)
	local mo = self:getActivityInfo(self:getCurSeasonId())

	if not mo then
		return
	end

	return not mo.unlockActivity104EquipIds[equipId]
end

function Activity104Model:markActivityStory(actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if mo then
		mo:markStory(true)
	end
end

function Activity104Model:markEpisodeAfterStory(actId, layer)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if mo then
		mo:markEpisodeAfterStory(layer)
	end
end

function Activity104Model:isReadActivity104Story(actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	return mo and mo.readActivity104Story
end

function Activity104Model:isEpisodeAfterStory(actId, layer)
	local episode = self:getAllEpisodeMO(actId)

	if not episode then
		return
	end

	return episode[layer] and episode[layer].readAfterStory
end

function Activity104Model:canPlayStageLevelup(fightResult, episodeType, exitFightGroup, actId, layer)
	if fightResult ~= 1 then
		return
	end

	if episodeType ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if exitFightGroup then
		return
	end

	actId = actId or self:getCurSeasonId()

	if self:isEpisodeAfterStory(actId, layer) then
		return
	end

	if self:getMaxLayer() == layer then
		local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

		return co.stage + 1
	end

	if not self:isNextLayerNewStage(layer) then
		return
	end

	local nextCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer + 1)

	return nextCo and nextCo.stage
end

function Activity104Model:canMarkFightAfterStory(fightResult, episodeType, exitFightGroup, actId, layer)
	if fightResult ~= 1 then
		return
	end

	if episodeType ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if exitFightGroup or not layer then
		return
	end

	actId = actId or self:getCurSeasonId()

	if self:isEpisodeAfterStory(actId, layer) then
		return
	end

	return true
end

function Activity104Model:getOptionalAct104Equips(actId)
	actId = actId or self:getCurSeasonId()

	local items = {}
	local mo = self:getActivityInfo(actId)

	if mo then
		for _, v in pairs(mo.activity104Items) do
			local itemCo = SeasonConfig.instance:getSeasonEquipCo(v.itemId)

			if itemCo and itemCo.isOptional == 1 then
				table.insert(items, v)
			end
		end
	end

	return items
end

function Activity104Model:addCardGetData(cardList)
	local actId = self:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.CelebrityCardGetlView)

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

function Activity104Model:setMakertLayerMark(actId, layer)
	actId = actId or self:getCurSeasonId()

	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), "")
	local t = string.split(value, "|")
	local data = {}

	for i, v in ipairs(t) do
		local sub = string.splitToNumber(v, "#")

		if sub and sub[1] then
			data[sub[1]] = sub[2]
		end
	end

	if not data[actId] or layer > data[actId] then
		data[actId] = layer
	end

	local list = {}

	for k, v in pairs(data) do
		table.insert(list, string.format("%s#%s", k, v))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), table.concat(list, "|"))
end

function Activity104Model:isCanPlayMakertLayerAnim(actId, layer)
	actId = actId or self:getCurSeasonId()

	if not actId or not layer then
		return
	end

	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), "")
	local t = string.split(value, "|")

	for i, v in ipairs(t) do
		local sub = string.splitToNumber(v, "#")

		if sub and sub[1] == actId then
			return layer > sub[2]
		end
	end

	return true
end

function Activity104Model:setGroupCardUnlockTweenPos(actId, pos)
	actId = actId or self:getCurSeasonId()

	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), "")
	local t = string.split(value, "|")
	local data = {}

	for _, v in ipairs(t) do
		local sub = string.splitToNumber(v, "#")

		if sub and sub[1] then
			data[sub[1]] = {}

			if #sub > 1 then
				for i = 2, #sub do
					data[sub[1]][sub[i]] = 1
				end
			end
		end
	end

	data[actId] = data[actId] or {}
	data[actId][pos] = 1

	local list = {}

	for _actId, v in pairs(data) do
		local temp = {
			_actId
		}

		for _pos, _ in pairs(v) do
			table.insert(temp, _pos)
		end

		table.insert(list, table.concat(temp, "#"))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), table.concat(list, "|"))
end

function Activity104Model:isContainGroupCardUnlockTweenPos(actId, layer, pos)
	actId = actId or self:getCurSeasonId()

	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

	if not co then
		return true
	end

	local list = string.splitToNumber(co.unlockEquipIndex, "#")

	if not tabletool.indexOf(list, pos) then
		return true
	end

	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), "")
	local t = string.split(value, "|")

	for _, v in ipairs(t) do
		local sub = string.splitToNumber(v, "#")

		if sub and sub[1] == actId then
			if #sub > 1 then
				for i = 2, #sub do
					if sub[i] == pos then
						return true
					end
				end
			end

			break
		end
	end

	return false
end

function Activity104Model:caleStageEquipRareWeight(stage)
	stage = stage or self:getAct104CurStage()

	local actId = self:getCurSeasonId()
	local co = SeasonConfig.instance:getSeasonRetailCo(actId, stage)
	local list1 = string.split(co.equipRareWeight, "|")
	local allWeight = 0
	local maxWeight = 0
	local maxStar = 0

	for i, v in ipairs(list1) do
		local list = string.splitToNumber(v, "#")

		if list then
			allWeight = list[2] + allWeight

			if maxStar < list[1] then
				maxStar = list[1]
				maxWeight = list[2]
			end
		end
	end

	if allWeight == 0 then
		allWeight = 1
	end

	local equipId = 0
	local optionCos = SeasonConfig.instance:getSeasonOptionalEquipCos()

	for _, v in pairs(optionCos) do
		if v.rare == maxStar then
			equipId = v.equipId

			break
		end
	end

	return maxWeight / allWeight, maxStar, equipId
end

function Activity104Model:getStageEpisodeList(stage)
	local list = {}

	if stage then
		local actId = self:getCurSeasonId()
		local dict = SeasonConfig.instance:getSeasonEpisodeCos(actId)

		for k, v in pairs(dict) do
			if v.stage == stage then
				table.insert(list, v)
			end
		end

		table.sort(list, function(a, b)
			return a.layer < b.layer
		end)
	end

	return list
end

function Activity104Model:getItemCount(itemId, actId)
	actId = actId or self:getCurSeasonId()

	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getItemCount(itemId)
end

function Activity104Model:isSeasonEpisodeType(episodeType)
	return episodeType == DungeonEnum.EpisodeType.Season or episodeType == DungeonEnum.EpisodeType.SeasonRetail or episodeType == DungeonEnum.EpisodeType.SeasonSpecial or episodeType == DungeonEnum.EpisodeType.SeasonTrial
end

function Activity104Model:getRealHeroGroupBySubId(subId)
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getRealHeroGroupBySubId(subId)
end

function Activity104Model:getFightCardDataList()
	local fightParam = FightModel.instance:getFightParam()
	local equips = fightParam.activity104Equips

	return Activity104EquipItemListModel.instance:fiterFightCardDataList(equips, fightParam.trialHeroList)
end

function Activity104Model:buildHeroGroup()
	local actId = self:getCurSeasonId()
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo:buildHeroGroup()
end

function Activity104Model:MarkPopSummary(actId)
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	mo:setIsPopSummary(false)
end

function Activity104Model:getIsPopSummary(actId)
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getIsPopSummary()
end

function Activity104Model:getLastMaxLayer(actId)
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getLastMaxLayer()
end

function Activity104Model:getTrialId(actId)
	local mo = self:getActivityInfo(actId)

	if not mo then
		return
	end

	return mo:getTrialId()
end

function Activity104Model:getSeasonTrialPrefsKey()
	return (string.format("%s_%s_%s", PlayerPrefsKey.SeasonHeroGroupTrial, PlayerModel.instance:getMyUserId(), self:getCurSeasonId()))
end

function Activity104Model:hasSeasonReview(actId)
	local constCo1 = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.LastSeasonId)
	local lastActId = constCo1 and constCo1.value1

	if not lastActId or lastActId == 0 then
		return false
	end

	local actCo = ActivityConfig.instance:getActivityCo(lastActId)

	return actCo ~= nil
end

function Activity104Model:caleRetailEquipRareWeight()
	local actId = self:getCurSeasonId()
	local retails = SeasonConfig.instance:getSeasonRetailEpisodes(actId)
	local maxWeight = 0
	local maxRare = 0
	local maxEquipId = 0

	for _, v in pairs(retails) do
		local episodeId = v.retailEpisodeId
		local weight, rare, equipId = self:getRetailEpisodeEquipRareWeight(actId, episodeId)

		if maxRare < rare then
			maxWeight = weight
			maxRare = rare
			maxEquipId = equipId
		end
	end

	return maxWeight, maxRare, maxEquipId
end

function Activity104Model:getRetailEpisodeEquipRareWeight(actId, episodeId)
	local episodeConfig = SeasonConfig.instance:getSeasonRetailEpisodeCo(actId, episodeId)
	local allWeight = 0
	local maxWeight = 0
	local maxStar = 0

	if not episodeConfig then
		return 0, 0, 0
	end

	local arr = GameUtil.splitString2(episodeConfig.equipRareWeight, true)

	for i, v in ipairs(arr) do
		allWeight = v[2] + allWeight

		if maxStar < v[1] then
			maxStar = v[1]
			maxWeight = v[2]
		end
	end

	if allWeight == 0 then
		allWeight = 1
	end

	local equipId = 0
	local optionCos = SeasonConfig.instance:getSeasonOptionalEquipCos()

	for _, v in pairs(optionCos) do
		if v.rare == maxStar then
			equipId = v.equipId

			break
		end
	end

	return maxWeight / allWeight, maxStar, equipId
end

Activity104Model.instance = Activity104Model.New()

return Activity104Model
