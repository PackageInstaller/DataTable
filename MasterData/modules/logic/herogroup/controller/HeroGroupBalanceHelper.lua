-- chunkname: @modules/logic/herogroup/controller/HeroGroupBalanceHelper.lua

module("modules.logic.herogroup.controller.HeroGroupBalanceHelper", package.seeall)

local HeroGroupBalanceHelper = class("HeroGroupBalanceHelper")

HeroGroupBalanceHelper.BalanceColor = "#bfdaff"
HeroGroupBalanceHelper.BalanceIconColor = "#81abe5"

function HeroGroupBalanceHelper.canShowBalanceSwitchBtn()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam or not fightParam.episodeId then
		return false
	end

	local episodeCO = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)
	local firstBattleId = episodeCO.firstBattleId

	if firstBattleId and firstBattleId > 0 then
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(fightParam.episodeId)

		if episodeInfo and episodeInfo.star > DungeonEnum.StarType.None then
			local battleCo = lua_battle.configDict[firstBattleId]

			if battleCo then
				return not string.nilorempty(battleCo.balance)
			end
		end
	end

	return false
end

function HeroGroupBalanceHelper.switchBalanceMode()
	HeroGroupBalanceHelper._isClickBalance = false

	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local isBalance = HeroGroupBalanceHelper.getIsBalanceMode()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	if isBalance then
		fightParam.battleId = episodeCO.battleId
	else
		HeroGroupBalanceHelper._isClickBalance = true
		fightParam.battleId = episodeCO.firstBattleId
	end

	fightParam:setBattleId(fightParam.battleId)

	HeroGroupModel.instance.battleId = fightParam.battleId

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
end

function HeroGroupBalanceHelper.clearBalanceStatus()
	HeroGroupBalanceHelper._isClickBalance = false
end

function HeroGroupBalanceHelper.isClickBalance()
	return HeroGroupBalanceHelper._isClickBalance
end

function HeroGroupBalanceHelper.getIsBalanceMode()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local battleCo = lua_battle.configDict[fightParam.battleId]

	return battleCo and not string.nilorempty(battleCo.balance) or false
end

local heroMaxLv, heroTalentMaxLv

function HeroGroupBalanceHelper.getBalanceLv()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local battleCo = lua_battle.configDict[fightParam.battleId]

	if not battleCo or string.nilorempty(battleCo.balance) then
		return
	end

	local balanceInfo = string.splitToNumber(battleCo.balance, "#")

	if not balanceInfo[1] then
		local roleLv = 0

		if not balanceInfo[2] then
			local talentLv = 0

			if not balanceInfo[3] then
				local equipLv = 0

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

				roleLv = Mathf.Clamp(balanceInfo[1], 1, heroMaxLv)
				talentLv = Mathf.Clamp(talentLv, 1, heroTalentMaxLv)
				equipLv = Mathf.Clamp(equipLv, 1, EquipConfig.MaxLevel)

				return balanceInfo[1], talentLv, equipLv
			end
		end
	end
end

function HeroGroupBalanceHelper.getHeroBalanceLv(heroId)
	local balanceLv = HeroGroupBalanceHelper.getBalanceLv()

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

function HeroGroupBalanceHelper.getHeroBalanceInfo(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return
	end

	local balanceLv, balanceTalent, equipLv = HeroGroupBalanceHelper.getBalanceLv()

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

return HeroGroupBalanceHelper
