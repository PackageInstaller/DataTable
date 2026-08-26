-- chunkname: @modules/logic/survival/util/SurvivalBalanceHelper.lua

module("modules.logic.survival.util.SurvivalBalanceHelper", package.seeall)

local SurvivalBalanceHelper = class("SurvivalBalanceHelper")

SurvivalBalanceHelper.BalanceColor = "#bfdaff"
SurvivalBalanceHelper.BalanceIconColor = "#81abe5"

local heroMaxLv, heroTalentMaxLv

function SurvivalBalanceHelper.getBalanceLv()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	local roleLv = weekInfo:getAttr(SurvivalEnum.AttrType.BalanceRoleLv)
	local talentLv = weekInfo:getAttr(SurvivalEnum.AttrType.BalanceResonanceLv)
	local equipLv = weekInfo:getAttr(SurvivalEnum.AttrType.BalanceEquipLv)

	if heroMaxLv == nil then
		heroMaxLv = #lua_character_cosume.configDict
	end

	if heroTalentMaxLv == nil then
		heroTalentMaxLv = 1

		for _, co in pairs(lua_character_talent.configList) do
			if co.talentId > heroTalentMaxLv then
				heroTalentMaxLv = co.talentId
			end
		end
	end

	roleLv = Mathf.Clamp(roleLv, 1, heroMaxLv)
	talentLv = Mathf.Clamp(talentLv, 1, heroTalentMaxLv)
	equipLv = Mathf.Clamp(equipLv, 1, EquipConfig.MaxLevel)

	return roleLv, talentLv, equipLv
end

function SurvivalBalanceHelper.getHeroBalanceLv(heroId)
	local balanceLv = SurvivalBalanceHelper.getBalanceLv()

	if not balanceLv then
		return 0
	end

	local heroMaxLv = 0
	local levelCos = SkillConfig.instance:getherolevelsCO(heroId)

	for level in pairs(levelCos) do
		if heroMaxLv < level then
			heroMaxLv = level
		end
	end

	balanceLv = math.min(heroMaxLv, balanceLv)

	return balanceLv
end

function SurvivalBalanceHelper.getHeroBalanceInfo(heroId, heroMo)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	heroMo = heroMo or HeroModel.instance:getByHeroId(heroId)

	if not heroMo and weekInfo.inSurvival then
		local teamInfo = SurvivalMapModel.instance:getSceneMo().teamInfo

		if teamInfo.assistMO and teamInfo.assistMO.heroId == heroId then
			heroMo = teamInfo.assistMO.heroMO
		end
	end

	if not heroMo then
		return
	end

	local balanceLv, balanceTalent, equipLv = SurvivalBalanceHelper.getBalanceLv()

	if not balanceLv then
		return
	end

	local heroMaxLv = 0
	local levelCos = SkillConfig.instance:getherolevelsCO(heroId)

	for level in pairs(levelCos) do
		if heroMaxLv < level then
			heroMaxLv = level
		end
	end

	balanceLv = math.min(heroMaxLv, balanceLv)
	balanceLv = math.max(heroMo.level, balanceLv)

	local passiveLevel, rank = SkillConfig.instance:getHeroExSkillLevelByLevel(heroId, balanceLv)
	local fixTalent = 1

	for talent = balanceTalent, 1, -1 do
		local talentCo = lua_character_talent.configDict[heroId][talent]

		if talentCo and rank >= talentCo.requirement then
			fixTalent = talent

			break
		end
	end

	local talentCubeInfos = heroMo.talentCubeInfos

	if (fixTalent > heroMo.talent or heroMo.rank < CharacterEnum.TalentRank) and rank >= CharacterEnum.TalentRank then
		local infos = {}
		local talentCO = lua_character_talent.configDict[heroId][fixTalent]
		local talentMould = talentCO.talentMould
		local starMould = string.splitToNumber(talentCO.exclusive, "#")[1]
		local talenScheme = lua_talent_scheme.configDict[fixTalent][talentMould][starMould].talenScheme
		local dict = GameUtil.splitString2(talenScheme, true, "#", ",")

		for k, v in ipairs(dict) do
			local cubeInfo = HeroDef_pb.TalentCubeInfo()

			cubeInfo.cubeId = v[1]
			cubeInfo.direction = v[2] or 0
			cubeInfo.posX = v[3] or 0
			cubeInfo.posY = v[4] or 0

			table.insert(infos, cubeInfo)
		end

		talentCubeInfos = HeroTalentCubeInfosMO.New()

		talentCubeInfos:init(infos)
		talentCubeInfos:setOwnData(heroId, fixTalent)
	end

	return balanceLv, rank, fixTalent, talentCubeInfos, equipLv
end

return SurvivalBalanceHelper
