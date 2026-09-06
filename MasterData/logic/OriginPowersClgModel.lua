-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/model/OriginPowersClgModel.lua

module("logic.extensions.originpowersclg.model.OriginPowersClgModel", package.seeall)

local OriginPowersClgModel = class("OriginPowersClgModel", BaseModel)

function OriginPowersClgModel:onInit()
	self:onReset()
end

function OriginPowersClgModel:onReset()
	self._normalFmtMo = nil
	self._extermeFmtMo = nil
	self._extInfos = {}
	self._extStageInfos = {}
	self._normalInfo = {}
	self._normalStageInfos = {}
	self._prizeGainMap = {}
end

function OriginPowersClgModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or OriginPowersClgNormalFmtMo.New()

	return self._normalFmtMo
end

function OriginPowersClgModel:getExtermeFmtMo()
	self._extermeFmtMo = self._extermeFmtMo or OriginPowersClgExteremeFmtMo.New()

	return self._extermeFmtMo
end

function OriginPowersClgModel:saveExtremeInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._extInfos[data.activityId] = data

	local stageInfos = {}

	if data.stages then
		for i, v in ipairs(data.stages) do
			stageInfos[v.stageId] = v
		end
	end

	self._extStageInfos[data.activityId] = stageInfos
end

function OriginPowersClgModel:getExtStageInfo(activityId, stageId)
	if self._extStageInfos[activityId] then
		return self._extStageInfos[activityId][stageId]
	end
end

function OriginPowersClgModel:resetExtStageInfo(activityId, stageId)
	if self._extStageInfos[activityId] then
		self._extStageInfos[activityId][stageId] = nil
	end
end

function OriginPowersClgModel:saveExtBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._extStageInfos[data.activityId] then
		self._extStageInfos[data.activityId][data.stageId] = {
			stagId = data.stageId,
			lockPetRaceIds = data.lockPetRaceIds,
			buffNum = data.buffNum
		}
	end

	if checknumber(data.changeSetId) > 0 and self._extInfos[data.activityId] then
		self._extInfos[data.activityId].gainedPrize = true
	end
end

function OriginPowersClgModel:saveTempBattleResult(msg)
	self._tempResult = GameUtil.pbToTable(msg)
end

function OriginPowersClgModel:getTempBattleResult()
	return self._tempResult
end

function OriginPowersClgModel:resestBattleResult()
	self._tempResult = nil
end

function OriginPowersClgModel:isGainExtremePrize(activityId)
	if self._extInfos[activityId] then
		return self._extInfos[activityId].gainedPrize
	end

	return false
end

function OriginPowersClgModel:isGainNormalPrize(activityId, prizeId)
	return false
end

function OriginPowersClgModel:saveNormalInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._normalInfo[data.activityId] = data

	local stageInfo = {}

	if data.stages then
		for i, v in ipairs(data.stages) do
			stageInfo[v.indexId] = v
		end
	end

	self._normalStageInfos[data.activityId] = stageInfo

	local prizeGainMap = {}

	if data.gainedPrizeIds then
		for i, v in ipairs(data.gainedPrizeIds) do
			prizeGainMap[v] = true
		end
	end

	self._prizeGainMap[data.activityId] = prizeGainMap
end

function OriginPowersClgModel:saveNormalBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local oldNum = checknumber(self._normalStageInfos[data.activityId][data.index])

	if oldNum < data.buffNum then
		self._normalStageInfos[data.activityId][data.index] = {
			indexId = data.index,
			buffNum = data.buffNum
		}
		self._normalInfo[data.activityId].totalBuffNum = self._normalInfo[data.activityId].totalBuffNum - oldNum + data.buffNum
	end
end

function OriginPowersClgModel:getNormalStageInfo(activityId, index)
	if self._normalStageInfos[activityId] then
		return self._normalStageInfos[activityId][index]
	end
end

function OriginPowersClgModel:isGainPrize(activityId, prizeId)
	if self._prizeGainMap[activityId] then
		return self._prizeGainMap[activityId][prizeId] or false
	end

	return false
end

function OriginPowersClgModel:savePrizeInfo(msg)
	self._prizeGainMap[msg.activityId] = self._prizeGainMap[msg.activityId] or {}
	self._prizeGainMap[msg.activityId][msg.prizeId] = true
end

OriginPowersClgModel.instance = OriginPowersClgModel.New()

return OriginPowersClgModel
