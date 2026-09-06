-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/model/DragonXiuerModel.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerModel", package.seeall)

local DragonXiuerModel = class("DragonXiuerModel", BaseModel)

function DragonXiuerModel:ctor()
	return
end

function DragonXiuerModel:onInit()
	self:onReset()
end

function DragonXiuerModel:onReset()
	self.infos = {}
end

function DragonXiuerModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local saveInfo = {}

	saveInfo.destroyModeInfo = info.destroyModeInfo
	saveInfo.passedStage = {}

	for i, stageInfo in ipairs(info.destroyModeInfo.stageInfos or {}) do
		local scores = {}

		for j, score in ipairs(stageInfo.scores) do
			scores[score.teamIndex + 1] = score
		end

		saveInfo.passedStage[stageInfo.stageId] = info.destroyModeInfo.passedStageId >= stageInfo.stageId and {
			isPass = true,
			scores = scores
		} or {
			isPass = false,
			scores = scores
		}
	end

	saveInfo.soulModeInfo = info.soulModeInfo
	saveInfo.bossInfoMap = {}

	for i, bossInfo in ipairs(info.soulModeInfo.bossInfos or {}) do
		saveInfo.bossInfoMap[bossInfo.bossId] = bossInfo
	end

	self.infos[msg.activityId] = saveInfo
end

function DragonXiuerModel:resetStageInfo(activityId, stageId, teamIndex)
	self.infos[activityId].passedStage[stageId].scores[teamIndex] = {
		score = 0
	}
end

function DragonXiuerModel:getLockPetIdsList(activityId, stageId)
	local petIds = {}

	if not self.infos[activityId] or not self.infos[activityId].passedStage or not self.infos[activityId].passedStage[stageId] then
		return petIds
	end

	for i, info in pairs(self.infos[activityId].passedStage[stageId].scores) do
		for j, petId in ipairs(info.lockPetIds or {}) do
			table.insert(petIds, petId)
		end
	end

	return petIds
end

function DragonXiuerModel:getLockPetIdsMap(activityId, stageId)
	local petIds = {}

	if not self.infos[activityId] or not self.infos[activityId].passedStage or not self.infos[activityId].passedStage[stageId] then
		return petIds
	end

	for i, info in pairs(self.infos[activityId].passedStage[stageId].scores) do
		for j, petId in ipairs(info.lockPetIds or {}) do
			petIds[petId] = true
		end
	end

	return petIds
end

function DragonXiuerModel:getStageInfo(activityId, stageId)
	if self.infos[activityId] and self.infos[activityId].passedStage then
		return self.infos[activityId].passedStage[stageId]
	else
		return nil
	end
end

function DragonXiuerModel:getTeamInfo(activityId, stageId, teamIndex)
	if self.infos[activityId] and self.infos[activityId].passedStage and self.infos[activityId].passedStage[stageId] and self.infos[activityId].passedStage[stageId].scores then
		return self.infos[activityId].passedStage[stageId].scores[teamIndex]
	else
		return nil
	end
end

function DragonXiuerModel:getPassStageId(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].destroyModeInfo.passedStageId
	else
		return 0
	end
end

function DragonXiuerModel:getLevelFmtMo()
	self._levelFmtMo = self._levelFmtMo or DragonXiuerLevelFmtMo.New()

	return self._levelFmtMo
end

function DragonXiuerModel:getBossFmtMo()
	self._bossFmtMo = self._bossFmtMo or DragonXiuerBossFmtMo.New()

	return self._bossFmtMo
end

function DragonXiuerModel:setFromStageEnd(msg, activityId, stageId, teamIndex)
	local info = GameUtil.pbToTable(msg)

	if info.passStage == true then
		self.infos[activityId].destroyModeInfo.passedStageId = self.infos[activityId].destroyModeInfo.passedStageId + 1
	end

	self.infos[activityId].passedStage[stageId].scores[teamIndex].score = info.score
	self.infos[activityId].passedStage[stageId].scores[teamIndex].lockPetIds = info.lockPetIds
end

function DragonXiuerModel:getBossInfo(activityId, bossId)
	return self.infos[activityId].bossInfoMap[bossId]
end

function DragonXiuerModel:getBossTime(activityId)
	return checknumber(self.infos[activityId].soulModeInfo.hasChallengeTimes)
end

function DragonXiuerModel:getIsPassBoss(activityId)
	return self.infos[activityId].soulModeInfo.passed
end

function DragonXiuerModel:saveBossInfo(msg, activityId)
	local info = GameUtil.pbToTable(msg)

	self.infos[activityId].soulModeInfo = info

	local bossInfoMap = {}

	for i, bossInfo in ipairs(info.bossInfos or {}) do
		bossInfoMap[bossInfo.bossId] = bossInfo
	end

	self.infos[activityId].bossInfoMap = bossInfoMap
end

function DragonXiuerModel:saveBossCfgInfo(bossInfo)
	self._bossCfgInfo = bossInfo
end

function DragonXiuerModel:getBossCfgInfo()
	return self._bossCfgInfo
end

function DragonXiuerModel:setResultViewName(viewName)
	self._resultViewName = viewName
end

function DragonXiuerModel:getResultViewName()
	return self._resultViewName
end

DragonXiuerModel.instance = DragonXiuerModel.New()

return DragonXiuerModel
