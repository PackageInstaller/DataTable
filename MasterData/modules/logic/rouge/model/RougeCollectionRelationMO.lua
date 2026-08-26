-- chunkname: @modules/logic/rouge/model/RougeCollectionRelationMO.lua

module("modules.logic.rouge.model.RougeCollectionRelationMO", package.seeall)

local RougeCollectionRelationMO = pureTable("RougeCollectionRelationMO")

function RougeCollectionRelationMO:init(info)
	self.effectIndex = tonumber(info.effectIndex)
	self.showType = tonumber(info.showType)

	self:updateTrueCollectionIds(info.trueGuids)
end

function RougeCollectionRelationMO:updateTrueCollectionIds(ids)
	self.trueIds = {}

	if ids then
		for _, id in ipairs(ids) do
			table.insert(self.trueIds, tonumber(id))
		end
	end
end

function RougeCollectionRelationMO:getTrueCollectionIds()
	return self.trueIds
end

return RougeCollectionRelationMO
