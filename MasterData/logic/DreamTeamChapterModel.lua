-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/model/DreamTeamChapterModel.lua

module("logic.extensions.dreamteamchapter.model.DreamTeamChapterModel", package.seeall)

local DreamTeamChapterModel = class("DreamTeamChapterModel", BaseModel)

function DreamTeamChapterModel:onInit()
	self:onReset()
end

function DreamTeamChapterModel:onReset()
	self._infos = {}
	self._rankInfos = {}
	self._challengeInfoMaps = {}
	self._progressInfoMaps = {}
	self._lastBossDamageMap = {}
	self._hotMMFmtMoPool = {}
	self._multMMFmtMoPool = {}
	self._chap3FmtMoPool = {}
	self._hasClickChapterMap = {}
	self._hotMMStageKillMap = {}
	self._changeSetList = {}
end

function DreamTeamChapterModel:getInfo(activityId)
	return self._infos[activityId]
end

function DreamTeamChapterModel:getRankInfo(activityId)
	return self._rankInfos[activityId]
end

function DreamTeamChapterModel:getChallengeInfoMap(activityId)
	return self._challengeInfoMaps[activityId]
end

function DreamTeamChapterModel:getProgressInfoMap(activityId)
	return self._progressInfoMaps[activityId]
end

function DreamTeamChapterModel:getLastBossDamage(activityId)
	return self._lastBossDamageMap[activityId]
end

function DreamTeamChapterModel:gethasClickChapterMap(activityId)
	return self._hasClickChapterMap[activityId]
end

function DreamTeamChapterModel:getHotMMStageKillMap(activityId)
	return self._hotMMStageKillMap[activityId]
end

function DreamTeamChapterModel:pushChangeSetList(changeSetId)
	return table.insert(self._changeSetList, changeSetId)
end

function DreamTeamChapterModel:popChangeSetList()
	if #self._changeSetList > 0 then
		return table.remove(self._changeSetList, #self._changeSetList)
	end
end

function DreamTeamChapterModel:getHotMMFmtMo(activityId)
	if self._hotMMFmtMoPool[activityId] == nil then
		self._hotMMFmtMoPool[activityId] = DreamTeamChapterHotMMFmtMo.New()
	end

	return self._hotMMFmtMoPool[activityId]
end

function DreamTeamChapterModel:getMultMMFmtMo(activityId)
	if self._multMMFmtMoPool[activityId] == nil then
		self._multMMFmtMoPool[activityId] = DreamTeamChapterMultMMFmtMo.New()
	end

	return self._multMMFmtMoPool[activityId]
end

function DreamTeamChapterModel:getChap3FmtMo(activityId)
	if self._chap3FmtMoPool[activityId] == nil then
		self._chap3FmtMoPool[activityId] = DreamTeamChapter3FmtMo.New()
	end

	return self._chap3FmtMoPool[activityId]
end

function DreamTeamChapterModel:getBattleFmtMo(activityId, challengeId, stageId)
	if DreamTeamChapterConfig.instance:isMultBattleStage(activityId, challengeId, stageId) then
		return self:getMultMMFmtMo(activityId)
	end

	return self:getHotMMFmtMo(activityId)
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.hasClickChapter = msg.hasClickChapter or {}
	info.challengeInfo = info.challengeInfo or {}
	info.progressInfo = info.progressInfo or {}
	info.passionStageToKillNum = info.passionStageToKillNum or {}
	info.hasSmeltPotion = info.hasSmeltPotion or {}
	self._challengeInfoMaps[msg.activityId] = {}

	local challengeInfoMap = self._challengeInfoMaps[msg.activityId]

	for _, challengeInfo in ipairs(info.challengeInfo) do
		challengeInfo.passStageId = challengeInfo.passStageId or {}
		challengeInfoMap[challengeInfo.challengeId] = challengeInfo
	end

	self._hasClickChapterMap[msg.activityId] = {}

	local hasClickChapterMap = self._hasClickChapterMap[msg.activityId]

	for i, chapter in ipairs(info.hasClickChapter) do
		hasClickChapterMap[chapter] = true
	end

	self._hotMMStageKillMap[msg.activityId] = {}

	local hotMMStageKillMap = self._hotMMStageKillMap[msg.activityId]

	for i, pair in ipairs(info.passionStageToKillNum) do
		hotMMStageKillMap[pair.left] = pair.right
	end

	self._progressInfoMaps[msg.activityId] = {}

	local progressInfoMap = self._progressInfoMaps[msg.activityId]

	for i, info in ipairs(info.progressInfo) do
		progressInfoMap[info.progressType] = info.maxGainProgressId
	end
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterSmeltRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.alchemyScore = checknumber(info.alchemyScore) + checknumber(msg.gainScore)

		if msg.smeltPotion > 0 then
			local hasSmeltPotion = info.hasSmeltPotion

			table.insert(hasSmeltPotion, msg.smeltPotion)
		end
	end
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterChallengeRes(msg)
	return
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterNotifyClgRes(msg)
	if not checkbool(msg.isPass) then
		return
	end

	self._challengeInfoMaps[msg.activityId] = self._challengeInfoMaps[msg.activityId] or {}

	local challengeInfoMap = self._challengeInfoMaps[msg.activityId]
	local info = self._infos[msg.activityId]
	local challengeInfo = challengeInfoMap[msg.challengeId]

	if challengeInfo == nil then
		challengeInfo = {
			challengeId = msg.challengeId,
			passStageId = {}
		}
		challengeInfoMap[msg.challengeId] = challengeInfo

		if info then
			info.challengeInfo = info.challengeInfo or {}

			table.insert(info.challengeInfo, challengeInfo)
		end
	else
		challengeInfo.passSt = challengeInfo.passStageId or {}
	end

	if not TableUtil.isHad(challengeInfo.passStageId, msg.stageId) then
		table.insert(challengeInfo.passStageId, msg.stageId)
	end

	if checknumber(msg.passionKillNum) > 0 then
		local hotKillNumMap = self._hotMMStageKillMap[msg.activityId]

		hotKillNumMap[msg.stageId] = msg.passionKillNum
	end
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterChallengeBossRes(msg)
	return
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterNotifyBossClgRes(msg)
	self._lastBossDamageMap[msg.activityId] = checknumber(msg.damage)

	local info = self._infos[msg.activityId]

	if info then
		info.todayBossClgTimes = checknumber(info.todayBossClgTimes) + 1
		info.totalBossDamage = checknumber(info.totalBossDamage) + checknumber(msg.damage)
	end
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterOneClickGainProgressPrizeRes(msg)
	self._progressInfoMaps[msg.activityId] = self._progressInfoMaps[msg.activityId] or {}

	local progressInfoMap = self._progressInfoMaps[msg.activityId]

	progressInfoMap[msg.progressType] = msg.maxGainProgressId
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterRankViewRes(msg)
	self._rankInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterFirstClickRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.hasClickChapter = info.hasClickChapter or {}

		if not TableUtil.isHad(info.hasClickChapter, msg.chapterId) then
			table.insert(info.hasClickChapter, msg.chapterId)

			local hasClickChapterMap = self._hasClickChapterMap[msg.activityId]

			hasClickChapterMap[msg.chapterId] = true
		end
	end
end

function DreamTeamChapterModel:handlePM_DreamTeamChapterAwakenMengMengRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.hasAwakenMengMeng = true
	end
end

DreamTeamChapterModel.instance = DreamTeamChapterModel.New()

return DreamTeamChapterModel
