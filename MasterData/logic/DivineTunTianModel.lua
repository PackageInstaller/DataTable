-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/model/DivineTunTianModel.lua

module("logic.extensions.divinetuntian.model.DivineTunTianModel", package.seeall)

local DivineTunTianModel = class("DivineTunTianModel", BaseModel)

function DivineTunTianModel:onInit()
	self:onReset()
end

function DivineTunTianModel:onReset()
	self._customExtFmtMoPool = {}
	self._customNorFmtMoPool = {}
	self._infos = {}
	self._changeSetIdList = {}
	self._coordMap = {
		{
			0,
			1,
			-1
		},
		{
			-1,
			1,
			0
		},
		{
			1,
			0,
			-1
		},
		{
			0,
			0,
			0
		},
		{
			-1,
			0,
			1
		},
		{
			1,
			-1,
			0
		},
		{
			0,
			-1,
			1
		}
	}
end

function DivineTunTianModel:popChangeSetId()
	if #self._changeSetIdList > 0 then
		return table.remove(self._changeSetIdList, #self._changeSetIdList)
	end
end

function DivineTunTianModel:setChangeSetId(changeSetId)
	table.insert(self._changeSetIdList, changeSetId)
end

function DivineTunTianModel:getInfo(activityId)
	return self._infos[activityId]
end

function DivineTunTianModel:getExtFmtMo(activityId)
	if self._customExtFmtMoPool[activityId] == nil then
		self._customExtFmtMoPool[activityId] = DivineTunTianExtFmtMo.New()
	end

	return self._customExtFmtMoPool[activityId]
end

function DivineTunTianModel:getNorFmtMo(activityId)
	if self._customNorFmtMoPool[activityId] == nil then
		self._customNorFmtMoPool[activityId] = DivineTunTianNorFmtMo.New()
	end

	return self._customNorFmtMoPool[activityId]
end

function DivineTunTianModel:handlePM_DivineTunTianClgGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.extremeStageInfoMap = {}

	for i, stageInfo in ipairs(msg.extremeStageInfo) do
		info.extremeStageInfoMap[stageInfo.stageId] = stageInfo
	end
end

function DivineTunTianModel:handlePM_DivineTunTianClgExtremeResetRes(msg)
	local info = self._infos[msg.activityId]

	info.extremeStageInfoMap = {}
end

function DivineTunTianModel:handlePM_DivineTunTianClgGainNormalProgressPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.normalPrizeIds = info.normalPrizeIds or {}

	table.insert(info.normalPrizeIds, msg.prizeId)
end

function DivineTunTianModel:handlePM_DivineTunTianClgExtremeConfirmRes(msg)
	if msg.changeSetId > 0 then
		self:setChangeSetId(msg.changeSetId)
	end
end

function DivineTunTianModel:getPassPowerAfterAddScore(activityId, stageId, addScore, addStageId)
	local passPower = 0
	local info = self._infos[activityId]

	if info.extremeStageInfoMap[addStageId] == nil then
		info.extremeStageInfoMap[addStageId] = {}

		local extremeStageInfo = info.extremeStageInfoMap[addStageId]

		extremeStageInfo.score = checknumber(extremeStageInfo.score) + addScore
		extremeStageInfo.stageId = addStageId
	end

	if info then
		for k, info in pairs(info.extremeStageInfoMap) do
			local curStageId = info.stageId
			local precent = self:getPrecent(curStageId, stageId)

			passPower = passPower + math.ceil(precent * info.score)
		end
	end

	return passPower
end

function DivineTunTianModel:getPassPower(activityId, stageId)
	local passPower = 0
	local info = self._infos[activityId]

	if info then
		for k, info in pairs(info.extremeStageInfoMap) do
			local curStageId = info.stageId
			local precent = self:getPrecent(curStageId, stageId)

			passPower = passPower + math.ceil(precent * info.score)
		end
	end

	return passPower
end

function DivineTunTianModel:getPrecent(stageId, bePassedStageId)
	local x1, y1, z1, x2, y2, z2 = 0, 0, 0, 0, 0, 0
	local coord1 = self._coordMap[stageId]
	local coord2 = self._coordMap[bePassedStageId]

	if coord1 and coord2 then
		z1 = coord1[3]
		y1 = coord1[2]
		x1 = coord1[1]
		z2 = coord2[3]
		y2 = coord2[2]
		x2 = coord2[1]
	end

	local distance = (math.abs(x2 - x1) + math.abs(y2 - y1) + math.abs(z2 - z1)) / 2

	if distance == 1 then
		return 0.5
	elseif distance == 2 then
		return 0.25
	end

	return 0
end

function DivineTunTianModel:getAllNorScores(activityId)
	local totalScore = 0
	local info = self._infos[activityId]

	for i, score in ipairs(info.todayNormalMaxScores) do
		totalScore = totalScore + score
	end

	return totalScore
end

function DivineTunTianModel:hasWin(activityId, stageId)
	local extremeStageInfoMap = self._infos[activityId].extremeStageInfoMap

	return extremeStageInfoMap[stageId] ~= nil
end

function DivineTunTianModel:getLockRaceIds(activityId)
	local extremeStageInfoMap = self._infos[activityId].extremeStageInfoMap
	local lockRaceIds = {}

	for k, stageInfo in pairs(extremeStageInfoMap) do
		for _, raceId in ipairs(stageInfo.lockRaceIds) do
			table.insert(lockRaceIds, raceId)
		end
	end

	return lockRaceIds
end

DivineTunTianModel.instance = DivineTunTianModel.New()

return DivineTunTianModel
