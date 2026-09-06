-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/model/WuWenChallengeModel.lua

module("logic.extensions.wuwenchallenge.model.WuWenChallengeModel", package.seeall)

local WuWenChallengeModel = class("WuWenChallengeModel", BaseModel)

function WuWenChallengeModel:ctor()
	return
end

function WuWenChallengeModel:onInit()
	self:onReset()
end

function WuWenChallengeModel:onReset()
	self._info = {}
	self._tempFightInfo = {}
	self._tempFightInfo = {}
	self._fmtMoMap = {}
	self._fmtMo = nil
end

function WuWenChallengeModel:getCurrActId()
	return 374001
end

function WuWenChallengeModel:setInfo(msg)
	local info = GameUtil.pbToTable(msg).clgInfo

	info.passStageMap = {}

	if info.stageIdPassed then
		for i, v in ipairs(info.stageIdPassed) do
			info.passStageMap[v] = true
		end
	end

	info.buffUseMap = {}

	if info.buffUsedInfo then
		for i, v in ipairs(info.buffUsedInfo) do
			info.buffUseMap[v.left] = v.right
		end
	end

	info.raceHpRateMap = {}

	if info.raceHpRateInfo then
		for i, v in ipairs(info.raceHpRateInfo) do
			info.raceHpRateMap[v.left] = v.right
		end
	end

	self._info[msg.activityId] = info
end

function WuWenChallengeModel:getChallengeInfo(activityId)
	return self._info[activityId]
end

function WuWenChallengeModel:getStagePass(activityId, stageId)
	local info = self:getChallengeInfo(activityId)

	return (info or nil) and (info.passStageMap[stageId] or false)
end

function WuWenChallengeModel:getAlivePetCount(activityId)
	local info = self:getChallengeInfo(activityId)

	return (info or nil) and (info.alivePetCount or 0)
end

function WuWenChallengeModel:getCurLevel(activityId)
	local info = self:getChallengeInfo(activityId)

	return (info or nil) and (info.curPhaseId or 1)
end

function WuWenChallengeModel:getBuffUseCount(activityId, buffId)
	local info = self:getChallengeInfo(activityId)

	return (info or nil) and (info.buffUseMap[buffId] or 0)
end

function WuWenChallengeModel:getPetRateMap(activityId, raceId)
	local info = self:getChallengeInfo(activityId)

	return (info or nil) and (info.raceHpRateMap[raceId] or 100)
end

function WuWenChallengeModel:saveFightInfo(msg)
	self._tempFightInfo[msg.activityId] = GameUtil.pbToTable(msg)
end

function WuWenChallengeModel:getFightInfo(activityId)
	return self._tempFightInfo[activityId]
end

function WuWenChallengeModel:resetFightInfo(activityId)
	self._tempFightInfo[activityId] = nil
end

function WuWenChallengeModel:getFmtMo()
	self._fmtMo = self._fmtMo or WuWenChallengeFmtMo.New()

	return self._fmtMo
end

WuWenChallengeModel.instance = WuWenChallengeModel.New()

return WuWenChallengeModel
