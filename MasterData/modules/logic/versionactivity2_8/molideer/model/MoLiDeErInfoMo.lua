-- chunkname: @modules/logic/versionactivity2_8/molideer/model/MoLiDeErInfoMo.lua

module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErInfoMo", package.seeall)

local MoLiDeErInfoMo = pureTable("MoLiDeErInfoMo")

function MoLiDeErInfoMo:init(actId, episodeId, isUnlock, passCount, passStar, haveProgress)
	self.actId = actId
	self.episodeId = episodeId
	self.isUnlock = isUnlock
	self.passCount = passCount
	self.passStar = passStar
	self.haveProgress = haveProgress
	self.config = MoLiDeErConfig.instance:getEpisodeConfig(actId, episodeId)
end

function MoLiDeErInfoMo:isInProgress()
	return self.haveProgress
end

function MoLiDeErInfoMo:isComplete()
	return self.passCount > 0
end

return MoLiDeErInfoMo
