-- chunkname: @modules/logic/versionactivity2_3/act174/model/Act174MO.lua

module("modules.logic.versionactivity2_3.act174.model.Act174MO", package.seeall)

local Act174MO = pureTable("Act174MO")

function Act174MO:initBadgeInfo(actId)
	self.badgeMoDic = {}
	self.badgeScoreChangeDic = {}

	local badgeCoDic = lua_activity174_badge.configDict[actId]

	for id, badgeCo in pairs(badgeCoDic) do
		local badgeMo = Act174BadgeMO.New()

		badgeMo:init(badgeCo)

		self.badgeMoDic[id] = badgeMo
	end
end

function Act174MO:init(info)
	self.triggerList = {}
	self.season = info.season

	for _, badgeInfo in ipairs(info.badgeInfoList) do
		self.badgeMoDic[badgeInfo.id]:update(badgeInfo)
	end

	self:updateGameInfo(info.gameInfo)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateBadgeMo)
end

function Act174MO:updateGameInfo(info, filter)
	self.gameInfo = self.gameInfo or Act174GameMO.New()

	self.gameInfo:init(info, filter)
end

function Act174MO:updateShopInfo(info)
	self.gameInfo:updateShopInfo(info)
end

function Act174MO:updateTeamInfo(info)
	self.gameInfo:updateTeamMo(info)
end

function Act174MO:updateIsBet(isBet)
	self.gameInfo:updateIsBet(isBet)
end

function Act174MO:triggerEffectPush(effectId, param)
	self.triggerList[#self.triggerList + 1] = {
		effectId = effectId,
		param = param
	}
end

function Act174MO:getTriggerList()
	return self.triggerList
end

function Act174MO:cleanTriggerEffect()
	tabletool.clear(self.triggerList)
end

function Act174MO:setEndInfo(endInfo)
	for _, badgeInfo in ipairs(endInfo.badgeInfoList) do
		local id = badgeInfo.id
		local badgeMO = self.badgeMoDic[id]

		self.badgeScoreChangeDic[id] = badgeInfo.count - badgeMO.count

		self.badgeMoDic[id]:update(badgeInfo)
	end

	self.gameEndInfo = endInfo

	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateBadgeMo)
end

function Act174MO:getBadgeScoreChangeDic()
	return self.badgeScoreChangeDic
end

function Act174MO:clearEndInfo()
	self.gameEndInfo = nil

	tabletool.clear(self.badgeScoreChangeDic)
	self:cleanTriggerEffect()
end

function Act174MO:getGameInfo()
	return self.gameInfo
end

function Act174MO:getGameEndInfo()
	return self.gameEndInfo
end

function Act174MO:getBadgeMo(badgeId)
	local badgeMo = self.badgeMoDic[badgeId]

	if not badgeMo then
		logError("dont exist badgeMo" .. badgeId)
	end

	return badgeMo
end

function Act174MO:getBadgeMoList()
	local list = {}

	for _, badgeMo in pairs(self.badgeMoDic) do
		list[#list + 1] = badgeMo
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	return list
end

function Act174MO:getRuleHeroCoList()
	local list = {}
	local heroCoList = lua_activity174_role.configList

	for _, heroCo in ipairs(heroCoList) do
		if string.find(heroCo.season, tostring(self.season)) then
			list[#list + 1] = heroCo
		end
	end

	return list
end

function Act174MO:getRuleCollectionCoList()
	local list = {}
	local collectionCoList = lua_activity174_collection.configList

	for _, collectionCo in ipairs(collectionCoList) do
		if string.find(collectionCo.season, tostring(self.season)) then
			list[#list + 1] = collectionCo
		end
	end

	return list
end

function Act174MO:getRuleBuffCoList()
	local list = {}
	local buffCoList = lua_activity174_enhance.configList

	for _, buffCo in ipairs(buffCoList) do
		if string.find(buffCo.season, tostring(self.season)) then
			list[#list + 1] = buffCo
		end
	end

	return list
end

return Act174MO
