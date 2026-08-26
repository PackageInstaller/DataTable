-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LengZhou6InfoMo.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6InfoMo", package.seeall)

local LengZhou6InfoMo = pureTable("LengZhou6InfoMo")

function LengZhou6InfoMo:init(actId, episodeId, isFinish)
	self.actId = actId
	self.episodeId = episodeId
	self.isFinish = isFinish

	local config = LengZhou6Config.instance:getEpisodeConfig(self.actId, self.episodeId)

	if config == nil then
		logError("config is nil" .. episodeId)

		return
	end

	self._config = config
	self.preEpisodeId = config.preEpisodeId
end

function LengZhou6InfoMo:updateInfo(info)
	self:updateIsFinish(info.isFinished)

	self.progress = info.progress
end

function LengZhou6InfoMo:updateIsFinish(state)
	self.isFinish = state
end

function LengZhou6InfoMo:updateProgress(progress)
	self.progress = progress
end

function LengZhou6InfoMo:isEndlessEpisode()
	return LengZhou6Model.instance:getEpisodeIsEndLess(self._config)
end

function LengZhou6InfoMo:getEpisodeName()
	return self._config.name
end

function LengZhou6InfoMo:haveEliminate()
	local eliminateId = self._config.eliminateLevelId

	return eliminateId ~= 0
end

function LengZhou6InfoMo:isDown()
	return self.episodeId % 2 ~= 0
end

function LengZhou6InfoMo:canShowItem()
	if self:isEndlessEpisode() then
		return self:unLock()
	end

	return true
end

function LengZhou6InfoMo:unLock()
	local preEpisodeId = self.preEpisodeId

	return preEpisodeId == 0 or LengZhou6Model.instance:isEpisodeFinish(preEpisodeId)
end

function LengZhou6InfoMo:getLevel()
	if not string.nilorempty(self.progress) then
		local jsonData = cjson.decode(self.progress)

		return jsonData.endLessLayer or LengZhou6Enum.DefaultEndLessBeginRound
	end

	return LengZhou6Enum.DefaultEndLessBeginRound
end

function LengZhou6InfoMo:getEndLessBattleProgress()
	if not string.nilorempty(self.progress) then
		local jsonData = cjson.decode(self.progress)

		return jsonData.endLessBattleProgress
	end

	return nil
end

function LengZhou6InfoMo:setProgress(progress)
	self.progress = progress
end

return LengZhou6InfoMo
