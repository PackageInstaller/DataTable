-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroGroupModel.lua

module("modules.logic.seasonver.act166.model.Season166HeroGroupModel", package.seeall)

local Season166HeroGroupModel = class("Season166HeroGroupModel", BaseModel)

function Season166HeroGroupModel:onInit()
	self.heroGroupType = ModuleEnum.HeroGroupType.Default
	self._curGroupId = 1
	self._lastHeroGroupSnapshotList = {}
	self._lastHeroGroupList = {}
	self._herogroupItemPos = {}
	self._commonGroups = {}
	self._groupTypeSelect = {}
	self._groupTypeCustom = {}
end

function Season166HeroGroupModel:reInit()
	self.heroGroupType = ModuleEnum.HeroGroupType.Default
	self._curGroupId = 1
	self._lastHeroGroupSnapshotList = {}
	self._lastHeroGroupList = {}
	self._herogroupItemPos = {}
	self._commonGroups = {}
	self._groupTypeSelect = {}
	self._groupTypeCustom = {}
	self.battleId = nil
	self.episodeId = nil
	self.adventure = nil
	self.battleConfig = nil
	self.heroGroupTypeCo = nil
	self.episodeType = nil
	self.weekwalk = nil
	self.curGroupSelectIndex = 1
end

function Season166HeroGroupModel:onGetHeroGroupList(groupInfoList)
	local moList = {}
	local heroGroupMO

	for i = 1, #groupInfoList do
		heroGroupMO = Season166HeroGroupMO.New()

		heroGroupMO:init(groupInfoList[i])
		table.insert(moList, heroGroupMO)
	end

	self:setList(moList)
end

function Season166HeroGroupModel:onGetCommonGroupList(heroGroupCommonList)
	for _, heroGroup in ipairs(heroGroupCommonList.heroGroupCommons) do
		self._commonGroups[heroGroup.groupId] = Season166HeroGroupMO.New()

		self._commonGroups[heroGroup.groupId]:init(heroGroup)
	end

	for i = 1, self:getMaxHeroCountInGroup() do
		if not self._commonGroups[i] then
			self._commonGroups[i] = Season166HeroGroupMO.New()

			self._commonGroups[i]:init(Season166HeroGroupMO.New())
		end
	end

	for _, groupType in ipairs(heroGroupCommonList.heroGourpTypes) do
		self._groupTypeSelect[groupType.id] = groupType.currentSelect

		if groupType.id ~= ModuleEnum.HeroGroupServerType.Main and groupType:HasField("groupInfo") then
			self._groupTypeCustom[groupType.id] = Season166HeroGroupMO.New()

			self._groupTypeCustom[groupType.id]:init(groupType.groupInfo)
		end
	end
end

function Season166HeroGroupModel:getCustomHeroGroupMo(groupType, noCreate)
	if not self._groupTypeCustom[groupType] then
		if noCreate then
			return self:getMainGroupMo()
		end

		local heroGroupMO = Season166HeroGroupMO.New()

		heroGroupMO:init(self:getMainGroupMo())

		self._groupTypeCustom[groupType] = heroGroupMO
	end

	return self._groupTypeCustom[groupType]
end

function Season166HeroGroupModel:onModifyHeroGroup(groupInfo)
	local heroGroupMO = {}

	heroGroupMO = self:getById(groupInfo.groupId)

	if heroGroupMO then
		heroGroupMO:init(groupInfo)
	else
		heroGroupMO = Season166HeroGroupMO.New()

		heroGroupMO:init(groupInfo)
		self:addAtLast(heroGroupMO)
	end

	self:_updateScroll()
end

function Season166HeroGroupModel:_updateScroll()
	self:onModelUpdate()
	self:_setSingleGroup()
end

function Season166HeroGroupModel:isAdventureOrWeekWalk()
	return self.adventure or self.weekwalk
end

function Season166HeroGroupModel:setParam(battleId, episodeId, adventure, isReConnect)
	local paramTab = {
		battleId = battleId,
		episodeId = episodeId,
		adventure = adventure,
		isReConnect = isReConnect
	}

	self.battleId = battleId
	self.episodeId = episodeId
	self.adventure = adventure
	self.actId = Season166Model.instance:getCurSeasonId()

	local battleCO = battleId and lua_battle.configDict[battleId]
	local episodeCO = episodeId and lua_episode.configDict[episodeId]
	local chapterCO = episodeCO and lua_chapter.configDict[episodeCO.chapterId]

	self.episodeConfig = episodeCO
	self.battleConfig = battleCO
	self.heroGroupTypeCo = episodeCO and HeroConfig.instance:getHeroGroupTypeCo(episodeCO.chapterId)

	if episodeCO then
		self.episodeType = episodeCO.type or 0
	end

	local amountLimit = self:getAmountLimit(battleCO)

	self.weekwalk = chapterCO and chapterCO.type == DungeonEnum.ChapterType.WeekWalk

	local isSaveGroup = false
	local isMainChapter = chapterCO and (chapterCO.type == DungeonEnum.ChapterType.Normal or chapterCO.type == DungeonEnum.ChapterType.Hard or chapterCO.type == DungeonEnum.ChapterType.Simple)

	if isMainChapter then
		self.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if self.heroGroupTypeCo then
		self.curGroupSelectIndex = self._groupTypeSelect[(self.episodeType > 100 or nil) and self.episodeType]
		self.curGroupSelectIndex = self.curGroupSelectIndex or self.heroGroupTypeCo.saveGroup == 1 and 0 or 1
	else
		self.curGroupSelectIndex = 1
	end

	local configAids = {}

	if battleCO and not string.nilorempty(battleCO.aid) then
		configAids = string.splitToNumber(battleCO.aid, "#")
	end

	if battleCO and (battleCO.trialLimit > 0 or not string.nilorempty(battleCO.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() then
		local isSeasonChapter = Activity104Model.instance:isSeasonChapter()
		local str = isSeasonChapter and PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "") or PlayerPrefsHelper.getString(self.actId .. "#" .. PlayerPrefsKey.Season166HeroGroupTrial .. "#" .. tostring(PlayerModel.instance:getMyUserId()) .. "#" .. battleCO.id, "")

		self.heroGroupType = ModuleEnum.HeroGroupType.Season166Base
		self._curGroupId = 1

		local tempGroupMO

		if battleCO.trialLimit > 0 and battleCO.onlyTrial == 1 then
			tempGroupMO = self:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(str) then
			tempGroupMO = self.curGroupSelectIndex > 0 and self:generateTempGroup(self._commonGroups[self.curGroupSelectIndex], amountLimit, battleCO and battleCO.useTemp == 2) or self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id, true) or self:generateTempGroup(nil, amountLimit, battleCO and battleCO.useTemp == 2)
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
	elseif chapterCO and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(self.episodeType) then
		self._heroGroupList = {}

		local func = SeasonHeroGroupHandler.buildSeasonHandleFunc[self.episodeType]

		if func then
			self.heroGroupType = func(paramTab)
		end
	elseif chapterCO and battleCO and battleCO.useTemp ~= 0 or amountLimit or #configAids > 0 or battleCO and ToughBattleModel.instance:getEpisodeId() then
		self.heroGroupType = ModuleEnum.HeroGroupType.Temp
		self._heroGroupList = {}

		local savedHeroGroupMO
		local tempGroupMO = self:generateTempGroup((chapterCO and chapterCO.saveHeroGroup and (not battleCO or battleCO.useTemp ~= 2) or nil) and (self.curGroupSelectIndex > 0 and self:generateTempGroup(self._commonGroups[self.curGroupSelectIndex], amountLimit, battleCO and battleCO.useTemp == 2) or self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id, true) or self:generateTempGroup(nil, amountLimit, battleCO and battleCO.useTemp == 2)), amountLimit, battleCO and battleCO.useTemp == 2)

		table.insert(self._heroGroupList, tempGroupMO)

		self._curGroupId = 1
	elseif not isMainChapter and chapterCO then
		self.heroGroupType = ModuleEnum.HeroGroupType.Resources
		self._heroGroupList = {}
		self._curGroupId = 1

		if not self._groupTypeCustom[self.heroGroupTypeCo.id] then
			isSaveGroup = true
		end

		local resourcesGroupMO = self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id) or self._commonGroups[1]
		local groupName = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
			chapterCO.name
		})

		resourcesGroupMO:setTempName(groupName)
		table.insert(self._heroGroupList, resourcesGroupMO)
	elseif isMainChapter then
		self.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		self._heroGroupList = {}
		self._curGroupId = 1

		local groupMO = self:getCurGroupMO()

		if groupMO and groupMO.aidDict then
			groupMO.aidDict = nil
		end
	else
		self.heroGroupType = ModuleEnum.HeroGroupType.Default
		self._heroGroupList = {}
		self._curGroupId = 1
	end

	self:fixHeroGroupList()

	if isSaveGroup then
		self:saveCurGroupData()
	end
end

function Season166HeroGroupModel:getAmountLimit(battleCO)
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

function Season166HeroGroupModel:_getAmountLimit(ruleStr)
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

function Season166HeroGroupModel:getBattleRoleNum()
	local battleId = self.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local amountLimit = self:getAmountLimit(battleCO)

	return amountLimit or battleCO and battleCO.roleNum
end

function Season166HeroGroupModel:generateTempGroup(heroGroupMO, roleNum, initFromEmpty)
	local tempgroupMO = Season166HeroGroupMO.New()

	if not heroGroupMO and not initFromEmpty then
		heroGroupMO = self:getById(self._curGroupId)
	end

	if heroGroupMO then
		tempgroupMO:setSeasonCardLimit(heroGroupMO:getSeasonCardLimit())
	end

	if self.battleId then
		local battleCO = lua_battle.configDict[self.battleId]

		if battleCO then
			local configTrial = {}

			if not string.nilorempty(battleCO.trialHeros) then
				configTrial = GameUtil.splitString2(battleCO.trialHeros, true)
			end

			roleNum = roleNum or battleCO.roleNum

			local playerMax = battleCO.playerMax

			tempgroupMO:initWithBattle(heroGroupMO or Season166HeroGroupMO.New(), (not string.nilorempty(battleCO.aid) or nil) and string.splitToNumber(battleCO.aid, "#"), roleNum, playerMax, nil, configTrial)

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

function Season166HeroGroupModel:setCurGroupId(groupId)
	self._curGroupId = groupId

	self:_setSingleGroup()
end

function Season166HeroGroupModel:_setSingleGroup()
	local groupMO = self:getCurGroupMO()

	if not groupMO then
		groupMO = Season166HeroGroupMO.New()

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
		self:addAtLast(groupMO)
	end

	groupMO:clearAidHero()
	Season166HeroSingleGroupModel.instance:setSingleGroup(groupMO, true)
end

function Season166HeroGroupModel:getCommonGroupName(index)
	index = index or self.curGroupSelectIndex

	local name = self._commonGroups[index].name

	if string.nilorempty(name) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(index))
	else
		return name
	end
end

function Season166HeroGroupModel:setCommonGroupName(index, name)
	index = index or self.curGroupSelectIndex

	local nowName = self:getCommonGroupName(index)

	if name == nowName then
		return
	end

	self._commonGroups[index].name = name

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function Season166HeroGroupModel:getCurGroupMO()
	if SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(self.heroGroupType) then
		local func = SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[self.heroGroupType]

		if func then
			return func()
		end
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if self.curGroupSelectIndex == 0 then
			return self._heroGroupList[1]
		else
			return self._commonGroups[self.curGroupSelectIndex]
		end
	elseif self.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		if self.curGroupSelectIndex == 0 then
			return self:getMainGroupMo()
		else
			return self._commonGroups[self.curGroupSelectIndex]
		end
	else
		return self:getById(self._curGroupId)
	end
end

function Season166HeroGroupModel:setHeroGroupSelectIndex(index)
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

	if self.episodeType > 100 then
		id = self.episodeType
	end

	self._groupTypeSelect[id] = index

	self:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(id, index)

	return true
end

function Season166HeroGroupModel:getGroupTypeName()
	if not self.heroGroupTypeCo or self.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return self.heroGroupTypeCo.name
end

function Season166HeroGroupModel:getMainGroupMo()
	return self:getById(1)
end

function Season166HeroGroupModel:saveCurGroupData(callback, callbackObj, heroGroupMO)
	local episodeConfig = lua_episode.configDict[self.episodeId]

	if not episodeConfig then
		return
	end

	heroGroupMO = heroGroupMO or self:getCurGroupMO()

	if not heroGroupMO then
		return
	end

	heroGroupMO:checkAndPutOffEquip()

	if self.heroGroupType == ModuleEnum.HeroGroupType.Season166Base then
		heroGroupMO:saveData()

		if callback then
			callback(callbackObj)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, self.heroGroupType, 1)

		if heroGroupMO.isHaveTrial then
			return
		end
	end

	if self.heroGroupType == ModuleEnum.HeroGroupType.Temp or self.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if callback then
			callback(callbackObj)
		end

		return
	end

	SeasonHeroGroupHandler.setHeroGroupSnapshot(heroGroupMO, self.heroGroupType, self.episodeId, callback, callbackObj)
end

function Season166HeroGroupModel:setHeroGroupSnapshot(heroGroupType, episodeId, upload, extendData, callback, callbackObj)
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

	if SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(heroGroupType) then
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

		FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), seasonEquips or heroGroupMO:getAllHeroActivity104Equips())
		Season166HeroGroupUtils.buildFightGroupAssistHero(heroGroupType, req.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(heroGroupSnapshotType, snapshotSubId, req, callback, callbackObj)
	elseif callback then
		callback(callbackObj)
	end
end

function Season166HeroGroupModel:replaceSingleGroup()
	local tempGroupMO = self:getCurGroupMO()

	if tempGroupMO then
		local heroList = Season166HeroSingleGroupModel.instance:getList()

		tempGroupMO:replaceHeroList(heroList)
	end
end

function Season166HeroGroupModel:replaceSingleGroupEquips()
	local tempGroupMO = self:getCurGroupMO()
	local heroList = Season166HeroSingleGroupModel.instance:getList()
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

function Season166HeroGroupModel:replaceCloth(clothId)
	local tempGroupMO = self:getCurGroupMO()

	if tempGroupMO then
		tempGroupMO:replaceClothId(clothId)
	end
end

function Season166HeroGroupModel:replaceEquips(equips, groupMO)
	local tempGroupMO = groupMO or self:getCurGroupMO()

	if tempGroupMO then
		tempGroupMO:updatePosEquips(equips)
	end
end

function Season166HeroGroupModel:getCurGroupId()
	return self._curGroupId
end

function Season166HeroGroupModel:isPositionOpen(posId)
	return posId <= self:getMaxHeroCountInGroup()
end

function Season166HeroGroupModel:positionOpenCount()
	return self:getMaxHeroCountInGroup()
end

function Season166HeroGroupModel:getHighestLevel()
	local moList = Season166HeroSingleGroupModel.instance:getList()

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

function Season166HeroGroupModel:setHeroGroupItemPos(HeroGroupList)
	self._herogroupItemPos = HeroGroupList
end

function Season166HeroGroupModel:getHeroGroupItemPos()
	return self._herogroupItemPos
end

Season166HeroGroupModel.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function Season166HeroGroupModel:initRestrictHeroData(battleConfig)
	self.restrictHeroIdList = nil
	self.restrictCareerList = nil
	self.restrictRareList = nil

	local restrictRoles = battleConfig and battleConfig.restrictRoles

	if string.nilorempty(restrictRoles) then
		return
	end

	local typeStr = string.split(restrictRoles, "|")
	local restrictList, type

	for i = 1, #typeStr do
		restrictList = string.splitToNumber(typeStr[i], "#")
		restrictList, type = GameUtil.tabletool_fastRemoveValueByPos(restrictList, 1)

		if type == Season166HeroGroupModel.RestrictType.HeroId then
			self.restrictHeroIdList = restrictList
		elseif type == Season166HeroGroupModel.RestrictType.Career then
			self.restrictCareerList = restrictList
		elseif type == Season166HeroGroupModel.RestrictType.Rare then
			self.restrictRareList = restrictList
		else
			logError("un support restrict type : " .. tostring(type))
		end
	end
end

function Season166HeroGroupModel:isRestrict(heroUid)
	if heroUid then
		::label_35_0::

		local heroMo = HeroModel.instance:getById(heroUid)

		if not heroMo then
			return false
		end

		local var_35_0

		if self.restrictHeroIdList then
			var_35_0 = tabletool.indexOf(self.restrictHeroIdList, heroMo.heroId)

			if not var_35_0 then
				if self.restrictCareerList then
					var_35_0 = tabletool.indexOf(self.restrictCareerList, heroMo.config.career) or self.restrictRareList and tabletool.indexOf(self.restrictRareList, heroMo.config.rare)
				end
			end
		end

		return var_35_0
	end
end

function Season166HeroGroupModel:getCurrentBattleConfig()
	return self.battleConfig
end

function Season166HeroGroupModel:buildAidHeroGroup()
	local battleContext = Season166Model.instance:getBattleContext()

	if battleContext then
		local actId = battleContext.actId
		local seasonMO = Season166Model.instance:getActInfo(actId)

		if not seasonMO then
			return
		end

		if not self.battleConfig or string.nilorempty(self.battleConfig.aid) then
			return
		end

		local configAids = string.splitToNumber(self.battleConfig.aid, "#")

		if #configAids > 0 or self.battleConfig.trialLimit > 0 then
			self.aidHeroGroupMO = Season166HeroGroupModel.instance:generateTempGroup(nil, nil, true)

			self.aidHeroGroupMO:setTemp(false)
		end
	end
end

function Season166HeroGroupModel:getCurrentHeroGroup()
	local context = Season166Model.instance:getBattleContext()

	if not context then
		return
	end

	local seasonMO = Season166Model.instance:getActInfo(context.actId)

	if not seasonMO then
		return
	end

	if self.battleConfig and not string.nilorempty(self.battleConfig.aid) then
		return self.aidHeroGroupMO
	end

	if self:isSeason166BaseSpotEpisode(context.episodeId) then
		local baseId = context.baseId

		return seasonMO.spotHeroGroupSnapshot[baseId]
	elseif self:isSeason166TrainEpisode(context.episodeId) then
		return seasonMO.trainHeroGroupSnapshot[1]
	else
		logError("关卡类型异常或教学关卡trial或trialLimit试用角色为空，请检查关卡id： " .. context.episodeId)

		return seasonMO.trainHeroGroupSnapshot[1]
	end
end

function Season166HeroGroupModel:isSeason166BaseSpotEpisode(episodeId)
	return self:getEpisodeType(episodeId) == DungeonEnum.EpisodeType.Season166Base
end

function Season166HeroGroupModel:isSeason166TrainEpisode(episodeId)
	return self:getEpisodeType(episodeId) == DungeonEnum.EpisodeType.Season166Train
end

function Season166HeroGroupModel:isSeason166TeachEpisode(episodeId)
	return self:getEpisodeType(episodeId) == DungeonEnum.EpisodeType.Season166Teach
end

function Season166HeroGroupModel:getEpisodeType(episodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId or self.episodeId)

	return episodeCO and episodeCO.type
end

function Season166HeroGroupModel:isSeason166Episode(episodeId)
	return self:isSeason166BaseSpotEpisode(episodeId) or self:isSeason166TrainEpisode(episodeId) or self:isSeason166TeachEpisode(episodeId)
end

function Season166HeroGroupModel:getMaxHeroCountInGroup()
	local battleContext = Season166Model.instance:getBattleContext(true)

	if not battleContext then
		return ModuleEnum.MaxHeroCountInGroup
	end

	if self.episodeId then
		local episodeCO = lua_episode.configDict[self.episodeId]

		if not episodeCO then
			logError("episodeId or config in lua_episode is null")

			return ModuleEnum.MaxHeroCountInGroup
		end

		local getSeasonMaxHeroCountFuncMap = {
			[DungeonEnum.ChapterType.Season166Base] = Season166Controller.getMaxHeroGroupCount,
			[DungeonEnum.ChapterType.Season166Train] = Season166Controller.getMaxHeroGroupCount,
			[DungeonEnum.ChapterType.Season166Teach] = Season166Controller.getMaxHeroGroupCount
		}
		local getSeasonMaxHeroCountFunc = getSeasonMaxHeroCountFuncMap[DungeonEnum.ChapterType.Season166Base]

		if getSeasonMaxHeroCountFunc then
			return getSeasonMaxHeroCountFunc()
		else
			return ModuleEnum.MaxHeroCountInGroup
		end
	end
end

function Season166HeroGroupModel:getEpisodeConfigId(episodeId)
	local battleContext = Season166Model.instance:getBattleContext(true)

	if not battleContext then
		return 0
	end

	if self:isSeason166BaseSpotEpisode(episodeId) then
		return battleContext.baseId
	elseif self:isSeason166TrainEpisode(episodeId) then
		return battleContext.trainId
	elseif self:isSeason166TeachEpisode(episodeId) then
		return battleContext.teachId
	end

	return 0
end

function Season166HeroGroupModel:getTrailHeroGroupList()
	return self._heroGroupList[self._curGroupId]
end

function Season166HeroGroupModel:isHaveTrialCo()
	return self.battleConfig and self.battleConfig.trialLimit > 0
end

function Season166HeroGroupModel:fixHeroGroupList()
	local maxHeroCount = self:getMaxHeroCountInGroup()
	local curHeroGroup = self:getCurGroupMO()

	if not curHeroGroup.heroList then
		return
	end

	for i = 1, maxHeroCount do
		curHeroGroup.heroList[i] = curHeroGroup.heroList[i] or "0"
	end
end

function Season166HeroGroupModel:cleanAssistData()
	local curHeroGroup = self:getCurGroupMO()

	if curHeroGroup then
		for index, heroUid in ipairs(curHeroGroup.heroList) do
			if tonumber(heroUid) > 0 and not self:checkAndGetSelfHero(heroUid) then
				curHeroGroup.heroList[index] = "0"
			end
		end
	end

	Season166HeroSingleGroupModel.instance.assistMO = nil

	Season166Controller.instance:dispatchEvent(Season166Event.CleanAssistData)
end

function Season166HeroGroupModel:checkAndGetSelfHero(heroUid)
	return HeroModel.instance:getById(heroUid)
end

function Season166HeroGroupModel:setCurGroupMaxPlayerCount(playerMaxCount)
	local curHeroGroup = self:getCurGroupMO()

	curHeroGroup:setMaxHeroCount(playerMaxCount)
end

Season166HeroGroupModel.instance = Season166HeroGroupModel.New()

return Season166HeroGroupModel
