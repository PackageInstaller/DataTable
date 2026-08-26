-- chunkname: @modules/logic/seasonver/act123/model/Season123AssistHeroMO.lua

module("modules.logic.seasonver.act123.model.Season123AssistHeroMO", package.seeall)

local Season123AssistHeroMO = pureTable("Season123AssistHeroMO")

function Season123AssistHeroMO:init(info, hpRate)
	self.heroId = info.heroId
	self.heroUid = tostring(info.heroUid)
	self.userId = tostring(info.userId)
	self.name = info.name
	self.userLevel = info.userLevel
	self.portrait = info.portrait
	self.bg = info.bg
	self.isFriend = info.isFriend
	self.heroId = tonumber(info.heroId)
	self.level = tonumber(info.level)
	self.rank = info.rank
	self.skin = info.skin
	self.passiveSkillLevel = info.passiveSkillLevel
	self.exSkillLevel = info.exSkillLevel
	self.balanceLevel = info.balanceLevel
	self.isOpenTalent = info.isOpenTalent
	self.talent = info.talent
	self.talentCubeInfos = HeroTalentCubeInfosMO.New()

	self.talentCubeInfos:init(info.talentCubeInfos)
	self.talentCubeInfos:setOwnData(self.heroId, self.talent)

	self.style = info.style
	self.destinyRank = info.destinyRank
	self.destinyLevel = info.destinyLevel
	self.destinyStone = info.destinyStone
	self.extraStr = info.extraStr
end

return Season123AssistHeroMO
