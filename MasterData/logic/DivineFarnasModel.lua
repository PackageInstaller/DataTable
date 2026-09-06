-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/model/DivineFarnasModel.lua

module("logic.extensions.divineeternaldragonclg.model.DivineFarnasModel", package.seeall)

local DivineFarnasModel = class("DivineFarnasModel", BaseModel)

function DivineFarnasModel:onInit()
	self:onReset()
end

function DivineFarnasModel:onReset()
	self._infos = {}
	self._activeRaceIdMap = {}
	self._stageRaceIdMap = {}
	self._customNorFmtMoPool = {}
	self._customExtFmtMoPool = {}
end

function DivineFarnasModel:getInfo(activityId)
	return self._infos[activityId]
end

function DivineFarnasModel:getNorFmtMo(activityId)
	if self._customNorFmtMoPool[activityId] == nil then
		self._customNorFmtMoPool[activityId] = DivineFarnasNorFmtMo.New()
	end

	return self._customNorFmtMoPool[activityId]
end

function DivineFarnasModel:getExtFmtMo(activityId)
	if self._customExtFmtMoPool[activityId] == nil then
		self._customExtFmtMoPool[activityId] = DivineFarnasExtFmtMo.New()
	end

	return self._customExtFmtMoPool[activityId]
end

function DivineFarnasModel:handlePM_DivineFarnasClgGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	self._activeRaceIdMap[msg.activityId] = self._activeRaceIdMap[msg.activityId] or {}
	self._stageRaceIdMap[msg.activityId] = self._stageRaceIdMap[msg.activityId] or {}

	local activeRaceIdMap = self._activeRaceIdMap[msg.activityId]
	local stageRaceIdMap = self._stageRaceIdMap[msg.activityId]

	info.extremeStages = info.extremeStages or {}
	info.normalStages = info.normalStages or {}

	local extremeStages = {}
	local normalStages = {}

	for i, extStage in ipairs(info.extremeStages) do
		extremeStages[extStage.stageId] = extStage

		if extStage.pass and extStage.activeRaceIds and stageRaceIdMap[extStage.stageId] == nil then
			for _, activeRaceId in ipairs(extStage.activeRaceIds) do
				activeRaceIdMap[activeRaceId] = checknumber(activeRaceIdMap[activeRaceId]) + 1
			end

			stageRaceIdMap[extStage.stageId] = true
		end
	end

	for i, norStage in ipairs(info.normalStages) do
		normalStages[norStage.stageId] = norStage
	end

	info.extremeStages = extremeStages
	info.normalStages = normalStages
end

function DivineFarnasModel:handlePM_DivineFarnasClgExtremeFightNotifyRes(msg)
	local pb = GameUtil.pbToTable(msg)

	if pb.isPass then
		local info = self._infos[msg.activityId]

		info.extremeStages[msg.stageId] = pb.extremeStages

		if not msg.extremeStages.activeRaceIds then
			local activeRaceIdMap = self._activeRaceIdMap[msg.activityId]
			local stageRaceIdMap = self._stageRaceIdMap[msg.activityId]

			for i, raceId in ipairs(msg.extremeStages.activeRaceIds) do
				activeRaceIdMap[raceId] = checknumber(activeRaceIdMap[raceId]) + 1
			end

			stageRaceIdMap[msg.stageId] = true
		end
	end
end

function DivineFarnasModel:handlePM_DivineFarnasClgResetRes(msg)
	local info = self._infos[msg.activityId]
	local extremeStages = info.extremeStages
	local activeRaceIdMap = self._activeRaceIdMap[msg.activityId]
	local stageRaceIdMap = self._stageRaceIdMap[msg.activityId]
	local curExtremeStage = extremeStages[msg.stageId]

	if curExtremeStage.activeRaceIds then
		for i, raceId in ipairs(curExtremeStage.activeRaceIds) do
			activeRaceIdMap[raceId] = activeRaceIdMap[raceId] - 1
		end
	end

	info.extremeStages[msg.stageId] = msg.extremeStages
	stageRaceIdMap[msg.stageId] = nil
end

function DivineFarnasModel:handlePM_DivineFarnasClgGainPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.gainNormalPrizeIds = info.gainNormalPrizeIds or {}

	table.insert(info.gainNormalPrizeIds, msg.prizeId)
end

function DivineFarnasModel:getTotalRaceIdNum(activityId)
	local totalNum = 0
	local activeRaceIdMap = self._activeRaceIdMap[activityId]

	for k, num in pairs(activeRaceIdMap) do
		if num > 0 then
			totalNum = totalNum + 1
		end
	end

	return totalNum
end

function DivineFarnasModel:getDiffPetNum(activityId, stageId)
	local activeRaceIdMap = self._activeRaceIdMap[activityId]
	local info = self._infos[activityId]
	local extremeStages = info.extremeStages
	local curExtStages = extremeStages[stageId]

	if not curExtStages.activeRaceIds then
		local diffNum = 0

		if curExtStages then
			for i, raceId in ipairs(curExtStages.activeRaceIds) do
				local activeRaceIdNum = activeRaceIdMap[raceId]

				if activeRaceIdNum == 1 then
					diffNum = diffNum + 1
				end
			end
		end

		return diffNum
	end
end

function DivineFarnasModel:getDiffRaceIdList(activityId, stageId)
	local activeRaceIdMap = self._activeRaceIdMap[activityId]
	local info = self._infos[activityId]
	local extremeStages = info.extremeStages
	local curExtStages = extremeStages[stageId]

	if not curExtStages.activeRaceIds then
		local diffList = {}

		if curExtStages then
			for i, raceId in ipairs(curExtStages.activeRaceIds) do
				local activeRaceIdNum = activeRaceIdMap[raceId]

				if activeRaceIdNum == 1 then
					table.insert(diffList, raceId)
				end
			end
		end

		return diffList
	end
end

DivineFarnasModel.instance = DivineFarnasModel.New()

return DivineFarnasModel
