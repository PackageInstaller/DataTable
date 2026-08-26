-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiModel.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiModel", package.seeall)

local AergusiModel = class("AergusiModel", BaseModel)

function AergusiModel:onInit()
	self:reInit()
end

function AergusiModel:reInit()
	self._episodeInfos = {}
	self._evidenceDicts = {}
	self._curEpisodeId = 0
	self._curClueId = 0
	self._readClueList = {}
	self._unlockProcess = {
		0,
		0
	}
end

function AergusiModel:setEpisodeInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		local mo = AergusiEpisodeMo.New()

		mo:init(info)

		self._episodeInfos[info.episodeId] = mo
	end
end

function AergusiModel:getEpisodeInfo(episodeId)
	return self._episodeInfos[episodeId]
end

function AergusiModel:getEpisodeInfos()
	local infos = {}
	local firstEpisode = self:getFirstEpisode()

	local function getnextepisodeco(episodeId)
		local episodeCos = AergusiConfig.instance:getEpisodeConfigs()

		table.insert(infos, episodeCos[episodeId])

		for _, v in pairs(episodeCos) do
			if v.preEpisodeId == episodeId then
				return getnextepisodeco(v.episodeId)
			end
		end
	end

	getnextepisodeco(firstEpisode)

	return infos
end

function AergusiModel:getMaxUnlockEpisodeIndex()
	local episodeInfos = self:getEpisodeInfos()

	for i = 1, #episodeInfos do
		if not self:isEpisodeUnlock(episodeInfos[i].episodeId) and self:isEpisodeUnlock(episodeInfos[i].preEpisodeId) then
			return i - 1
		end
	end

	return #episodeInfos
end

function AergusiModel:getFirstEpisode()
	local episodeCos = AergusiConfig.instance:getEpisodeConfigs()

	for _, v in pairs(episodeCos) do
		if v.preEpisodeId == 0 then
			return v.episodeId
		end
	end

	return 0
end

function AergusiModel:getEpisodeNextEpisode(episodeId)
	local episodeCos = AergusiConfig.instance:getEpisodeConfigs()

	for _, v in pairs(episodeCos) do
		if v.preEpisodeId == episodeId then
			return v.episodeId
		end
	end

	return 0
end

function AergusiModel:getEpisodeIndex(episodeId)
	local infos = self:getEpisodeInfos()

	for i = 1, #infos do
		if infos[i].episodeId == episodeId then
			return i
		end
	end

	return 0
end

function AergusiModel:getNewFinishEpisode()
	return self._newFinishEpisode or -1
end

function AergusiModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function AergusiModel:getNewUnlockEpisode()
	return self._newUnlockEpisode or -1
end

function AergusiModel:setNewUnlockEpisode(episodeId)
	self._newUnlockEpisode = episodeId
end

function AergusiModel:isStoryEpisode(episodeId)
	local co = AergusiConfig.instance:getEpisodeConfig(nil, episodeId)

	return co.evidenceId == ""
end

function AergusiModel:getMaxPassedEpisode()
	local episodeCo = AergusiConfig.instance:getEpisodeConfigs()
	local maxEpisode = 0

	for _, co in pairs(episodeCo) do
		local episodePass = self:isEpisodePassed(co.episodeId)
		local prePass = co.preEpisodeId > 0 and self:isEpisodePassed(co.preEpisodeId)

		if prePass then
			if not episodePass then
				return co.preEpisodeId
			else
				maxEpisode = co.episodeId
			end
		end
	end

	return maxEpisode
end

function AergusiModel:setCurEpisode(episodeId)
	self._curEpisodeId = episodeId
end

function AergusiModel:getCurEpisode()
	return self._curEpisodeId
end

function AergusiModel:isEpisodeUnlock(episodeId)
	if self._episodeInfos[episodeId].episodeState >= AergusiEnum.ProgressState.Finished then
		return true
	else
		local preEpisodeId = AergusiConfig.instance:getEpisodeConfig(nil, episodeId).preEpisodeId

		if not preEpisodeId or preEpisodeId == 0 then
			return true
		end

		return self._episodeInfos[preEpisodeId].episodeState >= AergusiEnum.ProgressState.Finished
	end
end

function AergusiModel:isEpisodePassed(episodeId)
	return self._episodeInfos[episodeId] and self._episodeInfos[episodeId].episodeState >= AergusiEnum.ProgressState.Finished
end

function AergusiModel:setReadClueList(infos)
	self._readClueList = {}

	for _, v in ipairs(infos) do
		table.insert(self._readClueList, v)
	end
end

function AergusiModel:isClueReaded(clueId)
	for _, v in pairs(self._readClueList) do
		if v == clueId then
			return true
		end
	end

	if self._evidenceDicts[self._curEpisodeId] then
		for _, clueInfo in pairs(self._evidenceDicts[self._curEpisodeId].clueInfos) do
			if clueInfo.clueId == clueId then
				return clueInfo.status == 1
			end
		end
	end

	return false
end

function AergusiModel:setClueReaded(clueId)
	table.insert(self._readClueList, clueId)
end

function AergusiModel:setEvidenceInfo(episodeId, evidenceInfo)
	if not self._evidenceDicts[episodeId] then
		self._evidenceDicts[episodeId] = AergusiEvidenceMo.New()

		self._evidenceDicts[episodeId]:init(evidenceInfo)
	else
		self._evidenceDicts[episodeId]:update(evidenceInfo)
	end
end

function AergusiModel:setEpisodeUnlockAutoTipProcess(process)
	if process == "" then
		self._unlockProcess = {
			0,
			0
		}
	else
		local processes = string.splitToNumber(process, "_")

		self._unlockProcess = {
			processes[1],
			processes[2]
		}
	end
end

function AergusiModel:getUnlockAutoTipProcess()
	return self._unlockProcess
end

function AergusiModel:getEvidenceInfo(episodeId)
	return self._evidenceDicts[episodeId]
end

function AergusiModel:hasClueNotRead(clueConfigs)
	for _, v in pairs(clueConfigs) do
		if not self:isClueReaded(v.clueId) then
			return true
		end
	end

	return false
end

function AergusiModel:getAllClues(isInEpisode)
	local episodeInfos = self:getEpisodeInfos()

	if not self:isEpisodePassed(episodeInfos[1].episodeId) then
		return {}
	end

	for i = 1, #episodeInfos do
		if not self:isEpisodePassed(episodeInfos[i].episodeId) then
			local episodeCo = AergusiConfig.instance:getEpisodeConfig(nil, episodeInfos[i].episodeId)

			if self:isEpisodePassed(episodeCo.preEpisodeId) then
				return self:getEpisodeClueConfigs(episodeCo.preEpisodeId, isInEpisode)
			end
		end
	end

	return self:getEpisodeClueConfigs(episodeInfos[#episodeInfos].episodeId, isInEpisode)
end

function AergusiModel:getEpisodeClueConfigs(episodeId, isInEpisode)
	local isEpisodePass = self:isEpisodePassed(episodeId)
	local clues = {}

	if isInEpisode then
		local clueInfos = self._evidenceDicts[episodeId].clueInfos

		for _, clue in pairs(clueInfos) do
			local clueCo = AergusiConfig.instance:getClueConfig(clue.clueId)

			table.insert(clues, clueCo)
		end
	else
		local removeClues = {}
		local clueCos = AergusiConfig.instance:getClueConfigs()

		for _, clueCo in pairs(clueCos) do
			local isEpisodeClue = isEpisodePass and episodeId > clueCo.episodeId or episodeId >= clueCo.episodeId

			if isEpisodeClue then
				table.insert(clues, clueCo)

				if clueCo.materialId ~= "" then
					local materialCos = string.splitToNumber(clueCo.materialId, "#")

					for _, materialId in ipairs(materialCos) do
						table.insert(removeClues, materialId)
					end
				end

				if clueCo.replaceId ~= 0 then
					table.insert(removeClues, clueCo.replaceId)
				end
			end
		end

		for i = #clues, 1, -1 do
			for _, v in pairs(removeClues) do
				if clues[i].clueId == v then
					table.remove(clues, i)

					break
				end
			end
		end
	end

	table.sort(clues, function(a, b)
		return a.clueId < b.clueId
	end)

	return clues
end

function AergusiModel:getCouldMergeClues(bpClueConfigs)
	local couldMergeClues = {}
	local bgClues = {}

	for _, v in pairs(bpClueConfigs) do
		bgClues[v.clueId] = v
	end

	local configs = AergusiConfig.instance:getClueConfigs()

	for _, v in pairs(configs) do
		if v.materialId ~= "" then
			local ids = string.splitToNumber(v.materialId, "#")

			if bgClues[ids[1]] and bgClues[ids[2]] then
				table.insert(couldMergeClues, {
					ids[1],
					ids[2]
				})
			end
		end
	end

	return couldMergeClues
end

function AergusiModel:getCurClueId()
	return self._curClueId
end

function AergusiModel:setCurClueId(clueId)
	self._curClueId = clueId
end

function AergusiModel:setClueMergePosSelect(pos, selected)
	self._mergeClueState.pos[pos].selected = selected
	self._mergeClueState.pos[3 - pos].selected = false
end

function AergusiModel:getClueMergePosSelectState(pos)
	return self._mergeClueState.pos[pos].selected
end

function AergusiModel:setClueMergePosClueId(pos, clueId)
	self._mergeClueState.pos[pos].clueId = clueId

	if clueId > 0 and not self._mergeClueState.pos[3 - pos].selected and self._mergeClueState.pos[3 - pos].clueId <= 0 then
		self._mergeClueState.pos[pos].selected = false
		self._mergeClueState.pos[3 - pos].selected = true
	end
end

function AergusiModel:isClueInMerge(clueId)
	for _, v in pairs(self._mergeClueState.pos) do
		if v.clueId == clueId then
			return true
		end
	end

	return false
end

function AergusiModel:getSelectPos()
	if not self._mergeClueState or not self._mergeClueState.pos then
		return 0
	end

	for pos, v in pairs(self._mergeClueState.pos) do
		if v.selected then
			return pos
		end
	end

	return 0
end

function AergusiModel:getMergeClueState()
	return self._mergeClueState
end

function AergusiModel:clearMergePosState()
	self._mergeClueState = self._mergeClueState or {}
	self._mergeClueState.open = false

	for i = 1, 2 do
		self._mergeClueState.pos = self._mergeClueState.pos or {}
		self._mergeClueState.pos[i] = self._mergeClueState.pos[i] or {}
		self._mergeClueState.pos[i].selected = i == 1
		self._mergeClueState.pos[i].clueId = 0
	end
end

function AergusiModel:setMergeClueOpen(open)
	self._mergeClueState.open = open
end

function AergusiModel:isMergeClueOpen()
	return self._mergeClueState.open
end

function AergusiModel:getMergeClues()
	local clues = {}

	for i = 1, 2 do
		table.insert(clues, self._mergeClueState.pos[i].clueId)
	end

	return clues
end

function AergusiModel:getTargetMergeClue(clueId1, clueId2)
	local clueConfigs = AergusiConfig.instance:getClueConfigs()

	for _, v in pairs(clueConfigs) do
		if v.materialId == string.format("%s#%s", clueId1, clueId2) or v.materialId == string.format("%s#%s", clueId2, clueId1) then
			return v.clueId
		end
	end

	return 0
end

AergusiModel.instance = AergusiModel.New()

return AergusiModel
