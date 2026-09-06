-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/model/ChopKingModel.lua

module("logic.extensions.chopking.model.ChopKingModel", package.seeall)

local ChopKingModel = class("ChopKingModel")

function ChopKingModel:onInit()
	self:onReset()
end

function ChopKingModel:onReset()
	self._rogueFmtMo = nil
	self._circleFmtMo = nil
	self._againstTwoFmtMo = nil
	self._loopClgFmtMo = nil
	self._curLoopStageInfo = nil
	self._curCircleStageId = nil
	self._curAgainstTwoStageId = nil
	self._rogueInfo = {}
	self._circleClgInfo = {}
	self._circleClgStageInfo = {}
	self._againstTwoInfo = {}
	self._againstTwoStageInfo = {}
	self._loopClgInfo = {}
	self._loopClgStageInfo = {}
	self._rankInfo = {}
end

function ChopKingModel:saveRogueInfo(msg)
	self._rogueInfo[msg.activityId] = GameUtil.pbToTable(msg)
end

function ChopKingModel:saveRogueDropInfo(msg)
	if self._rogueInfo[msg.activityId] then
		self._rogueInfo[msg.activityId].dropBuffInfo = GameUtil.pbToTable(msg.dropBuffInfo)
	end
end

function ChopKingModel:getRoguePassNum(activityId)
	if self._rogueInfo[activityId] and self._rogueInfo[activityId] then
		return self._rogueInfo[activityId].stageIdPassed
	end

	return 0
end

function ChopKingModel:getRogueFmtMo()
	self._rogueFmtMo = self._rogueFmtMo or ChopKingRogueFmtMo.New()

	return self._rogueFmtMo
end

function ChopKingModel:getRogueBuffList(activityId)
	if self._rogueInfo[activityId] and self._rogueInfo[activityId].dropBuffInfo then
		return self._rogueInfo[activityId].dropBuffInfo.selectedDropBuffId or {}
	end

	return {}
end

function ChopKingModel:isNeedSelectBuff(activityId)
	if self._rogueInfo[activityId] and self._rogueInfo[activityId].dropBuffInfo then
		local selettingDropBuffList = self._rogueInfo[activityId].dropBuffInfo.selectingDropBuff

		return selettingDropBuffList ~= nil and #selettingDropBuffList > 0
	end

	return false
end

function ChopKingModel:getSelectDropBuffs(activityId)
	if self._rogueInfo[activityId] and self._rogueInfo[activityId].dropBuffInfo then
		return self._rogueInfo[activityId].dropBuffInfo.selectingDropBuff or {}
	end

	return {}
end

function ChopKingModel:saveRogueChallengeInfo(msg)
	if self._rogueInfo[msg.activityId] then
		self._rogueInfo[msg.activityId].dropBuffInfo = self._rogueInfo[msg.activityId].dropBuffInfo or {}
		self._rogueInfo[msg.activityId].dropBuffInfo.reRandomCount = 0
		self._rogueInfo[msg.activityId].dropBuffInfo.selectingDropBuff = msg.selectingDropBuff

		if self._rogueInfo[msg.activityId].stageIdPassed < msg.stageId then
			self._rogueInfo[msg.activityId].stageIdPassed = msg.stageId
		end
	end
end

function ChopKingModel:getReRandomCount(activityId)
	if self._rogueInfo[activityId] and self._rogueInfo[activityId].dropBuffInfo then
		return self._rogueInfo[activityId].dropBuffInfo.reRandomCount
	end

	return 0
end

function ChopKingModel:saveReRandomInfo(msg)
	if self._rogueInfo[msg.activityId] then
		self._rogueInfo[msg.activityId].dropBuffInfo = GameUtil.pbToTable(msg)
	end
end

function ChopKingModel:saveCircleClgInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._circleClgInfo[msg.activityId] = info
	self._circleClgStageInfo[msg.activityId] = {}
	self._circleClgStageInfo[msg.activityId].stages = {}

	local maxStageId = 0

	if info.stages then
		for i, v in ipairs(info.stages) do
			self._circleClgStageInfo[msg.activityId].stages[v.stageId] = v.circleNum

			if maxStageId < v.stageId then
				maxStageId = v.stageId
			end
		end
	end

	self._circleClgStageInfo[msg.activityId].maxStageId = maxStageId
end

function ChopKingModel:getCircleClgMaxStage(activityId)
	if self._circleClgStageInfo[activityId] then
		return self._circleClgStageInfo[activityId].maxStageId
	end
end

function ChopKingModel:getCircleClgStageInfo(activityId, stageId)
	if self._circleClgStageInfo[activityId] then
		return self._circleClgStageInfo[activityId].stages[stageId]
	end
end

function ChopKingModel:saveCircleClgFightInfo(msg)
	if self._circleClgStageInfo[msg.activityId] then
		self._circleClgStageInfo[msg.activityId].stages[msg.stageId] = self._circleClgStageInfo[msg.activityId].stages[msg.stageId] or math.huge

		if self._circleClgStageInfo[msg.activityId].stages[msg.stageId] > msg.circleNum then
			self._circleClgStageInfo[msg.activityId].stages[msg.stageId] = msg.circleNum
		end

		if self._circleClgStageInfo[msg.activityId].maxStageId < msg.stageId then
			self._circleClgStageInfo[msg.activityId].maxStageId = msg.stageId
		end
	end
end

function ChopKingModel:getCircleFmtMo()
	self._circleFmtMo = self._circleFmtMo or ChopKingCircleFmtMo.New()

	return self._circleFmtMo
end

function ChopKingModel:saveCurCircleStageId(stageId)
	self._curCircleStageId = stageId
end

function ChopKingModel:getCurCircleStageId()
	return self._curCircleStageId
end

function ChopKingModel:saveAgainstTwoInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._againstTwoInfo[msg.activityId] = info
	self._againstTwoStageInfo[msg.activityId] = {}
	self._againstTwoStageInfo[msg.activityId].stages = {}

	local maxStageId = 0

	if info.stages then
		for i, v in ipairs(info.stages) do
			self._againstTwoStageInfo[msg.activityId].stages[v.stageId] = v.activeNum

			if maxStageId < v.stageId then
				maxStageId = v.stageId
			end
		end
	end

	self._againstTwoStageInfo[msg.activityId].maxStageId = maxStageId
end

function ChopKingModel:getAgainstTwoMaxStage(activityId)
	if self._againstTwoStageInfo[activityId] then
		return self._againstTwoStageInfo[activityId].maxStageId
	end
end

function ChopKingModel:getAgainstTwoStageInfo(activityId, stageId)
	if self._againstTwoStageInfo[activityId] then
		return self._againstTwoStageInfo[activityId].stages[stageId]
	end
end

function ChopKingModel:saveAgainstTwoFightInfo(msg)
	if self._againstTwoStageInfo[msg.activityId] then
		self._againstTwoStageInfo[msg.activityId].stages[msg.stageId] = self._againstTwoStageInfo[msg.activityId].stages[msg.stageId] or 0

		if self._againstTwoStageInfo[msg.activityId].stages[msg.stageId] < msg.activeNum then
			self._againstTwoStageInfo[msg.activityId].stages[msg.stageId] = msg.activeNum
		end

		if self._againstTwoStageInfo[msg.activityId].maxStageId < msg.stageId then
			self._againstTwoStageInfo[msg.activityId].maxStageId = msg.stageId
		end
	end
end

function ChopKingModel:getAgainstTwoFmtMo()
	self._againstTwoFmtMo = self._againstTwoFmtMo or ChopKingAgainstTwoFmtMo.New()

	return self._againstTwoFmtMo
end

function ChopKingModel:saveCurAgainstTwoStageId(stageId)
	self._curAgainstTwoStageId = stageId
end

function ChopKingModel:getCurAgainstTwoStageId()
	return self._curAgainstTwoStageId
end

function ChopKingModel:saveLoopClgInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._loopClgInfo[msg.activityId] = info
	self._loopClgStageInfo[msg.activityId] = {}
	self._loopClgStageInfo[msg.activityId].stages = {}

	local maxStageId = 0
	local maxLoopId = 0

	if info.stages then
		for i, v in ipairs(info.stages) do
			self._loopClgStageInfo[msg.activityId].stages[v.loopId] = self._loopClgStageInfo[msg.activityId].stages[v.loopId] or {}
			self._loopClgStageInfo[msg.activityId].stages[v.loopId][v.stageId] = v

			if maxLoopId < v.loopId then
				maxLoopId = v.loopId
				maxStageId = v.stageId
			elseif v.loopId == maxLoopId and maxStageId < v.stageId then
				maxStageId = v.stageId
			end
		end
	end

	self._loopClgStageInfo[msg.activityId].maxLoopId = maxLoopId
	self._loopClgStageInfo[msg.activityId].maxStageId = maxStageId
end

function ChopKingModel:getLoopClgMaxStage(activityId)
	if self._loopClgStageInfo[activityId] then
		return self._loopClgStageInfo[activityId].maxLoopId, self._loopClgStageInfo[activityId].maxStageId
	end

	return 0, 0
end

function ChopKingModel:getLoopClgStageInfo(activityId, loopId, stageId)
	if self._loopClgStageInfo[activityId] and self._loopClgStageInfo[activityId].stages[loopId] then
		return self._loopClgStageInfo[activityId].stages[loopId][stageId]
	end

	return nil
end

function ChopKingModel:saveLoopClgFightInfo(msg)
	if self._loopClgStageInfo[msg.activityId] then
		self._loopClgStageInfo[msg.activityId].stages[msg.loopId] = self._loopClgStageInfo[msg.activityId].stages[msg.loopId] or {}

		local info = {}

		info.loopId = msg.loopId
		info.stageId = msg.stageId

		if msg.circleNum then
			info.bestCircleNum = msg.circleNum
		end

		if msg.activeNum then
			info.bestActiveNum = msg.activeNum
		end

		self._loopClgStageInfo[msg.activityId].stages[msg.loopId][msg.stageId] = info

		local oldMaxStageId = self._loopClgStageInfo[msg.activityId].maxStageId
		local oldLoopId = self._loopClgStageInfo[msg.activityId].maxLoopId

		if oldLoopId < msg.loopId then
			self._loopClgStageInfo[msg.activityId].maxStageId = msg.stageId
			self._loopClgStageInfo[msg.activityId].maxLoopId = msg.loopId
		elseif oldLoopId == msg.loopId and oldMaxStageId < msg.stageId then
			self._loopClgStageInfo[msg.activityId].maxStageId = msg.stageId
		end
	end
end

function ChopKingModel:getLoopClgFmtMo()
	self._loopClgFmtMo = self._loopClgFmtMo or ChopKingLoopClgFmtMo.New()

	return self._loopClgFmtMo
end

function ChopKingModel:saveCurLoopStageInfo(stageInfo)
	self._curLoopStageInfo = stageInfo
end

function ChopKingModel:getCurLoopStageInfo()
	return self._curLoopStageInfo
end

function ChopKingModel:saveRankInfo(msg)
	self._rankInfo = GameUtil.pbToTable(msg)
end

function ChopKingModel:getMyRank()
	return self._rankInfo.myRank
end

function ChopKingModel:getRankList()
	return self._rankInfo.rankInfos or {}
end

ChopKingModel.instance = ChopKingModel.New()

return ChopKingModel
