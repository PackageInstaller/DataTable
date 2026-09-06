-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/model/DestroyEvilModel.lua

module("logic.extensions.destroyevil.model.DestroyEvilModel", package.seeall)

local DestroyEvilModel = class("DestroyEvilModel", BaseModel)

DestroyEvilModel.ShowFriendMonsterCount = 2
DestroyEvilModel.ChallengeMode_Nomal = 1
DestroyEvilModel.ChallengeMode_Powerful = 2
DestroyEvilModel.SelectTicketIdKey = "destroyevil_selectticketId"
DestroyEvilModel.OpenAutoCostTicketKey = "destroyevil_autocostticket"
DestroyEvilModel.Key_OpenBoss = "destroyevil_openboss"

function DestroyEvilModel:ctor()
	return
end

function DestroyEvilModel:onInit()
	self:onReset()
end

function DestroyEvilModel:onReset()
	self._activityId = 0
	self._monsterId = 0
	self._monsterTotalHp = 0
	self._monsterLeftHp = 0
	self._monsterUniqueId = 0
	self._seekHelpList = {}
	self._buyTicketTimes = 0
	self._strength = 0
	self._nextHpLeftTime = 0
	self._todayBuyStrengthTimes = 0
	self._buddyHelpCount = 0
	self._selfFight = false
	self._isCanHelp = false
	self._todayHelpTimes = 0
	self._todayNoPaidHelpTimes = 0
	self._reportList = {}
	self._buddyIds = {}
	self._buddyInfoList = {}
	self._rankInfoList = {}
	self._myRank = -1
	self._recommendList = {}
	self._tempBattleResult = {}
	self._battleResult = nil
	self._haveFriendScorePrize = false
	self.lastIsRecommend = false
	self._fmtMo = nil
end

function DestroyEvilModel:getActivityId()
	if self._activityId > 0 then
		return self._activityId
	else
		local cfgActivity = ActivityDefineController.instance:getActivityCfgByType(self:getActivityType())

		if cfgActivity then
			self._activityId = cfgActivity.activityId or 322001
		end

		return self._activityId
	end
end

function DestroyEvilModel:getActivityType()
	return GameEnum.ActivityType.DestroyEvil
end

function DestroyEvilModel:getTimeGap()
	local cfgActivity = DestroyEvilConfig.instance:getActivityCfg(self:getActivityId())

	return cfgActivity and cfgActivity.timeGap
end

function DestroyEvilModel:getInheritBuddyRank()
	local cfgActivity = DestroyEvilConfig.instance:getActivityCfg(self:getActivityId())

	return cfgActivity and cfgActivity.inheritBuddyRank
end

function DestroyEvilModel:onDestroyEvilGetInfoRes(msg)
	self:_initMonsterInfoField(msg.monsterInfo)

	self._seekHelpList = GameUtil.pbToTable(msg.seekHelpList) or {}
	self._buyTicketTimes = msg.buyTicketTimes
	self._strength = msg.strength
	self._nextHpLeftTime = msg.nextHpLeftTime
	self._todayBuyStrengthTimes = msg.todayBuyStrengthTimes
	self._todayHelpTimes = msg.todayHelpTimes
	self._todayNoPaidHelpTimes = msg.todayNoPaidHelpTimes
	self._todayHelpTimes = msg.todayHelpTimes
	self._todayNoPaidHelpTimes = msg.todayNoPaidHelpTimes
	self._todayResetDifficultyTimes = msg.todayResetDifficultyTimes
	self._difficultyStar = msg.difficultyStar
end

function DestroyEvilModel:_initMonsterInfoField(monsterInfo)
	self._monsterId = monsterInfo.monsterId
	self._monsterTotalHp = checknumber(monsterInfo.monsterTotalHp)
	self._monsterLeftHp = checknumber(monsterInfo.monsterLeftHp)
	self._monsterUniqueId = monsterInfo.monsterUniqueId
	self._buddyHelpCount = monsterInfo.buddyHelpCount
	self._selfFight = monsterInfo.selfFight
	self._isCanHelp = monsterInfo.isCanHelp
	self._autoPublicTimeMillis = monsterInfo.autoPublicTimeMillis
end

function DestroyEvilModel:onDestroyEvilChallengeRes(msg)
	local userId = RoleModel.instance:getUserId()

	if userId == msg.targetPlayerId then
		self._monsterId = msg.monsterId
		self._monsterTotalHp = checknumber(msg.monsterTotalHp)
		self._monsterLeftHp = checknumber(msg.monsterLeftHp)
		self._monsterUniqueId = msg.monsterUniqueId
		self._strength = msg.strength
		self._nextHpLeftTime = msg.nextHpLeftTime
		self._selfFight = true
	else
		for i, v in ipairs(self._seekHelpList) do
			if v.monster.headInfo.userId == msg.targetPlayerId then
				v.monster.monsterId = msg.monsterId
				v.monster.monsterTotalHp = checknumber(msg.monsterTotalHp)
				v.monster.monsterLeftHp = checknumber(msg.monsterLeftHp)
				v.monster.monsterUniqueId = msg.monsterUniqueId
				v.monster.everFight = msg.everFight
			end
		end
	end

	self._tempBattleResult.actId = msg.actId
	self._tempBattleResult.targetPlayerId = msg.targetPlayerId
	self._tempBattleResult.monsterId = msg.monsterId
	self._tempBattleResult.monsterTotalHp = checknumber(msg.monsterTotalHp)
	self._tempBattleResult.monsterLeftHp = checknumber(msg.monsterLeftHp)
	self._tempBattleResult.monsterUniqueId = msg.monsterUniqueId
	self._tempBattleResult.strength = msg.strength
	self._tempBattleResult.nextHpLeftTime = msg.nextHpLeftTime
	self._tempBattleResult.changeSetId = msg.changeSetId
	self._tempBattleResult.isMyBoss = msg.targetPlayerId == userId
	self._battleResult = msg.battleResult
end

function DestroyEvilModel:onDestroyEvilRefreshMonsterRes(msg)
	self._monsterId = msg.monsterId
	self._monsterTotalHp = checknumber(msg.monsterTotalHp)
	self._monsterLeftHp = checknumber(msg.monsterLeftHp)
	self._monsterUniqueId = msg.monsterUniqueId
	self._buddyHelpCount = msg.buddyHelpCount
	self._selfFight = msg.selfFight
	self._isCanHelp = msg.isCanHelp
end

function DestroyEvilModel:onDestroyEvilGetReportInfoRes(msg)
	self._reportList = GameUtil.pbToTable(msg.reportList) or {}

	for i, reportInfo in ipairs(self._reportList) do
		table.sort(reportInfo.playerInfoList, function(a, b)
			return checknumber(a.damage) > checknumber(b.damage)
		end)

		for j, playerInfo in ipairs(reportInfo.playerInfoList) do
			playerInfo.rank = j

			if checknumber(playerInfo.headInfo.userId) == checknumber(reportInfo.mvpPlayerId) then
				reportInfo.mvpPlayerInfo = playerInfo
			end

			if checknumber(playerInfo.headInfo.userId) == checknumber(reportInfo.defeatPlayerId) then
				reportInfo.defeatPlayer = playerInfo
			end
		end
	end
end

function DestroyEvilModel:onDestroyEvilConveneBuddyRes(buddyIds)
	self._buddyIds = buddyIds
end

function DestroyEvilModel:onDestroyEvilViewBuddyScoreRes(msg)
	self._buddyInfoList = GameUtil.pbToTable(msg.buddyInfoList) or {}

	if #self._buddyInfoList > 0 then
		table.sort(self._buddyInfoList, function(a, b)
			return a.score > b.score
		end)

		self._haveFriendScorePrize = false

		local havePrizeRank = self:getInheritBuddyRank()

		for i, v in ipairs(self._buddyInfoList) do
			v.rank = i

			if not v.gain and havePrizeRank >= v.rank then
				self._haveFriendScorePrize = true
			end
		end
	end
end

function DestroyEvilModel:onDestroyEvilGainBuddyPrizeRes(msg)
	for _, id in ipairs(msg.buddyIds) do
		for _, buddyInfo in ipairs(self._buddyInfoList) do
			if buddyInfo.headInfo.userId == id then
				buddyInfo.gain = true

				break
			end
		end
	end
end

function DestroyEvilModel:onDestroyEvilViewRankRes(msg)
	self._rankInfoList = GameUtil.pbToTable(msg.rankInfoList) or {}
	self._myRank = msg.myRank
	self._myHelpCount = msg.myHelpCount
	self._myHelpTotalDamage = msg.myHelpTotalDamage
end

function DestroyEvilModel:onDestroyEvilBuyTicketRes(msg)
	return
end

function DestroyEvilModel:onDestroyEvilGetRecommendListRes(msg)
	self._recommendList = GameUtil.pbToTable(msg.recommendList) or {}
end

function DestroyEvilModel:onDestroyEvilSetPublicBossRes(msg)
	self._autoPublicTimeMillis = -1
	self._isCanHelp = true
end

function DestroyEvilModel:onDestroyEvilBuyStrengthRes(msg)
	self._strength = msg.strength
	self._nextHpLeftTime = msg.nextHpLeftTime
	self._todayBuyStrengthTimes = msg.todayBuyStrengthTimes
end

function DestroyEvilModel:getRankInfos()
	return self._rankInfoList
end

function DestroyEvilModel:getMyRank()
	return checknumber(self._myRank)
end

function DestroyEvilModel:getFriendScoreList()
	return self._buddyInfoList or {}
end

function DestroyEvilModel:haveFriendScorePrize()
	return self._haveFriendScorePrize
end

function DestroyEvilModel:getReportInfo()
	return self._reportList
end

function DestroyEvilModel:getHelpInfo()
	return self._seekHelpList or {}
end

function DestroyEvilModel:GetBattleBossInfo()
	return self._tempBattleResult
end

function DestroyEvilModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = DestroyEvilCustomFmtMo.New()
	end

	return self._fmtMo
end

function DestroyEvilModel:getCurStrength()
	return checknumber(self._strength)
end

function DestroyEvilModel:getStrengthStamp()
	return checknumber(self._strengthStamp)
end

function DestroyEvilModel:getBuyStrengthTimesToday()
	return self._todayBuyStrengthTimes
end

function DestroyEvilModel:getAvailableSeekHelpList()
	local list = {}
	local curTimestamp = ServerTime.now()

	for i, v in ipairs(self._seekHelpList) do
		if #list < DestroyEvilModel.ShowFriendMonsterCount then
			local endTimestamp = checknumber(v.deadLine) / 1000

			if curTimestamp < endTimestamp then
				table.insert(list, v)
			end
		end
	end

	return list
end

function DestroyEvilModel:getMonsterId()
	return self._monsterId
end

function DestroyEvilModel:getMonsterUniqueId()
	return self._monsterUniqueId
end

function DestroyEvilModel:getMonsterTotalHp()
	return self._monsterTotalHp
end

function DestroyEvilModel:getMonsterLeftHp()
	return self._monsterLeftHp
end

function DestroyEvilModel:getBuddyHelpCount()
	return self._buddyHelpCount
end

function DestroyEvilModel:isFightedSelfBoss()
	return self._selfFight
end

function DestroyEvilModel:isDefeatBoss()
	return self._monsterLeftHp == 0
end

function DestroyEvilModel:getBattleResult()
	return self._battleResult
end

function DestroyEvilModel:getRecommendList()
	return self._recommendList
end

function DestroyEvilModel:isFixedPublicBoss(activityId)
	local cfg = DestroyEvilConfig.instance:getActivityCfg(activityId)

	if cfg then
		if self._monsterId > 0 and not self:isDefeatBoss() and (checknumber(self._autoPublicTimeMillis) == -1 or checknumber(self._autoPublicTimeMillis) <= ServerTime.nowMs()) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function DestroyEvilModel:getTodayHelpTimes()
	return self._todayHelpTimes
end

function DestroyEvilModel:getTodayNoPaidHelpTimes()
	return self._todayNoPaidHelpTimes
end

function DestroyEvilModel:isPublicBoss()
	return self._isCanHelp
end

function DestroyEvilModel:getDifficultyStar()
	return self._difficultyStar
end

function DestroyEvilModel:onSelectDifficulty(msg)
	self._difficultyStar = msg.difficultyStar
	self._todayResetDifficultyTimes = msg.todayResetDifficultyTimes

	if msg:HasField("myMonsterInfo") then
		self:_initMonsterInfoField(msg.myMonsterInfo)
	end
end

function DestroyEvilModel:getAutoPublicTimeMillis()
	return checknumber(self._autoPublicTimeMillis)
end

function DestroyEvilModel:getTodayResetDifficultyTimes()
	return self._todayResetDifficultyTimes
end

DestroyEvilModel.instance = DestroyEvilModel.New()

return DestroyEvilModel
