-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeFightEventMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeFightEventMO", package.seeall)

local RougeFightEventMO = class("RougeFightEventMO", RougeBaseEventMO)

function RougeFightEventMO:init(eventCo, data)
	RougeFightEventMO.super.init(self, eventCo, data)
	self:updateSurpriseAttackList()
end

function RougeFightEventMO:updateSurpriseAttackList()
	self.surpriseAttackList = {}

	for _, attackId in ipairs(self.jsonData.surpriseAttackList or {}) do
		table.insert(self.surpriseAttackList, attackId)
	end
end

function RougeFightEventMO:update(eventCo, data)
	RougeFightEventMO.super.update(self, eventCo, data)
	self:updateSurpriseAttackList()
end

function RougeFightEventMO:getSurpriseAttackList()
	return self.surpriseAttackList
end

function RougeFightEventMO:__tostring()
	return RougeFightEventMO.super.__tostring(self)
end

return RougeFightEventMO
