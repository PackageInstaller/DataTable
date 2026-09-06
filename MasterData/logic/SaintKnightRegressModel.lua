-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/model/SaintKnightRegressModel.lua

module("logic.extensions.saintknightregress.model.SaintKnightRegressModel", package.seeall)

local SaintKnightRegressModel = class("SaintKnightRegressModel", BaseModel)

function SaintKnightRegressModel:ctor()
	return
end

function SaintKnightRegressModel:onInit()
	self._tempLotteryInfo = nil

	self:onReset()
end

function SaintKnightRegressModel:onReset()
	self._info = {}
	self._gainInvitePrizeMap = {}
	self._regressTaskMap = {}
end

function SaintKnightRegressModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data
	self._gainInvitePrizeMap[data.activityId] = {}

	if data.gainPrizeIds then
		for i, v in ipairs(data.gainPrizeIds) do
			self._gainInvitePrizeMap[data.activityId][v] = true
		end
	end

	self._regressTaskMap[data.activityId] = self._regressTaskMap[data.activityId] or {}

	if data.playerList then
		for i, v in ipairs(data.playerList) do
			self._regressTaskMap[data.activityId][i] = self._regressTaskMap[data.activityId][i] or {}
			self._regressTaskMap[data.activityId][i].info = v
			self._regressTaskMap[data.activityId][i].prizeMap = {}

			if v.gainPrizeIds then
				for j, k in ipairs(v.gainPrizeIds) do
					self._regressTaskMap[data.activityId][i].prizeMap[k] = true
				end
			end
		end
	end
end

function SaintKnightRegressModel:getRegressPlayerList(activityId)
	if self._info[activityId] then
		return self._info[activityId].playerList or {}
	end

	return {}
end

function SaintKnightRegressModel:getRegressPlayerInfo(activityId, index)
	if self._info[activityId] and self._info[activityId].playerList then
		return self._info[activityId].playerList[index]
	end
end

function SaintKnightRegressModel:getIsRegressPlayer(activityId)
	if self._info[activityId] then
		return self._info[activityId].isRegressPlayer
	end
end

function SaintKnightRegressModel:getRegressTaskInfo(activityId, playerIndex)
	if self._regressTaskMap[activityId] then
		return self._regressTaskMap[activityId][playerIndex]
	end
end

function SaintKnightRegressModel:getFinishRegressTaskCount(activityId, playerIndex)
	if self._regressTaskMap[activityId] and self._regressTaskMap[activityId][playerIndex] then
		return self._regressTaskMap[activityId][playerIndex].info.finishTaskCount
	end

	return 0
end

function SaintKnightRegressModel:getGainRegressPrize(activityId, playerIndex, prizeId)
	if self._regressTaskMap[activityId] and self._regressTaskMap[activityId][playerIndex] then
		return self._regressTaskMap[activityId][playerIndex].prizeMap[prizeId]
	end

	return false
end

function SaintKnightRegressModel:isGainInvitePrize(activityId, prizeId)
	if self._gainInvitePrizeMap[activityId] then
		return self._gainInvitePrizeMap[activityId][prizeId]
	end

	return false
end

function SaintKnightRegressModel:getInviteCode(activityId)
	if self._info[activityId] then
		return self._info[activityId].myInviteCode
	end
end

function SaintKnightRegressModel:saveBindCode(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].bindInviteCode = msg.inviteCode
	end
end

function SaintKnightRegressModel:getBindInviteCode(activityId)
	if self._info[activityId] then
		return self._info[activityId].bindInviteCode
	end
end

function SaintKnightRegressModel:getSuperPrizeId(activityId)
	if self._info[activityId] then
		return self._info[activityId].superPrizeId
	end
end

function SaintKnightRegressModel:getLotteryMsgInfo(activityId)
	if self._info[activityId] then
		return self._info[activityId].msg
	end
end

function SaintKnightRegressModel:saveLotteryInfo(msg)
	self._tempLotteryInfo = GameUtil.pbToTable(msg)

	if msg.prizeType == 1 and self._info[msg.activityId] then
		self._info[msg.activityId].superPrizeId = msg.prizeId
	end
end

function SaintKnightRegressModel:getTempLotteryInfo()
	return self._tempLotteryInfo
end

function SaintKnightRegressModel:resetTempLotteryInfo()
	self._tempLotteryInfo = nil
end

function SaintKnightRegressModel:saveGainPrize(msg)
	local data = GameUtil.pbToTable(msg)

	if self._gainInvitePrizeMap[data.activityId] and data.gainPrizeIds then
		for i, v in ipairs(data.gainPrizeIds) do
			self._gainInvitePrizeMap[data.activityId][v] = true
		end
	end

	self._regressTaskMap[data.activityId] = self._regressTaskMap[data.activityId] or {}

	if data.playerList then
		for i, v in ipairs(data.playerList) do
			self._regressTaskMap[data.activityId][i] = self._regressTaskMap[data.activityId][i] or {}
			self._regressTaskMap[data.activityId][i].info = v
			self._regressTaskMap[data.activityId][i].prizeMap = {}

			if v.gainPrizeIds then
				for j, k in ipairs(v.gainPrizeIds) do
					self._regressTaskMap[data.activityId][i].prizeMap[k] = true
				end
			end
		end
	end
end

function SaintKnightRegressModel:saveLotteryMsg(info)
	local data = GameUtil.pbToTable(info.msg)

	if self._info[info.activityId] then
		self._info[info.activityId].msg = data
	end
end

function SaintKnightRegressModel:saveRegressTaskInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._tempTaskInfo = {}

	local finishTaskCount = 0

	for i, v in ipairs(data.taskList) do
		self._tempTaskInfo[v.taskId] = v

		local taskCfg = SaintKnightRegressConfig.instance:getRegressTaskCfg(data.activityId, v.taskId)

		if taskCfg.maxProgress <= v.curProgress then
			finishTaskCount = finishTaskCount + 1
		end
	end

	local index = 0

	for j, regressInfo in ipairs(self._regressTaskMap[data.activityId]) do
		if regressInfo.info.headInfo.userId == data.playerId then
			index = j

			break
		end
	end

	if self._regressTaskMap[data.activityId][index] then
		self._regressTaskMap[data.activityId][index].finishTaskCount = finishTaskCount
	end
end

function SaintKnightRegressModel:getRegressPlayerTaskInfo(taskId)
	if self._tempTaskInfo then
		return self._tempTaskInfo[taskId]
	end
end

SaintKnightRegressModel.instance = SaintKnightRegressModel.New()

return SaintKnightRegressModel
