-- chunkname: @modules/logic/versionactivity3_8/dianjishi/model/DianJiShiEpisodeMo.lua

module("modules.logic.versionactivity3_8.dianjishi.model.DianJiShiEpisodeMo", package.seeall)

local DianJiShiEpisodeMo = class("DianJiShiEpisodeMo")

function DianJiShiEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function DianJiShiEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_8Enum.ActivityId.DianJiShi
end

function DianJiShiEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function DianJiShiEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function DianJiShiEpisodeMo:isGame()
	local config = Activity220Config.instance:getEpisodeConfig(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return DianJiShiEpisodeMo
