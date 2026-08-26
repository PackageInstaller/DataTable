-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiEpisodeMo.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiEpisodeMo", package.seeall)

local YeShuMeiEpisodeMo = class("YeShuMeiEpisodeMo")

function YeShuMeiEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function YeShuMeiEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_1Enum.ActivityId.YeShuMei
end

function YeShuMeiEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function YeShuMeiEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function YeShuMeiEpisodeMo:isGame()
	local config = YeShuMeiConfig.instance:getEpisodeCo(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return YeShuMeiEpisodeMo
