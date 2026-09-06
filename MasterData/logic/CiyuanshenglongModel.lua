-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/model/CiyuanshenglongModel.lua

module("logic.extensions.ciyuanshenglong.model.CiyuanshenglongModel", package.seeall)

local CiyuanshenglongModel = class("CiyuanshenglongModel", BaseModel)

CiyuanshenglongModel.TAB_HISTORY = 1
CiyuanshenglongModel.TAB_TODAY = 2

function CiyuanshenglongModel:onInit()
	self:onReset()
end

function CiyuanshenglongModel:onReset()
	self._msgMap = {}
	self.historyRankInfo = {}
	self.todyRankInfo = {}
	self.fightDamage = 0
	self.fightScore = 0
	self.fightScoreMax = 0
	self.myHistoryRank = -1
	self.myDailyRank = -1
	self.tabChallengeIndex = 1
	self.rankIndex = CiyuanshenglongModel.TAB_HISTORY
end

function CiyuanshenglongModel:handlePM_CiYuanHolyDragonClgGetInfoRes(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function CiyuanshenglongModel:getMsgInfo(activityId)
	return self._msgMap[activityId]
end

function CiyuanshenglongModel:handlePM_CiYuanHolyDragonClgGetHistoryRankRes(msg)
	self.historyRankInfo = GameUtil.pbToTable(msg)
end

function CiyuanshenglongModel:handlePM_CiYuanHolyDragonClgGetDailyRankRes(msg)
	self.todyRankInfo = GameUtil.pbToTable(msg)
end

function CiyuanshenglongModel:handlePM_CiYuanHolyDragonClgNotifyFightResultRes(msg)
	self.fightDamage = checknumber(msg.fightDamage)
	self.fightScore = msg.fightScore
	self.myHistoryRank = msg.myHistoryRank
	self.myDailyRank = msg.myDailyRank
	self.fightScoreMax = 0

	local activityId = msg.activityId
	local stageId = msg.stageId
	local stageInfo

	if msg:HasField("stageInfo") ~= nil then
		stageInfo = GameUtil.pbToTable(msg.stageInfo)
	end

	local info = self._msgMap[activityId]

	if info then
		if not info.stageInfo then
			for i, v in ipairs(info.stageInfo) do
				if v.stageId == stageId then
					if stageInfo then
						info.stageInfo[i] = stageInfo
					end

					self.fightScoreMax = math.max(self.fightScore, info.stageInfo[i].todayMaxScore)

					break
				end
			end
		end
	end
end

CiyuanshenglongModel.instance = CiyuanshenglongModel.New()

return CiyuanshenglongModel
