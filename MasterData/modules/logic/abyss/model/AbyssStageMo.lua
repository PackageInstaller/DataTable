-- chunkname: @modules/logic/abyss/model/AbyssStageMo.lua

module("modules.logic.abyss.model.AbyssStageMo", package.seeall)

local AbyssStageMo = pureTable("AbyssStageMo")

function AbyssStageMo:ctor()
	self.stageId = nil
	self.star = nil
	self.maxStar = nil
	self.minRound = nil
	self.round = nil
	self.heroList = {}
	self.heroDic = {}
	self.equipDic = {}
	self.skillId = nil
	self.heroGroupSubId = nil
	self.lastUpdateTime = nil
end

function AbyssStageMo:init()
	return
end

function AbyssStageMo:updateInfo(stageInfo, actId)
	self.stageId = stageInfo.stageId
	self.star = stageInfo.star or 0
	self.maxStar = stageInfo.maxStar or 0
	self.minRound = stageInfo.minRound or 0
	self.round = stageInfo.round or 0
	self.totalStar = AbyssConfig.instance:getStageMaxStar(actId, stageInfo.stageId) or 0

	tabletool.clear(self.heroList)
	tabletool.clear(self.heroDic)
	tabletool.clear(self.equipDic)

	for _, heroNo in ipairs(stageInfo.heros) do
		self.heroDic[heroNo.heroId] = heroNo.heroId

		table.insert(self.heroList, heroNo.heroId)

		if heroNo.equipUids and next(heroNo.equipUids) then
			self.equipDic[heroNo.heroId] = heroNo.equipUids
		end
	end

	self.heroGroupSubId = self.stageId

	if stageInfo.skillIds then
		local skillId = stageInfo.skillIds[1]

		skillId = skillId or 0
		self.skillId = AbyssHelper.getValidSkill(self.stageId, skillId)

		local time = tonumber(stageInfo.lastUpdateTeamTime)

		self.lastUpdateTime = time ~= nil and time ~= 0 and time or self.stageId
	end
end

function AbyssStageMo:resetInfo()
	self.star = 0
	self.round = 0

	tabletool.clear(self.heroList)
	tabletool.clear(self.heroDic)
end

function AbyssStageMo:isChallenged()
	return self.heroList ~= nil and next(self.heroList) ~= nil
end

function AbyssStageMo:isHeroLocked(heroId)
	return self:isChallenged() and self.heroDic[heroId] ~= nil
end

return AbyssStageMo
