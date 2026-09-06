-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/model/SummerTreasureSnatchModel.lua

module("logic.extensions.summertreasuresnatch.model.SummerTreasureSnatchModel", package.seeall)

local SummerTreasureSnatchModel = class("SummerTreasureSnatchModel", BaseModel)

function SummerTreasureSnatchModel:onInit()
	self:onReset()
end

function SummerTreasureSnatchModel:onReset()
	self._infos = {}
	self._rankInfos = {}
	self._pvpMatchInfos = {}
	self._pvpFmtMoPool = {}
	self._bossFmtMoPool = {}
	self._defendFmtMoPool = {}
	self._pendingPresetForms = {}
	self._presetFormationMap = {}
	self._campInfoMap = {}
	self._gainBuffIdMap = {}
	self._petExperienceMap = {}
	self._bossInfoMap = {}
	self._bossBindRaceIdMap = {}
end

function SummerTreasureSnatchModel:getInfo(activityId)
	return self._infos[activityId]
end

function SummerTreasureSnatchModel:getRankInfo(activityId)
	return self._rankInfos[activityId]
end

function SummerTreasureSnatchModel:getPvpMatchInfo(activityId)
	return self._pvpMatchInfos[activityId]
end

function SummerTreasureSnatchModel:getPresetFormationMap(activityId)
	return self._presetFormationMap[activityId]
end

function SummerTreasureSnatchModel:getBuffIdMap(activityId)
	return self._gainBuffIdMap[activityId]
end

function SummerTreasureSnatchModel:getPetExperienceMap(activityId)
	return self._petExperienceMap[activityId]
end

function SummerTreasureSnatchModel:getPvpFmtMo(activityId)
	if self._pvpFmtMoPool[activityId] == nil then
		self._pvpFmtMoPool[activityId] = SummerTreasureSnatchPvpFmtMo.New()
	end

	return self._pvpFmtMoPool[activityId]
end

function SummerTreasureSnatchModel:getBossFmtMo(activityId)
	if self._bossFmtMoPool[activityId] == nil then
		self._bossFmtMoPool[activityId] = SummerTreasureSnatchBossFmtMo.New()
	end

	return self._bossFmtMoPool[activityId]
end

function SummerTreasureSnatchModel:getDefendFmtMo(activityId)
	if self._defendFmtMoPool[activityId] == nil then
		self._defendFmtMoPool[activityId] = SummerTreasureSnatchFmtMo.New()
	end

	return self._defendFmtMoPool[activityId]
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchInfoRes(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = msg.activityId

	info.presetFormation = info.presetFormation or {}
	self._presetFormationMap[activityId] = {}

	for _, formInfo in ipairs(info.presetFormation) do
		self._presetFormationMap[activityId][formInfo.formId] = formInfo
	end

	info.campInfo = info.campInfo or {}
	self._campInfoMap[activityId] = {}

	for _, campInfo in ipairs(info.campInfo) do
		self._campInfoMap[activityId][campInfo.campId] = campInfo
	end

	info.gainItemId = info.gainItemId or {}
	self._gainBuffIdMap[activityId] = {}
	self._petExperienceMap[activityId] = {}
	info.bossInfo = info.bossInfo or {}
	self._bossInfoMap[activityId] = {}
	self._bossBindRaceIdMap[activityId] = {}

	for _, bossInfo in ipairs(info.bossInfo) do
		self._bossInfoMap[activityId][bossInfo.bossId] = bossInfo
		bossInfo.bindRaceId = bossInfo.bindRaceId or {}
		self._bossBindRaceIdMap[activityId][bossInfo.bossId] = {}

		for _, raceId in ipairs(bossInfo.bindRaceId) do
			self._bossBindRaceIdMap[activityId][bossInfo.bossId][raceId] = true
		end
	end

	self._infos[activityId] = info
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchPvpFightRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.todayPvpTimes = checknumber(info.todayPvpTimes) + 1
		info.score = checknumber(info.score) + checknumber(msg.gainScore)
	end
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchPvpMatchRes(msg)
	self._pvpMatchInfos[msg.activityId] = msg
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchBossClgRes(msg)
	return
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchNotifyBossClgRes(msg)
	local result = GameUtil.pbToTable(msg)

	result.bindRaceId = result.bindRaceId or {}

	local info = self._infos[msg.activityId]

	if not info or msg.isTrial then
		return
	end

	info.damage = checknumber(info.damage) + checknumber(msg.damage)
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchBuyItemRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.gainItemId = info.gainItemId or {}

		table.insert(info.gainItemId, msg.itemId)
	end
end

function SummerTreasureSnatchModel:setPendingPresetForms(activityId, formList)
	self._pendingPresetForms[activityId] = formList
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchPresetFormationRes(msg)
	local info = self._infos[msg.activityId]
	local formList = self._pendingPresetForms[msg.activityId]

	self._pendingPresetForms[msg.activityId] = nil

	if not info or not formList then
		return
	end

	self._presetFormationMap[msg.activityId] = {}

	for idx, form in ipairs(formList) do
		self._presetFormationMap[msg.activityId][idx] = {
			formId = idx,
			form = form
		}
	end
end

function SummerTreasureSnatchModel:handlePM_SummerTreasureSnatchRankViewRes(msg)
	local rankInfo = GameUtil.pbToTable(msg)

	rankInfo.infoList = rankInfo.infoList or {}
	self._rankInfos[msg.activityId] = rankInfo
end

function SummerTreasureSnatchModel:hasBuff(activityId, buffId)
	return self._gainBuffIdMap[activityId] and self._gainBuffIdMap[activityId][buffId] == true
end

function SummerTreasureSnatchModel:getCampInfo(activityId, campId)
	return self._campInfoMap[activityId] and self._campInfoMap[activityId][campId]
end

function SummerTreasureSnatchModel:getBossInfo(activityId, bossId)
	return self._bossInfoMap[activityId] and self._bossInfoMap[activityId][bossId]
end

function SummerTreasureSnatchModel:getBossBindRaceIdMaps(activityId)
	return self._bossBindRaceIdMap[activityId]
end

function SummerTreasureSnatchModel:getBossBindRaceIdMap(activityId, bossId)
	local bossBindRaceIdMap = self._bossBindRaceIdMap[activityId]

	return (bossBindRaceIdMap or nil) and (bossBindRaceIdMap[bossId] or {})
end

function SummerTreasureSnatchModel:getCampWinRate(activityId, campId)
	local leftCampInfo = self:getCampInfo(activityId, SummerTreasureSnatchController.TeamType.Left)
	local rightCampInfo = self:getCampInfo(activityId, SummerTreasureSnatchController.TeamType.Right)
	local leftPvpWinNum = leftCampInfo and checknumber(leftCampInfo.pvpWinNum) or 0
	local rightPvpWinNum = rightCampInfo and checknumber(rightCampInfo.pvpWinNum) or 0
	local totalPvpNum = leftPvpWinNum + rightPvpWinNum
	local leftWinRate = 0

	if totalPvpNum == 0 then
		return 0
	end

	if leftPvpWinNum + rightPvpWinNum ~= 0 then
		leftWinRate = leftPvpWinNum / (leftPvpWinNum + rightPvpWinNum)
	end

	if campId == SummerTreasureSnatchController.TeamType.Left then
		return math.ceil(leftWinRate * 100)
	else
		return 100 - math.ceil(leftWinRate * 100)
	end

	return 0
end

function SummerTreasureSnatchModel:hasPreSetFormation(activityId)
	local presetFormationMap = self._presetFormationMap[activityId]
	local hasPreset = false

	for k, v in pairs(presetFormationMap) do
		if v then
			hasPreset = true
		end
	end

	return hasPreset
end

function SummerTreasureSnatchModel:getBuffIdList(activityId)
	local buffIdMap = self._gainBuffIdMap[activityId]
	local buffIdList = {}

	if buffIdMap then
		for k, v in pairs(buffIdMap) do
			table.insert(buffIdList, k)
		end
	end

	return buffIdList
end

SummerTreasureSnatchModel.instance = SummerTreasureSnatchModel.New()

return SummerTreasureSnatchModel
