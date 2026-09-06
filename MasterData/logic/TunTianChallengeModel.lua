-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/model/TunTianChallengeModel.lua

module("logic.extensions.tuntianchallenge.model.TunTianChallengeModel", package.seeall)

local TunTianChallengeModel = class("TunTianChallengeModel", BaseModel)

TunTianChallengeModel.StageStatus = {}
TunTianChallengeModel.StageStatus.UnChallenged = 0
TunTianChallengeModel.StageStatus.ChallengeFail = 1
TunTianChallengeModel.StageStatus.ChallengeSuc = 2
TunTianChallengeModel.StageTypeStatus = {}
TunTianChallengeModel.StageTypeStatus.NotPass = 1
TunTianChallengeModel.StageTypeStatus.HasPass = 2

function TunTianChallengeModel:ctor()
	return
end

function TunTianChallengeModel:onInit()
	self:onReset()
end

function TunTianChallengeModel:onReset()
	self._tunTianNorClgCustomFmtMo = nil
	self._tunTianExtClgCustomFmtMo = nil
	self._clgGetInfoResMsg = nil
	self._normalClgMonsterIdList = {}
	self._normalClgTodayLeftFightCount = 0
	self._normalClgTodayLeftRefreshCount = 0
	self._hasGainExtremeClgPrize = false
	self._fightResultResMsgOfExtClg = nil
	self._markSlotIdEffList = {}
end

function TunTianChallengeModel:handlePM_TunTianClgGetInfoRes(msg)
	self._clgGetInfoResMsg = msg

	table.clear(self._normalClgMonsterIdList)
	table.insertto(self._normalClgMonsterIdList, msg.normalClgMonsterId)

	self._normalClgTodayLeftFightCount = msg.normalClgTodayLeftFightCount
	self._normalClgTodayLeftRefreshCount = msg.normalClgTodayLeftRefreshCount
	self._hasGainExtremeClgPrize = msg.hasGainExtremeClgPrize
end

function TunTianChallengeModel:handlePM_TunTianNormalClgFightRes(msg)
	return
end

function TunTianChallengeModel:handlePM_TunTianRefreshNormalClgMonsterRes(msg)
	table.clear(self._normalClgMonsterIdList)
	table.insertto(self._normalClgMonsterIdList, msg.normalClgMonsterId)
	self:clearPartNeedFlashEffList()

	for slotId = 1, #self._normalClgMonsterIdList do
		self:markPartNeedFlashEff(slotId, true)
	end

	self._normalClgTodayLeftRefreshCount = self._normalClgTodayLeftRefreshCount - 1
end

function TunTianChallengeModel:handlePM_TunTianGainNormalClgProgressPrizeRes(msg)
	return
end

function TunTianChallengeModel:handlePM_TunTianExtremeClgFightRes(msg)
	return
end

function TunTianChallengeModel:handlePM_TunTianExtremeClgUseNewStageScoreRes(msg)
	self._fightResultResMsgOfExtClg = nil
end

function TunTianChallengeModel:handlePM_TunTianGainExtremeClgPrizeRes(msg)
	self._hasGainExtremeClgPrize = true
end

function TunTianChallengeModel:handlePM_TunTianNotifyNormalClgFightResultRes(msg)
	self._normalClgTodayLeftFightCount = self._normalClgTodayLeftFightCount - 1

	if msg.slotId ~= nil then
		self:clearPartNeedFlashEffList()
		self:markPartNeedFlashEff(msg.slotId, true)
	end
end

function TunTianChallengeModel:handlePM_TunTianNotifyExtremeClgFightResultRes(msg)
	self._fightResultResMsgOfExtClg = msg
end

function TunTianChallengeModel:getCustomFmtMoOfNorClg()
	if self._tunTianNorClgCustomFmtMo == nil then
		self._tunTianNorClgCustomFmtMo = TunTianNorClgCustomFmtMo.New()
	end

	return self._tunTianNorClgCustomFmtMo
end

function TunTianChallengeModel:getCustomFmtMoOfExtClg()
	if self._tunTianExtClgCustomFmtMo == nil then
		self._tunTianExtClgCustomFmtMo = TunTianExtClgCustomFmtMo.New()
	end

	return self._tunTianExtClgCustomFmtMo
end

function TunTianChallengeModel:isHasGainPrizeOfNormalClg(dataBitId)
	if self._clgGetInfoResMsg then
		for _, v in ipairs(self._clgGetInfoResMsg.normalClgPrizeGainedBitId) do
			if v == dataBitId then
				return true
			end
		end
	end

	return false
end

function TunTianChallengeModel:getCurProgressOfNorClg()
	if self._clgGetInfoResMsg then
		return self._clgGetInfoResMsg.normalClgProgress
	end

	return 0
end

function TunTianChallengeModel:getMonsterIdListOfNorClg()
	return self._normalClgMonsterIdList
end

function TunTianChallengeModel:getMonsterIdBySlotOfNorClg(slotId)
	return checknumber(self._normalClgMonsterIdList[slotId])
end

function TunTianChallengeModel:getLeftFightCountOfNorClg()
	return self._normalClgTodayLeftFightCount
end

function TunTianChallengeModel:getLeftRefreshMonsterCountOfNorClg()
	return self._normalClgTodayLeftRefreshCount
end

function TunTianChallengeModel:isInMarkPartNeedFlashEffList(slotId)
	return table.indexof(self._markSlotIdEffList, slotId) ~= false
end

function TunTianChallengeModel:markPartNeedFlashEff(slotId, isAdd)
	if isAdd then
		if not self:isInMarkPartNeedFlashEffList(slotId) then
			table.insert(self._markSlotIdEffList, slotId)
		end
	else
		table.removebyvalue(self._markSlotIdEffList, slotId, true)
	end
end

function TunTianChallengeModel:clearPartNeedFlashEffList()
	if self._markSlotIdEffList then
		table.clear(self._markSlotIdEffList)
	end
end

function TunTianChallengeModel:isHasGainPrizeOfExtClg()
	return self._hasGainExtremeClgPrize
end

function TunTianChallengeModel:getStageScoreOfExtClg(stageType, stageId)
	local stageInfo = self:getStageInfoOfExtClg(stageType, stageId)

	return checknumber(stageInfo and stageInfo.score)
end

function TunTianChallengeModel:getStageStatusOfExtClg(stageType, stageId)
	local stageInfo = self:getStageInfoOfExtClg(stageType, stageId)

	return checknumber(stageInfo and stageInfo.status)
end

function TunTianChallengeModel:getStageInfoOfExtClg(stageType, stageId)
	local stageInfo

	if self._clgGetInfoResMsg then
		for _, v in ipairs(self._clgGetInfoResMsg.extremeStageInfo) do
			if v.stageType == stageType and v.stageId == stageId then
				stageInfo = v

				break
			end
		end
	end

	return stageInfo
end

function TunTianChallengeModel:getFightResultResMsgOfExtClg()
	return self._fightResultResMsgOfExtClg
end

TunTianChallengeModel.instance = TunTianChallengeModel.New()

return TunTianChallengeModel
