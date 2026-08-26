-- chunkname: @modules/logic/herogroup/controller/HeroGroupController.lua

module("modules.logic.herogroup.controller.HeroGroupController", package.seeall)

local HeroGroupController = class("HeroGroupController", BaseController)

function HeroGroupController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function HeroGroupController:reInit()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function HeroGroupController:_onGetInfoFinish()
	HeroGroupModel.instance:setParam()
end

function HeroGroupController:_checkCommonHeroGroup(episodeId)
	if episodeId ~= 10101 then
		return
	end

	if not GuideModel.instance:isGuideRunning(102) then
		return
	end

	local firstSubId = 1
	local heroGroupMo = HeroGroupModel.instance:getCommonGroupList(firstSubId)

	if not heroGroupMo then
		logError("HeroGroupController:_checkCommonHeroGroup heroGroupMo nil")

		return
	end

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroId = heroGroupMo:getHeroByIndex(i)
		local heroMo = HeroModel.instance:getById(heroId)

		if heroMo then
			return
		end
	end

	local appleHeroMo = HeroModel.instance:getByHeroId(3028)

	if not appleHeroMo then
		logError("HeroGroupController:_checkCommonHeroGroup appleHeroMo nil")

		return
	end

	local uid = appleHeroMo.uid

	heroGroupMo.heroList[1] = tostring(uid)

	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMo.clothId, heroGroupMo:getMainList(), heroGroupMo:getSubList(), heroGroupMo:getAllHeroEquips(), heroGroupMo:getAllHeroActivity104Equips(), heroGroupMo:getAssistBossId())

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Common
	local snapshotSubId = firstSubId

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req)
end

function HeroGroupController:openGroupFightView(battleId, episodeId, adventure)
	callWithCatch(self._checkCommonHeroGroup, self, episodeId)

	self._groupFightName = self:_getGroupFightViewName(episodeId)

	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(battleId, episodeId, adventure)

	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(episodeId)] then
			FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
			FightRpc.instance:sendGetFightRecordGroupRequest(episodeId)

			return
		end
	end

	local currentGroupMo = HeroGroupModel.instance:getCurGroupMO()

	if self:changeToDefaultEquip() and currentGroupMo and not currentGroupMo.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			self:_openGroupView()
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial and currentGroupMo then
		currentGroupMo:saveData()
	end

	self:_openGroupView()
end

function HeroGroupController:_openGroupView()
	if self._groupFightName == ViewName.VersionActivity2_8HeroGroupBossView and self:_bossEnterFight() then
		return
	end

	ViewMgr.instance:openView(self._groupFightName)
end

function HeroGroupController:_bossEnterFight()
	local episodeId = HeroGroupModel.instance.episodeId

	if episodeId then
		::label_8_0::

		local heroGroupId = VersionActivity2_8BossConfig.instance:getHeroGroupId(episodeId)
		local heroGroupConfig = heroGroupId and lua_hero_group_type.configDict[heroGroupId]
		local changeForbiddenEpisode = heroGroupConfig and heroGroupConfig.changeForbiddenEpisode

		if not changeForbiddenEpisode or changeForbiddenEpisode == 0 then
			logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s changeForbiddenEpisode nil", episodeId, heroGroupId))

			return
		end

		local pass = DungeonModel.instance:hasPassLevelAndStory(changeForbiddenEpisode)

		if not pass then
			return
		end

		HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)

		local result = FightController.instance:setFightHeroSingleGroup()

		if result then
			local fightParam = FightModel.instance:getFightParam()

			fightParam.isReplay = false
			fightParam.multiplication = 1

			DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)

			return true
		else
			logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s setFightHeroSingleGroup failed", episodeId, heroGroupId))
		end
	end
end

function HeroGroupController:_getGroupFightViewName(episodeId)
	if not self.ActivityIdToHeroGroupView then
		self.ActivityIdToHeroGroupView = {
			[VersionActivity1_2Enum.ActivityId.Dungeon] = ViewName.V1a2_HeroGroupFightView,
			[VersionActivity1_3Enum.ActivityId.Dungeon] = ViewName.V1a3_HeroGroupFightView,
			[VersionActivity1_5Enum.ActivityId.Dungeon] = ViewName.V1a5_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.Dungeon] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.DungeonBossRush] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity2_9Enum.ActivityId.Dungeon] = ViewName.VersionActivity2_9HeroGroupFightView,
			[VersionActivity3_10Enum.ActivityId.Dungeon] = ViewName.V3A10_HeroGroupFightView
		}
		self.ChapterTypeToHeroGroupView = {
			[DungeonEnum.ChapterType.WeekWalk] = ViewName.HeroGroupFightWeekwalkView,
			[DungeonEnum.ChapterType.WeekWalk_2] = ViewName.HeroGroupFightWeekwalk_2View,
			[DungeonEnum.ChapterType.TowerPermanent] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBoss] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerLimited] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBossTeach] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerDeep] = ViewName.TowerDeepHeroGroupFightView,
			[DungeonEnum.ChapterType.Act183] = ViewName.Act183HeroGroupFightView,
			[DungeonEnum.ChapterType.Odyssey] = ViewName.OdysseyHeroGroupView,
			[DungeonEnum.ChapterType.Survival] = ViewName.SurvivalHeroGroupFightView,
			[DungeonEnum.ChapterType.Shelter] = ViewName.ShelterHeroGroupFightView,
			[DungeonEnum.ChapterType.Act191] = ViewName.Act191HeroGroupView,
			[DungeonEnum.ChapterType.Rouge2] = ViewName.Rouge2_HeroGroupFightView,
			[DungeonEnum.ChapterType.Rouge2Boss] = ViewName.Rouge2_BossHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerCompose] = ViewName.TowerComposeHeroGroupView,
			[DungeonEnum.ChapterType.Abyss] = ViewName.AbyssHeroGroupFightView,
			[DungeonEnum.ChapterType.Sodache] = ViewName.SodacheHeroGroupFightView,
			[DungeonEnum.ChapterType.AtomicDungeon] = ViewName.AtomicDungeonHeroGroupView
		}
		self.ChapterIdToHeroGroupView = {
			[DungeonEnum.ChapterId.BossStory] = ViewName.VersionActivity2_8HeroGroupBossView
		}

		local bossrushActModeActId = V3a9_BossRushModel.instance:getActModeActId()

		if bossrushActModeActId then
			self.ActivityIdToHeroGroupView[bossrushActModeActId] = ViewName.V3a9_BossRush_HeroGroupFightView
		end
	end

	if DungeonController.checkEpisodeFiveHero(episodeId) then
		return ViewName.HeroGroupFightFiveHeroView
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.BossRush then
		local viewName = BossRushController.instance:getGroupFightViewName(episodeId)

		if viewName then
			return viewName
		end
	end

	if episodeConfig then
		::label_9_0::

		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if chapterConfig then
			return self.ActivityIdToHeroGroupView[chapterConfig.actId] or self.ChapterTypeToHeroGroupView[chapterConfig.type] or self.ChapterIdToHeroGroupView[chapterConfig.id] or ViewName.HeroGroupFightView
		end

		return ViewName.HeroGroupFightView
	end
end

function HeroGroupController:changeToDefaultEquip()
	local groupMo = HeroGroupModel.instance:getCurGroupMO()

	if groupMo then
		if not groupMo.equips then
			local equipMoList = {}

			if groupMo then
				if not groupMo.heroList then
					local heroUidList = {}
					local heroMo, equipIndex
					local changed = false

					for index, heroUid in ipairs(heroUidList) do
						heroMo = HeroModel.instance:getById(heroUid)
						equipIndex = index - 1

						if heroMo and heroMo:hasDefaultEquip() and equipMoList[equipIndex] and heroMo.defaultEquipUid ~= equipMoList[equipIndex].equipUid[1] then
							local preFindIndex = self:_checkEquipInPreviousEquip(equipIndex - 1, heroMo.defaultEquipUid, equipMoList)

							if equipIndex <= preFindIndex then
								local findIndex = self:_checkEquipInBehindEquip(equipIndex + 1, heroMo.defaultEquipUid, equipMoList)

								if findIndex > 0 then
									equipMoList[findIndex].equipUid[1] = equipMoList[equipIndex].equipUid[1]
								end

								equipMoList[equipIndex].equipUid[1] = heroMo.defaultEquipUid
							elseif equipMoList[equipIndex].equipUid[1] == heroMo.defaultEquipUid then
								equipMoList[equipIndex].equipUid[1] = "0"
							end

							changed = true
						end
					end

					return changed
				end
			end
		end
	end
end

function HeroGroupController:_checkEquipInBehindEquip(startIndex, equipUid, equipMoList)
	if not EquipModel.instance:getEquip(equipUid) then
		return -1
	end

	for i = startIndex, #equipMoList do
		if equipUid == equipMoList[i].equipUid[1] then
			return i
		end
	end

	return -1
end

function HeroGroupController:_checkEquipInPreviousEquip(endIndex, equipUid, equipMoList)
	if not EquipModel.instance:getEquip(equipUid) then
		return endIndex + 1
	end

	for i = endIndex, 0, -1 do
		if equipUid == equipMoList[i].equipUid[1] then
			return i
		end
	end

	return endIndex + 1
end

function HeroGroupController:_onGetFightRecordGroupReply(fightGroupMO)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	HeroGroupModel.instance:setReplayParam(fightGroupMO)
	self:_openGroupView()
end

function HeroGroupController:onReceiveHeroGroupSnapshot(msg)
	local snapshotId = msg.snapshotId
	local subId = msg.snapshotSubId
	local groupInfo = msg.groupInfo

	if snapshotId == ModuleEnum.HeroGroupSnapshotType.Season123 then
		Season123Model.instance:setSnapshotByHeroGroup(subId, msg)
	end

	if snapshotId == ModuleEnum.HeroGroupSnapshotType.Abyss then
		HeroGroupSnapshotModel.instance:updateHeroGroupInfo(snapshotId, subId, groupInfo)
	end
end

function HeroGroupController:onReceiveHeroGroupSnapshotBatch(msg)
	local snapshotId = msg.snapshotId
	local subs = msg.groupInfos

	for i = 1, #subs do
		local subInfo = subs[i]
		local subId = subInfo.snapshotSubId
		local groupInfo = subInfo.groupInfo

		if snapshotId == ModuleEnum.HeroGroupSnapshotType.Abyss then
			HeroGroupSnapshotModel.instance:updateHeroGroupInfo(snapshotId, subId, groupInfo)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, snapshotId)
end

function HeroGroupController:useRecommendGroup(recommendMo, episodeId, hideMessageBox)
	self._tempRecommendMo = recommendMo
	self._tempEpisodeId = episodeId

	if not hideMessageBox then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AbyssEnterEpisodeTip, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.realUseRecommendGroup, self.onCancelUseRecommendGroup, nil, self, self, nil)
	else
		self:realUseRecommendGroup()
	end
end

function HeroGroupController:onCancelUseRecommendGroup()
	self:clearTempRecommendGroup()
end

function HeroGroupController:clearTempRecommendGroup()
	self._tempRecommendMo = nil
	self._tempEpisodeId = nil
end

function HeroGroupController:realUseRecommendGroup()
	local recommendMo = self._tempRecommendMo
	local episodeId = self._tempEpisodeId

	if HeroGroupModel.instance:getAfterUpdateRecommendState() then
		local enterEpisodeParam = {}

		enterEpisodeParam.recommendMo = recommendMo
		enterEpisodeParam.episodeId = episodeId

		HeroGroupModel.instance:setTempBattleRecommendParam(enterEpisodeParam)
		HeroGroupModel.instance:setAfterUpdateRecommendState(false)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroupAfterEnterEpisode, episodeId)

		return
	else
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroup)
	end

	local heroDataList = recommendMo.heroDataList
	local uidList = {}
	local battleId = HeroGroupModel.instance.battleId
	local battleConfig = lua_battle.configDict[battleId]
	local configAids = {}

	if not string.nilorempty(battleConfig.aid) then
		configAids = string.splitToNumber(battleConfig.aid, "#")
	end

	local configTrial = {}
	local curBattleTrialHeros = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)

	if not string.nilorempty(curBattleTrialHeros) then
		configTrial = GameUtil.splitString2(curBattleTrialHeros, true)
	end

	local allUseTrialHeros = {}

	for _, v in pairs(configTrial) do
		if v[3] then
			local co = lua_hero_trial.configDict[v[1]][v[2]]

			allUseTrialHeros[co.heroId] = true
		end
	end

	for i = 1, #heroDataList do
		local heroId = heroDataList[i].heroId

		if heroId and heroId > 0 then
			local heroMO = HeroModel.instance:getByHeroId(heroId)

			if HeroGroupModel.instance:isAdventureOrWeekWalk() then
				local cd = WeekWalkModel.instance:getCurMapHeroCd(heroId)

				if cd > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					heroMO = nil
				end
			elseif heroMO and HeroGroupModel.instance:isRestrict(heroMO.uid) then
				local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
				local restrictReason = battleCo and battleCo.restrictReason

				if not string.nilorempty(restrictReason) then
					ToastController.instance:showToastWithString(restrictReason)
				end

				heroMO = nil
			end

			if allUseTrialHeros[heroId] then
				heroMO = nil
			end

			if heroMO then
				table.insert(uidList, heroMO.uid)
			else
				table.insert(uidList, "0")
			end
		else
			table.insert(uidList, "0")
		end
	end

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothId = 0

	if recommendMo.cloth and recommendMo.cloth ~= 0 and PlayerClothModel.instance:canUse(recommendMo.cloth) then
		clothId = recommendMo.cloth
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		local list = PlayerClothModel.instance:getList()

		for _, clothMO in ipairs(list) do
			if PlayerClothModel.instance:hasCloth(clothMO.id) then
				clothId = clothMO.id

				break
			end
		end
	end

	local info = {
		groupId = heroGroupMO.id,
		name = heroGroupMO.name,
		clothId = clothId,
		heroList = uidList,
		episodeId = self._tempEpisodeId
	}

	if TowerModel.instance:isInTowerBattle() then
		self:onTowerUse(info, heroGroupMO, recommendMo, configAids, battleConfig.roleNum, battleConfig.playerMax, true, configTrial)
	elseif AbyssModel.instance:isInAbyssBattle() then
		local skillIds = string.splitToNumber(recommendMo.extString, "#")

		info.skillId = skillIds[1]

		self:onAbyssUse(info, heroGroupMO, configAids, battleConfig.roleNum, battleConfig.playerMax, true, configTrial)
	else
		heroGroupMO:initWithBattle(info, configAids, battleConfig.roleNum, battleConfig.playerMax, true, configTrial)
		HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		HeroGroupModel.instance:saveCurGroupData()
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroupFinish)
	end

	self:clearTempRecommendGroup()
end

function HeroGroupController:onTowerUse(info, heroGroupMO, recommendMo, ...)
	local towerFightParam = TowerModel.instance:getRecordFightParam()

	if towerFightParam and towerFightParam.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	local assistBossId = recommendMo.assistBossId

	if assistBossId and assistBossId > 0 and towerFightParam and not towerFightParam.isHeroGroupLock and not TowerModel.instance:isBossBan(assistBossId) and not TowerModel.instance:isLimitTowerBossBan(towerFightParam.towerType, towerFightParam.towerId, assistBossId) then
		local bossMo = TowerAssistBossModel.instance:getById(assistBossId)

		if bossMo then
			local bossIsOpen = TowerController.instance:isBossTowerOpen()

			if bossIsOpen then
				info.assistBossId = assistBossId
			end
		end
	end

	for i, v in ipairs(info.heroList) do
		local mo = HeroModel.instance:getById(v)

		if mo and TowerModel.instance:isHeroBan(mo.heroId) then
			info.heroList[i] = tostring(0)
		end
	end

	heroGroupMO:initWithBattle(info, ...)
	HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function HeroGroupController:onAbyssUse(info, heroGroupMO, ...)
	local activityId = AbyssModel.instance:getCurActId()
	local curEpisodeId = info.episodeId
	local stageId = not curEpisodeId and AbyssModel.instance:getCurStageId() or AbyssConfig.instance:getStageIdByEpisodeId(activityId, curEpisodeId)

	if stageId == nil or stageId == 0 then
		logError("HeroGroupController:onAbyssUse stageId is nil or 0")

		return
	end

	local stageMo = AbyssModel.instance:getStageInfoMo(activityId, stageId)

	if stageMo and stageMo:isChallenged() then
		GameFacade.showToast(ToastEnum.AbyssHeroGroupCannotEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	for i, v in ipairs(info.heroList) do
		local mo = HeroModel.instance:getById(v)

		if mo and AbyssModel.instance:isCurHeroLocked(mo.heroId) then
			AbyssController.instance:dispatchEvent(AbyssEvent.OnAbyssRecommendHeroRemove, {
				heroId = mo.heroId,
				pos = i,
				stageId = stageId
			})

			info.heroList[i] = tostring(0)
		end
	end

	self._tempAbyssUseInfo = info
	self._tempAbyssUseHeroGroupMO = heroGroupMO
	self._tempAbyssUseStageMo = stageMo
	self._tempAbyssUseArgs = {
		n = select("#", ...),
		...
	}

	local skillId = AbyssHelper.getValidSkill(stageId, info.skillId)

	if not skillId or skillId == 0 or skillId == stageMo.skillId then
		self:_onAbyssUseSkillModified()

		return
	end

	AbyssRpc.instance:sendAct229ModifySkillRequest(activityId, stageId, {
		skillId
	}, self._onAbyssUseSkillModified, self)
end

function HeroGroupController:clearTempAbyssUse()
	self._tempAbyssUseInfo = nil
	self._tempAbyssUseHeroGroupMO = nil
	self._tempAbyssUseStageMo = nil
	self._tempAbyssUseArgs = nil
end

function HeroGroupController:_onAbyssUseSkillModified()
	local info = self._tempAbyssUseInfo
	local heroGroupMO = self._tempAbyssUseHeroGroupMO
	local stageMo = self._tempAbyssUseStageMo
	local args = self._tempAbyssUseArgs

	self:clearTempAbyssUse()

	if not info or not heroGroupMO then
		return
	end

	heroGroupMO:initWithBattle(info, unpack(args, 1, args.n))

	local actId = AbyssModel.instance:getCurActId()
	local stageConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageMo.stageId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)

	HeroGroupModel.instance:setParam(episodeConfig.battleId, episodeConfig.id)

	local groupInfo = HeroGroupSnapshotModel.instance:getById(ModuleEnum.HeroGroupSnapshotType.Abyss)

	groupInfo:setSelectIndex(stageMo.heroGroupSubId or 1)
	HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	HeroGroupModel.instance:saveCurGroupData(nil, nil, heroGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

HeroGroupController.instance = HeroGroupController.New()

return HeroGroupController
