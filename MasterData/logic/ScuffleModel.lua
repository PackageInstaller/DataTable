-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/model/ScuffleModel.lua

module("logic.extensions.scuffle.model.ScuffleModel", package.seeall)

local ScuffleModel = class("ScuffleModel", BaseModel)

ScuffleModel.LevelPath = "ui/icon/scuffle/%s.png"

function ScuffleModel:ctor()
	return
end

function ScuffleModel:onInit()
	self:onReset()
end

function ScuffleModel:onReset()
	self._maxBanPetCount = checknumber(ScuffleConfig.instance:getCommonValueByKey("BAN_PET_NUM"))
	self._score = 0
	self._myRank = -1
	self._winStreak = 0
	self._dailyGainedScore = 0
	self._maxScore = 0
	self._gainBit = 0
	self._rankList = {}
	self._battleRecordList = {}
	self._seasonInfoList = {}
	self._dailyTaskRewardList = {}

	self:onTempReset()

	self._oldScore = -1
end

function ScuffleModel:onTempReset()
	self._isFunMode = false
	self._myInitPets = {}
	self._enemyInitPets = {}
	self._myRandomPets = {}
	self._enemyRandomPets = {}
	self._poolPets = {}
	self._myBanPetIds = {}
	self._enemyBanPetIds = {}
	self._myFmtPetIds = {}
	self._enemyFmtPetIds = {}
	self._randomBuffs = {}
	self._enemyAreaName = "匿名"
	self._enemyScore = 0
	self._enemyRank = -1
	self._isCanSelectBanPet = false
	self._selectBanPetList = {}
	self._bagPetMoDic = {}
	self._formation = nil
	self._teamId = 1
	self._resultState = 0
	self._battleResult = nil
	self._myTeamId = 0
	self._fun = nil
	self._oldRank = -1
	self._result = -1
	self._winStreak = 0
	self._selectBuffId = 0
end

function ScuffleModel:_setTempData()
	self._myInitPets = {
		5,
		6
	}
	self._enemyInitPets = {
		7,
		8
	}
	self._myRandomPets = {
		9,
		10,
		11,
		12,
		13,
		14
	}
	self._enemyRandomPets = {
		19,
		20,
		21,
		22,
		23,
		24
	}
	self._poolPets = {
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18,
		19,
		20,
		21,
		22,
		23,
		24,
		25,
		26,
		27,
		28
	}
end

function ScuffleModel:onScuffleInfoRes(msg)
	self._score = msg.score
	self._myRank = msg.myRank
	self._winStreak = msg.winStreak
	self._dailyGainedScore = msg.dailyGainedScore
end

function ScuffleModel:onGameStartRes(msg)
	self._enemyPlayerInfo = msg.opHeadInfo
	self._myInitPets = msg.myPetIds
	self._enemyInitPets = msg.enemyPetIds
	self._poolPets = msg.poolPetIds
	self._enemyAreaName = msg.opAreaName
	self._enemyScore = msg.opScore
	self._enemyRank = msg.opRank
end

function ScuffleModel:onNofityStartSetFormRes(msg)
	self._myInitPets = msg.myInitPetIds
	self._myRandomPets = msg.myRandomPetIds
	self._myBanPetIds = msg.myBanPetIds
	self._enemyBanPetIds = msg.enemyBanPetIds
	self._myFmtPetIds = msg.myPetIds
	self._enemyFmtPetIds = msg.enemyPetids
	self._randomBuffs = msg.randomBuffs
	self._enemyRandomPets = self:_calculateEnemyRandomPets(msg.enemyPetids, self._enemyInitPets)
end

function ScuffleModel:_calculateEnemyRandomPets(totalPets, initPets)
	local randomPets = {}

	for i, v in ipairs(totalPets) do
		if not TableUtil.isHad(initPets, v) then
			table.insert(randomPets, v)
		end
	end

	return randomPets
end

function ScuffleModel:onGameEndRes(msg)
	self._resultState = msg.state
	self._battleResult = msg.battleResult

	if msg:HasField("dailyGainedScore") then
		self._dailyGainedScore = msg.dailyGainedScore
	end

	self._myTeamId = msg:HasField("myTeamId") and msg.myTeamId or 0

	if msg:HasField("oldScore") then
		self._oldScore = msg.oldScore or -1
	end

	if msg:HasField("newSocre") then
		self._score = msg.newSocre or self._score
	end

	if msg:HasField("oldRank") then
		self._oldRank = msg.oldRank or -1
	end

	if msg:HasField("rank") then
		self._myRank = msg.rank or self._myRank
	end

	if msg:HasField("result") then
		self._result = msg.result or -1
	end
end

function ScuffleModel:onGetRankInfoRes(msg)
	self._rankList = GameUtil.pbToTable(msg.ranks) or {}
	self._myRank = msg.myRank
end

function ScuffleModel:onGetBattleRecordRes(msg)
	self._battleRecordList = GameUtil.pbToTable(msg.battleRecords) or {}
end

function ScuffleModel:onGetBattleVideoRes(msg)
	self._singleBattleVideo = msg.battleResult
end

function ScuffleModel:onGetAllSeasonInfoRes(msg)
	self._seasonInfoList = GameUtil.pbToTable(msg.infos) or {}
end

function ScuffleModel:onDailyTaskInfoRes(msg, seasonId)
	local taskList = GameUtil.pbToTable(msg.tasks)

	table.clear(self._dailyTaskRewardList)

	for i, v in ipairs(taskList) do
		local cfg = ScuffleConfig.instance:getTaskCfg(seasonId, v.taskId)
		local isCanGet = cfg and v.progress >= cfg.progress

		v.sortIndex = v.prizeGained and 3 or isCanGet and 1 or 2

		table.insert(self._dailyTaskRewardList, v)
	end

	self:_updateTaskInfoSort(seasonId)
end

function ScuffleModel:onAchievePrizeInfoRes(msg)
	self._maxScore = msg.maxScore
	self._gainBit = msg.gainBit
end

function ScuffleModel:getMaxScore()
	return self._maxScore
end

function ScuffleModel:isAchievePrizeGet(id)
	return GameUtil.isBitOpenByDigit(self._gainBit, id)
end

function ScuffleModel:updateAchievePrizeGainBit(id)
	self._gainBit = GameUtil.setBitByDigit(self._gainBit, id, true)
end

function ScuffleModel:updateTaskInfoPrizeGained(taskId, seasonId)
	for i, v in ipairs(self._dailyTaskRewardList) do
		if v.taskId == taskId then
			v.prizeGained = true
			v.sortIndex = 3

			break
		end
	end

	self:_updateTaskInfoSort(seasonId)
end

function ScuffleModel:_updateTaskInfoSort(seasonId)
	table.sort(self._dailyTaskRewardList, function(a, b)
		return a.sortIndex < b.sortIndex
	end)
end

function ScuffleModel:getDailyTaskList()
	return self._dailyTaskRewardList
end

function ScuffleModel:getBattleRecordList()
	return self._battleRecordList
end

function ScuffleModel:getSeasonInfoList()
	return self._seasonInfoList
end

function ScuffleModel:getSingleBattleVideo()
	return self._singleBattleVideo
end

function ScuffleModel:getEnemyHeadInfo()
	return self._enemyPlayerInfo
end

function ScuffleModel:getEnemyName()
	if self._enemyPlayerInfo then
		return self._enemyPlayerInfo.userName
	else
		return ""
	end
end

function ScuffleModel:getEnemyAreaName()
	return self._enemyAreaName
end

function ScuffleModel:getEnemyScore()
	return self._enemyScore
end

function ScuffleModel:getEnemyRank()
	return self._enemyRank
end

function ScuffleModel:getResultState()
	return self._resultState
end

function ScuffleModel:getMyTeamId()
	return self._myTeamId or 0
end

function ScuffleModel:isNormalBattle()
	return self._resultState == 1
end

function ScuffleModel:getBattleResult()
	return self._battleResult
end

function ScuffleModel:resetDailyGainedScore()
	self._dailyGainedScore = 0
end

function ScuffleModel:getAreaName()
	return RoleModel.instance:getAreaName()
end

function ScuffleModel:isHaveOldScore()
	printInfo("test isHaveOldScore", self._oldScore)

	return self._oldScore >= 0
end

function ScuffleModel:getOldScore()
	return self._oldScore
end

function ScuffleModel:getOldScoreAndReset()
	self._oldScore = -1

	return self._oldScore
end

function ScuffleModel:getScore()
	return self._score
end

function ScuffleModel:getCoinToday()
	return self._dailyGainedScore
end

function ScuffleModel:getMyRank()
	if self._myRank == -1 then
		return "未上榜"
	else
		return self._myRank
	end
end

function ScuffleModel:getMyInitPets()
	return self._myInitPets
end

function ScuffleModel:getEnemyInitPets()
	return self._enemyInitPets
end

function ScuffleModel:getMyRandomPets()
	return self._myRandomPets
end

function ScuffleModel:getEnemyRandomPets()
	return self._enemyRandomPets
end

function ScuffleModel:getMyAllPets()
	local result = {}

	table.insertto(result, self._myFmtPetIds)

	return result
end

function ScuffleModel:getEnemyAllPets()
	local result = {}

	table.insertto(result, self._enemyFmtPetIds)

	return result
end

function ScuffleModel:getPoolPets()
	return self._poolPets
end

function ScuffleModel:isExistMyRandomPet(id)
	return TableUtil.isHad(self._myRandomPets, id)
end

function ScuffleModel:isExistEnemyRandomPet(id)
	return TableUtil.isHad(self._enemyRandomPets, id)
end

function ScuffleModel:isExistMyBanPet(id)
	return TableUtil.isHad(self._myBanPetIds, id)
end

function ScuffleModel:isExistEnemyBanPet(id)
	return TableUtil.isHad(self._enemyBanPetIds, id)
end

function ScuffleModel:isCanSelectBanPet()
	return self._isCanSelectBanPet
end

function ScuffleModel:setIsCanSelectBanPet(active)
	self._isCanSelectBanPet = active
end

function ScuffleModel:isMaxBanCount()
	return #self._selectBanPetList >= self._maxBanPetCount
end

function ScuffleModel:addPetToBanList(id)
	local success = true

	if #self._selectBanPetList >= self._maxBanPetCount then
		return not success
	else
		table.insert(self._selectBanPetList, id)

		return success
	end
end

function ScuffleModel:isSelectBanPet(id)
	return TableUtil.isHad(self._selectBanPetList, id)
end

function ScuffleModel:removePetFromBanList(id)
	table.removebyvalue(self._selectBanPetList, id)
end

function ScuffleModel:getMyBanList()
	return self._selectBanPetList or {}
end

function ScuffleModel:getMyBanPetCount()
	return (self._selectBanPetList or nil) and (#self._selectBanPetList or 0)
end

function ScuffleModel:getMaxBanPetCount()
	return self._maxBanPetCount
end

function ScuffleModel:getFormationCountDown()
	return checknumber(ScuffleConfig.instance:getCommonValueByKey("READY_TIME")) - 5
end

function ScuffleModel:getRankList()
	return self._rankList
end

function ScuffleModel:isHaveRedPoint()
	return RedPointModel.instance:isActive(RedPointModel.ID_SCUFFLE_TASK) or RedPointModel.instance:isActive(RedPointModel.ID_SCUFFLE_REWARD)
end

function ScuffleModel:isHaveTaskRed()
	return RedPointModel.instance:isActive(RedPointModel.ID_SCUFFLE_TASK)
end

function ScuffleModel:isHaveRewardRed()
	return RedPointModel.instance:isActive(RedPointModel.ID_SCUFFLE_REWARD)
end

function ScuffleModel:getRamdomBuffList()
	return self._randomBuffs or {}
end

function ScuffleModel:setSelectBuffId(buffId)
	self._selectBuffId = buffId
end

function ScuffleModel:getSelectBuffId()
	if checknumber(self._selectBuffId) == 0 then
		return (self._randomBuffs[1] or nil) and (self._randomBuffs[1] or 0)
	else
		return self._selectBuffId
	end
end

function ScuffleModel:getSelectBuffIdIndex()
	if checknumber(self._selectBuffId) == 0 then
		return 0
	else
		for i, v in ipairs(self._randomBuffs) do
			if v == self._selectBuffId then
				return i
			end
		end

		return 0
	end
end

function ScuffleModel:initFormation()
	printInfo("test initFormation")

	local list = {}
	local pos = {}

	for i = 1, 9 do
		pos[i] = list[i] or 0
	end

	local form = {
		formId = 10,
		pos = pos,
		extParams = {
			heroSkillId = 0
		}
	}

	self:setFormation(form)
end

function ScuffleModel:createPet(creepsId)
	if self._bagPetMoDic[creepsId] then
		return self._bagPetMoDic[creepsId]
	end

	local creepCfg = ScuffleConfig.instance:getSystemPetCfg(creepsId)

	if creepCfg then
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(creepCfg)

		local petMo = fPowerPet:toBaseBagPetMo()

		petMo.petId = creepsId
		petMo.rare = CharacterConfig.instance:getRareByAwakenLv(petMo.awakeLevel, petMo.raceId)
		self._bagPetMoDic[creepsId] = petMo

		return petMo
	else
		return nil
	end
end

function ScuffleModel:getPet(petId)
	return self:createPet(petId)
end

function ScuffleModel:setFormation(form)
	self._teamId = self._teamId or 1
	self._formation = self._formation or ScuffleFormationMO.New()

	self._formation:SetData(form)
end

function ScuffleModel:getFormation()
	return self._formation
end

function ScuffleModel:getCurFormationId()
	return self._formation:GetId()
end

function ScuffleModel:setTeamId(id)
	self._teamId = id
end

function ScuffleModel:getTeamId()
	return self._teamId
end

function ScuffleModel:getAllPets()
	local allPets = {}
	local petIds = self:getMyAllPets()

	if petIds then
		for i = 1, #petIds do
			local petId = petIds[i]

			allPets[#allPets + 1] = self:createPet(petId)
		end
	end

	return allPets
end

ScuffleModel.instance = ScuffleModel.New()

return ScuffleModel
