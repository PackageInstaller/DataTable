-- chunkname: @modules/logic/versionactivity2_5/liangyue/model/LiangYueInfoMo.lua

module("modules.logic.versionactivity2_5.liangyue.model.LiangYueInfoMo", package.seeall)

local LiangYueInfoMo = pureTable("LiangYueInfoMo")

function LiangYueInfoMo:init(actId, episodeId, isFinish, puzzle)
	self.actId = actId
	self.episodeId = episodeId
	self.isFinish = isFinish
	self.puzzle = puzzle

	local config = LiangYueConfig.instance:getEpisodeConfigByActAndId(actId, episodeId)

	if config == nil then
		logError("config is nil" .. episodeId)

		return
	end

	self.config = config
	self.preEpisodeId = config.preEpisodeId
end

function LiangYueInfoMo:updateMO(isFinish, puzzle)
	self.isFinish = isFinish
	self.puzzle = puzzle
end

return LiangYueInfoMo
