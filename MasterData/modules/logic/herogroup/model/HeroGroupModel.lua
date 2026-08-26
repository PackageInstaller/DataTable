-- chunkname: @modules/logic/herogroup/model/HeroGroupModel.lua

module("modules.logic.herogroup.model.HeroGroupModel", package.seeall)

local HeroGroupModel = class("HeroGroupModel", ListScrollModel)

function HeroGroupModel:onInit()
	self.heroGroupType = ModuleEnum.HeroGroupType.Default
	self._curGroupId = 1
	self._lastHeroGroupSnapshotList = {}
	self._lastHeroGroupList = {}
	self._herogroupItemPos = {}
	self._commonGroups = {}
	self._groupTypeSelect = {}
	self._groupTypeCustom = {}
	self._groupSortList = {}

	self:clearAllAssist()
end

function HeroGroupModel:reInit()
	self.heroGroupType = ModuleEnum.HeroGroupType.Default
	self._curGroupId = 1
	self._lastHeroGroupSnapshotList = {}
	self._lastHeroGroupList = {}
	self._herogroupItemPos = {}
	self._commonGroups = {}
	self._groupTypeSelect = {}
	self._groupTypeCustom = {}
	self._groupSortList = {}
	self._replayParam = nil
	self.battleId = nil
	self.episodeId = nil
	self.adventure = nil
	self.battleConfig = nil
	self.heroGroupTypeCo = nil
	self._episodeType = nil
	self.weekwalk = nil
	self.curGroupSelectIndex = 1
	self.tempRecommendUseParam = nil
	self.isAfterUpdateRecommend = nil

	self:clearAllAssist()
end

function HeroGroupModel:onGetHeroGroupList(groupInfoList)
	local moList = {}
	local heroGroupMO

	for i = 1, #groupInfoList do
		heroGroupMO = HeroGroupMO.New()

		heroGroupMO:init(groupInfoList[i])
		table.insert(moList, heroGroupMO)
	end

	self:setList(moList)
end

function HeroGroupModel:getCommonGroupList(id)
	return self._commonGroups[id]
end

function HeroGroupModel:removeCommonGroupList(id)
	self._commonGroups[id] = nil
end

function HeroGroupModel:addCommonGroupList(id, heroGroupMo)
	if self._commonGroups[id] then
		return
	end

	self._commonGroups[id] = heroGroupMo
end

function HeroGroupModel:onGetCommonGroupList(heroGroupCommonList)
	for _, heroGroup in ipairs(heroGroupCommonList.heroGroupCommons) do
		self._commonGroups[heroGroup.groupId] = HeroGroupMO.New()

		self._commonGroups[heroGroup.groupId]:init(heroGroup)
	end

	for _, groupType in ipairs(heroGroupCommonList.heroGourpTypes) do
		self._groupTypeSelect[groupType.id] = groupType.currentSelect

		if groupType.id ~= ModuleEnum.HeroGroupServerType.Main and groupType:HasField("groupInfo") then
			self._groupTypeCustom[groupType.id] = HeroGroupMO.New()

			self._groupTypeCustom[groupType.id]:init(groupType.groupInfo)
		end
	end
end

function HeroGroupModel:clearCustomHeroGroup(id)
	self._groupTypeCustom[id] = nil
end

function HeroGroupModel:updateCustomHeroGroup(id, value)
	local heroGroupMO = HeroGroupMO.New()

	heroGroupMO:init(value)

	self._groupTypeCustom[id] = heroGroupMO
end

function HeroGroupModel:getCustomHeroGroupMo(groupType, noCreate)
	if not self._groupTypeCustom[groupType] then
		if noCreate then
			return self:getMainGroupMo()
		end

		local heroGroupMO = HeroGroupMO.New()

		heroGroupMO:init(self:getMainGroupMo())

		self._groupTypeCustom[groupType] = heroGroupMO
	end

	return self._groupTypeCustom[groupType]
end

function HeroGroupModel:onModifyHeroGroup(groupInfo)
	local heroGroupMO = {}

	heroGroupMO = self:getById(groupInfo.groupId)

	if heroGroupMO then
		heroGroupMO:init(groupInfo)
	else
		heroGroupMO = HeroGroupMO.New()

		heroGroupMO:init(groupInfo)
		self:addAtLast(heroGroupMO)
	end

	self:_updateScroll()
end

function HeroGroupModel:_updateScroll()
	self:onModelUpdate()
	self:_setSingleGroup()
end

function HeroGroupModel:isAdventureOrWeekWalk()
	return self.adventure or self.weekwalk
end

function HeroGroupModel:setParam(battleId, episodeId, adventure, isReConnect, episodeType)
	local paramTab = {
		battleId = battleId,
		episodeId = episodeId,
		adventure = adventure,
		isReConnect = isReConnect
	}

	self.battleId = battleId
	self.episodeId = episodeId
	self.adventure = adventure

	local battleCO = battleId and lua_battle.configDict[battleId]
	local episodeCO = episodeId and lua_episode.configDict[episodeId]
	local chapterCO = episodeCO and lua_chapter.configDict[episodeCO.chapterId]

	self.battleConfig = battleCO
	self.heroGroupTypeCo = episodeCO and HeroConfig.instance:getHeroGroupTypeCo(episodeCO.chapterId)

	if episodeCO then
		self._episodeType = episodeCO.type or 0
	end

	if episodeType then
		self._episodeType = episodeType
	end

	local amountLimit = self:getAmountLimit(battleCO)

	self.weekwalk = chapterCO and chapterCO.type == DungeonEnum.ChapterType.WeekWalk

	local isSaveGroup = false
	local isMainChapter = chapterCO and (chapterCO.type == DungeonEnum.ChapterType.Normal or chapterCO.type == DungeonEnum.ChapterType.Hard or chapterCO.type == DungeonEnum.ChapterType.Simple)

	if isMainChapter then
		self.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	self._isBossStory = chapterCO and chapterCO.id == DungeonEnum.ChapterId.BossStory

	if self._isBossStory then
		local heroGroupId = VersionActivity2_8BossConfig.instance:getHeroGroupId(episodeId)
		local heroGroupConfig = heroGroupId and lua_hero_group_type.configDict[heroGroupId]

		if heroGroupConfig then
			self.heroGroupTypeCo = heroGroupConfig
		else
			logError(string.format("BossStory episodeId:%s heroGroupId:%s error", episodeId, heroGroupId))
		end
	end

	if self.heroGroupTypeCo then
		self.curGroupSelectIndex = self._groupTypeSelect[(self._episodeType > 100 or nil) and self._episodeType]
		self.curGroupSelectIndex = self.curGroupSelectIndex or self.heroGroupTypeCo.saveGroup == 1 and 0 or 1
	else
		self.curGroupSelectIndex = 1
	end

	local configAids = {}

	if battleCO and not string.nilorempty(battleCO.aid) then
		configAids = string.splitToNumber(battleCO.aid, "#")
	end

	local isTowerEpisode = HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(self.episodeId) or HeroGroupHandler.checkIsTowerComposeEpisodeByEpisodeId(self.episodeId)

	if SeasonHeroGroupHandler.checkIsSeasonEpisodeType(self._episodeType) then
		local func = SeasonHeroGroupHandler.buildSeasonHandleFunc[self._episodeType]

		if func then
			self.heroGroupType = func(paramTab)
		end
	elseif battleCO and (battleCO.trialLimit > 0 or not string.nilorempty(battleCO.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() or isTowerEpisode then
		local isSeasonChapter = Activity104Model.instance:isSeasonChapter()
		local str = isSeasonChapter and PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "") or SodacheUtil.isSodacheEpisode() and GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SodacheTrialHeroGroupKey, "") or PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. battleCO.id, "")

		self.heroGroupType = ModuleEnum.HeroGroupType.Trial
		self._curGroupId = 1

		local tempGroupMO

		if battleCO.trialLimit > 0 and battleCO.onlyTrial == 1 then
			tempGroupMO = self:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(str) or self._isBossStory then
			if self.curGroupSelectIndex > 0 then
				tempGroupMO = self:generateTempGroup(self:_getCommonBySelectIndex(), amountLimit, battleCO and battleCO.useTemp == 2)
			else
				tempGroupMO = self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id, true)
				tempGroupMO = self:generateTempGroup(tempGroupMO, amountLimit, battleCO and battleCO.useTemp == 2)
			end
		else
			local saveData = cjson.decode(str)

			GameUtil.removeJsonNull(saveData)

			tempGroupMO = self:generateTempGroup(nil, nil, true)

			tempGroupMO:initByLocalData(saveData)
		end

		tempGroupMO:setTrials(isReConnect)

		self._heroGroupList = {
			tempGroupMO
		}

		if isTowerEpisode or self._episodeType == DungeonEnum.EpisodeType.Rouge2 or self._episodeType == DungeonEnum.EpisodeType.AtomicDungeon then
			self.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(self.episodeId)
		elseif self._episodeType == DungeonEnum.EpisodeType.Rouge2Boss then
			self.heroGroupType = ModuleEnum.HeroGroupType.Temp
			self._heroGroupList = {}

			local tempGroupMo = Rouge2_BossBattleController.instance:generateTempHeroGroup(self.battleId, self.episodeId)

			table.insert(self._heroGroupList, tempGroupMo)

			self._curGroupId = 1
		end
	elseif self._episodeType == DungeonEnum.EpisodeType.Odyssey then
		self.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif V2a9BossRushModel.instance:isV2a9BossRushSecondStageSpecialLayer(self._episodeType, self.episodeId) then
		self.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif HeroGroupHandler.checkIsEpisodeType(self._episodeType) then
		self.heroGroupType = ModuleEnum.HeroGroupType.General

		HeroGroupSnapshotModel.instance:setParam(self.episodeId)
	elseif self._episodeType == DungeonEnum.EpisodeType.Abyss then
		self.heroGroupType = ModuleEnum.HeroGroupType.General

		HeroGroupSnapshotModel.instance:setParam(self.episodeId)

		local curStage = AbyssModel.instance:getCurStageMo()

		self._curGroupId = curStage.heroGroupSubId or 1
	elseif self._episodeType == DungeonEnum.EpisodeType.BossRushActMode then
		self.heroGroupType = ModuleEnum.HeroGroupType.BossRushActMode

		local stage = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(self.episodeId)

		self._curGroupId = stage or 1
	elseif chapterCO and battleCO and battleCO.useTemp ~= 0 or amountLimit or #configAids > 0 or battleCO and ToughBattleModel.instance:getEpisodeId() then
		self.heroGroupType = ModuleEnum.HeroGroupType.Temp
		self._heroGroupList = {}

		local savedHeroGroupMO

		if chapterCO and chapterCO.saveHeroGroup and (not battleCO or battleCO.useTemp ~= 2) then
			savedHeroGroupMO = self.curGroupSelectIndex > 0 and self:generateTempGroup(self:_getCommonBySelectIndex(), amountLimit, battleCO and battleCO.useTemp == 2) or self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id, true) or self:generateTempGroup(nil, amountLimit, battleCO and battleCO.useTemp == 2)
		end

		if self._isBossStory then
			self:_clearAids(savedHeroGroupMO)
		end

		local tempGroupMO = self:generateTempGroup(savedHeroGroupMO, amountLimit, battleCO and battleCO.useTemp == 2)

		table.insert(self._heroGroupList, tempGroupMO)

		self._curGroupId = 1
	elseif not isMainChapter and chapterCO then
		self.heroGroupType = ModuleEnum.HeroGroupType.Resources
		self._heroGroupList = {}
		self._curGroupId = 1

		self:_checkCommonSelectIndex()

		if self._isBossStory then
			local resourcesGroupMO = self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id) or self._commonGroups[self.curGroupSelectIndex]
			local groupName = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
				chapterCO.name
			})

			resourcesGroupMO:setTempName(groupName)
			table.insert(self._heroGroupList, resourcesGroupMO)
		end
	elseif isMainChapter then
		self.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		self._heroGroupList = {}
		self._curGroupId = 1

		if DungeonController.checkEpisodeFiveHero(self.episodeId) then
			self.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(self.episodeId)
		else
			self:_checkCommonSelectIndex()
		end

		local groupMO = self:getCurGroupMO()

		if groupMO and groupMO.aidDict then
			groupMO.aidDict = nil
		end
	else
		self.heroGroupType = ModuleEnum.HeroGroupType.Default
		self._heroGroupList = {}
		self._curGroupId = 1
	end

	self:_convertToPreset()
	self:_setSingleGroup()
	self:initRestrictHeroData(battleCO)

	if isSaveGroup then
		self:saveCurGroupData()
	end
end

function HeroGroupModel:_convertToPreset()
	self._presetHeroGroupType = nil

	if self.heroGroupType == ModuleEnum.HeroGroupType.NormalFb or self.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if self._isBossStory then
			return
		end

		self._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.Common

		return
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.General then
		local episdoeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)

		if episdoeConfig then
			if episdoeConfig.type == DungeonEnum.EpisodeType.TowerPermanent or episdoeConfig.type == DungeonEnum.EpisodeType.TowerLimited or episdoeConfig.type == DungeonEnum.EpisodeType.TowerDeep then
				if HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] then
					self._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit
				end

				return
			elseif episdoeConfig.type == DungeonEnum.EpisodeType.Abyss then
				self._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.Abyss
			elseif episdoeConfig.type == DungeonEnum.EpisodeType.AtomicDungeon then
				self._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.AtomicDungeon
			end
		end
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.BossRushActMode then
		self._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.Common
	end
end

function HeroGroupModel:_getCommonBySelectIndex()
	self:_checkCommonSelectIndex()

	return self._commonGroups[self.curGroupSelectIndex]
end

function HeroGroupModel:_checkCommonSelectIndex()
	self.curGroupSelectIndex = HeroGroupPresetHeroGroupSelectIndexController.instance:getCommonSelectedIndex(self.curGroupSelectIndex)
end

function HeroGroupModel:getPresetHeroGroupType()
	return self._presetHeroGroupType
end

function HeroGroupModel:_clearAids(heroGroupMO)
	if not heroGroupMO or not heroGroupMO.heroList then
		return
	end

	for k, v in pairs(heroGroupMO.heroList) do
		if v == "-1" then
			heroGroupMO.heroList[k] = "0"
		end
	end
end

function HeroGroupModel:setReplayParam(heroGroupMO)
	self._replayParam = heroGroupMO

	if heroGroupMO then
		if heroGroupMO.replay_hero_data then
			for uid, data in pairs(heroGroupMO.replay_hero_data) do
				local heroMo = HeroModel.instance:getById(uid)

				if heroMo and heroMo.skin > 0 then
					data.skin = heroMo.skin
				end
			end
		end

		self.heroGroupType = ModuleEnum.HeroGroupType.Temp
		self._heroGroupList = {}
		self._heroGroupList[heroGroupMO.id] = heroGroupMO
		self._curGroupId = heroGroupMO.id

		self:_setSingleGroup()
	end
end

function HeroGroupModel:getReplayParam()
	return self._replayParam
end

function HeroGroupModel:getAmountLimit(battleCO)
	if not battleCO then
		return
	end

	local limit = self:_getAmountLimit(battleCO.additionRule)

	if limit then
		return limit
	end

	limit = self:_getAmountLimit(battleCO.hiddenRule)

	return limit
end

function HeroGroupModel:_getAmountLimit(ruleStr)
	if LuaUtil.isEmptyStr(ruleStr) == false then
		local ruleList = GameUtil.splitString2(ruleStr, true, "|", "#")

		for i, v in ipairs(ruleList) do
			local targetId = v[1]

			if targetId == FightEnum.EntitySide.MySide then
				local ruleId = v[2]
				local ruleCo = lua_rule.configDict[ruleId]

				if ruleCo and ruleCo.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(ruleCo.effect)
				end
			end
		end
	end
end

function HeroGroupModel:getBattleRoleNum()
	if self.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyEnum.MaxHeroGroupCount
	end

	local roleNum = HeroGroupHandler.getHeroRoleOpenNum(self.episodeId)

	if roleNum then
		return roleNum
	end

	local battleId = self.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local amountLimit = self:getAmountLimit(battleCO)

	return amountLimit or battleCO and battleCO.roleNum
end

function HeroGroupModel:generateTempGroup(heroGroupMO, roleNum, initFromEmpty)
	local tempgroupMO = HeroGroupMO.New()

	if not heroGroupMO and not initFromEmpty then
		heroGroupMO = self:getMainGroupMo()
	end

	if heroGroupMO then
		tempgroupMO:setSeasonCardLimit(heroGroupMO:getSeasonCardLimit())
	end

	if self.battleId then
		local battleCO = lua_battle.configDict[self.battleId]

		if battleCO then
			local configTrial = {}
			local curBattleTrialHeros = HeroGroupHandler.getTrialHeros(self.episodeId)

			if not string.nilorempty(curBattleTrialHeros) then
				configTrial = GameUtil.splitString2(curBattleTrialHeros, true)
			end

			roleNum = roleNum or battleCO.roleNum

			local playerMax = battleCO.playerMax

			tempgroupMO:initWithBattle(heroGroupMO or HeroGroupMO.New(), (not string.nilorempty(battleCO.aid) or nil) and string.splitToNumber(battleCO.aid, "#"), roleNum, playerMax, nil, configTrial)

			if self.adventure then
				if self.episodeId then
					local episodeConfig = lua_episode.configDict[self.episodeId]

					if episodeConfig then
						local groupName = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
							episodeConfig.name
						})

						tempgroupMO:setTempName(groupName)
					end
				end
			end
		else
			logError("临时编队没有战斗配置，永远不该发生")
			tempgroupMO:init(heroGroupMO)
		end

		tempgroupMO:setTemp(true)

		return tempgroupMO
	end
end

function HeroGroupModel:setCurGroupId(groupId)
	self._curGroupId = groupId

	self:_setSingleGroup()
end

function HeroGroupModel:_setSingleGroup()
	local groupMO = self:getCurGroupMO()

	if not groupMO then
		groupMO = HeroGroupMO.New()

		local curGroupId = self._curGroupId

		if self.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			curGroupId = curGroupId - 1
		end

		local groupName = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
			luaLang("hero_group"),
			curGroupId
		})

		groupMO:init({
			groupId = curGroupId,
			name = groupName
		})

		local mo = self:getById(groupMO.id)

		if not mo then
			self:addAtLast(groupMO)
		end
	end

	groupMO:clearAidHero()
	HeroGroupHandler.hanldeHeroListData(self.episodeId)
	HeroSingleGroupModel.instance:setSingleGroup(groupMO, true)
end

function HeroGroupModel:getCommonGroupName(index, id)
	id = id or self:getHeroGroupSnapshotType()
	index = index or self:getHeroGroupSelectIndex()

	if self.heroGroupType == ModuleEnum.HeroGroupType.General then
		local name = HeroGroupSnapshotModel.instance:getGroupName(id)

		if string.nilorempty(name) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(index))
		else
			return name
		end
	end

	local heroGroupMo = self._commonGroups[index]
	local name = heroGroupMo and heroGroupMo.name

	if string.nilorempty(name) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(index))
	else
		return name
	end
end

function HeroGroupModel:setCommonGroupName(index, name, id)
	id = id or self:getHeroGroupSnapshotType()
	index = index or self:getHeroGroupSelectIndex()

	local nowName = self:getCommonGroupName(index, id)

	if name == nowName then
		return
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.General then
		HeroGroupSnapshotModel.instance:setGroupName(id, index, name)
	else
		self._commonGroups[index].name = name
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function HeroGroupModel:getCurGroupMO()
	if self.heroGroupType == ModuleEnum.HeroGroupType.Temp or self.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		return self._heroGroupList[self._curGroupId]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(self.heroGroupType) then
		local func = SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[self.heroGroupType]

		if func then
			return func()
		end
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if self._isBossStory then
			return self._heroGroupList[1]
		end

		return self:_getCommonBySelectIndex()
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		return self:_getCommonBySelectIndex()
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurGroup()
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:getCurHeroGroup()
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.BossRushActMode then
		-- block empty
	else
		return self:getById(self._curGroupId)
	end
end

function HeroGroupModel:getHeroGroupSelectIndex()
	if self.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getSelectIndex()
	end

	return self.curGroupSelectIndex
end

function HeroGroupModel:getHeroGroupSnapshotType()
	if self.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurSnapshotId()
	end

	return ModuleEnum.HeroGroupSnapshotType.Common
end

function HeroGroupModel:setHeroGroupSelectIndex(index)
	if self.heroGroupType == ModuleEnum.HeroGroupType.General then
		local result = HeroGroupSnapshotModel.instance:setSelectIndex(nil, index)

		if result then
			self:_setSingleGroup()
		end

		return result
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		self:_setSingleGroup()

		return
	end

	if not self.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if index == 0 and self.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if self.curGroupSelectIndex == index then
		return
	end

	self.curGroupSelectIndex = index

	local id = self.heroGroupTypeCo.id

	if self._episodeType > 100 then
		id = self._episodeType
	end

	self._groupTypeSelect[id] = index

	self:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(id, index)

	return true
end

function HeroGroupModel:getGroupTypeName()
	if not self.heroGroupTypeCo or self.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return self.heroGroupTypeCo.name
end

function HeroGroupModel:getMainGroupMo()
	for i = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
		local mo = self:getCommonGroupList(i)

		if mo then
			return mo
		end
	end
end

function HeroGroupModel:saveCurGroupData(callback, callbackObj, heroGroupMO)
	local episodeConfig = lua_episode.configDict[self.episodeId]

	if not episodeConfig then
		if self.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(heroGroupMO, nil, callback, callbackObj)
		end

		return
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.Cachot then
		return
	end

	heroGroupMO = heroGroupMO or self:getCurGroupMO()

	if not heroGroupMO then
		return
	end

	heroGroupMO:checkAndPutOffEquip()

	if self.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		heroGroupMO:saveData()

		if callback then
			callback(callbackObj)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, self.heroGroupType, 1)

		return
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.Temp or self.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if callback then
			callback(callbackObj)
		end

		return
	end

	if SeasonHeroGroupHandler.NeedGetHeroCardSeason[self.heroGroupType] then
		SeasonHeroGroupHandler.setHeroGroupSnapshot(heroGroupMO, self.heroGroupType, self.episodeId, callback, callbackObj)

		return
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.Act183 then
		Act183HeroGroupController.instance:saveGroupData(heroGroupMO, self.heroGroupType, self.episodeId, callback, callbackObj)

		return
	end

	if DungeonController.checkEpisodeFiveHero(self.episodeId) then
		DungeonController.saveFiveHeroGroupData(heroGroupMO, self.heroGroupType, self.episodeId, callback, callbackObj)

		return
	end

	if episodeConfig.type == DungeonEnum.EpisodeType.Abyss then
		AbyssController.instance:saveSnapShot(heroGroupMO, nil, callback, callbackObj)

		return
	end

	local lastSelectGroupIndex = self.curGroupSelectIndex

	if lastSelectGroupIndex == 0 then
		logError("HeroGroupModel:saveCurGroupData: lastSelectGroupIndex 异常,值不能为0")
	else
		local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		if HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(self.episodeId) or self._episodeType == DungeonEnum.EpisodeType.Rouge2 or self._episodeType == DungeonEnum.EpisodeType.AtomicDungeon then
			FightParam.initTowerFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())
		elseif HeroGroupHandler.checkIsTowerComposeEpisodeByEpisodeId(self.episodeId) then
			local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
			local planeClothId = recordFightParam and TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(recordFightParam.themeId, recordFightParam.plane, TowerComposeEnum.TeamBuffType.Cloth) or heroGroupMO.clothId

			FightParam.initTowerFightGroup(req.fightGroup, planeClothId, heroGroupMO.heroList, heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId(), nil, heroGroupMO:getSaveParams())
		else
			FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())
		end

		if self.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(heroGroupMO, nil, callback, callbackObj)

			return
		end

		local snapshotId = ModuleEnum.HeroGroupSnapshotType.Common
		local snapshotSubId = lastSelectGroupIndex

		if self.heroGroupType == ModuleEnum.HeroGroupType.General then
			snapshotId = HeroGroupSnapshotModel.instance:getCurSnapshotId()

			local isSurvivalDebug = snapshotId == ModuleEnum.HeroGroupSnapshotType.Survival

			snapshotSubId = HeroGroupSnapshotModel.instance:getCurGroupId(nil, isSurvivalDebug)
		end

		if snapshotId and snapshotSubId then
			if episodeConfig.type == DungeonEnum.EpisodeType.Survival then
				local teamInfo = SurvivalMapModel.instance:getSceneMo().teamInfo

				if teamInfo and teamInfo.assistMO then
					for i, uid in ipairs(req.fightGroup.heroList) do
						if teamInfo.assistMO.heroUid == uid then
							req.fightGroup.assistHeroUid = teamInfo.assistMO.heroUid
							req.fightGroup.assistUserId = teamInfo.assistMO.userId
						end
					end
				end
			end

			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
			HeroGroupPresetController.instance:initCopyHeroGroupList()
		else
			logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", snapshotId, snapshotSubId))
		end
	end
end

function HeroGroupModel:setHeroGroupSnapshot(heroGroupType, episodeId, upload, extendData, callback, callbackObj)
	local paramTab = {
		heroGroupType = heroGroupType,
		episodeId = episodeId,
		upload = upload,
		extendData = extendData
	}
	local episodeConfig = episodeId and lua_episode.configDict[episodeId]

	if not episodeConfig then
		return
	end

	local heroGroupSnapshotType = 0
	local snapshotSubId = 0
	local heroGroupMO, seasonEquips

	if heroGroupType == ModuleEnum.HeroGroupType.Resources then
		heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Resources
		snapshotSubId = episodeConfig.chapterId
		heroGroupMO = self._heroGroupList[1]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(heroGroupType) then
		local func = SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[heroGroupType]

		if func then
			heroGroupSnapshotType, snapshotSubId, heroGroupMO, seasonEquips = func(paramTab)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(heroGroupType))

		return
	end

	if heroGroupMO and upload then
		local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local fightGroup = FightDef_pb.FightGroup()

		FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), seasonEquips or heroGroupMO:getAllHeroActivity104Equips())
		Season123HeroGroupUtils.processFightGroupAssistHero(heroGroupType, req.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(heroGroupSnapshotType, snapshotSubId, req, callback, callbackObj)
	elseif callback then
		callback(callbackObj)
	end
end

function HeroGroupModel:replaceSingleGroup()
	local tempGroupMO = self:getCurGroupMO()

	if tempGroupMO then
		local heroList = HeroSingleGroupModel.instance:getList()

		tempGroupMO:replaceHeroList(heroList)
	end
end

function HeroGroupModel:replaceSingleGroupEquips()
	local tempGroupMO = self:getCurGroupMO()
	local heroList = HeroSingleGroupModel.instance:getList()
	local heroMo, info

	for index, heroSingleGroupMO in ipairs(heroList) do
		heroMo = HeroModel.instance:getById(heroSingleGroupMO.heroUid)

		if heroMo and heroMo:hasDefaultEquip() then
			tempGroupMO:updatePosEquips({
				index = index - 1,
				equipUid = {
					heroMo.defaultEquipUid
				}
			})
		end
	end
end

function HeroGroupModel:replaceCloth(clothId)
	local tempGroupMO = self:getCurGroupMO()

	if tempGroupMO then
		tempGroupMO:replaceClothId(clothId)
	end
end

function HeroGroupModel:replaceEquips(equips, groupMO)
	local tempGroupMO = groupMO or self:getCurGroupMO()

	if tempGroupMO then
		tempGroupMO:updatePosEquips(equips)
	end
end

function HeroGroupModel:getCurGroupId()
	return self._curGroupId
end

function HeroGroupModel:isPositionOpen(posId)
	local openNum = HeroGroupHandler.getHeroRoleOpenNum(self.episodeId)

	if openNum then
		return posId > 0 and posId <= openNum
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:isPositionOpen(posId)
	end

	local openGroupCO = lua_open_group.configDict[posId]

	if not openGroupCO then
		if posId == ModuleEnum.FiveHeroEnum.MaxHeroNum and DungeonController.checkEpisodeFiveHero(self.episodeId) then
			return true
		end

		return false
	end

	if self.episodeId then
		local episodeCO = lua_episode.configDict[self.episodeId]
		local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]
		local aidCount = battleCO and #FightStrUtil.instance:getSplitToNumberCache(battleCO.aid, "#") or 0

		if episodeCO and episodeCO.type == DungeonEnum.EpisodeType.Sp and posId <= aidCount then
			return true
		end

		if openGroupCO.need_level > 0 then
			local playerInfo = PlayerModel.instance:getPlayinfo()

			if playerInfo.level < openGroupCO.need_level then
				return false
			end
		end

		if openGroupCO.need_episode > 0 then
			local episodeMO = DungeonModel.instance:getEpisodeInfo(openGroupCO.need_episode)

			if not episodeMO or episodeMO.star <= 0 then
				return false
			end

			local afterStory = lua_episode.configDict[openGroupCO.need_episode].afterStory

			if afterStory and afterStory > 0 and not StoryModel.instance:isStoryFinished(afterStory) then
				return false
			end
		end

		if openGroupCO.need_enter_episode > 0 or openGroupCO.need_finish_guide > 0 then
			if openGroupCO.need_enter_episode > 0 then
				local episodeMO = DungeonModel.instance:getEpisodeInfo(openGroupCO.need_enter_episode)
				local episodeFinish = episodeMO and episodeMO.star > 0

				if episodeFinish or self.episodeId == openGroupCO.need_enter_episode then
					return true
				end
			end

			if openGroupCO.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(openGroupCO.need_finish_guide) then
				return true
			end

			return false
		end

		return true
	end
end

function HeroGroupModel:positionOpenCount()
	local count = 0

	for i = 1, 4 do
		if self:isPositionOpen(i) then
			count = count + 1
		end
	end

	return count
end

function HeroGroupModel:getPositionLockDesc(posId)
	local openGroupCO = lua_open_group.configDict[posId]
	local needEpisodeId = openGroupCO and openGroupCO.need_episode

	if not needEpisodeId or needEpisodeId == 0 then
		return nil
	end

	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(needEpisodeId)
	local lockDesc = openGroupCO.lock_desc

	return lockDesc, episodeDisplay
end

function HeroGroupModel:getHighestLevel()
	local moList = HeroSingleGroupModel.instance:getList()

	if not moList then
		return 0
	end

	local maxLevel = 0

	for i, mo in ipairs(moList) do
		if mo.aid and mo.aid ~= -1 then
			local monsterConfig = lua_monster.configDict[tonumber(mo.aid)]

			if monsterConfig and maxLevel < monsterConfig.level then
				maxLevel = monsterConfig.level
			end
		elseif mo.heroUid then
			local heroMO = HeroModel.instance:getById(mo.heroUid)

			if heroMO and maxLevel < heroMO.level then
				maxLevel = heroMO.level
			end
		end
	end

	return maxLevel
end

function HeroGroupModel:setHeroGroupItemPos(HeroGroupList)
	self._herogroupItemPos = HeroGroupList
end

function HeroGroupModel:getHeroGroupItemPos()
	return self._herogroupItemPos
end

HeroGroupModel.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2,
	CanHeroId = 4
}

function HeroGroupModel:initRestrictHeroData(battleConfig)
	self.restrictHeroIdList = nil
	self.restrictCareerList = nil
	self.restrictRareList = nil
	self.restrictCanHeroIdList = nil

	local restrictRoles = battleConfig and battleConfig.restrictRoles

	if string.nilorempty(restrictRoles) then
		return
	end

	local typeStr = string.split(restrictRoles, "|")
	local restrictList, type

	for i = 1, #typeStr do
		restrictList = string.splitToNumber(typeStr[i], "#")
		restrictList, type = GameUtil.tabletool_fastRemoveValueByPos(restrictList, 1)

		if type == HeroGroupModel.RestrictType.HeroId then
			self.restrictHeroIdList = restrictList
		elseif type == HeroGroupModel.RestrictType.Career then
			self.restrictCareerList = restrictList
		elseif type == HeroGroupModel.RestrictType.Rare then
			self.restrictRareList = restrictList
		elseif type == HeroGroupModel.RestrictType.CanHeroId then
			self.restrictCanHeroIdList = restrictList
		else
			logError("un support restrict type : " .. tostring(type))
		end
	end
end

function HeroGroupModel:isRestrict(heroUid)
	if heroUid then
		::label_50_0::

		local heroMo = HeroModel.instance:getById(heroUid)

		if not heroMo then
			return false
		end

		if self.restrictCanHeroIdList and not tabletool.indexOf(self.restrictCanHeroIdList, heroMo.heroId) then
			return true
		end

		local var_50_0

		if self.restrictHeroIdList then
			var_50_0 = tabletool.indexOf(self.restrictHeroIdList, heroMo.heroId)

			if not var_50_0 then
				if self.restrictCareerList then
					var_50_0 = tabletool.indexOf(self.restrictCareerList, heroMo.config.career) or self.restrictRareList and tabletool.indexOf(self.restrictRareList, heroMo.config.rare)
				end
			end
		end

		return var_50_0
	end
end

function HeroGroupModel:getCurrentBattleConfig()
	return self.battleConfig
end

function HeroGroupModel:setHeroGroupType(type)
	self._heroGroupType = type
end

function HeroGroupModel:getHeroGroupType()
	return self._heroGroupType
end

function HeroGroupModel:setBattleAndEpisodeId(battleId, episodeId)
	self.battleId = battleId
	self.episodeId = episodeId
end

function HeroGroupModel:setAfterUpdateRecommendState(value)
	self.isAfterUpdateRecommend = value
end

function HeroGroupModel:getAfterUpdateRecommendState()
	return self.isAfterUpdateRecommend
end

function HeroGroupModel:setTempBattleRecommendParam(param)
	self.tempRecommendUseParam = param
end

function HeroGroupModel:getTempBattleRecommendParam()
	return self.tempRecommendUseParam
end

function HeroGroupModel:setAssistMo(mo, i)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episdoeType = episodeConfig.type

	if episdoeType == DungeonEnum.EpisodeType.V3_2ZongMao then
		V3a2_BossRushModel.instance:setAssistMo(mo, i)
	end
end

function HeroGroupModel:getAssistMo()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episdoeType = episodeConfig.type
	local chapterCo = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local episdoeActId = chapterCo.actId

	if episdoeType == DungeonEnum.EpisodeType.V3_2ZongMao then
		local assistMO = V3a2_BossRushModel.instance:getAssistMo()

		return true, assistMO, episdoeType, episdoeActId
	end
end

function HeroGroupModel:setEditorAssistMo(mo)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episdoeType = episodeConfig.type

	if episdoeType == DungeonEnum.EpisodeType.V3_2ZongMao then
		V3a2_BossRushModel.instance:setEditorAssistMo(mo)
	end
end

function HeroGroupModel:getEditorAssistMo()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episdoeType = episodeConfig.type

	if episdoeType == DungeonEnum.EpisodeType.V3_2ZongMao then
		return (V3a2_BossRushModel.instance:getEditorAssistMo())
	end
end

function HeroGroupModel:clearCurAssist(isClearEditor)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episdoeType = episodeConfig.type

	if episdoeType == DungeonEnum.EpisodeType.V3_2ZongMao then
		V3a2_BossRushModel.instance:clearAssist(isClearEditor)
	end
end

function HeroGroupModel:clearAllAssist()
	V3a2_BossRushModel.instance:clearAllAssist()
end

HeroGroupModel.instance = HeroGroupModel.New()

return HeroGroupModel
