-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191NodeDetailMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191NodeDetailMO", package.seeall)

local Act191NodeDetailMO = pureTable("Act191NodeDetailMO")

function Act191NodeDetailMO:init(str)
	local isOk, result = pcall(cjson.decode, str)

	if not isOk then
		logError("json非法: Act191NodeDetailMO")

		return
	end

	self.type = result.type
	self.shopId = result.shopId
	self.shopFreshNum = result.shopFreshNum
	self.freeRefreshNum = result.freeRefreshNum
	self.shopPosMap = result.shopPosMap
	self.boughtSet = result.boughtSet
	self.enhanceList = result.enhanceList
	self.enhanceNumList = result.enhanceNumList
	self.eventId = result.eventId
	self.fightEventId = result.fightEventId

	if result.matchInfo then
		self.matchInfo = Act191MatchMO.New()

		self.matchInfo:init(result.matchInfo)
	end

	self.replaceNum = result.replaceNum
	self.changeItemList = result.changeItemList
end

return Act191NodeDetailMO
