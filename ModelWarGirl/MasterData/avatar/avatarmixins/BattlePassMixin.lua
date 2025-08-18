-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\BattlePassMixin.lua

local PlayerPrefs = UnityEngine.PlayerPrefs
local DoLoadWaitLogin = require("System/Load/DoLoadWaitLogin")
local ResStage = require("ClientData/ResStage")
local ResMainBattleChapter = require("ClientData/ResMainBattleChapter")
local ResScene = require("ClientData/ResScene")
local SDKConst = require("SDK/SDKConst")
local ResRandClient = require("ClientData/ResRandClient")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResLoadingTips = require("ClientData/ResLoadingTips")
local PerformManager = require("Logic/perform/PerformManager")
local Analytics = require("SDK/Analytics")
local ResStageBonusPredict = require("ClientData/ResStageBonusPredict")
local ResStageCareerReplace = require("ClientData/ResStageCareerReplace")
local EventConst = require("EventConst")
local BattlePassMixin = {}

function BattlePassMixin:initBaseBattlePassMixin(baseData)
	self._waitSyncDataPhase = DoLoadWaitLogin(self)
	self._slotStageSceneLoadEnded = Functor(self.stageSceneLoaded, self)

	self:tempInitStage(baseData)

	self.stageHookAwards = {
		base = {},
		item = {}
	}

	self:initFormation(baseData.necessary.formation)
	self:_initStageActionIndex()
end

function BattlePassMixin:initFormation(data)
	self.formation = {}
	self.formationOtherInfos = {}
	self.formationSnapShot = {}

	for index, info in ipairs(data.item) do
		local infos = {}
		local heros = {}

		for _, coordInfo in ipairs(info.hero) do
			heros[coordInfo.gid] = coordInfo.idx
		end

		if next(heros) then
			self.formation[index - 1] = heros
		end

		self.formationSnapShot[index - 1] = info.snapshot == 1
		infos.petId = info.pet
		self.formationOtherInfos[index - 1] = infos
	end
end

function BattlePassMixin:refreshMultiPvpDefendFormation(type, formations)
	local keyAttr
	local useContainer = false

	if type == Const.FORMATION_TYPE_MULTIPVP_DEFEND then
		keyAttr = "FORMATION_MULTIPVP_DEFEND_"
	elseif type == Const.FORMATION_TYPE_MULTIPVP_ATTACK then
		keyAttr = "FORMATION_MULTIPVP_ATTACK_"
	elseif type == Const.FORMATION_TYPE_OPACTPVP_DEFEND then
		keyAttr = "FORMATION_OPACTPVP_DEFEND_"
	elseif type == Const.FORMATION_TYPE_OPACTPVP_ATTACK then
		keyAttr = "FORMATION_OPACTPVP_ATTACK_"
	elseif type == Const.FORMATION_TYPE_TOPPVP_DEFEND then
		keyAttr = "FORMATION_TOPPVP_DEFEND_"
	elseif type == Const.FORMATION_TYPE_TOPPVP_ATTACK then
		keyAttr = "FORMATION_TOPPVP_ATTACK_"
	elseif type == Const.FORMATION_TYPE_RENT_DEFEND then
		keyAttr = Const.FORMATION_RENT_TEAMS
		useContainer = true
	end

	if not keyAttr then
		return
	end

	for i, info in ipairs(formations) do
		local heros = {}

		for _, coordInfo in ipairs(info.hero) do
			heros[coordInfo.gid] = coordInfo.idx
		end

		local fIndex

		if useContainer then
			fIndex = keyAttr[i]
		else
			fIndex = Const[keyAttr .. i]
		end

		if next(heros) then
			self.formation[fIndex] = heros
		end

		local infos = self.formationOtherInfos[fIndex] or {}

		infos.petId = info.pet
		self.formationOtherInfos[fIndex] = infos
		self.formationSnapShot[fIndex] = info.snapshot == 1
		self.formationOtherInfos[fIndex] = {
			petId = info.pet
		}
	end

	if type == Const.FORMATION_TYPE_MULTIPVP_DEFEND then
		self:checkSeniorPvpFormationRedHint()
	elseif type == Const.FORMATION_TYPE_OPACTPVP_DEFEND then
		self:checkOpactPvpFormationRedHind()
	elseif type == Const.FORMATION_TYPE_RENT_DEFEND then
		self:checkRentFormationRedHind()
		self:refreshRentSetupUI()
	end
end

function BattlePassMixin:getNowFormation(formationIndex)
	if formationIndex == Const.FORMATION_ASYNC_DEFEND then
		return self.asyncPVPDefendFormation
	end

	if formationIndex == Const.FORMATION_FORCE_EMPTY then
		return {}
	end

	if formationIndex == Const.FORMATION_MAZE or formationIndex == Const.FORMATION_EQUIP_TOWER_1 or formationIndex == Const.FORMATION_EQUIP_TOWER_2 or formationIndex == Const.FORMATION_EQUIP_TOWER_3 then
		return self.formation[formationIndex] or {}
	elseif self.formation[formationIndex] then
		return self.formation[formationIndex]
	elseif formationIndex == Const.FORMATION_MULTIPVP_ATTACK_1 or formationIndex == Const.FORMATION_MULTIPVP_ATTACK_2 or formationIndex == Const.FORMATION_MULTIPVP_ATTACK_3 or formationIndex == Const.FORMATION_MULTIPVP_DEFEND_1 or formationIndex == Const.FORMATION_MULTIPVP_DEFEND_2 or formationIndex == Const.FORMATION_MULTIPVP_DEFEND_3 then
		return {}
	elseif formationIndex == Const.FORMATION_OPACTPVP_DEFEND_1 or formationIndex == Const.FORMATION_OPACTPVP_DEFEND_2 or formationIndex == Const.FORMATION_OPACTPVP_DEFEND_3 or formationIndex == Const.FORMATION_OPACTPVP_ATTACK_1 or formationIndex == Const.FORMATION_OPACTPVP_ATTACK_2 or formationIndex == Const.FORMATION_OPACTPVP_ATTACK_3 then
		return {}
	elseif formationIndex and formationIndex > Const.FORMATION_OPACTPVP_ATTACK_3 then
		return {}
	elseif self.formation[Const.FORMATION_MAIN_STAGE] then
		return self.formation[Const.FORMATION_MAIN_STAGE]
	else
		return {}
	end
end

function BattlePassMixin:getFormationOtherInfo(formationIndex)
	return self.formationOtherInfos[formationIndex] or {}
end

function BattlePassMixin:getFormationPet(formationIndex)
	local otherInfo = self.formationOtherInfos[formationIndex]

	if otherInfo and otherInfo.petId then
		return self:getPetByResId(otherInfo.petId)
	end
end

function BattlePassMixin:formationHasLackCareer(heros)
	if heros == nil then
		heros = self:getFormationHeros()
	end

	local career = {}

	for _, hero in ipairs(heros or {}) do
		career[hero.career] = true
	end

	local count = 0

	for c, _ in pairs(career) do
		count = count + 1
	end

	return count < 5
end

function BattlePassMixin:getFormationHeros(formationIdx)
	formationIdx = formationIdx or Const.FORMATION_MAIN_STAGE

	local teamHeroGids = self:getNowFormation(formationIdx)
	local heroList = {}

	for gid, pos in pairs(teamHeroGids or {}) do
		local hero = self.heroDic[gid]

		if hero then
			table.insert(heroList, hero)
		end
	end

	return heroList
end

function BattlePassMixin:getFormationAverageLv(formationIdx)
	formationIdx = formationIdx or Const.FORMATION_MAIN_STAGE

	local formationHeros = self:getFormationHeros(formationIdx)

	return utils.calHerosAverageLv(formationHeros)
end

function BattlePassMixin:getPriestsAverageLv(formationIdx)
	if self.crystalPriestsDic then
		local priestHeros = {}

		for gid, _ in pairs(self.crystalPriestsDic) do
			local hero = self.heroDic[gid]

			if hero then
				table.insert(priestHeros, hero)
			end
		end

		return utils.calHerosAverageLv(priestHeros)
	end
end

function BattlePassMixin:getNowFormationCapacity(formationIndex)
	local capa = 0
	local form = self:getNowFormation(formationIndex)

	for gid, pos in pairs(form) do
		local hero = self.heroDic[gid]

		if hero then
			capa = capa + hero:getCapacity()
		end
	end

	local pet = self:getFormationPet(formationIndex)

	if pet then
		capa = capa + pet:getCapacity()
	end

	return capa
end

function BattlePassMixin:heroInBattle(heroGid)
	for index, heros in pairs(self.formation) do
		if heros[heroGid] then
			return index
		end
	end
end

function BattlePassMixin:heroInFormation(heroGid, formationIndex)
	if self.formation[formationIndex] and self.formation[formationIndex] and self.formation[formationIndex][heroGid] then
		return true
	end

	return false
end

function BattlePassMixin:delHeroInAllFormations(heroGid, needRPC, canClearAsyncPvp, exceptFormation, cantBeEmptyFormations)
	local results = {}

	for use_pos, heros in pairs(self.formation) do
		if not exceptFormation or not exceptFormation[use_pos] then
			local canDel = true

			if cantBeEmptyFormations and cantBeEmptyFormations[use_pos] then
				canDel = utils.getTableElemCount(heros) > 1
			end

			if canDel then
				local needUpdate = false

				for gid, idx in pairs(heros) do
					if gid == heroGid then
						needUpdate = true
						heros[gid] = nil
					end
				end

				if next(heros) == nil then
					self.formation[use_pos] = nil
				end

				if needUpdate and needRPC then
					local result = {}

					if self.formation[use_pos] then
						for heroGid, pos in pairs(self.formation[use_pos]) do
							table.insert(result, {
								idx = pos,
								gid = heroGid
							})
						end
					end

					results[use_pos] = result
				end
			end
		end
	end

	for formationIdx, result in pairs(results) do
		if self.formationOtherInfos[formationIdx] then
			RPC.formationUpdate(formationIdx, result, self.formationOtherInfos[formationIdx].petId)
		else
			RPC.formationUpdate(formationIdx, result)
		end
	end

	local asyncCount = utils.getTableElemCount(self.asyncPVPDefendFormation)
	local needUpdate = false

	for gid, index in pairs(self.asyncPVPDefendFormation) do
		if gid == heroGid then
			if asyncCount == 1 and not canClearAsyncPvp then
				return
			end

			needUpdate = true
			self.asyncPVPDefendFormation[gid] = nil
		end
	end

	if needRPC and needUpdate then
		local result = {}

		for heroGid, pos in pairs(self.asyncPVPDefendFormation) do
			table.insert(result, {
				idx = pos,
				gid = heroGid
			})
		end

		if #result > 0 then
			RPC.asyncPVPFormation(result)
		end
	end
end

function BattlePassMixin:onFormationDataNotify(item, use_pos)
	local heros = {}

	for _, coordInfo in ipairs(item.hero) do
		heros[coordInfo.gid] = coordInfo.idx
	end

	if next(heros) then
		self.formation[use_pos] = heros
	else
		self.formation[use_pos] = nil
	end

	self.formationSnapShot[use_pos] = item.snapshot == 1
	self.formationOtherInfos[use_pos] = {
		petId = item.pet
	}

	self:refreshMyRoleInfoHerosFormationChange(heros, use_pos)
	self:initHeroTeamInfo()
	self:checkSeniorPvpFormationRedHint(use_pos)
	self:checkOpactPvpFormationRedHind(use_pos)
	self:checkRentFormationRedHind(use_pos)
	EventCenter.sendEvent(EventConst.FORMATION_DATA_NOTIFY, use_pos)
end

function BattlePassMixin:onFormationsUpdateByPosResp(items)
	for _, info in ipairs(items) do
		self:onFormationDataNotify(info.item, info.pos)
	end
end

function BattlePassMixin:isFormationSnapShot(formationIndex)
	if self.formationSnapShot then
		return self.formationSnapShot[formationIndex] == true
	end

	return false
end

function BattlePassMixin:setFormationSnapShot(formationIndex, isTrue)
	if self.formationSnapShot == nil then
		self.formationSnapShot = {}
	end

	self.formationSnapShot[formationIndex] = isTrue
end

function BattlePassMixin:swapFormation(pos1, pos2)
	if self.formation then
		self.formation[pos1], self.formation[pos2] = self.formation[pos2], self.formation[pos1]
	end
end

function BattlePassMixin:tempInitStage(baseData)
	self:onStageDataNotify(baseData.necessary.deposit.record, true)

	self.stageHookAwardGotTime = baseData.necessary.deposit.last_get_tick
	self.stageHookAwardUpdateTime = baseData.necessary.deposit.online_assgin_tick
	self.mainStageSearchEndTime = 0
	self.stageDatas = {}

	for season, seasonInfo in pairs(ResStage) do
		for chapter, chapterInfo in pairs(seasonInfo) do
			for level, stageInfo in pairs(chapterInfo) do
				if stageInfo.idx then
					self.stageDatas[stageInfo.idx] = stageInfo
				end
			end
		end
	end
end

function BattlePassMixin:getMainStageInfo(season, chapter, level)
	return ((ResStage[season] or {})[chapter] or {})[level]
end

function BattlePassMixin:getNextRandomAwardInfo()
	local nextRandAwardInfo
	local curRandShowId = {}
	local curStageData = self:getNowStageData()

	if curStageData and curStageData.deposit_rand_award and ResRandClient[curStageData.deposit_rand_award] and ResRandClient[curStageData.deposit_rand_award].show_ids then
		for i, itemId in ipairs(ResRandClient[curStageData.deposit_rand_award].show_ids) do
			curRandShowId[itemId] = true
		end
	end

	local nextStageData = self:getNextMainStageInfo()

	while nextStageData do
		local addRandItemId

		if nextStageData and nextStageData.deposit_rand_award and ResRandClient[nextStageData.deposit_rand_award] and ResRandClient[nextStageData.deposit_rand_award].show_ids then
			for i, itemId in ipairs(ResRandClient[nextStageData.deposit_rand_award].show_ids) do
				if not curRandShowId[itemId] then
					addRandItemId = addRandItemId or {}

					table.insert(addRandItemId, itemId)
				end
			end
		end

		if addRandItemId then
			nextRandAwardInfo = {
				resData = nextStageData,
				addRandItemId = addRandItemId
			}

			return nextRandAwardInfo
		else
			nextStageData = self:getNextMainStageInfo(nextStageData)
		end
	end
end

function BattlePassMixin:getNextChapterAwardInfo()
	if ResStage[1][self.mainStageCur.chapter + 1] then
		local totalLevel = #ResStage[1][self.mainStageCur.chapter + 1]

		return ResStage[1][self.mainStageCur.chapter + 1][math.floor(totalLevel / 2)]
	end
end

function BattlePassMixin:getNextMainStageInfo(stageInfo)
	if stageInfo == nil then
		stageInfo = self.mainStageCur
	end

	return self.stageDatas[stageInfo.idx + 1]
end

function BattlePassMixin:getNowStageData()
	local stageInfo = self.mainStageCur
	local nextStageInfo = self:getNextMainStageInfo()

	if not nextStageInfo or nextStageInfo.chapter ~= stageInfo.chapter and self.mainStageToNext ~= 1 then
		return stageInfo
	else
		return nextStageInfo
	end
end

function BattlePassMixin:getNextRecStageInfo(stageInfo)
	if stageInfo == nil then
		stageInfo = self.mainStageCur
	end

	if stageInfo == nil then
		return
	end

	local nextRecStageInfo = {}

	for i = stageInfo.idx + 1, #self.stageDatas do
		if self.stageDatas[i].level_formation == 1 then
			return self.stageDatas[i]
		end
	end

	return nextRecStageInfo
end

function BattlePassMixin:needScenePreStage()
	return self.mainStageAtkedIdx == 0
end

function BattlePassMixin:getMainStageScene()
	if not self:isFirstBeginnerOver() then
		return 30016
	else
		local stageInfo = self:getNowStageData()

		if stageInfo.scene_id == -1 then
			return utils.getRandomScene()
		else
			return stageInfo.scene_id
		end
	end
end

function BattlePassMixin:isFirstBeginnerOver()
	return true
end

function BattlePassMixin:isBattlePassedServerMode(serverStage)
	local now = self.mainStageCur.season * 10000 + self.mainStageCur.chapter * 100 + self.mainStageCur.level

	return serverStage <= now
end

function BattlePassMixin:mainStageStatePassed(season, chapter, level)
	local passedSeason = self.mainStageCur.season

	if season < passedSeason then
		return true
	elseif season == passedSeason then
		local passedChapter = self.mainStageCur.chapter

		if chapter < passedChapter then
			return true
		elseif chapter == passedChapter then
			local passedLevel = self.mainStageCur.level

			if level <= passedLevel then
				return true
			end
		end
	end

	return false
end

function BattlePassMixin:getMainStageStateByInfo(season, chapter, level)
	if level == 0 then
		if self.mainStageAtkedIdx == 0 then
			return Const.STAGE_STATE_ATK_AF
		else
			return Const.STAGE_STATE_PASSED
		end
	else
		return self:getMainStageState(self:getMainStageInfo(season, chapter, level))
	end
end

function BattlePassMixin:getMainStageState(stageInfo)
	local curIdx = 0

	if self.mainStageCur then
		curIdx = self.mainStageCur.idx
	end

	if stageInfo == nil or stageInfo.idx == curIdx then
		if curIdx <= self.mainStageAtkedIdx then
			return Const.STAGE_STATE_ATK_AF
		else
			return Const.STAGE_STATE_ATK_BF
		end
	end

	if curIdx > stageInfo.idx then
		return Const.STAGE_STATE_PASSED
	elseif curIdx < stageInfo.idx then
		return Const.STAGE_STATE_LOCK
	end
end

function BattlePassMixin:onStageDataNotify(data, fromInit)
	self.mainStageToNext = data.cannext
	self.mainStageCur = self:getMainStageInfo(data.season, data.chapter, data.level)
	self.mainStageAtkedIdx = 0

	if self.mainStageCur then
		self.mainStageAtkedIdx = self.mainStageCur.idx
		self.mainStageAtkedDetail = {
			data.season,
			data.chapter,
			data.level
		}
	else
		self.mainStageAtkedIdx = 0
		self.mainStageCur = {
			season = 1,
			idx = 0,
			chapter = 1,
			level = 0
		}
	end

	if not fromInit then
		self.stageDataChanged = data

		ConditionLimitManager.triggerStageUnlock(data.season, data.chapter, data.level)
		self:checkTestStageSDKInfo(data.season, data.chapter, data.level)
		self:checkPreviewDlgUnlock(data.season, data.chapter, data.level)
	end

	Analytics.onStageChanged()
	self:refreshMasterApprenticeBattleGuideRed()
	self:refreshApprenticeGraduteRed()
end

function BattlePassMixin:checkPreviewDlgUnlock(season, chapter, level)
	local stageBonusResDataList = utils.getStageBonusResInfoList()

	for id, bonusData in ipairs(stageBonusResDataList) do
		local startInfo = bonusData.begin_stage

		if season == startInfo[1] and chapter == startInfo[2] and level == startInfo[3] then
			self.cacheUnlockPreviewStage = math.max(id - 1, 1)
		end
	end
end

function BattlePassMixin:checkTestStageSDKInfo(season, chapter, level)
	if chapter == 1 and level == 5 then
		if RegionUtils.isSEA() then
			local data = Analytics.getBiliSeaSendLogPubParameter()

			data.content = "EndGuide_1-4"

			ChannelUtil.doAnyFunction("appsflyerTrackEventKey", {
				eventName = "af_tutorial_completion",
				eventValue = ClientUtils.table2String(data)
			})
			ChannelUtil.doAnyFunction("firebaseTrackEventKey", {
				eventName = "G_tutorial_complete",
				eventValue = ClientUtils.table2String(data)
			})
		else
			SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.STAGE_1_4)
		end
	elseif chapter == 1 and level == 12 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.STAGE_1_12)
	elseif chapter == 3 and level == 24 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.STAGE_3_24)
	elseif chapter == 4 and level == 1 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.STAGE_4_1)
	elseif chapter == 4 and level == 15 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.STAGE_4_15)
	elseif chapter == 11 and level == 1 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.STAGE_11_1)
	end
end

function BattlePassMixin:getBattleChapterStory()
	if self.mainStageToNext == 1 then
		local stageInfo = self:getNowStageData()

		if stageInfo.level == 1 then
			local data = ResMainBattleChapter[stageInfo.season] or {}

			data = data[stageInfo.chapter] or {}

			return data.perform_id
		end
	end
end

function BattlePassMixin:onStageUnlockNextResp()
	self.mainStageToNext = 1

	if not self:enterMainStage() then
		PerformManager.stop()
		PerformManager.start()

		local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

		if mainStageDlg then
			mainStageDlg:refreshData()
		end
	end
end

function BattlePassMixin:stageSceneLoaded()
	GameFsm.getState(Const.STATE_MAIN_STAGE):checkSceneConfig()
	CueManager.playBaseBGM()

	if self.stageSceneEndCallback then
		self.stageSceneEndCallback()

		self.stageSceneEndCallback = nil
	else
		local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

		if mainStageDlg then
			mainStageDlg:refreshData()
		end
	end
end

function BattlePassMixin:enterMainStage(endCallback)
	local tgtSceneNo = self:getMainStageScene()

	if tgtSceneNo and not SceneManager.isSameScene(tgtSceneNo, SceneManager.mCurSceneID) then
		PerformManager.stop()
		SceneManager.addLoadScene(tgtSceneNo)

		if not self.syncDataReady then
			LoadManager.addLoadPhase(self._waitSyncDataPhase)
		end

		self.stageSceneEndCallback = endCallback

		if not endCallback then
			LoadManager.start(self._slotStageSceneLoadEnded, "mainStageLoading")
		else
			LoadManager.start(self._slotStageSceneLoadEnded)
		end

		return true
	else
		if endCallback then
			endCallback()
		end

		return false
	end
end

function BattlePassMixin:onDepositAwardStartResp(level, season, chapter)
	return
end

function BattlePassMixin:getMainStageHookAward()
	local hookAwards = {
		base = {},
		item = {}
	}

	if self.stageHookAwardUpdateTime == 0 then
		return hookAwards
	end

	local limitTime = math.min(self.stageHookAwardGotTime + Const.MAIN_STAGE_DEPOSIT_MAX_TIME, ClientUtils.getServerTime())
	local hookTime = limitTime - self.stageHookAwardUpdateTime
	local times = math.max(0, math.floor(hookTime / Const.STAGE_HOOK_UPDATE_CD))
	local baseAwards = ResRandClient[self.mainStageCur.deposit_assgin_award] or {}
	local baseAwardIDs = baseAwards.show_ids or {}
	local baseAwardNums = baseAwards.show_nums or {}

	for i, awardID in ipairs(baseAwardIDs) do
		local awardNum = baseAwardNums[i] or 0

		if awardID == Const.MONEY_ID_GOLD then
			awardNum = self:getPrivilegeValue(Const.PRIVITY_KEY_GOLD, awardNum)
		elseif awardID == Const.MONEY_ID_HERO_EXP then
			awardNum = self:getPrivilegeValue(Const.PRIVITY_KEY_HERO_EXP, awardNum)
		end

		hookAwards.base[awardID] = math.floor(times * awardNum + (self.stageHookAwards.base[awardID] or 0))
	end

	for awardID, awardNum in pairs(self.stageHookAwards.base) do
		if hookAwards.base[awardID] == nil then
			hookAwards.base[awardID] = math.floor(awardNum)
		end
	end

	hookAwards.item = self.stageHookAwards.item
	hookAwards.activityBonus = self:getActivityDepositBonus()

	return hookAwards
end

function BattlePassMixin:onDepositAwardNotify(time, doType, award, get_tick, fixAward)
	self.stageHookAwards = {
		base = {},
		item = {}
	}
	self.stageHookAwardUpdateTime = time

	for _, fixedInfo in ipairs(fixAward) do
		if fixedInfo.flag == 0 then
			self.stageHookAwards.base[fixedInfo.id] = fixedInfo.num * 0.0001
		end
	end

	if get_tick then
		self.stageHookAwardGotTime = get_tick
	end

	if doType ~= "kDepositTypeGet" then
		for _, info in ipairs(award) do
			if info.flag == 0 then
				self.stageHookAwards.base[info.id] = (self.stageHookAwards.base[info.id] or 0) + info.num
			elseif info.num > 0 then
				table.insert(self.stageHookAwards.item, BaseObject.GetObject(info.id, info.num))
			end
		end
	end

	local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

	if mainStageDlg then
		mainStageDlg:updateHook()
	end
end

function BattlePassMixin:onDepositAwardGetResp(tick)
	self.stageHookAwardGotTime = tick

	MsgManager.notice(Lang.get(1815))

	local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

	if mainStageDlg then
		mainStageDlg:updateHook()
	end
end

local function JumpToDeposit()
	local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

	mainStageDlg = mainStageDlg or UIManager.getUI("mainStageDlg", true)

	mainStageDlg:openDeposit()
end

function BattlePassMixin:checkHookGotTime(fromLogin)
	local hookTime = ClientUtils.getServerTime() - self.stageHookAwardGotTime

	if self.stageHookAwardGotTime > 0 and self.mainStageAtkedIdx > 0 then
		if fromLogin then
			local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

			if mainStageDlg then
				mainStageDlg:openDeposit()
			end
		elseif hookTime < Const.MAIN_STAGE_DEPOSIT_MAX_TIME then
			if hookTime >= Const.MAIN_STAGE_DEPOSIT_INTERVAL_TIME then
				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResClientNotice[154].notice, JumpToDeposit)
			end
		else
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResClientNotice[156].notice, JumpToDeposit)
		end
	end
end

function BattlePassMixin:sendAvgAnalyticsData(eventType, param1, param2, param3)
	if self.mainStageCur.chapter <= 2 then
		Analytics.sendOSSLog(eventType, param1, param2, param3)
	end
end

function BattlePassMixin:_initStageActionIndex()
	self._stageActionPrefKey = "StageAction" .. self.uid

	if PlayerPrefs.HasKey(self._stageActionPrefKey) then
		self.stageActionIndex = PlayerPrefs.GetInt(self._stageActionPrefKey)
	else
		self:setStageActionIndex(0)
	end
end

function BattlePassMixin:getStageActionIndex()
	return self.stageActionIndex or 0
end

function BattlePassMixin:setStageActionIndex(idx)
	self.stageActionIndex = idx

	PlayerPrefs.SetInt(self._stageActionPrefKey, idx)
end

function BattlePassMixin:onStageRecordResp(season, chapter, level, data)
	local ui = UIManager.tryGetUI("battleRecommendDlg")

	if ui then
		ui:onStageRecordResp(season, chapter, level, data)

		return
	end

	local ui = UIManager.tryGetUI("stageInfoDlg")

	if ui then
		ui:onStageRecordResp(season, chapter, level, data)
	end
end

local CachedTipsNotice
local DEFAULT_TIPS_NOTICE = 0

function BattlePassMixin:getNoticeTips(noticeType, heros)
	if not CachedTipsNotice then
		CachedTipsNotice = {}
		CachedTipsNotice[DEFAULT_TIPS_NOTICE] = {}

		for _, info in pairs(ResLoadingTips) do
			if info.show_type then
				for _, sType in ipairs(info.show_type) do
					if not CachedTipsNotice[sType] then
						CachedTipsNotice[sType] = {}
					end

					table.insert(CachedTipsNotice[sType], info)
				end
			else
				table.insert(CachedTipsNotice[DEFAULT_TIPS_NOTICE], info)
			end
		end
	end

	local validTips = {}

	for _, info in pairs(CachedTipsNotice[noticeType] or {}) do
		if self:_noticeTipsOk(info, heros) then
			table.insert(validTips, info)
		end
	end

	for _, info in pairs(CachedTipsNotice[DEFAULT_TIPS_NOTICE] or {}) do
		if self:_noticeTipsOk(info, heros) then
			table.insert(validTips, info)
		end
	end

	if #validTips > 0 then
		return validTips[math.random(#validTips)]
	end
end

function BattlePassMixin:_noticeTipsOk(info, heros)
	if info.start_stage and not self:isBattlePassedServerMode(info.start_stage) then
		return false
	end

	if info.end_stage and self:isBattlePassedServerMode(info.end_stage) then
		return false
	end

	if info.cond_career == 1 and not self:formationHasLackCareer(heros) then
		return false
	end

	return true
end

function BattlePassMixin:noticeBeginnerHookResult(result)
	RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HOOK, false)
	RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HERO, false)

	self.beginnerLoseMarked = false

	if result == BattleConst.BATTLE_RESULT_WIN or result == nil then
		self.beginnerLoseNum = 0

		return
	end

	if self:mainStageStatePassed(1, 5, 0) then
		return
	end

	if not self:mainStageStatePassed(1, 1, 7) then
		return
	end

	self.beginnerLoseNum = (self.beginnerLoseNum or 0) + 1

	if self:mainStageStatePassed(1, 1, 12) and self.beginnerLoseNum < 2 then
		return
	end

	if self:getBeginnerHintLvUpHero(true) then
		self.beginnerLoseMarked = true

		RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HOOK, true)
		RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HERO, false)
	end
end

function BattlePassMixin:clearBeginnerHookLose()
	return
end

function BattlePassMixin:onFormationRecommendRankGetResp(type, level, hero, formation)
	if not self.formationRecData then
		self.formationRecData = {}
	end

	self.formationRecData[level] = {}
	self.formationRecData[level].flag = true
	self.formationRecData[level].hero = hero
	self.formationRecData[level].formation = formation

	local ui = UIManager.tryGetUI("battleRecommendDlg")

	if ui then
		ui:onRefreshUI(level, self.formationRecData[level])
	end
end

function BattlePassMixin:parseRecHeroWithCareer(hero, career)
	if not hero or #hero < 1 then
		return {}
	end

	local function getHotValue(cur, max)
		return math.floor(cur / max * 99)
	end

	local maxCount = hero[1].count
	local newHeroList = {}

	for _, v in ipairs(hero) do
		if career == 0 then
			table.insert(newHeroList, v)
		else
			local hero = BaseObject.GetObject(v.hero)

			if hero.career == career then
				table.insert(newHeroList, v)
			end
		end
	end

	if newHeroList then
		for _, v in ipairs(newHeroList) do
			v.hot = getHotValue(v.count, maxCount)
		end
	end

	return newHeroList
end

function BattlePassMixin:parseRecHeroByFormation(hero, formations)
	if not hero or #hero < 1 then
		return {}
	end

	if not formations or #formations < 1 then
		return {}
	end

	local replaceData = ResStageCareerReplace
	local newHero = {}
	local heroDatas = {}

	for i = 1, 5 do
		heroDatas[i] = {}

		local data = self:parseRecHeroWithCareer(hero, i)

		heroDatas[i] = data
	end

	for i, v in ipairs(formations) do
		local formation = tostring(v)

		newHero[i] = {}

		if #formation ~= 5 then
			break
		else
			local tempHeroDatas = {}
			local tempReplaceDatas = {}

			tempHeroDatas = utils.deepcopy(heroDatas)

			for j = 1, #formation do
				local needCareer = string.sub(formation, j, j)

				needCareer = tonumber(needCareer)

				if tempHeroDatas then
					local temp = tempHeroDatas[needCareer]

					if temp and #temp >= 1 then
						table.insert(newHero[i], temp[1])
						table.remove(temp, 1)
					elseif i == 1 then
						table.insert(tempReplaceDatas, needCareer)
					end
				end
			end

			if i == 1 and tempReplaceDatas and #tempReplaceDatas >= 1 then
				for _, id in ipairs(tempReplaceDatas) do
					if replaceData[id] and replaceData[id].replace_career then
						local replaceIds = replaceData[id].replace_career

						if replaceIds then
							for _, replaceId in ipairs(replaceIds) do
								if tempHeroDatas[replaceId] and #tempHeroDatas[replaceId] >= 1 then
									table.insert(newHero[i], tempHeroDatas[replaceId][1])
									table.remove(tempHeroDatas[replaceId], 1)

									break
								end
							end
						end
					end
				end

				if #newHero[i] == 5 then
					return newHero
				else
					return {}
				end
			end

			if #newHero[i] ~= 5 then
				table.remove(newHero, i)
			end
		end
	end

	return newHero
end

return BattlePassMixin
