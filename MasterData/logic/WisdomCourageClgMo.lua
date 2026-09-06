-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/data/WisdomCourageClgMo.lua

module("logic.extensions.wisdomcourageclg.data.WisdomCourageClgMo", package.seeall)

local WisdomCourageClgMo = class("WisdomCourageClgMo")

function WisdomCourageClgMo:ctor(activityId)
	self._activityId = activityId

	local actData = WisdomCourageClgConfig.instance:getActData(self._activityId)

	if actData then
		self._maxDailyTimes = actData.dailyBossTimes or 0
	end

	self._bossInfos = {}
	self._gainedWisdomPrizeIds = {}
	self._curStageId = 0
	self._historyStageId = 0
	self._maxStageId = WisdomCourageClgConfig.instance:getSupportMaxStageCount(activityId)
	self._supportPetNum = 0
	self._changeSetIdInSupport = nil
	self._bossClgFinishResMsg = nil
	self._supportClgFinishResMsg = nil
end

function WisdomCourageClgMo:dispose()
	return
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgBossInfoRes(msg)
	for i, v in ipairs(msg.boss) do
		self._bossInfos[v.bossId] = v
	end

	table.clear(self._gainedWisdomPrizeIds)
	table.insertto(self._gainedWisdomPrizeIds, msg.gainedWisdomPrizeIds)
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgBossChallengeRes(msg)
	return
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgBossRankInfoRes(msg)
	return
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgSupportInfoRes(msg)
	self._curStageId = msg.stageId
	self._historyStageId = msg.historyStageId
	self._supportPetNum = msg.supportPetNum
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgSupportChallengeRes(msg)
	return
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgSupportConfirmRes(msg)
	if msg:HasField("stageId") then
		self._curStageId = msg.stageId
		self._historyStageId = Mathf.Max(self._historyStageId, self._curStageId)
	end

	if msg:HasField("supportPetNum") then
		self._supportPetNum = msg.supportPetNum
	end

	if msg:HasField("changeSetId") then
		self._changeSetIdInSupport = msg.changeSetId
	end
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgSupportResetRes(status, msg)
	self._curStageId = 0
end

function WisdomCourageClgMo:handlePM_WisdomCourageClgSupportRankInfoRes(msg)
	return
end

function WisdomCourageClgMo:handlePM_NotifyWisdomCourageClgBossChallengeFinishRes(msg)
	self._bossClgFinishResMsg = msg
end

function WisdomCourageClgMo:handlePM_NotifyWisdomCourageClgSupportChallengeFinishRes(msg)
	self._supportClgFinishResMsg = msg
end

function WisdomCourageClgMo:getLeftDailyTimes(bossId)
	local max = self:getMaxDailyTimes()
	local cur = self:getCurDailyTimes(bossId)

	return Mathf.Max(0, max - cur)
end

function WisdomCourageClgMo:getCurDailyTimes(bossId)
	local info = self:getBossInfo(bossId)

	return checknumber(info and info.dailyTimes)
end

function WisdomCourageClgMo:getMaxDailyTimes()
	return self._maxDailyTimes
end

function WisdomCourageClgMo:getTodayMaxDamage(bossId)
	local info = self:getBossInfo(bossId)

	return checknumber(info and info.todayMaxDamage)
end

function WisdomCourageClgMo:getHistoryMaxDamage(bossId)
	local info = self:getBossInfo(bossId)

	return checknumber(info and info.historyMaxDamage)
end

function WisdomCourageClgMo:getBossInfo(bossId)
	return self._bossInfos[bossId]
end

function WisdomCourageClgMo:isHasGainPrizeInBoss(prizeId)
	return table.indexof(self._gainedWisdomPrizeIds, prizeId) ~= false
end

function WisdomCourageClgMo:getBossClgFinishResMsg()
	return self._bossClgFinishResMsg
end

function WisdomCourageClgMo:getCurStageIdInSupport()
	return self._curStageId
end

function WisdomCourageClgMo:getHistoryStageIdInSupport()
	return self._historyStageId
end

function WisdomCourageClgMo:getMaxStageIdInSupport()
	return self._maxStageId
end

function WisdomCourageClgMo:isPassStageInSupportCur(stageId)
	return stageId <= self._curStageId
end

function WisdomCourageClgMo:isPassAllStageInSupportCur()
	return self._curStageId >= self._maxStageId
end

function WisdomCourageClgMo:isPassStageInSupport(stageId)
	return stageId <= self._historyStageId
end

function WisdomCourageClgMo:isPassAllStageInSupport()
	return self._historyStageId >= self._maxStageId
end

function WisdomCourageClgMo:getSupportPetNum()
	return self._supportPetNum
end

function WisdomCourageClgMo:popChangeSetIdInSupport()
	self._changeSetIdInSupport = nil

	return self._changeSetIdInSupport
end

function WisdomCourageClgMo:getSupportClgFinishResMsg()
	return self._supportClgFinishResMsg
end

return WisdomCourageClgMo
