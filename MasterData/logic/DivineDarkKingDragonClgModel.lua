-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/model/DivineDarkKingDragonClgModel.lua

module("logic.extensions.divinedarkkingdragonclg.model.DivineDarkKingDragonClgModel", package.seeall)

local DivineDarkKingDragonClgModel = class("DivineDarkKingDragonClgModel", BaseModel)

function DivineDarkKingDragonClgModel:onInit()
	self:onReset()
end

function DivineDarkKingDragonClgModel:onReset()
	self._baseInfoMap = {}
	self._phaseInfoMap = {}
end

function DivineDarkKingDragonClgModel:getBaseInfo(activityId)
	local baseInfo = self._baseInfoMap[activityId]

	if not baseInfo then
		print(string.format("神曜暗星龙皇挑战数据未初始化：%s", activityId))
	end

	return baseInfo
end

function DivineDarkKingDragonClgModel:getPhaseInfoMap(activityId)
	return self._phaseInfoMap[activityId]
end

function DivineDarkKingDragonClgModel:getPhaseInfo(activityId, phaseId)
	if self._phaseInfoMap[activityId] then
		return self._phaseInfoMap[activityId][phaseId]
	end
end

function DivineDarkKingDragonClgModel:getStageInfo(activityId, phaseId, stageId)
	local phaseInfo = self:getPhaseInfo(activityId, phaseId)

	if phaseInfo then
		return phaseInfo.stageMap[stageId]
	end
end

function DivineDarkKingDragonClgModel:getCurBuffNum(activityId)
	local buffNum = 0
	local phaseInfoMap = self:getPhaseInfoMap(activityId) or {}

	for phaseId, phaseInfo in pairs(phaseInfoMap) do
		buffNum = buffNum + phaseInfo.info.buffNum
	end

	return buffNum
end

function DivineDarkKingDragonClgModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._baseInfoMap[activityId] = info

	if not info.phase then
		local phaseInfoMap = {}

		for _, phaseInfo in ipairs(info.phase) do
			local savePhaseInfo = {}

			if not phaseInfo.stages then
				local stageMap = {}
				local lockRaceIds = {}

				for i, stageInfo in ipairs(phaseInfo.stages) do
					stageMap[stageInfo.stageId] = stageInfo

					if not stageInfo.lockRaceIds then
						for k, raceId in ipairs(stageInfo.lockRaceIds) do
							table.insert(lockRaceIds, raceId)
						end
					end
				end

				savePhaseInfo.info = phaseInfo
				savePhaseInfo.stageMap = stageMap
				savePhaseInfo.lockRaceIds = lockRaceIds
				phaseInfoMap[phaseInfo.phaseId] = savePhaseInfo
			end
		end

		self._phaseInfoMap[activityId] = phaseInfoMap
	end
end

function DivineDarkKingDragonClgModel:onResetClg(msg)
	return
end

function DivineDarkKingDragonClgModel:onClgFinish(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		-- block empty
	end
end

DivineDarkKingDragonClgModel.instance = DivineDarkKingDragonClgModel.New()

return DivineDarkKingDragonClgModel
