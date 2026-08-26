-- chunkname: @modules/logic/dungeon/model/DungeonAssistHeroMO.lua

module("modules.logic.dungeon.model.DungeonAssistHeroMO", package.seeall)

local DungeonAssistHeroMO = pureTable("DungeonAssistHeroMO")

function DungeonAssistHeroMO:init(assistType, heroInfo)
	if not assistType or not heroInfo then
		return false
	end

	self.assistType = assistType
	self.heroUid = heroInfo.heroUid
	self.userId = heroInfo.userId
	self.name = heroInfo.name
	self.userLevel = heroInfo.userLevel
	self.portrait = heroInfo.portrait
	self.bg = heroInfo.bg
	self.isFriend = heroInfo.isFriend
	self.heroId = heroInfo.heroId
	self.level = heroInfo.level
	self.rank = heroInfo.rank
	self.skin = heroInfo.skin
	self.passiveSkillLevel = heroInfo.passiveSkillLevel
	self.exSkillLevel = heroInfo.exSkillLevel
	self.talent = heroInfo.talent
	self.balanceLevel = heroInfo.balanceLevel
	self.isOpenTalent = heroInfo.isOpenTalent
	self.style = heroInfo.style
	self.originalTalentCubeInfos = nil

	if heroInfo.talentCubeInfos then
		self.talentCubeInfos = HeroTalentCubeInfosMO.New()

		self.talentCubeInfos:init(heroInfo.talentCubeInfos)
		self.talentCubeInfos:setOwnData(self.heroId, self.talent)

		self.originalTalentCubeInfos = {}

		for i, cubeInfo in ipairs(heroInfo.talentCubeInfos) do
			self.originalTalentCubeInfos[i] = {}
			self.originalTalentCubeInfos[i].cubeId = cubeInfo.cubeId
			self.originalTalentCubeInfos[i].direction = cubeInfo.direction
			self.originalTalentCubeInfos[i].posX = cubeInfo.posX
			self.originalTalentCubeInfos[i].posY = cubeInfo.posY
		end
	end

	self.destinyRank = heroInfo.destinyRank
	self.destinyLevel = heroInfo.destinyLevel
	self.destinyStone = heroInfo.destinyStone
	self.extraStr = heroInfo.extraStr

	return true
end

function DungeonAssistHeroMO:getHeroInfo()
	return {
		heroUid = self:getHeroUid(),
		userId = self:getUserId(),
		name = self:getName(),
		userLevel = self:getUserLevel(),
		portrait = self:getPortrait(),
		bg = self:getBg(),
		isFriend = self:getIsFriend(),
		heroId = self:getHeroId(),
		level = self:getLevel(),
		rank = self:getRank(),
		skin = self:getSkin(),
		passiveSkillLevel = self:getPassiveSkillLevel(),
		exSkillLevel = self:getExSkillLevel(),
		talent = self:getTalent(),
		talentCubeInfos = self:getOriginalTalentCubeInfos(),
		balanceLevel = self:getBalanceLevel(),
		isOpenTalent = self:getIsOpenTalent(),
		style = self:getTalentStyle(),
		destinyRank = self:getDestinyRank(),
		destinyLevel = self:getDestinyLevel(),
		destinyStone = self:getDestinyStone(),
		extraStr = self:getExtraStr()
	}
end

function DungeonAssistHeroMO:getHeroUid()
	return self.heroUid
end

function DungeonAssistHeroMO:getUserId()
	return self.userId
end

function DungeonAssistHeroMO:getName()
	return self.name
end

function DungeonAssistHeroMO:getUserLevel()
	return self.userLevel or 0
end

function DungeonAssistHeroMO:getPortrait()
	return self.portrait
end

function DungeonAssistHeroMO:getBg()
	return self.bg
end

function DungeonAssistHeroMO:getIsFriend()
	return self.isFriend
end

function DungeonAssistHeroMO:getHeroId()
	return self.heroId
end

function DungeonAssistHeroMO:getLevel()
	return self.level or 0
end

function DungeonAssistHeroMO:getRank()
	return self.rank
end

function DungeonAssistHeroMO:getSkin()
	return self.skin
end

function DungeonAssistHeroMO:getPassiveSkillLevel()
	return self.passiveSkillLevel
end

function DungeonAssistHeroMO:getExSkillLevel()
	return self.exSkillLevel
end

function DungeonAssistHeroMO:getTalent()
	return self.talent
end

function DungeonAssistHeroMO:getOriginalTalentCubeInfos()
	return self.originalTalentCubeInfos
end

function DungeonAssistHeroMO:getTalentCubeInfos()
	return self.talentCubeInfos
end

function DungeonAssistHeroMO:getBalanceLevel()
	return self.balanceLevel or 0
end

function DungeonAssistHeroMO:getIsOpenTalent()
	return self.isOpenTalent
end

function DungeonAssistHeroMO:getTalentStyle()
	return self.style
end

function DungeonAssistHeroMO:getDestinyRank()
	return self.destinyRank
end

function DungeonAssistHeroMO:getDestinyLevel()
	return self.destinyLevel
end

function DungeonAssistHeroMO:getDestinyStone()
	return self.destinyStone
end

function DungeonAssistHeroMO:getExtraStr()
	return self.extraStr
end

return DungeonAssistHeroMO
