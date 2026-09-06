-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/data/MagicContestSubMo.lua

module("logic.extensions.magiccontest.data.MagicContestSubMo", package.seeall)

local MagicContestSubMo = class("MagicContestSubMo")

function MagicContestSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function MagicContestSubMo:_resetData()
	local actData = MagicContestConfig.instance:getActivityData(self._activityId)

	if actData then
		self._maxChallengeTimes = actData.dailyChallengeTimes or 0
	end

	self._termId = 0
	self._campId = 0
	self._level = 0
	self._todayChallengeTimes = 0
	self._campScores = {}
	self._typeInfos = {}
	self._defenseForms = {}
	self._lastTermWinCampId = -1
	self._matchPlayerId = 0
	self._matchPlayerView = nil
	self._myBanRaceIds = {}
	self._raceIdAndLeftHp = {}
	self._curSelectBuffs = {}
	self._maxBuffCount = 0
	self._rankInfoRes = nil
	self._battleResMsg = nil
end

function MagicContestSubMo:dispose()
	self:_resetData()
end

function MagicContestSubMo:handlePM_MagicContestGetInfoRes(msg)
	self._termId = msg.termId
	self._campId = msg.campId
	self._level = msg.level
	self._todayChallengeTimes = msg.todayChallengeTimes

	table.clear(self._campScores)

	for _, v in ipairs(msg.campScores) do
		self._campScores[v.campId] = v.score
	end

	table.clear(self._defenseForms)

	self._typeInfos = {}

	for _, v in ipairs(msg.typeInfos) do
		self._typeInfos[v.type] = v

		if v:HasField("defenseForm") then
			self._defenseForms[v.type] = v.defenseForm
		end
	end

	self._lastTermWinCampId = -1

	if msg:HasField("lastTermWinCampId") then
		self._lastTermWinCampId = msg.lastTermWinCampId
	end
end

function MagicContestSubMo:handlePM_MagicContestSetDefenseFormRes(msg)
	self._defenseForms[msg.type] = msg.form
end

function MagicContestSubMo:handlePM_MagicContestStartMatchRes(msg)
	self._matchPlayerId = msg.matchPlayerId
	self._matchPlayerView = nil

	if msg:HasField("matchPlayerView") then
		self._matchPlayerView = msg.matchPlayerView
	end

	MmUtil.fillTableByValues(self._myBanRaceIds, msg.myBanRaceIds, true)
	table.clear(self._raceIdAndLeftHp)

	for _, pairInt in ipairs(msg.raceIdAndLeftHp) do
		self._raceIdAndLeftHp[pairInt.left] = pairInt.right
	end

	self._curSelectBuffs[msg.type] = {}

	for i, v in ipairs(msg.curSelectBuffs) do
		self._curSelectBuffs[msg.type][v] = v
	end

	self._maxBuffCount = 0

	if msg:HasField("maxBuffCount") then
		self._maxBuffCount = msg.maxBuffCount
	end
end

function MagicContestSubMo:handlePM_MagicContestChallengeRes(msg)
	return
end

function MagicContestSubMo:handlePM_MagicContestSelectBuffRes(msg)
	self._curSelectBuffs[msg.type] = {}

	for i, v in ipairs(msg.buffIds) do
		self._curSelectBuffs[msg.type][v] = v
	end
end

function MagicContestSubMo:handlePM_MagicContestGetRankInfoRes(msg)
	self._rankInfoRes = msg
end

function MagicContestSubMo:handlePM_Notify_MagicContestChallengeResult(msg)
	self._battleResMsg = msg
end

function MagicContestSubMo:getTermId()
	return self._termId
end

function MagicContestSubMo:getCampId()
	return self._campId
end

function MagicContestSubMo:setCampId(campId)
	self._campId = campId
end

function MagicContestSubMo:getLevel()
	return self._level
end

function MagicContestSubMo:getTodayChallengeTimes()
	return self._todayChallengeTimes
end

function MagicContestSubMo:getMaxChallengeTimes()
	return self._maxChallengeTimes
end

function MagicContestSubMo:getLeftChallengeTimes()
	local cur = self:getTodayChallengeTimes()
	local max = self:getMaxChallengeTimes()

	return Mathf.Max(0, max - cur)
end

function MagicContestSubMo:getTodayWinCount(batType)
	local info = self:getTypeInfo(batType)

	return (info or nil) and (info.todayWinCount or 0)
end

function MagicContestSubMo:getTodayWinStreak(batType)
	local info = self:getTypeInfo(batType)

	return (info or nil) and (info.todayWinStreak or 0)
end

function MagicContestSubMo:isContinueWinStreak(batType)
	return self:getTodayWinStreak(batType) > 0
end

function MagicContestSubMo:getCampScores(campId)
	return self._campScores[campId] or 0
end

function MagicContestSubMo:getScorePair(batType)
	local info = self:getTypeInfo(batType)

	return (info or nil) and (info.score or 0)
end

function MagicContestSubMo:getTypeInfo(batType)
	return self._typeInfos[batType]
end

function MagicContestSubMo:getLastTermWinCampId()
	return self._lastTermWinCampId
end

function MagicContestSubMo:getDefenseForms(batType)
	return self._defenseForms[batType]
end

function MagicContestSubMo:getMatchPlayerId()
	return self._matchPlayerId
end

function MagicContestSubMo:getMatchPlayerView()
	return self._matchPlayerView
end

function MagicContestSubMo:isBanRace(raceId)
	return self._myBanRaceIds[raceId] ~= nil
end

function MagicContestSubMo:getRaceHp(raceId)
	return self._raceIdAndLeftHp[raceId] or 0
end

function MagicContestSubMo:getCurSelectBuffs(batType)
	return self._curSelectBuffs[batType] or {}
end

function MagicContestSubMo:getCurSelectBuffCount(batType)
	local buffs = self:getCurSelectBuffs(batType)

	return table.nums(buffs)
end

function MagicContestSubMo:isBuffSelected(batType, buffId)
	local buffs = self:getCurSelectBuffs(batType)

	return buffs[buffId] ~= nil
end

function MagicContestSubMo:getMaxBuffCount()
	return self._maxBuffCount
end

function MagicContestSubMo:getRankInfoRes()
	return self._rankInfoRes
end

function MagicContestSubMo:getBattleResMsg()
	return self._battleResMsg
end

return MagicContestSubMo
