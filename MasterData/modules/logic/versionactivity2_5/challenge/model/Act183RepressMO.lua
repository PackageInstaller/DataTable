-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183RepressMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183RepressMO", package.seeall)

local Act183RepressMO = pureTable("Act183RepressMO")

function Act183RepressMO:init(info)
	self._ruleIndex = info.ruleIndex
	self._heroIndex = info.heroIndex or 0
end

function Act183RepressMO:hasRepress()
	return self._ruleIndex ~= 0
end

function Act183RepressMO:getRuleIndex()
	return self._ruleIndex
end

function Act183RepressMO:getHeroIndex()
	return self._heroIndex
end

return Act183RepressMO
