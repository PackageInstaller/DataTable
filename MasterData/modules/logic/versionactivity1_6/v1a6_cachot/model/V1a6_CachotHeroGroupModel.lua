-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotHeroGroupModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupModel", package.seeall)

local V1a6_CachotHeroGroupModel = class("V1a6_CachotHeroGroupModel", ListScrollModel)

function V1a6_CachotHeroGroupModel:onInit()
	self.heroGroupType = ModuleEnum.HeroGroupType.Default
	self._curGroupId = 1
	self._lastHeroGroupSnapshotList = {}
	self._lastHeroGroupList = {}
	self._herogroupItemPos = {}
	self._commonGroups = {}
	self._groupTypeSelect = {}
	self._groupTypeCustom = {}
end

function V1a6_CachotHeroGroupModel:reInit()
	self.heroGroupType = ModuleEnum.HeroGroupType.Default
	self._curGroupId = 1
	self._lastHeroGroupSnapshotList = {}
	self._lastHeroGroupList = {}
	self._herogroupItemPos = {}
	self._commonGroups = {}
	self._groupTypeSelect = {}
	self._groupTypeCustom = {}
end

function V1a6_CachotHeroGroupModel:onGetHeroGroupList(groupInfoList)
	self.curGroupSelectIndex = nil

	local moList = {}
	local heroGroupMO

	for i = 1, #groupInfoList do
		heroGroupMO = HeroGroupMO.New()

		heroGroupMO:init(groupInfoList[i])
		table.insert(moList, heroGroupMO)
	end

	self:setList(moList)
end

function V1a6_CachotHeroGroupModel:onGetCommonGroupList(heroGroupCommonList)
	for _, heroGroup in ipairs(heroGroupCommonList.heroGroupCommons) do
		self._commonGroups[heroGroup.groupId] = HeroGroupMO.New()

		self._commonGroups[heroGroup.groupId]:init(heroGroup)
	end

	for i = 1, 4 do
		if not self._commonGroups[i] then
			self._commonGroups[i] = HeroGroupMO.New()

			self._commonGroups[i]:init(HeroGroupMO.New())
		end
	end

	for _, groupType in ipairs(heroGroupCommonList.heroGourpTypes) do
		self._groupTypeSelect[groupType.id] = groupType.currentSelect

		if groupType.id ~= ModuleEnum.HeroGroupServerType.Main and groupType:HasField("groupInfo") then
			self._groupTypeCustom[groupType.id] = HeroGroupMO.New()

			self._groupTypeCustom[groupType.id]:init(groupType.groupInfo)
		end
	end
end

function V1a6_CachotHeroGroupModel:getCustomHeroGroupMo(groupType, noCreate)
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

function V1a6_CachotHeroGroupModel:onModifyHeroGroup(groupInfo)
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

function V1a6_CachotHeroGroupModel:_updateScroll()
	self:onModelUpdate()
	self:_setSingleGroup()
end

function V1a6_CachotHeroGroupModel:isAdventureOrWeekWalk()
	return self.adventure or self.weekwalk
end

function V1a6_CachotHeroGroupModel:setParam(battleId, episodeId, adventure, isReConnect)
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

	local amountLimit = self:getAmountLimit(battleCO)

	self.weekwalk = chapterCO and chapterCO.type == DungeonEnum.ChapterType.WeekWalk

	local isSaveGroup = false
	local isMainChapter = chapterCO and (chapterCO.type == DungeonEnum.ChapterType.Normal or chapterCO.type == DungeonEnum.ChapterType.Hard)

	if isMainChapter then
		self.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if self.heroGroupTypeCo then
		self.curGroupSelectIndex = self._groupTypeSelect[(self._episodeType > 100 or nil) and self._episodeType]
		self.curGroupSelectIndex = self.curGroupSelectIndex or self.heroGroupTypeCo.saveGroup == 1 and 0 or 1
	else
		self.curGroupSelectIndex = 1
	end

	self.curGroupSelectIndex = V1a6_CachotModel.instance:getTeamInfo().groupIdx

	local configAids = {}

	if battleCO and not string.nilorempty(battleCO.aid) then
		configAids = string.splitToNumber(battleCO.aid, "#")
	end

	if battleCO and (battleCO.trialLimit > 0 or not string.nilorempty(battleCO.trialEquips)) then
		local isSeasonChapter = Activity104Model.instance:isSeasonChapter()
		local str = isSeasonChapter and PlayerPrefsHelper.getString(PlayerPrefsKey.SeasonHeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()), "") or PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. battleCO.id, "")

		self.heroGroupType = ModuleEnum.HeroGroupType.Trial
		self._curGroupId = 1

		local tempGroupMO

		if string.nilorempty(str) then
			tempGroupMO = self.curGroupSelectIndex > 0 and self:generateTempGroup(self._commonGroups[self.curGroupSelectIndex], amountLimit, battleCO and battleCO.useTemp == 2) or self.heroGroupTypeCo and self:getCustomHeroGroupMo(self.heroGroupTypeCo.id, true) or self:generateTempGroup(nil, amountLimit, battleCO and battleCO.useTemp == 2)
		else
			local saveData = cjson.decode(str)

			tempGroupMO = HeroGroupMO.New()

			tempGroupMO:initByLocalData(saveData)
		end

		tempGroupMO:setTrials(isReConnect)

		self._heroGroupList = {
			tempGroupMO
		}
	elseif chapterCO and Activity104Model.instance:isSeasonChapter() then
		self.heroGroupType = ModuleEnum.HeroGroupType.Season

		Activity104Model.instance:buildHeroGroup(isReConnect)
	elseif chapterCO and battleCO and battleCO.useTemp ~= 0 or amountLimit or #configAids > 0 then
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

	self:_setSingleGroup()
	self:initRestrictHeroData(battleCO)

	if isSaveGroup then
		self:saveCurGroupData()
	end
end

function V1a6_CachotHeroGroupModel:updateGroupIndex()
	self.curGroupSelectIndex = V1a6_CachotModel.instance:getTeamInfo().groupIdx
end

function V1a6_CachotHeroGroupModel:setReplayParam(heroGroupMO)
	self._replayParam = heroGroupMO

	if heroGroupMO then
		self.heroGroupType = ModuleEnum.HeroGroupType.Temp
		self._heroGroupList = {}
		self._heroGroupList[heroGroupMO.id] = heroGroupMO
		self._curGroupId = heroGroupMO.id

		self:_setSingleGroup()
	end
end

function V1a6_CachotHeroGroupModel:getReplayParam()
	return self._replayParam
end

function V1a6_CachotHeroGroupModel:getAmountLimit(battleCO)
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

function V1a6_CachotHeroGroupModel:_getAmountLimit(ruleStr)
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

function V1a6_CachotHeroGroupModel:getBattleRoleNum()
	local battleId = self.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local amountLimit = self:getAmountLimit(battleCO)

	return amountLimit or battleCO and battleCO.roleNum
end

function V1a6_CachotHeroGroupModel:generateTempGroup(heroGroupMO, roleNum, initFromEmpty)
	local tempgroupMO = HeroGroupMO.New()

	if not heroGroupMO and not initFromEmpty then
		heroGroupMO = self:getById(self._curGroupId)
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

			tempgroupMO:initWithBattle(heroGroupMO or HeroGroupMO.New(), (not string.nilorempty(battleCO.aid) or nil) and string.splitToNumber(battleCO.aid, "#"), roleNum, playerMax, nil, configTrial)

			if self.adventure then
				if self.episodeId then
					if self.episodeId then
						-- block empty
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

function V1a6_CachotHeroGroupModel:setCurGroupId(groupId)
	self._curGroupId = groupId

	self:_setSingleGroup()
end

function V1a6_CachotHeroGroupModel:_setSingleGroup()
	local groupMO = self:getCurGroupMO()

	if not groupMO then
		groupMO = HeroGroupMO.New()

		local curGroupId = self._curGroupId

		if self.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			curGroupId = curGroupId - 1
		end

		groupMO:init({
			groupId = curGroupId
		})
		self:addAtLast(groupMO)
	end

	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(groupMO)

	local list = V1a6_CachotHeroSingleGroupModel.instance:getList()

	for i = 1, #list do
		list[i]:setAid(groupMO.aidDict and groupMO.aidDict[i])

		if groupMO.trialDict and groupMO.trialDict[i] then
			list[i]:setTrial(unpack(groupMO.trialDict[i]))
		else
			list[i]:setTrial()
		end
	end
end

function V1a6_CachotHeroGroupModel:getCommonGroupName(index)
	index = index or self.curGroupSelectIndex

	return formatLuaLang("cachot_team_name", GameUtil.getNum2Chinese(index))
end

function V1a6_CachotHeroGroupModel:setCommonGroupName(index, name)
	index = index or self.curGroupSelectIndex

	local nowName = self:getCommonGroupName(index)

	if name == nowName then
		return
	end

	self._commonGroups[index].name = name

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function V1a6_CachotHeroGroupModel:getCurGroupMO()
	if self.curGroupSelectIndex then
		return self:getById(self.curGroupSelectIndex)
	end

	return self:getById(self._curGroupId)
end

function V1a6_CachotHeroGroupModel:setHeroGroupSelectIndex(index)
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
	self._groupTypeSelect[(self._episodeType > 100 or nil) and self._episodeType] = index

	self:_setSingleGroup()
	RogueRpc.instance:sendRogueGroupIdxChangeRequest(V1a6_CachotEnum.ActivityId, index)

	return true
end

function V1a6_CachotHeroGroupModel:getGroupTypeName()
	if not self.heroGroupTypeCo or self.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return self.heroGroupTypeCo.name
end

function V1a6_CachotHeroGroupModel:getMainGroupMo()
	return self:getById(1)
end

function V1a6_CachotHeroGroupModel:cachotSaveCurGroup(callback, callbackObj)
	local allHeros = {}
	local allEquips = {}
	local index = self.curGroupSelectIndex
	local group = self:_getGroup(index, "", allHeros, allEquips, 1, V1a6_CachotEnum.HeroCountInGroup)

	RogueRpc.instance:sendRogueGroupChangeRequest(V1a6_CachotEnum.ActivityId, index, group, callback, callbackObj)
end

function V1a6_CachotHeroGroupModel:_getGroup(id, groupName, allHeros, allEquips, startIndex, endIndex)
	local group = {}

	group.id = id
	group.groupName = groupName

	local curGroupMO = self:getCurGroupMO()
	local heroList = {}
	local equips = {}

	for i = startIndex, endIndex do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i)
		local equipMo = curGroupMO:getPosEquips(i - 1)
		local equipId = tonumber(equipMo.equipUid[1])

		if equipId and equipId > 0 then
			table.insert(allEquips, equipId)
		end

		local heroMO = HeroModel.instance:getById(mo.heroUid)

		if heroMO then
			if not heroMO.heroId then
				local heroId = 0

				table.insert(heroList, heroId)
				table.insert(equips, equipMo)

				if heroId > 0 then
					table.insert(allHeros, heroId)
				end
			end
		end
	end

	group.heroList = heroList
	group.equips = equips
	group.clothId = curGroupMO.clothId

	return group
end

function V1a6_CachotHeroGroupModel:saveCurGroupData(callback, callbackObj, heroGroupMO)
	return
end

function V1a6_CachotHeroGroupModel:saveCurGroupData2(callback, callbackObj, heroGroupMO)
	local episodeConfig = lua_episode.configDict[self.episodeId]

	if not episodeConfig then
		return
	end

	heroGroupMO = heroGroupMO or self:getCurGroupMO()

	if not heroGroupMO then
		return
	end

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

	if self.heroGroupType == ModuleEnum.HeroGroupType.Season then
		local extendData = {}

		extendData.groupIndex = heroGroupMO.groupId
		extendData.heroGroup = heroGroupMO

		self:setHeroGroupSnapshot(self.heroGroupType, self.episodeId, true, extendData, callback, callbackObj)

		return
	end

	local lastSelectGroupIndex = self.curGroupSelectIndex

	if lastSelectGroupIndex == 0 then
		if self.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
			HeroGroupRpc.instance:sendUpdateHeroGroupRequest(heroGroupMO.id, heroGroupMO.heroList, heroGroupMO.name, heroGroupMO.clothId, heroGroupMO.equips, nil, callback, callbackObj)
		elseif self.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

			FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips())
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, self.heroGroupTypeCo.id, req, callback, callbackObj)
		end
	else
		local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips())
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Common, lastSelectGroupIndex, req, callback, callbackObj)
	end
end

function V1a6_CachotHeroGroupModel:setHeroGroupSnapshot(heroGroupType, episodeId, upload, extendData, callback, callbackObj)
	local episodeConfig = episodeId and lua_episode.configDict[episodeId]

	if not episodeConfig then
		return
	end

	local heroGroupSnapshotType = 0
	local snapshotSubId = 0
	local heroGroupMO

	if heroGroupType == ModuleEnum.HeroGroupType.Resources then
		heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Resources
		snapshotSubId = episodeConfig.chapterId
		heroGroupMO = self._heroGroupList[1]
	elseif heroGroupType == ModuleEnum.HeroGroupType.Season then
		heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Season

		if extendData then
			snapshotSubId = extendData.groupIndex
			heroGroupMO = extendData.heroGroup
		end
	else
		logError("暂不支持此类编队快照")

		return
	end

	if heroGroupMO and upload then
		local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local fightGroup = FightDef_pb.FightGroup()

		FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips())
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(heroGroupSnapshotType, snapshotSubId, req, callback, callbackObj)
	elseif callback then
		callback(callbackObj)
	end
end

function V1a6_CachotHeroGroupModel:replaceSingleGroup()
	local tempGroupMO = self:getCurGroupMO()

	if tempGroupMO then
		local heroList = V1a6_CachotHeroSingleGroupModel.instance:getList()

		tempGroupMO:replaceHeroList(heroList)
	end
end

function V1a6_CachotHeroGroupModel:replaceSingleGroupEquips()
	local tempGroupMO = self:getCurGroupMO()
	local heroList = V1a6_CachotHeroSingleGroupModel.instance:getList()
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

function V1a6_CachotHeroGroupModel:replaceCloth(clothId)
	local tempGroupMO = self:getCurGroupMO()

	if tempGroupMO then
		tempGroupMO:replaceClothId(clothId)
	end
end

function V1a6_CachotHeroGroupModel:replaceEquips(equips, groupMO)
	local tempGroupMO = groupMO or self:getCurGroupMO()

	if tempGroupMO then
		tempGroupMO:updatePosEquips(equips)
	end
end

function V1a6_CachotHeroGroupModel:getCurGroupId()
	return self._curGroupId
end

function V1a6_CachotHeroGroupModel:isPositionOpen(posId)
	local openGroupCO = lua_open_group.configDict[posId]

	if not openGroupCO then
		return false
	end

	if self.episodeId then
		local episodeCO = lua_episode.configDict[self.episodeId]
		local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]
		local aidCount = battleCO and #string.splitToNumber(battleCO.aid, "#") or 0

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

function V1a6_CachotHeroGroupModel:positionOpenCount()
	local count = 0

	for i = 1, 4 do
		if self:isPositionOpen(i) then
			count = count + 1
		end
	end

	return count
end

function V1a6_CachotHeroGroupModel:getPositionLockDesc(posId)
	local openGroupCO = lua_open_group.configDict[posId]
	local needEpisodeId = openGroupCO and openGroupCO.need_episode

	if not needEpisodeId or needEpisodeId == 0 then
		return nil
	end

	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(needEpisodeId)
	local lockDesc = openGroupCO.lock_desc

	return lockDesc, episodeDisplay
end

function V1a6_CachotHeroGroupModel:getHighestLevel()
	local moList = V1a6_CachotHeroSingleGroupModel.instance:getList()

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

function V1a6_CachotHeroGroupModel:setHeroGroupItemPos(HeroGroupList)
	self._herogroupItemPos = HeroGroupList
end

function V1a6_CachotHeroGroupModel:getHeroGroupItemPos()
	return self._herogroupItemPos
end

V1a6_CachotHeroGroupModel.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function V1a6_CachotHeroGroupModel:initRestrictHeroData(battleConfig)
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

		if type == V1a6_CachotHeroGroupModel.RestrictType.HeroId then
			self.restrictHeroIdList = restrictList
		elseif type == V1a6_CachotHeroGroupModel.RestrictType.Career then
			self.restrictCareerList = restrictList
		elseif type == V1a6_CachotHeroGroupModel.RestrictType.Rare then
			self.restrictRareList = restrictList
		else
			logError("un support restrict type : " .. tostring(type))
		end
	end
end

function V1a6_CachotHeroGroupModel:isRestrict(heroUid)
	if heroUid then
		::label_42_0::

		local heroMo = HeroModel.instance:getById(heroUid)

		if not heroMo then
			return false
		end

		local var_42_0

		if self.restrictHeroIdList then
			var_42_0 = tabletool.indexOf(self.restrictHeroIdList, heroMo.heroId)

			if not var_42_0 then
				if self.restrictCareerList then
					var_42_0 = tabletool.indexOf(self.restrictCareerList, heroMo.config.career) or self.restrictRareList and tabletool.indexOf(self.restrictRareList, heroMo.config.rare)
				end
			end
		end

		return var_42_0
	end
end

function V1a6_CachotHeroGroupModel:getCurrentBattleConfig()
	return self.battleConfig
end

V1a6_CachotHeroGroupModel.instance = V1a6_CachotHeroGroupModel.New()

return V1a6_CachotHeroGroupModel
