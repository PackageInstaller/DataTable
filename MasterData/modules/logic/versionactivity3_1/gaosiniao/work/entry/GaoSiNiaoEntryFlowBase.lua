-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/entry/GaoSiNiaoEntryFlowBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoEntryFlowBase", package.seeall)

local GaoSiNiaoEntryFlowBase = class("GaoSiNiaoEntryFlowBase", GaoSiNiaoFlowSequence_Base)

function GaoSiNiaoEntryFlowBase:start(episodeId)
	self:reset()
	assert(episodeId and episodeId > 0)

	self._episodeId = episodeId

	GaoSiNiaoEntryFlowBase.super.start(self)
end

function GaoSiNiaoEntryFlowBase:episodeId()
	return self._episodeId
end

function GaoSiNiaoEntryFlowBase:preStoryId()
	return GaoSiNiaoConfig.instance:getPreStoryId(self._episodeId)
end

function GaoSiNiaoEntryFlowBase:postStoryId()
	return GaoSiNiaoConfig.instance:getPostStoryId(self._episodeId)
end

function GaoSiNiaoEntryFlowBase:gameId()
	return GaoSiNiaoConfig.instance:getEpisodeCO_gameId(self._episodeId)
end

return GaoSiNiaoEntryFlowBase
