-- chunkname: @modules/logic/chargepush/model/ChargePushMO.lua

module("modules.logic.chargepush.model.ChargePushMO", package.seeall)

local ChargePushMO = pureTable("ChargePushMO")

function ChargePushMO:init(id)
	self.id = id
	self.config = ChargePushConfig.instance:getPushGoodsConfig(id)
end

function ChargePushMO.sortFunction(a, b)
	return a.id < b.id
end

return ChargePushMO
