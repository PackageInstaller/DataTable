-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/data/MagicSchoolPvPSubMo.lua

module("logic.extensions.magicschoolpvp.data.MagicSchoolPvPSubMo", package.seeall)

local MagicSchoolPvPSubMo = class("MagicSchoolPvPSubMo")

function MagicSchoolPvPSubMo:ctor(activityId)
	self._activityId = activityId
	self._groupIds = {}

	local campGroups = MagicSchoolPvpConfig.instance:getCommonDataValue("CAMP_ID_TO_GROUP_ID", false)

	if not string.nilorempty(campGroups) then
		local array = string.split(campGroups, ",")

		for k, v in pairs(array) do
			local infos = string.split(v, "_")
			local campId = checknumber(infos[1])

			self._groupIds[campId] = checknumber(infos[2])
		end
	end

	self._openTimeArrays = {}

	local openTimeStr = MagicSchoolPvpConfig.instance:getCommonDataValue("OPEN_TIME", false)

	if not string.nilorempty(openTimeStr) then
		local array = string.split(openTimeStr, ",")

		for i, v in ipairs(array) do
			local infos = string.split(v, "#")

			infos[1] = "0-0-0 " .. infos[1]
			infos[2] = "0-0-0 " .. infos[2]
			self._openTimeArrays[i] = infos
		end
	end

	local actData = MagicSchoolPvpConfig.instance:getActivityData(self._activityId)

	if actData then
		self._maxDailyTimes = actData.dailyTimes or 0
	end

	local bossDatas = MagicSchoolPvpConfig.instance:getBossDatas(self._activityId) or {}

	self._bossCount = #bossDatas
	self._isGaming = false
	self._isRuning = false
	self._dailyTimes = 0
	self._campId = 0
	self._bestScoreInfo = nil
	self._teamPlayers = {}
	self._bossExtMsgs = {}
	self._withBuffList = {}
	self._selectedBuffIds = {}
	self._selectBuffIdRecords = {}
	self._switchTimesRecords = {}
	self._gameEndRes = nil
	self._formationSimpleForm = nil
	self._formationSimpleFormBattle = nil
	self._periodSchedule = {}
	self._battleMsgs = {}
	self._damageInRounds = {}
end

function MagicSchoolPvPSubMo:dispose()
	return
end

function MagicSchoolPvPSubMo:handlePM_MSPvPInfoRes(msg)
	self._isGaming = msg.isGaming
	self._dailyTimes = msg.dailyTimes
	self._campId = msg.campId
	self._bestScoreInfo = msg:HasField("bestScore") and msg.bestScore or nil
end

function MagicSchoolPvPSubMo:handlePM_MSPvPGetPresetFormationRes(msg)
	self._formationSimpleForm = msg.simpleForm
end

function MagicSchoolPvPSubMo:handlePM_MSPvPSetPresetFormationRes(msg)
	self._formationSimpleForm = msg.simpleForm
end

function MagicSchoolPvPSubMo:handlePM_MSPvPAskSwitchRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_MSPvPAskHandleSwitchRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_MSPvPSetFormationRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_MSPvPSelectBuffRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_MSPvPChatRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_MSPvPRankInfoRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_NotifyMSPvPMatchStartRes(msg)
	self:_resetPeriodSchedule()
	self:setCurPeriodType(MagicSchoolPvPEnum.PeriodType_Match)

	self._isGaming = true
	self._isRuning = true
end

function MagicSchoolPvPSubMo:handlePM_NotifyMSPvPMatchOverTimeRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_NotifyMSPvPMatchFailRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_NotifyMSPvPGameStartRes(msg)
	self:setCurBossId(1)

	self._switchTimesRecords = {}
	self._selectBuffIdRecords = {}
	self._selectedBuffIds = {}
	self._formationSimpleFormBattle = nil

	self:setCurPeriodType(MagicSchoolPvPEnum.PeriodType_Ready)

	local startTime = checknumber(msg.startTime) / 1000

	self:setPeriodTimeStamp(MagicSchoolPvPEnum.PeriodType_Ready, startTime)
	self:setPeriodTimeStamp(MagicSchoolPvPEnum.PeriodType_Boss, startTime + self:getSwitchPlaceTime())

	self._teamPlayers = {}

	for _, team in ipairs(msg.teams) do
		self._teamPlayers[team.campId] = {}

		for _, player in ipairs(team.players) do
			self._teamPlayers[team.campId][player.bossId] = player
		end
	end

	self._bossExtMsgs = {}

	for _, v in ipairs(msg.bossExtMsgs) do
		self._bossExtMsgs[v.bossId] = v
	end

	self._damageInRounds = {}
end

function MagicSchoolPvPSubMo:handlePM_NotifyMSPvPAskSwitchPositionRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_NotifyMSPvPAskSwitchPositionResultRes(msg)
	if msg:HasField("team") then
		local team = msg.team

		self._teamPlayers[team.campId] = {}

		for _, player in ipairs(team.players) do
			self._teamPlayers[team.campId][player.bossId] = player
		end
	end

	local ask = msg.ask

	if msg.result == 1 then
		self._switchTimesRecords[ask.userId] = self._switchTimesRecords[ask.userId] or self._switchTimesRecords[ask.userId] + 1
	end
end

function MagicSchoolPvPSubMo:handlePM_NotifyMsPvPWatchBattleResultRes(msg)
	self:setCurPeriodType(MagicSchoolPvPEnum.PeriodType_Boss)
	self:setCurBossId(msg.bossId)

	local startTime = checknumber(msg.startTime) / 1000

	self:setBossRoundTimeStamp(msg.bossId, MagicSchoolPvPEnum.RoundType_Battle, startTime)
	self:setBossRoundTimeStamp(msg.bossId, MagicSchoolPvPEnum.RoundType_Buff, startTime + self:getBattleTime())

	local myCampId = self:getCampId()

	if myCampId == MagicSchoolPvPEnum.CampId_Black then
		if not MagicSchoolPvPEnum.CampId_White then
			local opCampId = MagicSchoolPvPEnum.CampId_Black

			self._damageInRounds[msg.bossId] = {}
			self._damageInRounds[msg.bossId][myCampId] = msg.damage
			self._damageInRounds[msg.bossId][opCampId] = msg.opDamage
			self._battleMsgs[msg.bossId] = msg

			table.clear(self._withBuffList)
			table.insertto(self._withBuffList, msg.buffIds)
			table.clear(self._selectedBuffIds)
			table.insertto(self._selectedBuffIds, msg.selectedBuffIds)
		end
	end
end

function MagicSchoolPvPSubMo:handlePM_NotifyMsPvPStartSelectBuffRes(msg)
	local bossId = self:getCurBossId()
	local nextBossId = bossId + 1
	local startTime = checknumber(msg.startTime) / 1000

	self:setBossRoundTimeStamp(nextBossId, MagicSchoolPvPEnum.RoundType_Battle, startTime + self:getSelectBuffTime())
end

function MagicSchoolPvPSubMo:handlePM_NotifyMsPvPFinishSelectBuffRes(msg)
	self._selectBuffIdRecords[msg.bossId] = msg.buffId
end

function MagicSchoolPvPSubMo:handlePM_NotifyMsPvPGameEndRes(msg)
	self:setCurPeriodType(MagicSchoolPvPEnum.PeriodType_End)
	self:setPeriodTimeStamp(MagicSchoolPvPEnum.PeriodType_End, ServerTime.now())

	self._gameEndRes = msg
end

function MagicSchoolPvPSubMo:handlePM_NotifyMsPvPErrorRes(msg)
	return
end

function MagicSchoolPvPSubMo:handlePM_NotifyMsPvPChatRes(msg)
	return
end

function MagicSchoolPvPSubMo:getOpenTimeArrays()
	return self._openTimeArrays
end

function MagicSchoolPvPSubMo:isInOpenTimeArrays()
	local result = false

	for _, info in ipairs(self._openTimeArrays) do
		if GameUtil.checkIsInTimePeriod(info[1], info[2]) then
			result = true

			break
		end
	end

	return result
end

function MagicSchoolPvPSubMo:getTeamMemberNum()
	return MagicSchoolPvpConfig.instance:getCommonDataValue("TEAM_MEMBER_NUM", true)
end

function MagicSchoolPvPSubMo:getMatchTime()
	return MagicSchoolPvpConfig.instance:getCommonDataValue("MATCH_TIME", true)
end

function MagicSchoolPvPSubMo:getSwitchPlaceTime()
	return MagicSchoolPvpConfig.instance:getCommonDataValue("SWITCH_PLACE_TIME", true)
end

function MagicSchoolPvPSubMo:getSwitchReqWaitTime()
	return MagicSchoolPvpConfig.instance:getCommonDataValue("SWITCH_REQ_WAIT_TIME", true)
end

function MagicSchoolPvPSubMo:getBattleTime()
	return MagicSchoolPvpConfig.instance:getCommonDataValue("BATTLE_TIME", true)
end

function MagicSchoolPvPSubMo:getSelectBuffTime()
	return MagicSchoolPvpConfig.instance:getCommonDataValue("SELECT_BUFF_TIME", true)
end

function MagicSchoolPvPSubMo:getGroupId(campId)
	return (self._groupIds or nil) and (self._groupIds[campId] or 0)
end

function MagicSchoolPvPSubMo:getCurGroupId()
	local campId = self:getCampId()

	return self:getGroupId(campId)
end

function MagicSchoolPvPSubMo:getBossCount()
	return self._bossCount
end

function MagicSchoolPvPSubMo:getCurDailyTimes()
	return self._dailyTimes
end

function MagicSchoolPvPSubMo:getMaxDailyTimes()
	return self._maxDailyTimes
end

function MagicSchoolPvPSubMo:isEnoughDailyTimes()
	return self._dailyTimes < self._maxDailyTimes
end

function MagicSchoolPvPSubMo:getCampId()
	return self._campId
end

function MagicSchoolPvPSubMo:isGameing()
	return self._isGaming
end

function MagicSchoolPvPSubMo:setIsGameing(isGaming)
	self._isGaming = isGaming
end

function MagicSchoolPvPSubMo:isRuning()
	return self._isRuning
end

function MagicSchoolPvPSubMo:setIsRuning(isRuning)
	self._isRuning = isRuning
end

function MagicSchoolPvPSubMo:getBestScoreInfo()
	return self._bestScoreInfo
end

function MagicSchoolPvPSubMo:getFormationSimpleForm()
	return self._formationSimpleForm
end

function MagicSchoolPvPSubMo:isEmptyFormationSimpleForm()
	if self._formationSimpleForm then
		local result = true

		for _, petId in ipairs(self._formationSimpleForm.pos) do
			if petId > 0 then
				result = false

				break
			end
		end

		return result
	else
		return true
	end
end

function MagicSchoolPvPSubMo:getFormationSimpleFormBattle()
	return self._formationSimpleFormBattle
end

function MagicSchoolPvPSubMo:setFormationSimpleFormBattle(simpleForm)
	self._formationSimpleFormBattle = simpleForm
end

function MagicSchoolPvPSubMo:_resetPeriodSchedule()
	self._periodSchedule = {}
	self._periodSchedule[MagicSchoolPvPEnum.PeriodType_Match] = 0
	self._periodSchedule[MagicSchoolPvPEnum.PeriodType_Ready] = 0
	self._periodSchedule[MagicSchoolPvPEnum.PeriodType_Boss] = 0
	self._periodSchedule[MagicSchoolPvPEnum.PeriodType_End] = 0
	self._bossRounds = {}

	local bossCount = self:getBossCount()

	for bossId = 1, bossCount do
		self._bossRounds[bossId] = {}
		self._bossRounds[bossId][MagicSchoolPvPEnum.RoundType_Battle] = 0
		self._bossRounds[bossId][MagicSchoolPvPEnum.RoundType_Buff] = 0
	end

	self._battleMsgs = {}
end

function MagicSchoolPvPSubMo:getCurPeriodType()
	return self._curPeriodType
end

function MagicSchoolPvPSubMo:setCurPeriodType(periodType)
	self._curPeriodType = periodType
end

function MagicSchoolPvPSubMo:getPeriodTimeStamp(periodType)
	return self._periodSchedule[periodType] or 0
end

function MagicSchoolPvPSubMo:setPeriodTimeStamp(periodType, timeStamp)
	self._periodSchedule[periodType] = timeStamp
end

function MagicSchoolPvPSubMo:getCurBossId()
	return self._curBossId
end

function MagicSchoolPvPSubMo:setCurBossId(bossId)
	self._curBossId = bossId
end

function MagicSchoolPvPSubMo:getBossRoundTimeStamp(bossId, roundType)
	return (self._bossRounds[bossId] or nil) and (self._bossRounds[bossId][roundType] or 0)
end

function MagicSchoolPvPSubMo:setBossRoundTimeStamp(bossId, roundType, timeStamp)
	self._bossRounds[bossId][roundType] = timeStamp
end

function MagicSchoolPvPSubMo:getTeamPlayer(campId, bossId)
	local list = self:getTeamPlayerList(campId)

	return list[bossId]
end

function MagicSchoolPvPSubMo:getTeamPlayerList(campId)
	return self._teamPlayers[campId] or {}
end

function MagicSchoolPvPSubMo:getBossExtMsg(bossId)
	return self._bossExtMsgs[bossId]
end

function MagicSchoolPvPSubMo:isCanSwitchWitTimes()
	local userId = RoleModel.instance:getUserId()
	local times = self:getSwitchTimes(userId)

	return times < MagicSchoolPvPEnum.MaxSwitchPosTimes
end

function MagicSchoolPvPSubMo:getSwitchTimes(userId)
	return self._switchTimesRecords[userId] or 0
end

function MagicSchoolPvPSubMo:getWithBuffList()
	return self._withBuffList
end

function MagicSchoolPvPSubMo:getSelectedBuffIds()
	return self._selectedBuffIds
end

function MagicSchoolPvPSubMo:getSelectBuffIdRecord(bossId)
	return self._selectBuffIdRecords[bossId] or 0
end

function MagicSchoolPvPSubMo:getDamageInRounds(bossId, campId)
	return (self._damageInRounds[bossId] or nil) and (self._damageInRounds[bossId][campId] or 0)
end

function MagicSchoolPvPSubMo:getBattleMsg(bossId)
	return self._battleMsgs[bossId]
end

function MagicSchoolPvPSubMo:getGameEndRes()
	return self._gameEndRes
end

return MagicSchoolPvPSubMo
