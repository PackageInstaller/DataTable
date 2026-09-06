-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/model/GuardCiytModel.lua

module("logic.extensions.guardcity.model.GuardCiytModel", package.seeall)

local GuardCiytModel = class("GuardCiytModel", BaseModel)

GuardCiytModel.ReadFlag = "GuardCiytModel.ReadFlag"

function GuardCiytModel:ctor()
	self:onReset()
end

function GuardCiytModel:onInit()
	self:onReset()
end

function GuardCiytModel:onReset()
	self._activityId = nil
	self._isInit = false
	self._prePathData = nil
	self._preMasterList = nil
	self._readyAttack = nil
	self._pathData = nil
	self._masterList = nil
	self._readyAttack = nil
	self._helpInfos = nil
	self._rewardScoreInfos = nil
	self._reportInfos = nil
	self._friendScoreInfo = nil
	self._rankInfos = nil
	self._fmtMo = nil
end

function GuardCiytModel:saveGameInfo(msg)
	self._gameInfo = GameUtil.pbToTable(msg)
	self._preMyCityHp = checknumber(self._myCityHp)
	self._myCityHp = checknumber(self._gameInfo.cityHp)
	self._abilityLv = checknumber(self._gameInfo.abilityLv)
	self._dailyRefreshTimes = checknumber(self._gameInfo.dailyRefreshTimes)
	self._curScore = checknumber(self._gameInfo.curScore)
	self._curStrength = checknumber(self._gameInfo.curStrength)
	self._nextIncStrengthSurplusTime = self._gameInfo.nextIncStrengthSurplusTime
	self._strengthStamp = checknumber(self._nextIncStrengthSurplusTime) == 0 and ServerTime.now() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) or ServerTime.now() + checknumber(self._nextIncStrengthSurplusTime) - GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true)
	self._buyStrengthTimesToday = self._gameInfo.buyStrengthTimesToday
	self._privilegeBuyTimesToday = self._gameInfo.privilegeBuyTimesToday

	self:setPathInfo(self._gameInfo.pathInfos)

	self._isInit = true
end

function GuardCiytModel:setPathInfo(pathInfos)
	self._prePathData = self._pathData
	self._preMasterList = self._masterList
	self._preMasterCount = checknumber(self._masterCount)
	self._preReadyAttack = self._readyAttack
	self._pathData = {}
	self._masterList = {}
	self._readyAttack = {}
	self._masterCount = 0

	for i, pathInfo in ipairs(pathInfos) do
		self._pathData[pathInfo.pathId] = self._pathData[pathInfo.pathId] or {}

		if pathInfo.masterInfos then
			for j, masterInfo in ipairs(pathInfo.masterInfos) do
				masterInfo.enemyStage = {}
				masterInfo.hadAttack = false

				for i, v in ipairs(masterInfo.creepsInfos or {}) do
					masterInfo.enemyStage[v.creepsId] = v.curHpRatio
					masterInfo.hadAttack = true
				end

				masterInfo.pathId = pathInfo.pathId
				self._masterCount = self._masterCount + 1
				self._masterList[masterInfo.masterUniqueId] = masterInfo
				self._pathData[pathInfo.pathId][masterInfo.pos] = masterInfo

				if masterInfo.pos == 1 then
					table.insert(self._readyAttack, masterInfo)
				end
			end
		end
	end
end

function GuardCiytModel:setRefreshInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self:setPathInfo(info.pathInfos)

	self._myCityHp = info.cityHp
	self._dailyRefreshTimes = info.dailyRefreshTimes
end

function GuardCiytModel:setRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._myRank = checknumber(info.myRank)
	self._rankInfos = info.rankInfos or {}
end

function GuardCiytModel:setFriendScoreInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._friendScoreInfo = info.friendInfos or {}

	if #self._friendScoreInfo > 0 then
		table.sort(self._friendScoreInfo, function(a, b)
			return a.score > b.score
		end)

		self._haveFriendScorePrize = false

		local havePrizeRank = GuardCityConfig.instance:getCommonValue("INHERIT_FRIEND_RANK", true)

		for i, v in ipairs(self._friendScoreInfo) do
			v.rank = i

			if not v.gain and havePrizeRank >= v.rank then
				self._haveFriendScorePrize = true
			end
		end
	end
end

function GuardCiytModel:setReportInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._reportInfos = info.reportInfos or {}

	for i, reportInfo in ipairs(self._reportInfos) do
		table.sort(reportInfo.reportPlayerInfos, function(a, b)
			return a.damage > b.damage
		end)

		for j, playerInfo in ipairs(reportInfo.reportPlayerInfos) do
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

function GuardCiytModel:setRewardScoreInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rewardScoreInfos = info.prizeInfos
end

function GuardCiytModel:setHelpInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._helpInfos = info.seekHelpInfos or {}

	for i, v in ipairs(self._helpInfos) do
		v.masterInfo.enemyStage = {}

		for j, creepInfo in ipairs(v.masterInfo.creepsInfos or {}) do
			v.masterInfo.enemyStage[creepInfo.creepsId] = creepInfo.curHpRatio
		end
	end
end

function GuardCiytModel:setBossInfoFormStart(info)
	self._battleBossInfo = {}
	self._battleBossInfo.isMyBoss = info.isMyBoss
	self._battleBossInfo.activityId = info.activityId
	self._battleBossInfo.readyAttack = info.attackId
end

function GuardCiytModel:setBossInfo(msg)
	self._battleBossInfo = self._battleBossInfo or {}
	self._battleBossInfo.maxHp = msg.totalHp
	self._battleBossInfo.curHp = msg.surplusHp
	self._battleBossInfo.changeSetId = msg.changeSetId

	if self._battleBossInfo.curHp == 0 then
		self._battleBossInfo.isKillBoss = true
	end
end

function GuardCiytModel:setBuyStrengeInfo(msg)
	local info = GameUtil.pbToTable(msg) or {}

	self._curStrength = msg.curStrength
	self._buyStrengthTimesToday = self._buyStrengthTimesToday + 1
end

function GuardCiytModel:getEnemyHave(gridId)
	local acticityCfg = GuardCityConfig.instance:getActivityCfg(self:getCurActId())
	local pathInfo = GuardCityConfig.instance:getPathPosByGrid(acticityCfg.pathPlanId, gridId)

	if pathInfo and self._pathData[pathInfo.path] then
		return self._pathData[pathInfo.path][pathInfo.posId]
	else
		return nil
	end

	return nil
end

function GuardCiytModel:getEnemyInfo(gridId)
	local acticityCfg = GuardCityConfig.instance:getActivityCfg(self:getCurActId())
	local pathInfo = GuardCityConfig.instance:getPathPosByGrid(acticityCfg.pathPlanId, gridId)

	if pathInfo and self._pathData and self._pathData[pathInfo.path] then
		return self._pathData[pathInfo.path][pathInfo.posId]
	else
		return nil
	end

	return nil
end

function GuardCiytModel:getPreEnemyInfo(gridId)
	local acticityCfg = GuardCityConfig.instance:getActivityCfg(self:getCurActId())
	local pathInfo = GuardCityConfig.instance:getPathPosByGrid(acticityCfg.pathPlanId, gridId)

	if pathInfo and self._prePathData and self._prePathData[pathInfo.pathId] then
		return self._prePathData[pathInfo.pathId][pathInfo.posId]
	else
		return nil
	end

	return nil
end

function GuardCiytModel:getCurActId()
	if not self._activityId then
		local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.GUARD_CITY)

		if not cfgs then
			printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.GUARD_CITY)

			return false
		end

		for i, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GUARD_CITY, v.activityId) then
				local cfg = GuardCityConfig.instance:getActivityCfg(v.activityId)

				if cfg then
					self._activityId = cfg.activityId

					break
				end

				printError("====t_liu_dao_activity no cfg, id = " .. v, activityId)

				break
			end
		end
	end

	return self._activityId
end

function GuardCiytModel:getCurCityHp()
	return self._myCityHp
end

function GuardCiytModel:getMasterCount()
	return self._masterCount
end

function GuardCiytModel:getRankInfos()
	return self._rankInfos or {}
end

function GuardCiytModel:getMyRank()
	return checknumber(self._myRank)
end

function GuardCiytModel:getFriendScoreList()
	return self._friendScoreInfo or {}
end

function GuardCiytModel:haveFriendScorePrize()
	return self._haveFriendScorePrize
end

function GuardCiytModel:getReportInfo()
	return self._reportInfos or {}
end

function GuardCiytModel:getRewardScoreInfo()
	return self._rewardScoreInfos or {}
end

function GuardCiytModel:getMasterInfo(masterUniqueId)
	return self._masterList[masterUniqueId]
end

function GuardCiytModel:getAllMasterInfo()
	return self._masterList
end

function GuardCiytModel:getReadyAttack()
	return self._readyAttack
end

function GuardCiytModel:getGameInfos()
	return self._gameInfo
end

function GuardCiytModel:getPreData()
	local var_33_0 = {
		pathInfo = self._prePathData,
		masterInfo = self._preMasterList,
		cityHp = self._preMyCityHp,
		masterCount = self._preMasterCount
	}

	var_33_0.readyAttack = self._preReadyAttack or {}

	return var_33_0
end

function GuardCiytModel:getHelpInfo()
	return self._helpInfos or {}
end

function GuardCiytModel:GetBattleBossInfo()
	return self._battleBossInfo or {}
end

function GuardCiytModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = GuardCityFmtMo.New()
	end

	return self._fmtMo
end

function GuardCiytModel:getRefreshTimes()
	return self._dailyRefreshTimes
end

function GuardCiytModel:getCurScore()
	return self._curScore
end

function GuardCiytModel:getCurStrength()
	return checknumber(self._curStrength)
end

function GuardCiytModel:onClockStrengthChange()
	self._curStrength = checknumber(self._curStrength) + 1
	self._strengthStamp = ServerTime.now()
end

function GuardCiytModel:getStrengthStamp()
	return checknumber(self._strengthStamp)
end

function GuardCiytModel:getBuyStrengthTimesToday()
	return self._buyStrengthTimesToday
end

function GuardCiytModel:getPrivilegeBuyTimesToday()
	return self._privilegeBuyTimesToday
end

function GuardCiytModel:saveOpenRuleFlag()
	GameUtil.saveUserData(GuardCiytModel.ReadFlag, true)
end

function GuardCiytModel:getOpenRuleFlage()
	return GameUtil.getUserData(GuardCiytModel.ReadFlag)
end

GuardCiytModel.instance = GuardCiytModel.New()

return GuardCiytModel
