-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueCollectionMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueCollectionMO", package.seeall)

local RogueCollectionMO = pureTable("RogueCollectionMO")

function RogueCollectionMO:init(info)
	self.id = info.uid
	self.cfgId = info.id
	self.leftUid = info.leftUid
	self.rightUid = info.rightUid
	self.baseId = info.baseId
	self.enchantUid = info.enchantUid
end

function RogueCollectionMO:getEnchantId(holeType)
	return (holeType == V1a6_CachotEnum.CollectionHole.Left or nil) and (self.leftUid or self.rightUid)
end

function RogueCollectionMO:isEnchant()
	return self.enchantUid and self.enchantUid ~= 0
end

function RogueCollectionMO:getEnchantCount()
	local enchantCount = 0

	if self.leftUid and self.leftUid ~= V1a6_CachotEnum.EmptyEnchantId then
		enchantCount = enchantCount + 1
	end

	if self.rightUid and self.rightUid ~= V1a6_CachotEnum.EmptyEnchantId then
		enchantCount = enchantCount + 1
	end

	return enchantCount
end

return RogueCollectionMO
