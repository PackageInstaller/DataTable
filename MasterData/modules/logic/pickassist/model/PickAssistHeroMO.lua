-- chunkname: @modules/logic/pickassist/model/PickAssistHeroMO.lua

module("modules.logic.pickassist.model.PickAssistHeroMO", package.seeall)

local PickAssistHeroMO = pureTable("PickAssistHeroMO")

local function createHeroMOByAssistMO(assistMO, checkIsBalance)
	local heroCo = HeroConfig.instance:getHeroCO(assistMO.heroId)
	local heroInfo = HeroDef_pb.HeroInfo()

	heroInfo.uid = assistMO.heroUid

	local level = assistMO.level
	local rank = assistMO.rank
	local balanceLevel = assistMO.balanceLevel
	local isBalance = false

	if checkIsBalance and balanceLevel ~= level then
		level = balanceLevel

		local _, balanceRank = HeroConfig.instance:getShowLevel(balanceLevel)

		rank = balanceRank
		isBalance = true
	end

	heroInfo.level = level
	heroInfo.heroId = assistMO.heroId
	heroInfo.skin = assistMO.skin
	heroInfo.defaultEquipUid = "0"
	heroInfo.rank = rank
	heroInfo.talent = assistMO.talent
	heroInfo.exSkillLevel = assistMO.exSkillLevel

	if assistMO.passiveSkillLevel then
		for i = 1, #assistMO.passiveSkillLevel do
			table.insert(heroInfo.passiveSkillLevel, assistMO.passiveSkillLevel[i])
		end
	else
		local passiveLevel = SkillConfig.instance:getHeroExSkillLevelByLevel(assistMO.heroId, level)

		for i = 1, passiveLevel do
			table.insert(heroInfo.passiveSkillLevel, i)
		end
	end

	local baseAttr = SkillConfig.instance:getBaseAttr(assistMO.heroId, level)

	heroInfo.baseAttr.attack = baseAttr.atk
	heroInfo.baseAttr.defense = baseAttr.def
	heroInfo.baseAttr.hp = baseAttr.hp
	heroInfo.baseAttr.mdefense = baseAttr.mdef
	heroInfo.baseAttr.technic = baseAttr.technic
	heroInfo.exAttr.addDmg = baseAttr.add_dmg
	heroInfo.exAttr.cri = baseAttr.cri
	heroInfo.exAttr.criDef = baseAttr.cri_def
	heroInfo.exAttr.dropDmg = baseAttr.drop_dmg
	heroInfo.exAttr.recri = baseAttr.recri
	heroInfo.exAttr.criDmg = baseAttr.cri_dmg

	local heroMO = HeroMo.New()

	heroMO:init(heroInfo, heroCo)

	heroMO.talentCubeInfos = assistMO.talentCubeInfos

	heroMO:setIsBelongOtherPlayer(true)
	heroMO:setIsBalance(isBalance)
	heroMO:setOtherPlayerIsOpenTalent(assistMO.isOpenTalent)
	heroMO:setOtherPlayerTalentStyle(assistMO.style)

	heroMO.destinyRank = assistMO.destinyRank
	heroMO.destinyLevel = assistMO.destinyLevel
	heroMO.destinyStone = assistMO.destinyStone
	heroMO.destinyStoneMo = heroMO.destinyStoneMo or HeroDestinyStoneMO.New(heroInfo.heroId)

	heroMO.destinyStoneMo:refreshMo(assistMO.destinyRank, assistMO.destinyLevel, assistMO.destinyStone, assistMO.destinyStoneUnlock)

	heroMO.extraMo = heroMO.extraMo or CharacterExtraMO.New(heroMO)

	heroMO.extraMo:refreshMo(assistMO.extraStr)

	return heroMO
end

function PickAssistHeroMO:init(info)
	self.id = info.heroUid

	self:setHeroInfo(info)

	self.heroMO = createHeroMOByAssistMO(self, true)
end

function PickAssistHeroMO:setHeroInfo(info)
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

	self.destinyRank = info.destinyRank
	self.destinyLevel = info.destinyLevel
	self.destinyStone = info.destinyStone
	self.extraStr = info.extraStr
	self.style = info.style
end

function PickAssistHeroMO:getId()
	return self.id
end

function PickAssistHeroMO:isSameHero(targetPickAssistMO)
	local result = false

	if targetPickAssistMO then
		local curHeroUid = self:getId()
		local targetHeroUid = targetPickAssistMO:getId()

		result = curHeroUid == targetHeroUid
	end

	return result
end

function PickAssistHeroMO:getPlayerInfo()
	return {
		userId = self.userId,
		name = self.name,
		level = self.userLevel,
		portrait = self.portrait,
		bg = self.bg
	}
end

function PickAssistHeroMO:getCareer()
	local result

	return (self.heroMO and self.heroMO.config or nil) and self.heroMO.config.career
end

return PickAssistHeroMO
