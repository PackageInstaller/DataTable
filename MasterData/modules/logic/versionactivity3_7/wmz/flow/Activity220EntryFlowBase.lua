-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/Activity220EntryFlowBase.lua

module("modules.logic.versionactivity3_7.wmz.flow.Activity220EntryFlowBase", package.seeall)

local Activity220EntryFlowBase = class("Activity220EntryFlowBase", GaoSiNiaoFlowSequence_Base)

function Activity220EntryFlowBase:start(episodeId)
	self:reset()
	assert(episodeId and episodeId > 0)

	self._episodeId = episodeId

	Activity220EntryFlowBase.super.start(self)
end

function Activity220EntryFlowBase:_internal_set_ctrlInst(ctrlInst)
	if isDebugBuild then
		assert(isTypeOf(ctrlInst, Activity220SimpleBaseController), debug.traceback())
		assert(isTypeOf(ctrlInst:systemInst(), Activity220SimpleBaseModel), debug.traceback())
		assert(isTypeOf(ctrlInst:battleInst(), Activity220SimpleBaseModel), debug.traceback())
		assert(isTypeOf(ctrlInst:configInst(), Activity220SimpleBaseConfig), debug.traceback())
	end

	self._ctrlInst = ctrlInst
end

function Activity220EntryFlowBase:configInst()
	return self._ctrlInst:configInst()
end

function Activity220EntryFlowBase:battleInst()
	return self._ctrlInst:battleInst()
end

function Activity220EntryFlowBase:systemInst()
	return self._ctrlInst:systemInst()
end

function Activity220EntryFlowBase:episodeId()
	return self._episodeId
end

function Activity220EntryFlowBase:preStoryId()
	return self:configInst():getPreStoryId(self._episodeId)
end

function Activity220EntryFlowBase:postStoryId()
	return self:configInst():getPostStoryId(self._episodeId)
end

function Activity220EntryFlowBase:gameId()
	return self:configInst():getEpisodeCO_gameId(self._episodeId)
end

function Activity220EntryFlowBase:bHasGame()
	return self:configInst():bHasGame()
end

return Activity220EntryFlowBase
