-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/model/ChuangzhengliModel.lua

module("logic.extensions.chuangzhengli.view.ChuangzhengliModel", package.seeall)

local ChuangzhengliModel = class("ChuangzhengliModel", BaseModel)

function ChuangzhengliModel:ctor()
	return
end

function ChuangzhengliModel:onInit()
	self:onReset()
end

function ChuangzhengliModel:onReset()
	self._msgInfos = {}
	self._curScore = 0
	self._fmtMo = nil
end

function ChuangzhengliModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].teamScores = self._msgInfos[msg.activityId].teamScores or {}
end

function ChuangzhengliModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function ChuangzhengliModel:getFmtMo()
	self._fmtMo = self._fmtMo or ChuangzhengliFmtMo.New()

	return self._fmtMo
end

function ChuangzhengliModel:isChallenged(activityId, stageId, creepsMasterId)
	local info = self:getInfo(activityId)
	local stageCfg = ChuangzhengliConfig.instance:getStageCfg(activityId, stageId)
	local idx = 0

	for i, v in ipairs(stageCfg.teams) do
		if v == creepsMasterId then
			idx = i

			break
		end
	end

	if info.teamLockRaceIds and info.teamLockRaceIds[idx] and #info.teamLockRaceIds[idx].list > 0 then
		return true
	end
end

function ChuangzhengliModel:getAllLockRaceId(activityId)
	local raceIdMap = {}
	local info = self:getInfo(activityId)

	if info.teamLockRaceIds then
		for _, v in pairs(info.teamLockRaceIds) do
			for _, raceId in ipairs(v.list) do
				raceIdMap[raceId] = raceId
			end
		end
	end

	return raceIdMap
end

function ChuangzhengliModel:onClgEndRes(msg)
	local msgTable = GameUtil.pbToTable(msg)
	local info = self:getInfo(msgTable.activityId)

	info.teamLockRaceIds[msgTable.teamIndex] = info.teamLockRaceIds[msgTable.teamIndex] or {}
	info.teamLockRaceIds[msgTable.teamIndex].list = msgTable.lockRaceIds or {}
	info.teamScores[msgTable.teamIndex] = checknumber(msgTable.score)

	if msgTable.passStage then
		info.passStageId = msgTable.stageId
		info.teamLockRaceIds = {}
		info.teamScores = {}
	end
end

function ChuangzhengliModel:onResetStage(msg)
	local info = self:getInfo(msg.activityId)

	info.teamLockRaceIds = {}
	info.teamScores = {}
end

function ChuangzhengliModel:getCurrScore(activityId)
	local info = self:getInfo(activityId)
	local score = 0

	for i, v in pairs(info.teamLockRaceIds or {}) do
		if #v.list > 0 then
			score = score + checknumber(info.teamScores[i])
		end
	end

	return score
end

ChuangzhengliModel.instance = ChuangzhengliModel.New()

return ChuangzhengliModel
