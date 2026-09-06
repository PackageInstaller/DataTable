-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/data/KingKaYaMo.lua

module("logic.extensions.kingkaya.data.KingKaYaMo", package.seeall)

local KingKaYaMo = class("KingKaYaMo")

function KingKaYaMo:ctor(activityId)
	self._activityId = activityId
	self._lockRaceIdsInExt = {}
	self._signScoresInExt = {}
	self._passStagesInExt = {}
	self._extClgEndRes = nil
	self._stageIdListInNor = {}
	self._passStagesInNor = {}
	self._totalScoreInNor = 0
	self._gainedPrizeIdsInNor = {}
	self._norClgEndRes = nil
	self._petPosInExt = {}
	self._curTabIdxInExt = 0
end

function KingKaYaMo:getActivityId()
	return self._activityId
end

function KingKaYaMo:handlePM_KingKaYaGetInfoRes(msg)
	self._signScoresInExt = {}
	self._passStagesInExt = {}
	self._lockRaceIdsInExt = {}

	for i, v in ipairs(msg.extremeStages) do
		local stageId = v.stageId

		self._lockRaceIdsInExt[stageId] = v.lockRaceIds
		self._signScoresInExt[stageId] = {}

		for signId, score in ipairs(v.signScores) do
			self._signScoresInExt[stageId][signId] = score
		end
	end

	for stageId, signScores in pairs(self._signScoresInExt) do
		local stageData = KingKaYaConfig.instance:getExtStageData(self._activityId, stageId)

		if stageData then
			self._passStagesInExt[stageId] = true

			for signId, needScore in ipairs(stageData.winScoreRequirements) do
				local score = signScores[signId]

				if score < needScore then
					self._passStagesInExt[stageId] = false

					break
				end
			end
		end
	end

	self._stageIdListInNor = {}

	for i, v in ipairs(msg.normalInfo.stageIds) do
		local stageId = checknumber(v.left)

		self._passStagesInNor[stageId] = checknumber(v.right) == 1

		table.insert(self._stageIdListInNor, stageId)
	end

	self._totalScoreInNor = msg.normalInfo.totalScroe

	table.clear(self._gainedPrizeIdsInNor)
	table.insertto(self._gainedPrizeIdsInNor, msg.normalInfo.gainedPrizeIds)
end

function KingKaYaMo:handlePM_KingKaYaExtremeChallengeRes(msg)
	return
end

function KingKaYaMo:handlePM_KingKaYaResetExtremeStageRes(msg)
	local stageId = msg.stageId

	self._passStagesInExt[stageId] = false
	self._signScoresInExt[stageId] = nil
	self._lockRaceIdsInExt[stageId] = nil
end

function KingKaYaMo:handlePM_KingKaYaNormalChallengeRes(msg)
	return
end

function KingKaYaMo:handlePM_KingKaYaGainProgressPrizeRes(msg)
	table.insert(self._gainedPrizeIdsInNor, msg.prizeId)
end

function KingKaYaMo:handlePM_Notify_KingKaYaExtremeChallengeEndRes(msg)
	self._extClgEndRes = msg
end

function KingKaYaMo:handlePM_Notify_KingKaYaNormalChallengeEndRes(msg)
	self._norClgEndRes = msg
end

function KingKaYaMo:getLockRaceIdsInExtStage(stageId)
	return self._lockRaceIdsInExt[stageId] or {}
end

function KingKaYaMo:getLockRaceIdsInExt()
	local list = {}

	for k, lockRaceIds in pairs(self._lockRaceIdsInExt) do
		table.insertto(list, lockRaceIds)
	end

	return list
end

function KingKaYaMo:getSignScoresInExt(stageId, signId)
	return (self._signScoresInExt[stageId] or nil) and (self._signScoresInExt[stageId][signId] or 0)
end

function KingKaYaMo:isPassStageInExt(stageId)
	return checkbool(self._passStagesInExt[stageId])
end

function KingKaYaMo:isPassAllStageInExt()
	local isPassAll = true
	local cfg = KingKaYaConfig.instance:getExtStageCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if not self:isPassStageInExt(data.stageId) then
				isPassAll = false

				break
			end
		end
	end

	return isPassAll
end

function KingKaYaMo:getExtClgEndRes()
	return self._extClgEndRes
end

function KingKaYaMo:getStageIdListInNor()
	return self._stageIdListInNor
end

function KingKaYaMo:isPassStageInNor(stageId)
	return checkbool(self._passStagesInNor[stageId])
end

function KingKaYaMo:getTotalScoreInNor()
	return self._totalScoreInNor
end

function KingKaYaMo:isHasGainPrizeInNor(prizeId)
	return table.indexof(self._gainedPrizeIdsInNor, prizeId) ~= false
end

function KingKaYaMo:isEnoughGetPrizeInNor(prizeId)
	local data = KingKaYaConfig.instance:getNorProgressData(self._activityId, prizeId)

	if data then
		if not data.needScore then
			local need = 0
			local cur = self:getTotalScoreInNor()

			return need <= cur
		end
	end
end

function KingKaYaMo:_isCanGetPrizeInNor(prizeId)
	return not self:isHasGainPrizeInNor(prizeId) and self:isEnoughGetPrizeInNor(prizeId)
end

function KingKaYaMo:getNorClgEndRes()
	return self._norClgEndRes
end

function KingKaYaMo:getPetPosInExt(stageId)
	return self._petPosInExt[stageId] or {}
end

function KingKaYaMo:savePetPosInExt(stageId, posList)
	self._petPosInExt[stageId] = posList
end

function KingKaYaMo:getCurTabIdxInExt()
	return self._curTabIdxInExt
end

function KingKaYaMo:saveCurTabIdxInExt(value)
	self._curTabIdxInExt = value
end

return KingKaYaMo
