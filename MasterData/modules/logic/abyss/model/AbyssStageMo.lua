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
	self.assistHeroList = {}
	self.heroDic = {}
	self.assistHeroDic = {}
	self.equipDic = {}
	self.skillId = nil
	self.skinDic = {}
	self.heroSkinList = {}
	self.assistPosDic = {}
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
	tabletool.clear(self.assistHeroDic)
	tabletool.clear(self.assistHeroList)
	tabletool.clear(self.equipDic)
	tabletool.clear(self.skinDic)
	tabletool.clear(self.heroSkinList)
	tabletool.clear(self.assistPosDic)

	for index, heroNo in ipairs(stageInfo.heros) do
		self.heroDic[heroNo.heroId] = heroNo.heroId

		table.insert(self.heroList, heroNo.heroId)

		if heroNo.equipUids and next(heroNo.equipUids) then
			self.equipDic[heroNo.heroId] = heroNo.equipUids
		end

		if heroNo.skinId and heroNo.skinId ~= 0 then
			self:addAssistHero(heroNo.heroId, heroNo.skinId, index)
		end

		local data = {}

		data.heroId = heroNo.heroId
		data.skinId = heroNo.skinId or 0

		table.insert(self.heroSkinList, data)
	end

	if stageInfo.heroGroupSubId ~= nil and stageInfo.heroGroupSubId ~= 0 then
		self.heroGroupSubId = stageInfo.heroGroupSubId or stageInfo.stageId
	end

	if stageInfo.skillIds then
		local skillId = stageInfo.skillIds[1]

		skillId = skillId or 0
		self.skillId = AbyssHelper.getValidSkill(actId, self.stageId, skillId)

		local time = tonumber(stageInfo.lastUpdateTeamTime)

		self.lastUpdateTime = time ~= nil and time ~= 0 and time or self.stageId
	end
end

function AbyssStageMo:resetInfo()
	self.star = 0
	self.round = 0

	tabletool.clear(self.heroList)
	tabletool.clear(self.heroDic)
	self:clearAssistHero()
end

function AbyssStageMo:isChallenged()
	return self.heroList ~= nil and next(self.heroList) ~= nil
end

function AbyssStageMo:isHeroLocked(heroId)
	return self:isChallenged() and self.heroDic[heroId] ~= nil
end

function AbyssStageMo:getAssistHeroIds()
	return self.assistHeroList
end

function AbyssStageMo:haveAssist()
	return self.assistHeroList and next(self.assistHeroList) ~= nil
end

function AbyssStageMo:isHeroAssist(heroId)
	return self.assistHeroDic[heroId] ~= nil
end

function AbyssStageMo:isPosAssist(pos)
	return self.assistPosDic[pos] ~= nil
end

function AbyssStageMo:getPosAssistHeroId(pos)
	local data = self.assistPosDic[pos]

	return data and data.heroId
end

function AbyssStageMo:addAssistHero(heroId, skinId, index)
	if self.assistHeroDic[heroId] == nil then
		self.assistHeroDic[heroId] = heroId

		table.insert(self.assistHeroList, heroId)

		local data = {}

		data.heroId = heroId
		data.skinId = skinId or 0
		self.heroSkinList[heroId] = data
		self.skinDic[heroId] = skinId
		self.assistPosDic[index] = data
	end
end

function AbyssStageMo:clearAssistHero()
	tabletool.clear(self.assistHeroDic)
	tabletool.clear(self.assistHeroList)
	tabletool.clear(self.heroSkinList)
	tabletool.clear(self.skinDic)
	tabletool.clear(self.assistPosDic)
end

return AbyssStageMo
