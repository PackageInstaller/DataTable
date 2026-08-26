-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueInfoMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueInfoMO", package.seeall)

local RogueInfoMO = pureTable("RogueInfoMO")

function RogueInfoMO:init(info)
	self.activityId = info.activityId
	self.difficulty = info.difficulty
	self.layer = info.layer
	self.room = info.room
	self.coin = info.coin
	self.currency = info.currency
	self.heart = info.heart
	self.isFinish = info.isFinish
	self.score = info.score
	self.sceneId = info.sceneId
	self.currencyTotal = info.currencyTotal

	self:updateTeamInfo(info.teamInfo)

	self.currentEvents = {}

	for i, v in ipairs(info.currentEvents) do
		local mo = RogueEventMO.New()

		mo:init(v)
		table.insert(self.currentEvents, mo)
	end

	self.nextEvents = {}

	for i, v in ipairs(info.nextEvents) do
		local mo = RogueEventMO.New()

		mo:init(v)
		table.insert(self.nextEvents, mo)
	end

	self:updateCollections(info.collections)

	self.selectedEvents = {}

	for i, v in ipairs(info.selectedEvents) do
		if v.status ~= V1a6_CachotEnum.EventStatus.Finish then
			local mo = RogueEventMO.New()

			mo:init(v)
			table.insert(self.selectedEvents, mo)
		end
	end
end

function RogueInfoMO:updateTeamInfo(teamInfo)
	self.teamInfo = RogueTeamInfoMO.New()

	self.teamInfo:init(teamInfo)
end

function RogueInfoMO:updateCoin(value)
	self.coin = value
end

function RogueInfoMO:updateCurrency(value)
	self.currency = value
end

function RogueInfoMO:updateCurrencyTotal(value)
	self.currencyTotal = value
end

function RogueInfoMO:updateHeart(value)
	self.heart = value
end

function RogueInfoMO:updateCollections(collections)
	self.collections = {}
	self.collectionCfgMap = {}
	self.collectionBaseMap = {}
	self.enchants = {}
	self.collectionMap = {}

	if collections then
		for _, v in ipairs(collections) do
			local mo = RogueCollectionMO.New()

			mo:init(v)

			local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(mo.cfgId)

			if collectionCfg and collectionCfg.type == V1a6_CachotEnum.CollectionType.Enchant then
				table.insert(self.enchants, mo)
			end

			if not mo:isEnchant() then
				table.insert(self.collections, mo)
			end

			self.collectionMap[mo.id] = mo
			self.collectionCfgMap[mo.cfgId] = self.collectionCfgMap[mo.cfgId] or {}

			table.insert(self.collectionCfgMap[mo.cfgId], mo)

			if mo and mo.baseId and mo.baseId ~= 0 then
				self.collectionBaseMap[mo.baseId] = self.collectionBaseMap[mo.baseId] or {}

				table.insert(self.collectionBaseMap[mo.baseId], mo)
			end
		end
	end
end

function RogueInfoMO:getCollectionByUid(collectionUid)
	return self.collectionMap and self.collectionMap[collectionUid]
end

function RogueInfoMO:getSelectEvents()
	return self.selectedEvents
end

return RogueInfoMO
