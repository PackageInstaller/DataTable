-- chunkname: @modules/logic/rouge/dlc/103/model/RougeLayerChoiceInfoMO.lua

module("modules.logic.rouge.dlc.103.model.RougeLayerChoiceInfoMO", package.seeall)

local RougeLayerChoiceInfoMO = pureTable("RougeLayerChoiceInfoMO")

function RougeLayerChoiceInfoMO:init(info)
	self.layerId = info.layerId
	self.mapRuleId = info.mapRuleId
	self.mapRuleCo = RougeDLCConfig103.instance:getMapRuleConfig(self.mapRuleId)
	self.curLayerCollection = {}

	tabletool.addValues(self.curLayerCollection, info.curLayerCollection)

	self.mapRuleCanFreshNum = info.mapRuleCanFreshNum
end

function RougeLayerChoiceInfoMO:getMapRuleCo()
	return self.mapRuleCo
end

function RougeLayerChoiceInfoMO:getMapRuleType()
	local ruleCo = self:getMapRuleCo()

	return ruleCo and ruleCo.type
end

function RougeLayerChoiceInfoMO:getCurLayerCollection()
	return self.curLayerCollection
end

function RougeLayerChoiceInfoMO:getMapRuleCanFreshNum()
	return self.mapRuleCanFreshNum
end

return RougeLayerChoiceInfoMO
