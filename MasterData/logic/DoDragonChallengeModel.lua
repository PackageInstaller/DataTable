-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/model/DoDragonChallengeModel.lua

module("logic.extensions.dodragonchallenge.model.DoDragonChallengeModel", package.seeall)

local DoDragonChallengeModel = class("DoDragonChallengeModel", BaseModel)

function DoDragonChallengeModel:ctor()
	return
end

function DoDragonChallengeModel:onInit()
	self:onReset()
end

function DoDragonChallengeModel:onReset()
	self._challengeMsgs = {}
	self._challengeInfoPool = {}
	self._extremeResultMsg = {}
	self._isHasPlay = true
	self._doDragonUnitCustomFmtMo = nil
	self._doDragonBossCustomFmtMo = nil
end

function DoDragonChallengeModel:handlePM_DisorderDragonChallengeGetInfoRes(msg)
	self._challengeMsgs[msg.activityId] = msg
	self._challengeInfoPool = {}

	for _, v in ipairs(msg.challenges) do
		self._challengeInfoPool[v.allChallengeId] = v
	end
end

function DoDragonChallengeModel:handlePM_DisorderDragonChallengeAllRes(msg)
	return
end

function DoDragonChallengeModel:handlePM_DisorderDragonChallengeExtremeRes(msg)
	return
end

function DoDragonChallengeModel:handlePM_DisorderDragonChallengeAllResultRes(msg)
	return
end

function DoDragonChallengeModel:handlePM_DisorderDragonChallengeExtremeResultRes(msg)
	self._extremeResultMsg = msg

	self:setHasPlayRelifeAnimAsBoss(false)
end

function DoDragonChallengeModel:_getInfoMsg(activityId)
	return self._challengeMsgs[activityId] or {}
end

function DoDragonChallengeModel:getFireNumAsUnit(activityId)
	return checknumber(self:_getInfoMsg(activityId).allFire)
end

function DoDragonChallengeModel:getChallengeIdListAsUnit(activityId)
	local challengeIdList = {}
	local msg = self:_getInfoMsg(activityId)

	if msg.challenges then
		for _, v in ipairs(msg.challenges) do
			table.insert(challengeIdList, v.allChallengeId)
		end
	end

	return challengeIdList
end

function DoDragonChallengeModel:getChallengeIdResultAsUnit(activityId, challengeId)
	if not self._challengeInfoPool[challengeId] then
		return checknumber(self._challengeInfoPool[challengeId].style)
	end
end

function DoDragonChallengeModel:getBossHpAsBoss(activityId)
	local hp = checknumber(self:_getInfoMsg(activityId).extremeBossHp)

	return Mathf.Max(hp, 0)
end

function DoDragonChallengeModel:getChallengeTimesAsBoss(activityId)
	return checknumber(self:_getInfoMsg(activityId).extremeTime)
end

function DoDragonChallengeModel:getUsedRaceIdsAsBoss(activityId)
	return self:_getInfoMsg(activityId).extremeUsedRaceIds or {}
end

function DoDragonChallengeModel:isPetHasUseAsBoss(activityId, raceId)
	local list = self:getUsedRaceIdsAsBoss(activityId)

	return table.indexof(list, raceId) ~= false
end

function DoDragonChallengeModel:getBuffIdAsBoss(activityId)
	return checknumber(self:_getInfoMsg(activityId).extremeRandBuffId)
end

function DoDragonChallengeModel:isPassExtreme(activityId)
	return checkbool(self:_getInfoMsg(activityId).extremePass)
end

function DoDragonChallengeModel:getExtremeMaxHp(activityId)
	return checknumber(self:_getInfoMsg(activityId).extremeMaxHp)
end

function DoDragonChallengeModel:getCustomFmtMoAsUnit()
	if self._doDragonUnitCustomFmtMo == nil then
		self._doDragonUnitCustomFmtMo = DoDragonUnitCustomFmtMo.New()
	end

	return self._doDragonUnitCustomFmtMo
end

function DoDragonChallengeModel:getCustomFmtMoAsBoss()
	if self._doDragonBossCustomFmtMo == nil then
		self._doDragonBossCustomFmtMo = DoDragonBossCustomFmtMo.New()
	end

	return self._doDragonBossCustomFmtMo
end

function DoDragonChallengeModel:getDecHpAsBoss()
	if not self._extremeResultMsg.decHp then
		return Mathf.Max(self._extremeResultMsg.decHp, 0)
	end
end

function DoDragonChallengeModel:isRelifeAsBoss()
	return checkbool(self._extremeResultMsg.isRelife)
end

function DoDragonChallengeModel:isHasPlayRelifeAnimAsBoss()
	return checkbool(self._isHasPlay)
end

function DoDragonChallengeModel:setHasPlayRelifeAnimAsBoss(isHasPlay)
	self._isHasPlay = isHasPlay
end

DoDragonChallengeModel.instance = DoDragonChallengeModel.New()

return DoDragonChallengeModel
