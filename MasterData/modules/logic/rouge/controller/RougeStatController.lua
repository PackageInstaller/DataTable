-- chunkname: @modules/logic/rouge/controller/RougeStatController.lua

module("modules.logic.rouge.controller.RougeStatController", package.seeall)

local RougeStatController = class("RougeStatController", BaseController)

function RougeStatController:addConstEvents()
	RougeMapController.instance:registerCallback(RougeMapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeSendMoveRpc, self.beforeMoveEvent, self)
	RougeController.instance:registerCallback(RougeEvent.AdjustBackPack, self.onAdjustBackPack, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeNormalToMiddle, self.trackExitDungeonLayer, self)
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
end

function RougeStatController:clear()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onBeforeSendMoveRpc, self.beforeMoveEvent, self)
	RougeController.instance:unregisterCallback(RougeEvent.AdjustBackPack, self.onAdjustBackPack, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onBeforeNormalToMiddle, self.trackExitDungeonLayer, self)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
end

function RougeStatController:_onPushEndFight()
	local fightRecordMO = FightModel.instance:getRecordMO()
	local result = fightRecordMO and fightRecordMO.fightResult

	if result then
		self._failResult = result
	end
end

function RougeStatController:statStart()
	self.startTime = ServerTime.now()
	self._isStart = true
	self._isReset = false
	self._failResult = nil
end

function RougeStatController:checkIsReset()
	return self._isReset
end

function RougeStatController:setReset()
	self._isReset = true
end

RougeStatController.EndResult = {
	Close = 3,
	Abort = 4,
	Fail = 2,
	Success = 1
}

function RougeStatController:statEnd(endResult)
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()
	local result

	StatController.instance:track(StatEnum.EventName.FinishRouge, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.UseTime] = self:getUseTime(),
		[StatEnum.EventProperties.DungeonResult] = result or self:getRougeResult(endResult),
		[StatEnum.EventProperties.InterrruptReason] = self:getInterruptReason(endResult),
		[StatEnum.EventProperties.CompletedEventNum] = self:getCompletedEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = self:getCompletedEventID(),
		[StatEnum.EventProperties.CompletedEntrustId] = self:getCompletedEntrustId(),
		[StatEnum.EventProperties.CompletedEntrustNum] = self:getCompletedEntrustNum(),
		[StatEnum.EventProperties.CompletedLayers] = self:getCompletedLayers(),
		[StatEnum.EventProperties.DungeonPoints] = self:getRougePoints(),
		[StatEnum.EventProperties.RewardPoints] = self:getRougeRewardPoints(),
		[StatEnum.EventProperties.TalentPoints] = self:getRougeTalentPoints(),
		[StatEnum.EventProperties.TotalDeathNum] = self:getTotalDeathNum(),
		[StatEnum.EventProperties.TotalReviveNum] = self:getTotalReviveNum(),
		[StatEnum.EventProperties.CollectionConflateNum] = self:getCollectionConflateNum(),
		[StatEnum.EventProperties.BadgeName] = self:getBadgeName(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc(),
		[StatEnum.EventProperties.EmblemNum] = self:getAddEmblemCount()
	})
end

function RougeStatController:bakerougeInfoMo()
	self.rougeInfoMo = RougeModel.instance:getRougeInfo()
end

function RougeStatController:getrougeInfoMo()
	return self.rougeInfoMo
end

function RougeStatController:clearrougeInfoMo()
	self.rougeInfoMo = nil
end

function RougeStatController:reInit()
	self:_clearInitHeroGroupList()
end

function RougeStatController:_clearInitHeroGroupList()
	self.initHeroNameList = nil
	self.initHeroObjList = nil
	self.assistList = {}
end

function RougeStatController:_initHeroGroupList()
	self.initHeroNameList = {}
	self.initHeroObjList = {}

	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return
	end

	local teamInfo = rougeInfo.teamInfo
	local initHeroIds = RougeModel.instance:getInitHeroIds()

	for _, heroId in ipairs(initHeroIds) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)
		local assistHeroMo = teamInfo:getAssistHeroMo(heroId)

		if heroMo and not assistHeroMo then
			local heroName, heroObj = self:buildObj(heroMo)

			table.insert(self.initHeroNameList, heroName)
			table.insert(self.initHeroObjList, heroObj)
		end
	end
end

function RougeStatController:selectInitHeroGroup(heroMoList, assistHeroMo)
	self:_clearInitHeroGroupList()

	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	local initHeroIds = {}

	for _, heroMo in ipairs(heroMoList) do
		initHeroIds[#initHeroIds + 1] = heroMo.heroId
	end

	if assistHeroMo then
		initHeroIds[#initHeroIds + 1] = assistHeroMo.heroId
	end

	RougeModel.instance:setTeamInitHeros(initHeroIds)
	self:_initHeroGroupList()

	if assistHeroMo then
		local heroMo = assistHeroMo:getHeroMO()

		if heroMo then
			local _, heroObj = self:buildObj(heroMo)

			table.insert(self.assistList, heroObj)
		end
	end

	StatController.instance:track(StatEnum.EventName.SelectHeroGroup, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList()
	})
end

function RougeStatController:buildObj(heroMo, equipMo)
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	local herolevel = 0
	local herotalent = 0
	local equipLevel, equipRefine, equipName
	local balanceLv = 0
	local balanceRank = 0
	local balanceTalent = 0
	local balanceTalentCubeInfos
	local balanceEquipLv = 0

	if not heroMo:isTrial() and RougeHeroGroupBalanceHelper.getIsBalanceMode() then
		balanceLv, balanceRank, balanceTalent, balanceTalentCubeInfos, balanceEquipLv = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(heroMo.heroId)

		local isBalance = balanceLv and balanceLv > heroMo.level

		herolevel = isBalance and balanceLv or heroMo.level

		local isBalanceTalent = (balanceRank and balanceRank >= CharacterEnum.TalentRank and balanceTalent > 0 or nil) and true and (not ((not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or nil) and false) or balanceTalent > heroMo.talent)

		herotalent = isBalanceTalent and balanceTalent or heroMo.talent

		if equipMo then
			local isBalance = balanceEquipLv and balanceEquipLv > equipMo.level

			equipLevel = isBalance and balanceEquipLv or equipMo.level
			equipRefine = equipMo.refineLv
			equipName = equipMo.config.name
		else
			equipLevel = 0
			equipRefine = 0
			equipName = ""
		end
	end

	local heroCo = HeroConfig.instance:getHeroCO(heroMo.heroId)
	local _, rankLevel = HeroConfig.instance:getShowLevel(herolevel)
	local obj = {}

	obj.hero_name = heroCo.name
	obj.hero_level = herolevel
	obj.hero_rank = rankLevel
	obj.breakthrough = heroMo.exSkillLevel
	obj.talent = herotalent
	obj.EquipName = equipName
	obj.EquipLevel = equipLevel
	obj.equip_refine = equipRefine

	return heroCo.name, obj
end

RougeStatController.EventType = {
	"普通战斗事件",
	"困难战斗事件（精英）",
	"精英战斗事件（层间boss）",
	"BOSS战斗事件（最终boss）",
	"奖励事件",
	"选项事件",
	"商店事件",
	"休憩事件"
}

function RougeStatController:beforeMoveEvent()
	local canArriveNameList = {}
	local canArriveIdList = {}
	local dict = RougeMapModel.instance:getNodeDict()

	for index, nodeInfo in pairs(dict) do
		if nodeInfo.arriveStatus == RougeMapEnum.Arrive.CanArrive then
			table.insert(canArriveIdList, nodeInfo.eventId)

			local eventco = nodeInfo:getEventCo()
			local typename = RougeStatController.EventType[eventco.type]

			if typename then
				table.insert(canArriveNameList, typename)
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.OccurOptionalEvent, {
		[StatEnum.EventProperties.OccurEventType] = canArriveNameList,
		[StatEnum.EventProperties.OccurEventID] = canArriveIdList
	})
end

function RougeStatController:onNodeEventStatusChange(eventId, curStatus)
	if curStatus ~= RougeMapEnum.EventState.Finish then
		return
	end

	self:tryTriggerFinishEvent(eventId)
end

function RougeStatController:tryTriggerFinishEvent(eventId)
	local eventco = RougeMapConfig.instance:getRougeEvent(eventId)
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.EventComplete, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc(),
		[StatEnum.EventProperties.DungeonEventId] = eventId,
		[StatEnum.EventProperties.DungeonEventName] = eventco.name,
		[StatEnum.EventProperties.DungeonEventType] = RougeStatController.EventType[eventco.type]
	})
end

function RougeStatController:statRougeChoiceEvent()
	local eventCo = RougeMapModel.instance:getCurEvent()
	local eventId = eventCo and eventCo.id
	local choiceId = RougeMapModel.instance:getCurChoiceId()
	local choiceCo = choiceId and lua_rouge_choice.configDict[choiceId]
	local choiceDesc = choiceCo and choiceCo.desc
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.RougeConfirmSelectOption, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc(),
		[StatEnum.EventProperties.DungeonEventId] = eventId,
		[StatEnum.EventProperties.DungeonEventName] = eventCo.name,
		[StatEnum.EventProperties.DungeonEventType] = RougeStatController.EventType[eventCo.type],
		[StatEnum.EventProperties.RougeEventChoiceId] = choiceId,
		[StatEnum.EventProperties.RougeEventChoiceName] = choiceDesc
	})
end

function RougeStatController:startAdjustBackPack()
	self.startAdjustTime = ServerTime.now()
	self._isopenbackpack = true
end

function RougeStatController:onAdjustBackPack()
	if not self._isopenbackpack then
		return
	end

	self._adjustbackpack = true
end

function RougeStatController:clearBackpack()
	self._adjustbackpack = false
	self._isopenbackpack = false
end

function RougeStatController:endAdjustBackPack()
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.ExitRougeBackpack, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc(),
		[StatEnum.EventProperties.UseTime] = self:getAdjustBackPackTime(),
		[StatEnum.EventProperties.IsBackPackAdjust] = self:getAdjustBackPack()
	})
	self:clearBackpack()
end

RougeStatController.operateType = {
	Auto = 1,
	Clear = 2
}

function RougeStatController:operateCollection(operateType)
	local type = operateType == RougeStatController.operateType.Auto and "一键填入" or "清空"
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.OperateCollection, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc(),
		[StatEnum.EventProperties.RougeOperationType] = type
	})
end

function RougeStatController:trackExitDungeonLayer()
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.ExitRougeLayer, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc()
	})
end

function RougeStatController:trackUpdateTalent(buildTalentId)
	if not buildTalentId then
		return
	end

	local co = lua_rouge_style_talent.configDict[buildTalentId]
	local desc = co and co.desc
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.UpdateTalent, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.BuildTalentId] = tostring(buildTalentId),
		[StatEnum.EventProperties.BuildTalentDescribe] = desc,
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc()
	})
end

function RougeStatController:trackUseMapSkill(mapSkillId)
	local collectionList, collectionArray, activeEffectList = self:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.UseMapSkill, {
		[StatEnum.EventProperties.Season] = self:getSeason(),
		[StatEnum.EventProperties.Version] = self:getVersion(),
		[StatEnum.EventProperties.MatchId] = self:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = self:getDifficulty(),
		[StatEnum.EventProperties.Layer] = self:getLayer(),
		[StatEnum.EventProperties.Build] = self:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = self:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = self:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = self:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = self:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = self:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = self:getAssistList(),
		[StatEnum.EventProperties.CollectList] = collectionList,
		[StatEnum.EventProperties.CollectArray] = collectionArray,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = activeEffectList,
		[StatEnum.EventProperties.DungeonGold] = self:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = self:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = self:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = self:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = self:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = self:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = self:getAllLimiterDesc(),
		[StatEnum.EventProperties.MapSkill] = tostring(mapSkillId)
	})
end

function RougeStatController:getCurrentHeroGroupList()
	local namelist = {}
	local objlist = {}
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	local teamInfo = rougeInfo.teamInfo
	local heroSingleGroupMoList = teamInfo:getBattleHeroList()
	local equipMoList = teamInfo:getGroupEquips()

	for index, heroMo in ipairs(heroSingleGroupMoList) do
		local equipMo = equipMoList[index]

		if heroMo then
			local heroName, heroObj = self:buildObj(heroMo, equipMo)

			table.insert(namelist, heroName)
			table.insert(objlist, heroObj)
		end
	end

	return namelist, objlist
end

function RougeStatController:getUnlockTalentNameList()
	local namelist = {}
	local season = RougeOutsideModel.instance:season()
	local unlocktalentlist = RougeTalentModel.instance:getUnlockTalent()

	for index, talentid in ipairs(unlocktalentlist) do
		local name = RougeTalentConfig.instance:getBranchConfigByID(season, talentid).name

		table.insert(namelist, name)
	end

	return namelist
end

RougeStatController.Effect2Chinese = {
	"电能",
	"吞噬",
	"升级"
}

function RougeStatController:getCollectionInfo()
	local collectNameList = {}
	local collectObjList = {}
	local activeEffectList = {}
	local slotlist = RougeCollectionModel.instance:getSlotAreaCollection()

	for _, mo in pairs(slotlist) do
		local enchantCfgIds = mo:getAllEnchantCfgId()
		local cfgId = mo:getCollectionCfgId()
		local name = RougeCollectionConfig.instance:getCollectionName(cfgId, enchantCfgIds)
		local RichTextTags = {
			"</color>",
			"<#.->"
		}

		for i, v in ipairs(RichTextTags) do
			name = string.gsub(name, v, "")
		end

		table.insert(collectNameList, name)

		local obj = {}

		obj.collection_name = name
		obj.collection_num = 1

		for index, enchantCfgId in ipairs(enchantCfgIds) do
			if enchantCfgId ~= 0 then
				local coList = RougeCollectionConfig.instance:getCollectionDescsCfg(enchantCfgId)

				for _, co in ipairs(coList) do
					obj["enchant_collection_name" .. index] = co.name
					obj["enchant_collection_num" .. index] = 1

					break
				end
			end
		end

		table.insert(collectObjList, obj)

		for _, effectType in pairs(RougeEnum.EffectActiveType) do
			local isActive = mo:isEffectActive(effectType)

			if isActive then
				local name = RougeStatController.Effect2Chinese[effectType]

				table.insert(activeEffectList, name)
			end
		end
	end

	return collectNameList, collectObjList, activeEffectList
end

function RougeStatController:getSeason()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.season
end

function RougeStatController:getVersion()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return rougeInfo and rougeInfo.version
end

function RougeStatController:getGameNum()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return rougeInfo and rougeInfo.gameNum
end

function RougeStatController:getDifficulty()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.difficulty
end

function RougeStatController:getBuild()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	local season = rougeInfo.season
	local style = rougeInfo.style
	local styleco = lua_rouge_style.configDict[season][style]

	return styleco.desc
end

function RougeStatController:getLayer()
	return RougeMapModel.instance:getLayerId()
end

function RougeStatController:getTeamLevel()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.teamLevel
end

function RougeStatController:getInitHeroNameList()
	if not self.initHeroNameList then
		self:_initHeroGroupList()
	end

	return self.initHeroNameList
end

function RougeStatController:getInitHeroObjList()
	if not self.initHeroObjList then
		self:_initHeroGroupList()
	end

	return self.initHeroObjList
end

function RougeStatController:getHeroGroup()
	local result = {}
	local teamInfo = RougeModel.instance:getTeamInfo()
	local heroList = teamInfo and teamInfo:getAllHeroId()

	if heroList then
		for _, heroId in ipairs(heroList) do
			local assistHeroMo = teamInfo:getAssistHeroMo(heroId)

			if not assistHeroMo then
				local heroConfig = HeroConfig.instance:getHeroCO(heroId)

				if heroConfig then
					result[#result + 1] = heroConfig.name or ""
				end
			end
		end
	end

	return result
end

function RougeStatController:getHeroGroupArray()
	local result = {}
	local teamInfo = RougeModel.instance:getTeamInfo()
	local heroList = teamInfo and teamInfo:getAllHeroId()

	if heroList then
		local supportHeroDict = {}
		local battleHeroMoList = teamInfo:getBattleHeroList()

		for _, battleHeroMo in ipairs(battleHeroMoList) do
			supportHeroDict[battleHeroMo.heroId] = battleHeroMo.supportHeroId
		end

		for _, heroId in ipairs(heroList) do
			local assistHeroMo = teamInfo:getAssistHeroMo(heroId)

			if not assistHeroMo then
				local heroMo = HeroModel.instance:getByHeroId(heroId)

				if heroMo then
					local balanceLv = 0
					local balanceRank = 0
					local balanceTalent = 0
					local isBalanceMode = RougeHeroGroupBalanceHelper.getIsBalanceMode()

					if isBalanceMode then
						balanceLv, balanceRank, balanceTalent = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(heroId)

						if not balanceLv then
							balanceLv = 0
						end

						balanceRank = balanceRank or 0
						balanceTalent = balanceTalent or 0
					end

					local heroData = {}
					local heroConfig = heroMo.config

					heroData.hero_name = heroConfig.name
					heroData.hero_level = balanceLv > heroMo.level and balanceLv or heroMo.level
					heroData.hero_rank = balanceRank > heroMo.rank and balanceRank or heroMo.rank
					heroData.breakthrough = heroMo.exSkillLevel
					heroData.talent = balanceTalent > heroMo.talent and balanceTalent or heroMo.talent

					local heroInfo = teamInfo:getHeroInfo(heroId)

					heroData.rationality_num = heroInfo and heroInfo:getStressValue() or 0

					local equipMo = heroMo:hasDefaultEquip()

					if equipMo then
						heroData.EquipName = equipMo.config.name
						heroData.EquipLevel = equipMo.level
						heroData.equip_refine = equipMo.refineLv
					end

					local hpInfo = teamInfo:getHeroHp(heroId)

					if hpInfo then
						heroData.remaining_HP = hpInfo.life / 10 or 0
					end

					local supportHeroId = supportHeroDict[heroId]

					if supportHeroId and supportHeroId ~= 0 then
						local supportHeroCfg = HeroConfig.instance:getHeroCO(supportHeroId)
						local skillId = teamInfo:getSupportSkill(supportHeroId)
						local skillCo = lua_skill.configDict[skillId]
						local supportIsInitHero = RougeModel.instance:isInitHero(supportHeroId)

						if supportHeroCfg then
							heroData.support_heroname = supportHeroCfg.name or nil
						end

						if skillCo then
							heroData.support_heroskill = skillCo.name or nil
						end

						heroData.support_is_recruit = not supportIsInitHero
					end

					local inTeam = teamInfo:inTeam(heroId)

					if inTeam then
						local isInitHero = RougeModel.instance:isInitHero(heroId)

						heroData.combat_is_recruit = not isInitHero
					end

					result[#result + 1] = heroData
				end
			end
		end
	end

	return result
end

function RougeStatController:getCoin()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.coin
end

function RougeStatController:getMedium()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.power
end

function RougeStatController:getTalentNameList()
	return (self:getUnlockTalentNameList())
end

function RougeStatController:getConsumeTalentPoint()
	return (RougeTalentModel.instance:getHadConsumeTalentPoint())
end

function RougeStatController:getBuildTalentLevel()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	return rougeInfo.teamLevel
end

function RougeStatController:getBuildTalentList()
	local list = {}
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return nil
	end

	local talentList = rougeInfo.talentInfo

	for _, talentmo in ipairs(talentList) do
		if talentmo and talentmo.isActive == 1 then
			local id = talentmo.id
			local co = lua_rouge_style_talent.configDict[id]

			table.insert(list, co.desc)
		end
	end

	return list
end

function RougeStatController:getAssistList()
	local result = {}
	local supportHeroDict = {}
	local teamInfo = RougeModel.instance:getTeamInfo()
	local battleHeroMoList = teamInfo:getBattleHeroList()

	for _, battleHeroMo in ipairs(battleHeroMoList) do
		supportHeroDict[battleHeroMo.heroId] = battleHeroMo.supportHeroId
	end

	local assistHeroMo = teamInfo:getAssistHeroMo()

	if assistHeroMo then
		local assistHeroId = assistHeroMo.heroId
		local heroConfig = assistHeroMo.config
		local assistHeroData = {}
		local balanceLv = 0
		local balanceRank = 0
		local balanceTalent = 0
		local isBalanceMode = RougeHeroGroupBalanceHelper.getIsBalanceMode()

		if isBalanceMode then
			balanceLv, balanceRank, balanceTalent = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(assistHeroId)

			if not balanceLv then
				balanceLv = 0
			end

			balanceRank = balanceRank or 0
			balanceTalent = balanceTalent or 0
		end

		assistHeroData.hero_name = heroConfig.name
		assistHeroData.hero_level = balanceLv > assistHeroMo.level and balanceLv or assistHeroMo.level
		assistHeroData.hero_rank = balanceRank > assistHeroMo.rank and balanceRank or assistHeroMo.rank
		assistHeroData.breakthrough = assistHeroMo.exSkillLevel
		assistHeroData.talent = balanceTalent > assistHeroMo.talent and balanceTalent or assistHeroMo.talent

		local equipMo = assistHeroMo:hasDefaultEquip()

		if equipMo then
			assistHeroData.EquipName = equipMo.config.name
			assistHeroData.EquipLevel = equipMo.level
			assistHeroData.equip_refine = equipMo.refineLv
		end

		local hpInfo = teamInfo:getHeroHp(assistHeroId)

		if hpInfo then
			assistHeroData.remaining_HP = hpInfo.life / 10 or 0
		end

		local heroInfo = teamInfo:getHeroInfo(assistHeroId)

		assistHeroData.rationality_num = heroInfo and heroInfo:getStressValue() or 0

		local targetHero = teamInfo:getAssistTargetHero(assistHeroId)

		if targetHero then
			local targetHeroCfg = HeroConfig.instance:getHeroCO(targetHero.heroId)

			if targetHeroCfg then
				assistHeroData.support_target_name = targetHeroCfg.name or nil
			end

			local skillId = teamInfo:getSupportSkill(assistHeroId)
			local skillCo = lua_skill.configDict[skillId]

			if skillCo then
				assistHeroData.support_heroskill = skillCo.name or nil
			end
		else
			local supportHeroId = supportHeroDict[assistHeroId]

			if supportHeroId and supportHeroId ~= 0 then
				local supportHeroCfg = HeroConfig.instance:getHeroCO(supportHeroId)
				local skillId = teamInfo:getSupportSkill(supportHeroId)
				local skillCo = lua_skill.configDict[skillId]

				if supportHeroCfg then
					assistHeroData.support_heroname = supportHeroCfg.name or nil
				end

				if skillCo then
					assistHeroData.support_heroskill = skillCo.name or nil
				end

				local supportIsInitHero = RougeModel.instance:isInitHero(supportHeroId)

				assistHeroData.support_is_recruit = not supportIsInitHero
			end
		end

		result[#result + 1] = assistHeroData
	end

	return result
end

function RougeStatController:getRougeResult(endResult)
	local result

	if endResult then
		if endResult == RougeStatController.EndResult.Close then
			result = "主动返回退出"
		elseif endResult == RougeStatController.EndResult.Abort then
			result = "重置"
		end
	else
		local endId = RougeModel.instance:getEndId()

		result = endId and endId ~= 0 and "成功" or "失败"
	end

	return result
end

function RougeStatController:getInterruptReason(endResult)
	local result

	if endResult then
		if endResult == RougeStatController.EndResult.Close then
			result = "主动放弃探索"
		end
	else
		local endId = RougeModel.instance:getEndId()

		if not endId or endId == 0 then
			local eventMo = RougeMapModel.instance:getCurEvent()
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
			end
		end
	end

	return result
end

function RougeStatController:getCompletedEventNum()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	if rougeResultInfo.finishEventId and #rougeResultInfo.finishEventId > 0 then
		return #rougeResultInfo.finishEventId
	end
end

function RougeStatController:getCompletedEventID()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	if rougeResultInfo.finishEventId and #rougeResultInfo.finishEventId > 0 then
		return rougeResultInfo.finishEventId
	end
end

function RougeStatController:getCompletedEntrustId()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	if rougeResultInfo.finishEntrustId and #rougeResultInfo.finishEntrustId > 0 then
		return rougeResultInfo.finishEntrustId
	end
end

function RougeStatController:getCompletedEntrustNum()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	if rougeResultInfo.finishEntrustId and #rougeResultInfo.finishEntrustId > 0 then
		return #rougeResultInfo.finishEntrustId
	end
end

function RougeStatController:getCompletedLayers()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	local count, score = rougeResultInfo:getLayerCountAndScore()

	return count
end

function RougeStatController:getRougePoints()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return 0
	end

	return rougeResultInfo.finalScore
end

function RougeStatController:getRougeRewardPoints()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	return rougeResultInfo.addPoint
end

function RougeStatController:getRougeTalentPoints()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return 0
	end

	return rougeResultInfo.addGeniusPoint
end

function RougeStatController:getTotalDeathNum()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return 0
	end

	return rougeResultInfo.deadNum
end

function RougeStatController:getTotalReviveNum()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return 0
	end

	return rougeResultInfo.reviveNum
end

function RougeStatController:getCollectionConflateNum()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return 0
	end

	local count = 0
	local moList = rougeResultInfo:getCompositeCollectionIdAndCount()

	if moList and #moList > 0 then
		for key, mo in ipairs(moList) do
			if mo and mo[2] then
				count = count + mo[2]
			end
		end
	end

	return count
end

function RougeStatController:getBadgeName()
	local result = {}
	local season = self:getSeason()
	local rougeResultInfo = RougeModel.instance:getRougeResult()

	if not rougeResultInfo then
		return
	end

	if rougeResultInfo.badge2Score then
		for id, value in pairs(rougeResultInfo.badge2Score) do
			local co = RougeConfig.instance:getRougeBadgeCO(season, value[1])

			if co and co.name then
				table.insert(result, co.name)
			end
		end
	end

	return result
end

function RougeStatController:getUseTime()
	local time = 0

	if self:checkIsReset() or not self.startTime then
		return time
	end

	if self.startTime then
		time = ServerTime.now() - self.startTime
	end

	return time
end

function RougeStatController:getAdjustBackPackTime()
	if not self.startAdjustTime then
		return 0
	else
		return ServerTime.now() - self.startAdjustTime
	end
end

function RougeStatController:getAdjustBackPack()
	return not not self._adjustbackpack
end

function RougeStatController:getAllLimiterDesc()
	local descList = {}
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local gameLimiterMo = rougeInfo and rougeInfo:getGameLimiterMo()
	local limiterIds = gameLimiterMo and gameLimiterMo:getLimiterIds()

	for _, limiterId in ipairs(limiterIds or {}) do
		local limiterCo = RougeDLCConfig101.instance:getLimiterCo(limiterId)

		table.insert(descList, limiterCo and limiterCo.desc)
	end

	local limiterBuffIds = gameLimiterMo and gameLimiterMo:getLimiterBuffIds()

	for _, buffId in ipairs(limiterBuffIds or {}) do
		local limiterBuffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

		table.insert(descList, limiterBuffCo and limiterBuffCo.desc)
	end

	return descList
end

function RougeStatController:getAddEmblemCount()
	local rougeResultInfo = RougeModel.instance:getRougeResult()
	local limiterResultMo = rougeResultInfo and rougeResultInfo:getLimiterResultMo()

	return limiterResultMo and limiterResultMo:getLimiterAddEmblem() or 0
end

RougeStatController.instance = RougeStatController.New()

return RougeStatController
