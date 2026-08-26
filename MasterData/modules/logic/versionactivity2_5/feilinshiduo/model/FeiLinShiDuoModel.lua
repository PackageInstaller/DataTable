-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/model/FeiLinShiDuoModel.lua

module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoModel", package.seeall)

local FeiLinShiDuoModel = class("FeiLinShiDuoModel", BaseModel)

function FeiLinShiDuoModel:onInit()
	self:reInit()

	self.maxStageCount = 7
end

function FeiLinShiDuoModel:reInit()
	self.episodeFinishMap = {}
	self.curEpisodeId = 0
	self.newUnlockEpisodeId = 0
	self.curFinishEpisodeId = 0
end

function FeiLinShiDuoModel:initEpisodeFinishInfo(info)
	self.activityId = info.activityId

	for index, episodeInfo in ipairs(info.episodes) do
		self.episodeFinishMap[episodeInfo.episodeId] = episodeInfo.isFinished
	end
end

function FeiLinShiDuoModel:getEpisodeFinishState(episodeId)
	return self.episodeFinishMap[episodeId]
end

function FeiLinShiDuoModel:updateEpisodeFinishState(episodeId, state)
	self.episodeFinishMap[episodeId] = state
end

function FeiLinShiDuoModel:isUnlock(activityId, episodeId)
	local config = FeiLinShiDuoConfig.instance:getEpisodeConfig(activityId, episodeId)
	local preEpisodeId = config.preEpisodeId

	if preEpisodeId > 0 then
		if not self.episodeFinishMap[preEpisodeId] then
			local isPreFinish = true

			return self.episodeFinishMap[episodeId] ~= nil and isPreFinish
		end
	end
end

function FeiLinShiDuoModel:getFinishStageIndex()
	local finishStageIndex = 0

	for stage = 1, self.maxStageCount do
		local stageEpisodes = FeiLinShiDuoConfig.instance:getStageEpisodes(stage)
		local isStageAllFinish = true

		for _, episodeCo in pairs(stageEpisodes) do
			if not self.episodeFinishMap[episodeCo.episodeId] then
				isStageAllFinish = false

				break
			end
		end

		if isStageAllFinish then
			finishStageIndex = stage
		end
	end

	return finishStageIndex
end

function FeiLinShiDuoModel:getCurActId()
	return self.activityId
end

function FeiLinShiDuoModel:getCurEpisodeId()
	local episodeConfigList = FeiLinShiDuoConfig.instance:getEpisodeConfigList()

	for index, episodeCo in ipairs(episodeConfigList) do
		local preEpisodeId = episodeCo.preEpisodeId

		if not self.episodeFinishMap[episodeCo.episodeId] and preEpisodeId > 0 then
			local isPreFinish = self.episodeFinishMap[preEpisodeId]

			if not isPreFinish then
				self.curEpisodeId = preEpisodeId

				return self.curEpisodeId
			else
				self.curEpisodeId = episodeCo.episodeId

				return self.curEpisodeId
			end
		elseif not self.episodeFinishMap[episodeCo.episodeId] and preEpisodeId == 0 then
			self.curEpisodeId = episodeCo.episodeId

			return self.curEpisodeId
		end
	end

	self.curEpisodeId = episodeConfigList[#episodeConfigList].episodeId

	return self.curEpisodeId
end

function FeiLinShiDuoModel:getLastEpisodeId()
	local episodeConfigList = FeiLinShiDuoConfig.instance:getNoGameEpisodeList(self.activityId)

	return episodeConfigList[#episodeConfigList].episodeId
end

function FeiLinShiDuoModel:setCurEpisodeId(episodeId)
	self.curEpisodeId = episodeId
end

function FeiLinShiDuoModel:setNewUnlockEpisode(info)
	for index, episodeInfo in ipairs(info.episodes) do
		self.newUnlockEpisodeId = episodeInfo.episodeId
	end
end

function FeiLinShiDuoModel:getNewUnlockEpisode(actId)
	if self.newUnlockEpisodeId then
		return (FeiLinShiDuoConfig.instance:getEpisodeConfig(actId, self.newUnlockEpisodeId))
	end
end

function FeiLinShiDuoModel:cleanNewUnlockEpisode()
	self.newUnlockEpisodeId = 0
end

function FeiLinShiDuoModel:setCurFinishEpisodeId(episodeId)
	self.curFinishEpisodeId = self.episodeFinishMap[episodeId] and 0 or episodeId
end

function FeiLinShiDuoModel:getCurFinishEpisodeId()
	return self.curFinishEpisodeId
end

FeiLinShiDuoModel.instance = FeiLinShiDuoModel.New()

return FeiLinShiDuoModel
