-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianEpisodeMo.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianEpisodeMo", package.seeall)

local LuSiJianEpisodeMo = class("LuSiJianEpisodeMo")

function LuSiJianEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function LuSiJianEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_2Enum.ActivityId.LuSiJian
end

function LuSiJianEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function LuSiJianEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function LuSiJianEpisodeMo:isGame()
	local config = LuSiJianConfig.instance:getEpisodeCo(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return LuSiJianEpisodeMo
