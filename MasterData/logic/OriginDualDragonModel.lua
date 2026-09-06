-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/model/OriginDualDragonModel.lua

module("logic.extensions.origindualdragon.model.OriginDualDragonModel", package.seeall)

local OriginDualDragonModel = class("OriginDualDragonModel", BaseModel)
local STAGE_TYPE_KINDNESS = 1

function OriginDualDragonModel:onInit()
	self:onReset()
end

function OriginDualDragonModel:onReset()
	self._fmtMo = nil
	self._challengeContext = nil
	self._tempChallengeResult = nil
	self._tempPrizeChangeSetId = nil
	self._pendingReChallenge = false
end

function OriginDualDragonModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginDualDragonFmtMo.New()

	return self._fmtMo
end

function OriginDualDragonModel:saveChallengeContext(activityId, stageType, stageId, raceIdList)
	self._challengeContext = {
		activityId = checknumber(activityId),
		stageType = checknumber(stageType),
		stageId = checknumber(stageId),
		raceIdList = raceIdList or {}
	}
end

function OriginDualDragonModel:getChallengeContext()
	return self._challengeContext
end

function OriginDualDragonModel:saveTempChallengeResult(resultData)
	self._tempChallengeResult = resultData
end

function OriginDualDragonModel:getTempChallengeResult()
	return self._tempChallengeResult
end

function OriginDualDragonModel:clearTempChallengeResult()
	self._tempChallengeResult = nil
end

function OriginDualDragonModel:buildKindnessResultPetDataList(msg)
	local petDataList = {}

	for _, pairInfo in ipairs(msg.raceIdToHpRatio or {}) do
		local raceId = checknumber(pairInfo.left)
		local hpRate = checknumber(pairInfo.right) / 10000

		table.insert(petDataList, {
			raceId = raceId,
			hpRate = Mathf.Clamp(hpRate, 0, 1),
			isDie = hpRate <= 0
		})
	end

	return petDataList
end

function OriginDualDragonModel:buildEvilResultPetDataList()
	if not self._challengeContext then
		local petDataList = {}

		for _, raceId in ipairs(self._challengeContext.raceIdList or {}) do
			raceId = checknumber(raceId)

			table.insert(petDataList, {
				isDie = false,
				hpRate = 1,
				raceId = raceId
			})
		end

		return petDataList
	end
end

function OriginDualDragonModel:buildResultPetDataList(msg)
	if checknumber(msg.stageType) == STAGE_TYPE_KINDNESS then
		return self:buildKindnessResultPetDataList(msg)
	end

	return self:buildEvilResultPetDataList()
end

function OriginDualDragonModel:saveTempPrizeChangeSet(changeSetId)
	self._tempPrizeChangeSetId = changeSetId
end

function OriginDualDragonModel:getTempPrizeChangeSet()
	return self._tempPrizeChangeSetId
end

function OriginDualDragonModel:setPendingReChallenge(isPending)
	self._pendingReChallenge = isPending == true
end

function OriginDualDragonModel:isPendingReChallenge()
	return self._pendingReChallenge == true
end

function OriginDualDragonModel:clearPendingReChallenge()
	self._pendingReChallenge = false
end

OriginDualDragonModel.instance = OriginDualDragonModel.New()

return OriginDualDragonModel
