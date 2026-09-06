-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/model/TeShaMuChallengeModel.lua

module("logic.extensions.teshamu.model.TeShaMuChallengeModel", package.seeall)

local TeShaMuChallengeModel = class("TeShaMuChallengeModel", BaseModel)

function TeShaMuChallengeModel:ctor()
	return
end

function TeShaMuChallengeModel:onInit()
	self:onReset()
end

function TeShaMuChallengeModel:onReset()
	self.stageInfo = {}
	self.stageId = 1
	self.mapPlanId = 1
	self.activityId = nil
	self.petMoList = {}
	self.fmtMoPool = {}
	self.hasSignInToday = false
	self.signInBuffLv = 0
end

function TeShaMuChallengeModel:setStageInfo(msg)
	self.stageInfo = GameUtil.pbToTable(msg) or {}
end

function TeShaMuChallengeModel:getStageInfo()
	return self.stageInfo.stages or {}
end

function TeShaMuChallengeModel:getPassBlockIds(stageId)
	for _, v in pairs(self.stageInfo) do
		if v.stageId == stageId then
			return v.passBlockIds or {}
		end
	end

	return {}
end

function TeShaMuChallengeModel:setActId(activityId)
	self.activityId = activityId
end

function TeShaMuChallengeModel:getActId()
	return self.activityId
end

function TeShaMuChallengeModel:setStageId(stageId)
	self.stageId = stageId
end

function TeShaMuChallengeModel:getStageId()
	return checknumber(self.stageId)
end

function TeShaMuChallengeModel:setMapPlanId(mapPlanId)
	self.mapPlanId = mapPlanId
end

function TeShaMuChallengeModel:getMapPlanId()
	return self.mapPlanId
end

function TeShaMuChallengeModel:getChallengeFmtMo(activityId, stageId, blockId)
	if self.fmtMoPool[activityId] == nil then
		self.fmtMoPool[activityId] = {}
	end

	if self.fmtMoPool[activityId][stageId] == nil then
		self.fmtMoPool[activityId][stageId] = {}
	end

	if self.fmtMoPool[activityId][stageId][blockId] == nil then
		self.fmtMoPool[activityId][stageId][blockId] = TeShaMuChallengeFmtMo.New()
	end

	local fmtMo = self.fmtMoPool[activityId][stageId][blockId]

	fmtMo:initParams(activityId, stageId, blockId)

	return fmtMo
end

function TeShaMuChallengeModel:setWinId(winId)
	self._winId = winId
end

function TeShaMuChallengeModel:getWinId()
	self._winId = nil

	return self._winId
end

TeShaMuChallengeModel.instance = TeShaMuChallengeModel.New()

return TeShaMuChallengeModel
