-- chunkname: @modules/logic/seasonver/act166/model/Season166Model.lua

module("modules.logic.seasonver.act166.model.Season166Model", package.seeall)

local Season166Model = class("Season166Model", BaseModel)

function Season166Model:onInit()
	self:reInit()
end

function Season166Model:reInit()
	self._actInfo = {}
	self._battleContext = nil
	self.localPrefsDict = {}
	self._fightTalentData = {}
end

function Season166Model:setActInfo(msg)
	local activityId = msg.activityId
	local actMO = self._actInfo[activityId]

	if not actMO then
		actMO = Season166MO.New()
		self._actInfo[activityId] = actMO
		self._curSeasonId = activityId
	end

	actMO:updateInfo(msg)
end

function Season166Model:getActInfo(activityId)
	if not activityId then
		return nil
	end

	return self._actInfo[activityId]
end

function Season166Model:getCurSeasonId()
	return self._curSeasonId
end

function Season166Model:setBattleContext(actId, episodeId, baseId, talentId, trainId, teachId)
	self._battleContext = Season166BattleContext.New()

	self._battleContext:init(actId, episodeId, baseId, talentId, trainId, teachId)
end

function Season166Model:getBattleContext(ignoreNil)
	if not ignoreNil and not self._battleContext then
		logError("battleContext is nil")
	end

	return self._battleContext
end

function Season166Model:onReceiveAnalyInfo(msg)
	local actInfo = self:getActInfo(msg.activityId)

	if actInfo then
		actInfo:updateAnalyInfoStage(msg.infoId, msg.stage)
	end
end

function Season166Model:onReceiveInformationBonus(msg)
	local actInfo = self:getActInfo(msg.activityId)

	if actInfo then
		actInfo:onReceiveInformationBonus(msg.bonusIds)
	end
end

function Season166Model:onReceiveInfoBonus(msg)
	local actInfo = self:getActInfo(msg.activityId)

	if actInfo then
		actInfo:updateInfoBonus(msg.infoId, msg.bonusStage)
	end
end

function Season166Model:onReceiveUpdateInfos(msg)
	local actInfo = self:getActInfo(msg.activityId)

	if actInfo then
		local hasNewInfo = actInfo:updateInfos(msg.updateInfos)

		if hasNewInfo then
			Season166Controller.instance:showToast(Season166Enum.ToastType.Info)
		end
	end
end

function Season166Model:getTalentInfo(activityId, talentId)
	local actInfo = self:getActInfo(activityId)

	if actInfo then
		return actInfo:getTalentMO(talentId)
	end
end

function Season166Model:onReceiveSetTalentSkill(msg)
	local actInfo = self:getActInfo(msg.activityId)
	local isAdd = actInfo:setTalentSkillIds(msg.talentId, msg.skillIds)

	Season166Controller.instance:dispatchEvent(Season166Event.SetTalentSkill, msg.talentId, isAdd)
end

function Season166Model:onReceiveAct166TalentPush(msg)
	local actInfo = self:getActInfo(msg.activityId)

	if actInfo then
		actInfo:updateTalentInfo(msg.talents)
	end
end

function Season166Model:onReceiveAct166EnterBaseReply(msg)
	local actInfo = self:getActInfo(msg.activityId)

	if actInfo then
		actInfo:setSpotBaseEnter(msg.baseId, true)
	end
end

function Season166Model:onReceiveBattleFinishPush(msg)
	if msg.activityId ~= self._curSeasonId then
		logError("activityId mismatch")

		return
	end

	self.fightResult = msg

	local actInfo = self:getActInfo(msg.activityId)

	if actInfo and msg.isHighestScore then
		actInfo:updateMaxScore(msg.episodeType, msg.id, msg.totalScore)
	end
end

function Season166Model:getFightResult()
	if not self.fightResult then
		logError("not receive 166BattleFinishPush")
	end

	return self.fightResult
end

function Season166Model:clearFightResult()
	self.fightResult = nil
end

function Season166Model.setPrefsTalent(talentId)
	PlayerPrefsHelper.setNumber(Season166Model.getKey(), talentId)
end

function Season166Model.getPrefsTalent()
	local value = PlayerPrefsHelper.getNumber(Season166Model.getKey(), 0)

	if value == 0 then
		return
	end

	return value
end

function Season166Model.getKey()
	local userId = PlayerModel.instance:getMyUserId()
	local seasonId = Season166Model.instance:getCurSeasonId() or 0

	if seasonId == 0 then
		logError("赛季id为空,请检查")
	end

	return tostring(userId) .. PlayerPrefsKey.Season166EquipTalentId .. seasonId
end

function Season166Model:checkHasNewUnlockInfo()
	local saveUnlockStateTab = self:getLocalUnlockState(Season166Enum.InforMainLocalSaveKey)
	local actInfo = self:getActInfo(self._curSeasonId)

	if not actInfo then
		return false
	end

	local infoConfigList = Season166Config.instance:getSeasonInfos(self._curSeasonId)

	for _, infoCo in ipairs(infoConfigList) do
		local infoMo = actInfo and actInfo:getInformationMO(infoCo.infoId)

		if infoMo then
			if not Season166Enum.UnlockState then
				local isUnlock = Season166Enum.LockState
				local saveUnlockState = saveUnlockStateTab[infoCo.infoId]

				if infoMo and isUnlock ~= saveUnlockState then
					return true
				end
			end
		end
	end

	return false
end

function Season166Model:getLocalUnlockState(key)
	local saveStr = Season166Controller.instance:getPlayerPrefs(key)
	local saveStateList = Season166Controller.instance:loadDictFromStr(saveStr)
	local saveUnlockStateTab = {}

	for _, unlockStateStr in ipairs(saveStateList) do
		local param = string.split(unlockStateStr, "|")
		local id = tonumber(param[1])

		saveUnlockStateTab[id] = tonumber(param[2])
	end

	return saveUnlockStateTab
end

function Season166Model:getCurUnlockTalentData(talentId)
	local talentConfigList = lua_activity166_talent_style.configDict[talentId]
	local curTalentInfo = self:getTalentInfo(self._curSeasonId, talentId)
	local unlockCoList = {}

	for level, talentConfig in ipairs(talentConfigList) do
		if curTalentInfo.level >= talentConfig.level and talentConfig.needStar > 0 then
			table.insert(unlockCoList, talentConfig)
		end
	end

	local unlockSkillList = {}

	for _, co in ipairs(unlockCoList) do
		local skillList = string.splitToNumber(co.skillId, "#")

		for _, skillId in ipairs(skillList) do
			table.insert(unlockSkillList, skillId)
		end
	end

	return unlockCoList, unlockSkillList
end

function Season166Model:getUnlockWithNotSelectTalents(talentId)
	local _, unlockSkillList = self:getCurUnlockTalentData(talentId)
	local curTalentInfo = self:getTalentInfo(self._curSeasonId, talentId)
	local curSelectSkills = curTalentInfo.skillIds

	if tabletool.len(curSelectSkills) == 0 then
		return unlockSkillList
	end

	local unSelectSkillList = {}

	for _, skillId in ipairs(unlockSkillList) do
		for _, selectSkillId in ipairs(curSelectSkills) do
			if tabletool.indexOf(unlockSkillList, selectSkillId) and selectSkillId ~= skillId then
				table.insert(unSelectSkillList, skillId)
			end
		end
	end

	return unSelectSkillList
end

function Season166Model:getTalentLocalSaveKey(talentId)
	return string.format("%s_%s", Season166Enum.TalentLockSaveKey, talentId)
end

function Season166Model:checkHasNewTalent(talentId)
	local saveKey = self:getTalentLocalSaveKey(talentId)
	local saveUnlockStateTab = self:getLocalUnlockState(saveKey)
	local unSelectSkillList = self:getUnlockWithNotSelectTalents(talentId)

	for _, skillId in ipairs(unSelectSkillList) do
		if saveUnlockStateTab[skillId] ~= Season166Enum.UnlockState then
			return true
		end
	end

	return false
end

function Season166Model:checkAllHasNewTalent(actId)
	local talentConfigList = lua_activity166_talent.configDict[actId]

	for _, talentCo in pairs(talentConfigList) do
		if self:checkHasNewTalent(talentCo.talentId) then
			return true
		end
	end

	return false
end

function Season166Model:checkIsBaseSpotEpisode()
	local battleContext = self:getBattleContext()
	local var_29_0

	if battleContext then
		::label_29_0::

		var_29_0 = battleContext.baseId and battleContext.baseId > 0
	end

	return var_29_0
end

function Season166Model:checkCanShowSeasonTalent()
	local battleContext = self:getBattleContext()
	local fightParam = FightModel.instance:getFightParam()

	if fightParam and fightParam.episodeId then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

		if not Season166Controller.instance.isSeason166EpisodeType(episodeCo.type) then
			return false
		end
	end

	if battleContext.baseId then
		local isBaseSpot = battleContext.baseId > 0

		if battleContext.trainId then
			local isTrain = battleContext.trainId > 0

			return battleContext and (isBaseSpot or isTrain)
		end
	end
end

function Season166Model:isTrainPass(activityId, trainId)
	local actInfo = self:getActInfo(activityId)

	if actInfo then
		return actInfo:isTrainPass(trainId)
	end

	return false
end

function Season166Model:unpackFightReconnectData(data)
	local reconnectData = cjson.decode(data)

	if reconnectData then
		local talentId = reconnectData.talentId
		local talentSkillIds = reconnectData.talentSkillIds
		local talentLevel = reconnectData.talentLevel

		self:setFightTalentParam(talentId, talentSkillIds, talentLevel)
	end
end

function Season166Model:setFightTalentParam(talentId, talentSkillIds, talentLevel)
	self._fightTalentData = {}
	self._fightTalentData.talentId = talentId
	self._fightTalentData.talentSkillIds = {}
	self._fightTalentData.talentLevel = talentLevel

	for _, skillId in ipairs(talentSkillIds) do
		table.insert(self._fightTalentData.talentSkillIds, skillId)
	end
end

function Season166Model:getFightTalentParam()
	return self._fightTalentData
end

function Season166Model:getLocalPrefsTab(key)
	if not self.localPrefsDict[key] then
		local tab = {}
		local saveStr = Season166Controller.instance:getPlayerPrefs(key)
		local saveStateList = GameUtil.splitString2(saveStr, true)

		if saveStateList then
			for _, param in ipairs(saveStateList) do
				local id = param[1]

				tab[id] = param[2]
			end
		end

		self.localPrefsDict[key] = tab
	end

	return self.localPrefsDict[key]
end

function Season166Model:setLocalPrefsTab(key, id, state)
	local tab = self:getLocalPrefsTab(key)

	if tab[id] == state then
		return
	end

	tab[id] = state

	local list = {}

	for k, v in pairs(tab) do
		table.insert(list, string.format("%s#%s", k, v))
	end

	local value = table.concat(list, "|")

	Season166Controller.instance:savePlayerPrefs(key, value)
end

Season166Model.instance = Season166Model.New()

return Season166Model
