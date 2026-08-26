-- chunkname: @modules/logic/rouge/controller/RougeHeroGroupBalanceHelper.lua

module("modules.logic.rouge.controller.RougeHeroGroupBalanceHelper", package.seeall)

local RougeHeroGroupBalanceHelper = class("RougeHeroGroupBalanceHelper")

RougeHeroGroupBalanceHelper.BalanceColor = "#bfdaff"
RougeHeroGroupBalanceHelper.BalanceIconColor = "#81abe5"

function RougeHeroGroupBalanceHelper.canShowBalanceSwitchBtn()
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

function RougeHeroGroupBalanceHelper.switchBalanceMode()
	RougeHeroGroupBalanceHelper._isClickBalance = false

	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	if isBalance then
		fightParam.battleId = episodeCO.battleId
	else
		RougeHeroGroupBalanceHelper._isClickBalance = true
		fightParam.battleId = episodeCO.firstBattleId
	end

	fightParam:setBattleId(fightParam.battleId)

	HeroGroupModel.instance.battleId = fightParam.battleId

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
end

function RougeHeroGroupBalanceHelper.clearBalanceStatus()
	RougeHeroGroupBalanceHelper._isClickBalance = false
end

function RougeHeroGroupBalanceHelper.isClickBalance()
	return RougeHeroGroupBalanceHelper._isClickBalance
end

function RougeHeroGroupBalanceHelper.getIsBalanceMode()
	local difficulty = RougeModel.instance:getDifficulty()

	if not difficulty then
		return false
	end

	local config = RougeConfig1.instance:getDifficultyCO(difficulty)

	return config and not string.nilorempty(config.balanceLevel) or false
end

local heroMaxLv, heroTalentMaxLv

function RougeHeroGroupBalanceHelper.getBalanceLv()
	local difficulty = RougeModel.instance:getDifficulty()

	if not difficulty then
		return
	end

	local config = RougeConfig1.instance:getDifficultyCO(difficulty)

	if not config then
		return
	end

	local balanceInfo = string.splitToNumber(config.balanceLevel, "#")

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

function RougeHeroGroupBalanceHelper.getHeroBalanceLv(heroId)
	local balanceLv = RougeHeroGroupBalanceHelper.getBalanceLv()

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

function RougeHeroGroupBalanceHelper.getHeroBalanceInfo(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return
	end

	local balanceLv, balanceTalent, equipLv = RougeHeroGroupBalanceHelper.getBalanceLv()

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

return RougeHeroGroupBalanceHelper
