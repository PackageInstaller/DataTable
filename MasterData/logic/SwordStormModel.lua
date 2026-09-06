-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/model/SwordStormModel.lua

module("logic.extensions.swordstorm.model.SwordStormModel", package.seeall)

local SwordStormModel = class("SwordStormModel", BaseModel)

SwordStormModel.ReadFlag = "SwordStormModel.ReadFlag"

function SwordStormModel:onInit()
	self:onReset()
end

function SwordStormModel:onReset()
	self._fmtMo = nil
	self._infos = {}
	self._stageInfo = {}
end

function SwordStormModel:getFmtMo()
	self._fmtMo = self._fmtMo or SwordStormFmtMo.New()

	return self._fmtMo
end

function SwordStormModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	local totalStageInfo = {}

	for i, phaseInfo in ipairs(data.phaseInfos or {}) do
		totalStageInfo[phaseInfo.phaseId] = {}

		local curPhaseInfo = totalStageInfo[phaseInfo.phaseId]

		for j, stageInfo in ipairs(phaseInfo.stageInfos or {}) do
			curPhaseInfo[stageInfo.stageId] = {}

			local curStageInfo = curPhaseInfo[stageInfo.stageId]

			for q, v in ipairs(stageInfo.reachConditionIds or {}) do
				curStageInfo[v] = true
			end
		end
	end

	self._stageInfo[data.activityId] = totalStageInfo
end

function SwordStormModel:getConditionComplete(activityId, phaseId, stageId, conditionId)
	if self._stageInfo[activityId] and self._stageInfo[activityId][phaseId] and self._stageInfo[activityId][phaseId][stageId] then
		return self._stageInfo[activityId][phaseId][stageId][conditionId]
	end

	return false
end

function SwordStormModel:saveReadStageStory(activityId, phaseId, stageId)
	local key = string.format("%s#%s#%s#%s#story", SwordStormModel.ReadFlag, activityId, phaseId, stageId)

	GameUtil.saveUserData(key, true)
end

function SwordStormModel:getReadStageStory(activityId, phaseId, stageId)
	local key = string.format("%s#%s#%s#%s#story", SwordStormModel.ReadFlag, activityId, phaseId, stageId)

	return GameUtil.getUserData(key)
end

function SwordStormModel:setTempPhaseId(phaseId)
	self._tempPhaseId = phaseId
end

function SwordStormModel:getTempPhase()
	return self._tempPhaseId
end

SwordStormModel.instance = SwordStormModel.New()

return SwordStormModel
