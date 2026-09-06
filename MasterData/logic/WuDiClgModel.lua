-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/model/WuDiClgModel.lua

module("logic.extensions.wudiclg.model.WuDiClgModel", package.seeall)

local WuDiClgModel = class("WuDiClgModel", BaseModel)

function WuDiClgModel:ctor()
	return
end

function WuDiClgModel:onInit()
	self:onReset()
end

function WuDiClgModel:onReset()
	self._customFmtMoOfNor = nil
	self._customFmtMoOfExt = nil
	self._extStageInfoPool = {}
	self._hasGainExtremeClgPrize = false
	self._normalClgSoulCount = 0
	self._normalClgProgressPrizeGainedBitId = {}
	self._normalClgDailyMonsterPassBitId = {}
	self._normalClgTodayGroupId = 0
end

function WuDiClgModel:handlePM_WuDiClgGetInfoRes(msg)
	table.clear(self._extStageInfoPool)

	for _, v in ipairs(msg.extremeClgStageInfo) do
		self._extStageInfoPool[v.stageId] = v
	end

	self._hasGainExtremeClgPrize = msg.hasGainExtremeClgPrize
	self._normalClgSoulCount = msg.normalClgSoulCount

	table.clear(self._normalClgProgressPrizeGainedBitId)
	table.insertto(self._normalClgProgressPrizeGainedBitId, msg.normalClgProgressPrizeGainedBitId)
	table.clear(self._normalClgDailyMonsterPassBitId)
	table.insertto(self._normalClgDailyMonsterPassBitId, msg.normalClgDailyMonsterPassBitId)

	self._normalClgTodayGroupId = msg.normalClgTodayGroupId
end

function WuDiClgModel:handlePM_WuDiClgExtremeFightRes(msg)
	return
end

function WuDiClgModel:handlePM_WuDiClgExtremeFightConfirmRes(msg)
	if msg.stageInfo then
		self._extStageInfoPool[msg.stageInfo.stageId] = msg.stageInfo
	end
end

function WuDiClgModel:handlePM_WuDiClgResetExtremeClgRes(msg)
	table.clear(self._extStageInfoPool)
end

function WuDiClgModel:handlePM_WuDiClgGainExtremePrizeRes(msg)
	self._hasGainExtremeClgPrize = true
end

function WuDiClgModel:handlePM_WuDiClgNormalFightRes(msg)
	return
end

function WuDiClgModel:handlePM_WuDiClgGainNormalProgressPrizeRes(msg)
	table.insert(self._normalClgProgressPrizeGainedBitId, msg.dataBitId)
end

function WuDiClgModel:handlePM_WuDiClgNotifyExtremeFightResultRes(msg)
	self._extFightResultRes = msg
end

function WuDiClgModel:handlePM_WuDiClgNotifyNormalFightResultRes(msg)
	if msg.win then
		if msg.normalClgSoulCount then
			self._normalClgSoulCount = msg.normalClgSoulCount
		end

		table.insert(self._normalClgDailyMonsterPassBitId, msg.dataBitId)
	end

	self._normalFightResultRes = msg
end

function WuDiClgModel:getWuDiClgCustomFmtMoOfNor()
	if self._customFmtMoOfNor == nil then
		self._customFmtMoOfNor = WuDiClgCustomFmtMoOfNor.New()
	end

	return self._customFmtMoOfNor
end

function WuDiClgModel:getWuDiClgCustomFmtMoOfExt()
	if self._customFmtMoOfExt == nil then
		self._customFmtMoOfExt = WuDiClgCustomFmtMoOfExt.New()
	end

	return self._customFmtMoOfExt
end

function WuDiClgModel:isHasGainExtremeClgPrize()
	return self._hasGainExtremeClgPrize
end

function WuDiClgModel:getAttackInfoOfExtStage(stageId, raceId)
	local result
	local infoList = self:getAttackInfoListOfExtStage(stageId)

	for _, info in ipairs(infoList) do
		if info.raceId == raceId then
			result = info
		end
	end

	return result
end

function WuDiClgModel:getAttackInfoListOfExtStage(stageId)
	local attackInfoList = {}
	local info = self:getExtStageInfo(stageId)

	if info then
		table.insertto(attackInfoList, info.groupAttacks)
	end

	return attackInfoList
end

function WuDiClgModel:getLockedRaceIdListOfExtStage(stageId)
	local raceIdList = {}
	local info = self:getExtStageInfo(stageId)

	if info then
		table.insertto(raceIdList, info.lockedRace)
	end

	return raceIdList
end

function WuDiClgModel:isPassOfExtStage(stageId)
	return self._extStageInfoPool[stageId]
end

function WuDiClgModel:getExtStageInfo(stageId)
	return self._extStageInfoPool[stageId]
end

function WuDiClgModel:getExtFightResultRes()
	return self._extFightResultRes
end

function WuDiClgModel:getNormalClgTodayGroupId()
	return self._normalClgTodayGroupId
end

function WuDiClgModel:getPassBitIdListOfNorClg()
	return self._normalClgDailyMonsterPassBitId
end

function WuDiClgModel:getProgressPrizeGainedBitIdListOfNorClg()
	return self._normalClgProgressPrizeGainedBitId
end

function WuDiClgModel:getProgressOfNorClg()
	return self._normalClgSoulCount
end

function WuDiClgModel:getFightResultResOfNorClg()
	return self._normalFightResultRes
end

WuDiClgModel.instance = WuDiClgModel.New()

return WuDiClgModel
