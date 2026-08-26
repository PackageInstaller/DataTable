-- chunkname: @modules/logic/seasonver/act123/utils/Season123HeroUtils.lua

module("modules.logic.seasonver.act123.utils.Season123HeroUtils", package.seeall)

local Season123HeroUtils = class("Season123HeroUtils")

function Season123HeroUtils.createHeroMOByAssistMO(assistMO, checkIsBalance)
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

	heroMO.destinyStoneMo = HeroDestinyStoneMO.New(assistMO.heroId)

	heroMO.destinyStoneMo:refreshMo(assistMO.destinyRank, assistMO.destinyLevel, assistMO.destinyStone, assistMO.destinyStoneUnlock)

	heroMO.extraMo = heroMO.extraMo or CharacterExtraMO.New(heroMO)

	heroMO.extraMo:refreshMo(assistMO.extraStr)

	return heroMO
end

function Season123HeroUtils.createSeasonPickAssistMO(dungeonAssistHeroMo)
	if not dungeonAssistHeroMo then
		return
	end

	local heroInfo = dungeonAssistHeroMo:getHeroInfo()
	local mo = Season123PickAssistMO.New()

	mo:init(heroInfo)

	return mo
end

function Season123HeroUtils.getHeroMO(actId, heroUid, stage)
	local heroMO = HeroModel.instance:getById(heroUid)

	if not heroMO and stage ~= nil then
		local assistHeroMO, assistMO = Season123Model.instance:getAssistData(actId, stage)

		if assistMO and assistMO.heroUid == heroUid then
			return assistHeroMO
		end
	else
		return heroMO
	end
end

return Season123HeroUtils
