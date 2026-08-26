-- chunkname: @modules/logic/versionactivity3_7/xruianyi/model/XRuiAnYiEpisodeMo.lua

module("modules.logic.versionactivity3_7.xruianyi.model.XRuiAnYiEpisodeMo", package.seeall)

local XRuiAnYiEpisodeMo = class("XRuiAnYiEpisodeMo")

function XRuiAnYiEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function XRuiAnYiEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
end

function XRuiAnYiEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function XRuiAnYiEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function XRuiAnYiEpisodeMo:isGame()
	local config = XRuiAnYiConfig.instance:getEpisodeCo(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return XRuiAnYiEpisodeMo
