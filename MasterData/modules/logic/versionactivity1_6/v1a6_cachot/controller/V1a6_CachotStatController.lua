-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotStatController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotStatController", package.seeall)

local V1a6_CachotStatController = class("V1a6_CachotStatController", BaseController)

V1a6_CachotStatController.FailReasonEnum = {
	FightFail = 1,
	EventFail = 2,
	AbortFight = 3,
	GM = 4
}

local FailReason = {
	[V1a6_CachotStatController.FailReasonEnum.FightFail] = "战斗全员阵亡失败-%s",
	[V1a6_CachotStatController.FailReasonEnum.EventFail] = "战斗外事件导致失败-%s",
	[V1a6_CachotStatController.FailReasonEnum.AbortFight] = "战斗主动退出-%s"
}

function V1a6_CachotStatController:onInit()
	return
end

function V1a6_CachotStatController:reInit()
	self:clearStatEnd()
	self:clearInitHeroGroup()
end

function V1a6_CachotStatController:initObjPool()
	self.objPool = self.objPool or {}
end

function V1a6_CachotStatController:getNewObj()
	self:initObjPool()

	if self.objPool and #self.objPool > 1 then
		return table.remove(self.objPool)
	end

	return {}
end

function V1a6_CachotStatController:copyValueList(list)
	local newList = self:getNewObj()

	for _, value in ipairs(list) do
		table.insert(newList, value)
	end

	return newList
end

function V1a6_CachotStatController:copyValueDict(dict)
	local newDict = self:getNewObj()

	for key, value in pairs(dict) do
		newDict[key] = value
	end

	return newDict
end

function V1a6_CachotStatController:recycleObj(obj)
	if not obj then
		return
	end

	self:initObjPool()
	tabletool.clear(obj)
	table.insert(self.objPool, obj)
end

function V1a6_CachotStatController:recycleObjList(objList)
	if not objList then
		return
	end

	for _, obj in ipairs(objList) do
		self:recycleObj(obj)
	end

	self:recycleObj(objList)
end

function V1a6_CachotStatController:clearObjPool()
	self.objPool = nil
end

function V1a6_CachotStatController:statStart()
	self.startTime = ServerTime.now()
end

function V1a6_CachotStatController:statReset()
	self.statEnum = StatEnum.Result.Reset
end

function V1a6_CachotStatController:statAbort()
	self:removeRpcCallback()

	self.callbackId = RogueRpc.instance:sendRogueReturnRequest(V1a6_CachotEnum.ActivityId, self.onReceiveRogueReturnInfo, self)
end

function V1a6_CachotStatController:onReceiveRogueReturnInfo(cmd, resultCode, msg)
	self.callbackId = nil

	if resultCode ~= 0 then
		self:clearStatEnd()

		return
	end

	if not self.rogueEndInfo then
		local rogueEndInfoMo = RogueEndingInfoMO.New()

		rogueEndInfoMo:init(msg.endPush)
		self:_statEnd(StatEnum.Result.Abort, "", rogueEndInfoMo)
	end
end

function V1a6_CachotStatController:removeRpcCallback()
	if self.callbackId then
		RogueRpc.instance:removeCallbackById(self.callbackId)

		self.callbackId = nil
	end
end

function V1a6_CachotStatController:statEnd()
	local rogueEndInfoMo = V1a6_CachotModel.instance:getRogueEndingInfo()
	local result, failReason

	if self.statEnum == StatEnum.Result.Reset then
		self.startTime = ServerTime.now()
		result = StatEnum.Result.Reset
		failReason = ""
	else
		result = rogueEndInfoMo:isFinish() and StatEnum.Result.Success or StatEnum.Result.Fail
		failReason = self:getFailReason()
	end

	self:_statEnd(result, failReason, rogueEndInfoMo)
end

function V1a6_CachotStatController:_statEnd(result, failReason, rogueEndInfoMo)
	if not self.startTime then
		return
	end

	local rogueInfoMo = self:getRogueInfoMo()
	local collectionNameList, collectionObjList = self:getCollectList()
	local currentHeroNameList, currentHeroObjList = self:getHeroGroupList()
	local finishEventList = self:copyValueList(rogueEndInfoMo:getFinishEventList())
	local var_16_0 = StatEnum.EventName.ExitCachot
	local var_16_1 = {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self.startTime,
		[StatEnum.EventProperties.Difficulty] = rogueEndInfoMo:getDifficulty(),
		[StatEnum.EventProperties.DungeonResult] = result,
		[StatEnum.EventProperties.InterruptReason] = failReason,
		[StatEnum.EventProperties.CompletedEventNum] = rogueEndInfoMo:getFinishEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = finishEventList,
		[StatEnum.EventProperties.CompletedRoomEnum] = rogueEndInfoMo:getRoomNum(),
		[StatEnum.EventProperties.CompletedLayers] = rogueEndInfoMo:getLayer(),
		[StatEnum.EventProperties.DungeonPoints] = rogueEndInfoMo:getScore(),
		[StatEnum.EventProperties.IsDoublePoints] = rogueEndInfoMo:isDoubleScore(),
		[StatEnum.EventProperties.InitialHeroGroup] = self.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = self.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = currentHeroNameList,
		[StatEnum.EventProperties.HeroGroupArray] = currentHeroObjList,
		[StatEnum.EventProperties.CollectList] = collectionNameList,
		[StatEnum.EventProperties.CollectArray] = collectionObjList
	}

	if rogueInfoMo then
		var_16_1[StatEnum.EventProperties.HeartBeat] = rogueInfoMo.heart or nil
	end

	if rogueInfoMo then
		var_16_1[StatEnum.EventProperties.DungeonGold] = rogueInfoMo.coin or nil
	end

	if rogueInfoMo then
		var_16_1[StatEnum.EventProperties.DungeonTokens] = rogueInfoMo.currency or nil
	end

	StatController.instance:track(var_16_0, var_16_1)
	self:recycleObj(finishEventList)
	self:recycleObj(collectionNameList)
	self:recycleObj(currentHeroNameList)
	self:recycleObjList(collectionObjList)
	self:recycleObjList(currentHeroObjList)
	self:clearStatEnd()
end

function V1a6_CachotStatController:clearStatEnd()
	self.statEnum = nil
	self.startTime = nil

	self:removeRpcCallback()
end

function V1a6_CachotStatController:recordInitHeroGroupByEnterRogue()
	self:recycleObj(self.initHeroNameList)
	self:recycleObjList(self.initHeroObjList)

	self.initHeroNameList, self.initHeroObjList = self:getHeroGroupList(true)
end

function V1a6_CachotStatController:recordInitHeroGroup()
	if not LoginController.instance:isEnteredGame() then
		return
	end

	local rogueStateInfoMo = V1a6_CachotModel.instance:getRogueStateInfo()
	local lastMainGroup = rogueStateInfoMo.lastGroup
	local lastBackupGroup = rogueStateInfoMo.lastBackupGroup
	local heroNameList = self:getNewObj()
	local heroObjList = self:getNewObj()

	if not rogueStateInfoMo.difficulty then
		local difficulty = 1

		if not rogueStateInfoMo.difficulty or rogueStateInfoMo.difficulty == 0 then
			difficulty = 1
		end

		local rogueDifficultyCo = lua_rogue_difficulty.configDict[difficulty]

		if not rogueDifficultyCo then
			logError("not found rouge difficulty co : " .. tostring(difficulty))
		end

		local seatLevelList = string.splitToNumber(rogueDifficultyCo.initLevel, "#")

		self:addGroupData(lastMainGroup, heroNameList, heroObjList, seatLevelList)
		self:addGroupData(lastBackupGroup, heroNameList, heroObjList)
		self:recycleObj(self.initHeroNameList)
		self:recycleObjList(self.initHeroObjList)

		self.initHeroNameList = heroNameList
		self.initHeroObjList = heroObjList
	end
end

function V1a6_CachotStatController:clearInitHeroGroup()
	self:recycleObj(self.initHeroNameList)
	self:recycleObjList(self.initHeroObjList)

	self.initHeroNameList = nil
	self.initHeroObjList = nil
end

function V1a6_CachotStatController:addGroupData(group, heroNameList, heroObjList, seatLevelList)
	for index, heroUid in ipairs(group.heroList) do
		if heroUid ~= "0" then
			local heroMo = HeroModel.instance:getById(heroUid)

			if heroMo then
				if seatLevelList then
					local name, obj = self:buildHeroObj(heroMo, group:getFirstEquipMo(index), seatLevelList[index] or nil)

					obj.remain_HP = "100"

					table.insert(heroNameList, name)
					table.insert(heroObjList, obj)
				end
			end
		end
	end
end

function V1a6_CachotStatController:bakeRogueInfoMo()
	self.rogueInfoMo = V1a6_CachotModel.instance:getRogueInfo()
end

function V1a6_CachotStatController:getRogueInfoMo()
	return self.rogueInfoMo
end

function V1a6_CachotStatController:clearRogueInfoMo()
	self.rogueInfoMo = nil
end

function V1a6_CachotStatController:getRunningEvents()
	local rogueInfoMo = self:getRogueInfoMo()

	if not rogueInfoMo then
		return ""
	end

	local selectEventMoList = rogueInfoMo:getSelectEvents()

	if not selectEventMoList or #selectEventMoList < 1 then
		return ""
	end

	local eventIdList = self:getNewObj()

	for _, eventMo in ipairs(selectEventMoList) do
		if eventMo.status == V1a6_CachotEnum.EventStatus.Start then
			table.insert(eventIdList, eventMo.eventId)
		end
	end

	local result = table.concat(eventIdList, "-")

	self:recycleObj(eventIdList)

	return result
end

function V1a6_CachotStatController:getFailReason()
	local rogueEndInfoMo = V1a6_CachotModel.instance:getRogueEndingInfo()

	if not rogueEndInfoMo then
		return nil
	end

	if rogueEndInfoMo:isFinish() then
		return nil
	end

	local failReason = FailReason[rogueEndInfoMo:getFailReason()]

	failReason = failReason or FailReason[V1a6_CachotStatController.FailReasonEnum.FightFail]

	local eventStr = self:getRunningEvents()

	return string.format(failReason, eventStr)
end

function V1a6_CachotStatController:getCollectList()
	local rogueInfoMo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfoMo then
		return nil, nil
	end

	local collectionMoDict = rogueInfoMo.collections
	local allCollectionMoMap = rogueInfoMo.collectionMap
	local nameList = self:getNewObj()
	local objList = self:getNewObj()
	local existDict = self:getNewObj()

	for _, collectMo in pairs(collectionMoDict) do
		local config = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectMo.cfgId)

		if config then
			table.insert(nameList, config.name)

			existDict[collectMo.id] = true

			local obj = self:getNewObj()

			obj.collection_name = config.name
			obj.collection_num = 1

			if collectMo.leftUid ~= 0 then
				local tempMo = allCollectionMoMap[collectMo.leftUid]

				if tempMo then
					existDict[tempMo.id] = true
					config = V1a6_CachotCollectionConfig.instance:getCollectionConfig(tempMo.cfgId)
					obj.enchant_collection_left_name = config.name
					obj.enchant_collection_left_num = 1
				else
					logError(string.format("collectMo.id : '%s' not found left uid : '%s'", collectMo.id, collectMo.leftUid))
				end
			end

			if collectMo.rightUid ~= 0 then
				local tempMo = allCollectionMoMap[collectMo.rightUid]

				if tempMo then
					existDict[tempMo.id] = true
					config = V1a6_CachotCollectionConfig.instance:getCollectionConfig(tempMo.cfgId)
					obj.enchant_collection_right_name = config.name
					obj.enchant_collection_right_num = 1
				else
					logError(string.format("collectMo.id : '%s' not found right uid : '%s'", collectMo.id, collectMo.rightUid))
				end
			end

			table.insert(objList, obj)
		end
	end

	return nameList, objList
end

function V1a6_CachotStatController:getHeroGroupList(isRecordInit)
	local rogueInfoMo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfoMo then
		return nil, nil
	end

	local teamInfo = rogueInfoMo.teamInfo
	local heroNameList = self:getNewObj()
	local heroObjList = self:getNewObj()
	local heroSingleGroupMoList = teamInfo:getGroupHeros()
	local equipMoList = teamInfo:getGroupEquips()
	local groupBoxStar = teamInfo.groupBoxStar

	for index, heroSingleGroupMO in ipairs(heroSingleGroupMoList) do
		local heroMo = HeroModel.instance:getById(heroSingleGroupMO.heroUid)

		if heroMo then
			local equipMo = equipMoList[index]
			local seatLevel = groupBoxStar[index]
			local name, obj = self:buildHeroObj(heroMo, equipMo, seatLevel)

			obj.remain_HP = teamInfo.lifeMap[heroMo.heroId].lifePercent

			if not isRecordInit then
				obj.field_level = seatLevel
			end

			table.insert(heroNameList, name)
			table.insert(heroObjList, obj)
		end
	end

	local supportHeroSingleGroupMoList = teamInfo:getSupportHeros()

	for index, heroSingleGroupMO in ipairs(supportHeroSingleGroupMoList) do
		local heroMo = HeroModel.instance:getById(heroSingleGroupMO.heroUid)

		if heroMo then
			local equipMo = equipMoList[index + 4]
			local name, obj = self:buildHeroObj(heroMo, equipMo, nil)

			obj.remain_HP = teamInfo.lifeMap[heroMo.heroId].lifePercent

			if not isRecordInit then
				obj.field_level = 0
			end

			table.insert(heroNameList, name)
			table.insert(heroObjList, obj)
		end
	end

	return heroNameList, heroObjList
end

function V1a6_CachotStatController:buildHeroObj(heroMo, equipMo, seatLevel)
	local heroCo = HeroConfig.instance:getHeroCO(heroMo.heroId)
	local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(heroMo, seatLevel)
	local _, rankLevel = HeroConfig.instance:getShowLevel(level)
	local equipMaxLevel, equipRefine, equipName

	if equipMo then
		equipMaxLevel = V1a6_CachotTeamModel.instance:getEquipMaxLevel(equipMo, seatLevel)
		equipRefine = equipMo.refineLv
		equipName = equipMo.config.name
	else
		equipMaxLevel = 0
		equipRefine = 0
		equipName = ""
	end

	local obj = self:getNewObj()

	obj.hero_name = heroCo.name
	obj.hero_level = level
	obj.hero_rank = rankLevel
	obj.breakthrough = heroMo.exSkillLevel
	obj.talent = talentLevel
	obj.EquipName = equipName
	obj.EquipLevel = equipMaxLevel
	obj.equip_refine = equipRefine

	return heroCo.name, obj
end

function V1a6_CachotStatController:clearStartEventDict()
	if self.startEventDict then
		for _, eventObj in pairs(self.startEventDict) do
			self:recycleObj(eventObj)
		end

		tabletool.clear(self.startEventDict)
	end
end

function V1a6_CachotStatController:recycleEventObj(eventId)
	if not self.startEventDict then
		return
	end

	if self.startEventDict[eventId] then
		self:recycleObj(self.startEventDict[eventId])

		self.startEventDict[eventId] = nil
	end
end

function V1a6_CachotStatController:initEventStartHandle()
	self.startEventHandleDict = self.startEventHandleDict or {
		[V1a6_CachotEnum.EventType.HeroPosUpgrade] = self.onStartHeroPosUpgradeEvent
	}
end

function V1a6_CachotStatController:onStartHeroPosUpgradeEvent(event)
	local obj = self:getNewObj()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo

	obj.groupBoxStar = self:copyValueList(teamInfo.groupBoxStar)

	return obj
end

function V1a6_CachotStatController:statStartEvent(event)
	if not event then
		return
	end

	if event.status ~= V1a6_CachotEnum.EventStatus.Start then
		return
	end

	self.startEventDict = self.startEventDict or {}

	if self.startEventDict[event.eventId] then
		return
	end

	self:initEventStartHandle()

	local eventCo = lua_rogue_event.configDict[event.eventId]
	local startHandleFunc = self.startEventHandleDict[eventCo.type]

	if not startHandleFunc then
		return
	end

	self.startEventDict[event.eventId] = startHandleFunc(self, event)
end

function V1a6_CachotStatController:getObtainHeroNameList(event)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.CharacterGet then
		return
	end

	self.obtainHeroList = self.obtainHeroList or {}

	tabletool.clear(self.obtainHeroList)

	local heroCo = HeroConfig.instance:getHeroCO(event.option)

	if not heroCo then
		if event.option ~= 0 then
			logError("not config hero , heroId : " .. tostring(event.option))
		end

		return nil
	end

	table.insert(self.obtainHeroList, heroCo.name)

	return self.obtainHeroList
end

function V1a6_CachotStatController:getSeatUpList(event)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.HeroPosUpgrade then
		return
	end

	if not self.startEventDict then
		return
	end

	local beforeObj = self.startEventDict[event.eventId]

	if not beforeObj then
		return
	end

	local list = self:getNewObj()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo

	for seatId, level in ipairs(teamInfo.groupBoxStar) do
		if level ~= beforeObj.groupBoxStar[seatId] then
			local obj = self:getNewObj()

			obj.field_id = seatId
			obj.field_before_level = beforeObj.groupBoxStar[seatId]
			obj.field_after_level = level

			table.insert(list, obj)
		end
	end

	self:recycleEventObj(event.eventId)

	if #list > 0 then
		return list
	end

	self:recycleObjList(list)
end

function V1a6_CachotStatController:getStoryOptionId(event)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.ChoiceSelect then
		return
	end

	return tostring(event.option)
end

function V1a6_CachotStatController:getPromptOptionId(event)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.Tip then
		return
	end

	return tostring(eventConfig.eventId)
end

function V1a6_CachotStatController:initChangeLifeHeroNameList()
	self.changeLifeHeroNameList = self.changeLifeHeroNameList or {}

	tabletool.clear(self.changeLifeHeroNameList)
end

function V1a6_CachotStatController:setChangeLife(heroLifeList)
	self:initChangeLifeHeroNameList()

	for _, life in ipairs(heroLifeList) do
		local heroCo = HeroConfig.instance:getHeroCO(life.heroId)

		if heroCo then
			table.insert(self.changeLifeHeroNameList, heroCo.name)
		end
	end
end

function V1a6_CachotStatController:initBloodReturnHeroNameList()
	self.bloodReturnHeroNameList = self.bloodReturnHeroNameList or {}

	tabletool.clear(self.bloodReturnHeroNameList)
end

function V1a6_CachotStatController:getBloodReturnHeroNameList(event)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.CharacterCure then
		return
	end

	local lifeConfig = lua_rogue_event_life.configDict[eventConfig.eventId]

	if not lifeConfig then
		return
	end

	local numArr = string.splitToNumber(lifeConfig.num, "#")
	local type = numArr[1]

	if type == V1a6_CachotEnum.CureEventType.Single then
		local heroCo = HeroConfig.instance:getHeroCO(event.option)

		if heroCo then
			self:initBloodReturnHeroNameList()
			table.insert(self.bloodReturnHeroNameList, heroCo.name)

			return self.bloodReturnHeroNameList
		else
			logError("not find heroid  config : " .. tostring(event.option))

			return nil
		end
	elseif type == V1a6_CachotEnum.CureEventType.Random then
		return self.changeLifeHeroNameList
	elseif type == V1a6_CachotEnum.CureEventType.All then
		return self.changeLifeHeroNameList
	else
		logError("not handle type : " .. tostring(lifeConfig.num))

		return nil
	end
end

function V1a6_CachotStatController:initReviveHeroNameList()
	self.reviveHeroNameList = self.reviveHeroNameList or {}

	tabletool.clear(self.reviveHeroNameList)
end

function V1a6_CachotStatController:getReviveHeroNameList(event)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.CharacterRebirth then
		return
	end

	local reviveConfig = lua_rogue_event_revive.configDict[eventConfig.eventId]

	if not reviveConfig then
		return
	end

	local numArr = string.splitToNumber(reviveConfig.num, "#")
	local type = numArr[1]

	if type == V1a6_CachotEnum.CureEventType.Single then
		local heroCo = HeroConfig.instance:getHeroCO(event.option)

		if heroCo then
			self:initReviveHeroNameList()
			table.insert(self.reviveHeroNameList, heroCo.name)

			return self.reviveHeroNameList
		else
			logError("not find heroid  config : " .. tostring(event.option))

			return nil
		end
	elseif type == V1a6_CachotEnum.CureEventType.Random then
		return self.changeLifeHeroNameList
	elseif type == V1a6_CachotEnum.CureEventType.All then
		return self.changeLifeHeroNameList
	else
		logError("not handle type : " .. tostring(reviveConfig.num))

		return nil
	end
end

function V1a6_CachotStatController:addBuyGoods(event, collectionNameList, collectionObjList)
	if not event then
		return
	end

	local eventConfig = lua_rogue_event.configDict[event.eventId]

	if eventConfig.type ~= V1a6_CachotEnum.EventType.Store then
		return
	end

	local data = cjson.decode(event.eventData)

	if not data then
		return
	end

	local buyGoodsList = data.buy

	if not buyGoodsList then
		return
	end

	collectionNameList = collectionNameList or self:getNewObj()
	collectionObjList = collectionObjList or self:getNewObj()

	for _, goodsId in ipairs(buyGoodsList) do
		local goodsCo = lua_rogue_goods.configDict[goodsId]

		if goodsCo and goodsCo.creator ~= 0 then
			local collectCo = V1a6_CachotCollectionConfig.instance:getCollectionConfig(goodsCo.creator)

			if collectCo then
				table.insert(collectionNameList, collectCo.name)

				local obj = self:getNewObj()

				obj.collection_name = collectCo.name
				obj.collection_num = 1

				table.insert(collectionObjList, obj)
			end
		end
	end
end

function V1a6_CachotStatController:statFinishEvent(event)
	if not event or event.status ~= V1a6_CachotEnum.EventStatus.Finish then
		return
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local roomConfig = V1a6_CachotRoomConfig.instance:getCoByRoomId(rogueInfo.room)
	local eventConfig = lua_rogue_event.configDict[event.eventId]
	local collectionNameList, collectionObjList = self:getCollectList()
	local currentHeroNameList, currentHeroObjList = self:getHeroGroupList()
	local seatInfoList = self:getSeatUpList(event)

	self:addBuyGoods(event, collectionNameList, collectionObjList)
	StatController.instance:track(StatEnum.EventName.CompleteCachotEvent, {
		[StatEnum.EventProperties.Difficulty] = rogueInfo.difficulty,
		[StatEnum.EventProperties.Layer] = rogueInfo.layer,
		[StatEnum.EventProperties.RoomId] = roomConfig.id,
		[StatEnum.EventProperties.RoomName] = roomConfig.name,
		[StatEnum.EventProperties.DungeonEventId] = tostring(eventConfig.id),
		[StatEnum.EventProperties.DungeonEventName] = eventConfig.title,
		[StatEnum.EventProperties.DungeonEventType] = tostring(eventConfig.type),
		[StatEnum.EventProperties.InitialHeroGroup] = self.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = self.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = currentHeroNameList,
		[StatEnum.EventProperties.HeroGroupArray] = currentHeroObjList,
		[StatEnum.EventProperties.CollectList] = collectionNameList,
		[StatEnum.EventProperties.CollectArray] = collectionObjList,
		[StatEnum.EventProperties.HeartBeat] = rogueInfo.heart,
		[StatEnum.EventProperties.DungeonGold] = rogueInfo.coin,
		[StatEnum.EventProperties.DungeonTokens] = rogueInfo.currency,
		[StatEnum.EventProperties.CachotObtainHero] = self:getObtainHeroNameList(event),
		[StatEnum.EventProperties.FieldUp] = seatInfoList,
		[StatEnum.EventProperties.StoryOptionId] = self:getStoryOptionId(event),
		[StatEnum.EventProperties.PromptOptionId] = self:getPromptOptionId(event),
		[StatEnum.EventProperties.BloodReturnHero] = self:getBloodReturnHeroNameList(event),
		[StatEnum.EventProperties.ReviveHero] = self:getReviveHeroNameList(event)
	})
	self:recycleObj(currentHeroNameList)
	self:recycleObj(collectionNameList)
	self:recycleObjList(currentHeroObjList)
	self:recycleObjList(collectionObjList)
	self:recycleObjList(seatInfoList)
end

function V1a6_CachotStatController:statEnterRoom()
	self.enterRoomTime = ServerTime.now()

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	self.beforeCoin = rogueInfo.coin
	self.beforeCurrency = rogueInfo.currency
	self.beforeCollectionDict = self:copyValueDict(rogueInfo.collectionMap)
end

function V1a6_CachotStatController:getCostAndReward()
	if not self.enterRoomTime then
		return
	end

	local cost = self:getNewObj()
	local reward = self:getNewObj()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if self.beforeCoin ~= rogueInfo.coin then
		local itemConfig = ItemConfig.instance:getItemConfig(MaterialEnum.MaterialType.Currency, V1a6_CachotEnum.CoinId)
		local obj = self:getNewObj()

		obj.materialtype = MaterialEnum.MaterialType.Currency
		obj.materialname = itemConfig.name

		if self.beforeCoin > rogueInfo.coin then
			obj.materialnum = self.beforeCoin - rogueInfo.coin

			table.insert(cost, obj)
		else
			obj.materialnum = rogueInfo.coin - self.beforeCoin

			table.insert(reward, obj)
		end
	end

	if self.beforeCurrency ~= rogueInfo.currency then
		local itemConfig = ItemConfig.instance:getItemConfig(MaterialEnum.MaterialType.Currency, V1a6_CachotEnum.CurrencyId)
		local obj = self:getNewObj()

		obj.materialtype = MaterialEnum.MaterialType.Currency
		obj.materialname = itemConfig.name

		if self.beforeCurrency > rogueInfo.currency then
			obj.materialnum = self.beforeCurrency - rogueInfo.currency

			table.insert(cost, obj)
		else
			obj.materialnum = rogueInfo.currency - self.beforeCurrency

			table.insert(reward, obj)
		end
	end

	local currentCollectionDict = rogueInfo.collectionMap

	for uid, collectMo in pairs(currentCollectionDict) do
		if not self.beforeCollectionDict[uid] then
			local config = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectMo.cfgId)
			local obj = self:getNewObj()

			obj.materialtype = MaterialEnum.MaterialType.None
			obj.materialname = config.name
			obj.materialnum = 1

			table.insert(reward, obj)
		end
	end

	for uid, collectMo in pairs(self.beforeCollectionDict) do
		if not currentCollectionDict[uid] then
			local config = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectMo.cfgId)
			local obj = self:getNewObj()

			obj.materialtype = MaterialEnum.MaterialType.None
			obj.materialname = config.name
			obj.materialnum = 1

			table.insert(cost, obj)
		end
	end

	return cost, reward
end

function V1a6_CachotStatController:statFinishRoom(roomId, layer)
	if not self.enterRoomTime then
		return
	end

	local roomConfig = V1a6_CachotRoomConfig.instance:getCoByRoomId(roomId)

	if not roomConfig then
		return
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collectionNameList, collectionObjList = self:getCollectList()
	local currentHeroNameList, currentHeroObjList = self:getHeroGroupList()
	local cost, reward = self:getCostAndReward()

	StatController.instance:track(StatEnum.EventName.ExitCachotRoom, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self.enterRoomTime,
		[StatEnum.EventProperties.Difficulty] = rogueInfo.difficulty,
		[StatEnum.EventProperties.Layer] = layer,
		[StatEnum.EventProperties.RoomId] = roomConfig.id,
		[StatEnum.EventProperties.RoomName] = roomConfig.name,
		[StatEnum.EventProperties.InitialHeroGroup] = self.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = self.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = currentHeroNameList,
		[StatEnum.EventProperties.HeroGroupArray] = currentHeroObjList,
		[StatEnum.EventProperties.CollectList] = collectionNameList,
		[StatEnum.EventProperties.CollectArray] = collectionObjList,
		[StatEnum.EventProperties.HeartBeat] = rogueInfo.heart,
		[StatEnum.EventProperties.DungeonGold] = rogueInfo.coin,
		[StatEnum.EventProperties.DungeonTokens] = rogueInfo.currency,
		[StatEnum.EventProperties.CachotCost] = cost,
		[StatEnum.EventProperties.CachotReward] = reward
	})

	self.enterRoomTime = nil

	self:clearStartEventDict()
	self:recycleObj(collectionNameList)
	self:recycleObj(currentHeroNameList)
	self:recycleObjList(collectionObjList)
	self:recycleObjList(currentHeroObjList)
	self:recycleObjList(cost)
	self:recycleObjList(reward)
end

function V1a6_CachotStatController:statUnlockCollection(collectionList)
	if not collectionList then
		return
	end

	local obj = self:getNewObj()

	for _, collectionId in ipairs(collectionList) do
		tabletool.clear(obj)

		local config = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionId)

		obj[StatEnum.EventProperties.CollectionId] = collectionId

		if config then
			obj[StatEnum.EventProperties.CollectionName] = config.name or ""
		end

		StatController.instance:track(StatEnum.EventName.UnlockCachotCollection, obj)
	end

	self:recycleObj(obj)
end

V1a6_CachotStatController.instance = V1a6_CachotStatController.New()

return V1a6_CachotStatController
