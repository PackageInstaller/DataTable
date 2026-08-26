-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRushExpandBondMO.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRushExpandBondMO", package.seeall)

local V3a9_BossRushExpandBondMO = pureTable("V3a9_BossRushExpandBondMO")

function V3a9_BossRushExpandBondMO:init(co)
	self._co = co
	self._battleTags = {}
	self._careerTags = {}

	if not string.nilorempty(co.tag1) then
		local tags = string.splitToNumber(co.tag1, "|")

		for _, tag in ipairs(tags) do
			self._careerTags[tag] = true
		end
	end

	if not string.nilorempty(co.tag2) then
		local tags = string.splitToNumber(co.tag2, "|")

		for _, tag in ipairs(tags) do
			self._battleTags[tag] = true
		end
	end
end

function V3a9_BossRushExpandBondMO:getConfig()
	return self._co
end

function V3a9_BossRushExpandBondMO:getActiveNum()
	return self._co.activeNum
end

function V3a9_BossRushExpandBondMO:getTags()
	return self._careerTags, self._battleTags
end

function V3a9_BossRushExpandBondMO:isContainsCareerTags(tags)
	for _, tag in pairs(tags) do
		if self:isContainsCareerTag(tag) then
			return true
		end
	end
end

function V3a9_BossRushExpandBondMO:isContainsCareerTag(tag)
	if self._careerTags[tag] then
		return true
	end
end

function V3a9_BossRushExpandBondMO:isContainsBattleTags(tags)
	for _, tag in pairs(tags) do
		if self:isContainsBattleTag(tag) then
			return true
		end
	end
end

function V3a9_BossRushExpandBondMO:isContainsBattleTag(tag)
	if self._battleTags[tag] then
		return true
	end
end

return V3a9_BossRushExpandBondMO
