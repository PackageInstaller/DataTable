-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/data/KingMoYanClgMo.lua

module("logic.extensions.kingmoyanclg.data.KingMoYanClgMo", package.seeall)

local KingMoYanClgMo = class("KingMoYanClgMo")

function KingMoYanClgMo:ctor(activityId)
	self._activityId = activityId

	local stageCfg = KingMoYanClgConfig.instance:getStageCfg(activityId) or {}

	self._stageCount = #stageCfg
	self._curStageId = 0
	self._maxStageId = 0
	self._curUltimateTimes = 0
end

function KingMoYanClgMo:dispose()
	return
end

function KingMoYanClgMo:getActivityId()
	return self._activityId
end

function KingMoYanClgMo:handlePM_KingMoYanClgInfoRes(msg)
	self._curStageId = msg.curStageId
	self._maxStageId = msg.maxStageId
	self._curUltimateTimes = msg.curUltimateTimes
end

function KingMoYanClgMo:handlePM_KingMoYanClgChallengeRes(msg)
	return
end

function KingMoYanClgMo:handlePM_KingMoYanClgConfirmRes(msg, stageId)
	if msg.save == true then
		self._curStageId = stageId
	end
end

function KingMoYanClgMo:handlePM_KingMoYanClgResetRes(msg)
	return
end

function KingMoYanClgMo:handlePM_NotifyKingMoYanClgFinishRes(msg)
	self._endResMsg = msg
end

function KingMoYanClgMo:isPassAll()
	return self._curStageId >= self._stageCount
end

function KingMoYanClgMo:isPassStageInCur(stageId)
	return stageId <= self._curStageId
end

function KingMoYanClgMo:isPassStageInHistory(stageId)
	return stageId <= self._maxStageId
end

function KingMoYanClgMo:isUnlockStage(stageId)
	return stageId <= self._curStageId + 1
end

function KingMoYanClgMo:getCurStageId()
	return self._curStageId
end

function KingMoYanClgMo:getMaxStageId()
	return self._maxStageId
end

function KingMoYanClgMo:getStageCount()
	return self._stageCount
end

function KingMoYanClgMo:getCurUltimateTimes()
	return self._curUltimateTimes
end

function KingMoYanClgMo:getCurBuffId()
	local data = KingMoYanClgConfig.instance:getBuffDataByNum(self._activityId, self._curUltimateTimes)

	return (data or nil) and (data.buffId or 0)
end

function KingMoYanClgMo:isActiveBuff(buffId)
	local data = KingMoYanClgConfig.instance:getBuffData(self._activityId, buffId)
	local num = data.num

	return num <= self._curUltimateTimes
end

function KingMoYanClgMo:getEndResMsg(value)
	return self._endResMsg
end

function KingMoYanClgMo:setChangeSetId(value)
	self._changeSetId = value
end

function KingMoYanClgMo:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

return KingMoYanClgMo
