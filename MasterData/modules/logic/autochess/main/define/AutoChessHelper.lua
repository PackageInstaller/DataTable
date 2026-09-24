-- chunkname: @modules/logic/autochess/main/define/AutoChessHelper.lua

module("modules.logic.autochess.main.define.AutoChessHelper", package.seeall)

local AutoChessHelper = class("AutoChessHelper")

function AutoChessHelper.sameWarZoneType(from, to)
	local fromMark = from == AutoChessEnum.WarZone.Two and 1 or 0
	local toMark = to == AutoChessEnum.WarZone.Two and 1 or 0

	return fromMark == toMark
end

function AutoChessHelper.getMeshUrl(resName)
	return string.format("ui/assets/versionactivity_2_5_autochess/%s.asset", resName)
end

function AutoChessHelper.getMaterialUrl(isEnemy)
	if isEnemy then
		return "ui/materials/dynamic/outlinesprite_lw_ui_00.mat"
	else
		return "ui/materials/dynamic/outlinesprite_lw_ui_01.mat"
	end
end

function AutoChessHelper.getImageMaterialUrl(isLeader)
	if isLeader then
		return "ui/materials/dynamic/outlinesprite_lw_ui_01_glow.mat"
	else
		return "ui/materials/dynamic/outlinesprite_lw_ui_00_old.mat"
	end
end

function AutoChessHelper.getEffectUrl(resName)
	return string.format("ui/viewres/versionactivity_2_5/autochess/skill/%s.prefab", resName)
end

function AutoChessHelper.getSceneBgUrl(moduleId, viewType, roundType)
	local modulePath = moduleId == AutoChessEnum.ModuleId.PVE and "pve" or "pvp"

	if viewType ~= AutoChessEnum.ViewType.Player and roundType == AutoChessEnum.RoundType.BOSS then
		return ResUrl.getAutoChessIcon(string.format("scene_%s_%s_boss", modulePath, viewType), "scene")
	else
		return ResUrl.getAutoChessIcon(string.format("scene_%s_%s", modulePath, viewType), "scene")
	end
end

function AutoChessHelper.getFightBtnIcon(roundType, bossId)
	if roundType == AutoChessEnum.RoundType.BOSS then
		local bossCfg = AutoChessConfig.instance:getBossCfg(bossId)

		if not bossCfg.startBtnImage then
			return bossCfg.startBtnImage, "autochess_game_btn_fight2"
		end
	elseif roundType == AutoChessEnum.RoundType.PVE then
		return "autochess_game_commonicon_2", "autochess_game_btn_fight1"
	else
		return "autochess_game_commonicon_1", "autochess_game_btn_fight1"
	end
end

function AutoChessHelper.getChessQualityBg(type, level)
	if type == AutoChessStrEnum.ChessType.Attack or type == AutoChessStrEnum.ChessType.Boss then
		return "v2a5_autochess_quality1_" .. level
	elseif type == AutoChessStrEnum.ChessType.Support then
		return "v2a5_autochess_quality2_" .. level
	else
		return "autochess_leader_chessbg" .. level
	end
end

function AutoChessHelper.getBuffCnt(buffs, buffIds)
	local count = 0

	for _, buff in ipairs(buffs) do
		for _, id in ipairs(buffIds) do
			if buff.id == id then
				count = count + buff.layer
			end
		end
	end

	return count
end

function AutoChessHelper.universalMix(race, subRace, buffs)
	for _, buff in ipairs(buffs) do
		if buff.id == 1015 then
			return true
		else
			local effects = string.split(buff.config.effect, "#")

			if buff.config.type == 1015 and effects[1] == "UniversalBabyRace" and (effects[2] == "None" or effects[2] == race) and (effects[3] == "None" or effects[3] == subRace) then
				return true
			end
		end
	end

	return false
end

function AutoChessHelper.canMix(toChess, fromChess)
	local toId = toChess.id
	local fromId = fromChess.id
	local toIndex = tabletool.indexOf(AutoChessEnum.PenguinChessIds, toId)
	local fromIndex = tabletool.indexOf(AutoChessEnum.PenguinChessIds, fromId)

	if toIndex and fromIndex then
		local buffs = toChess.buffContainer.buffs

		for _, buff in ipairs(buffs) do
			local effects = string.split(buff.config.effect, "#")

			if buff.config.type == 1015 and effects[1] == "PenguinTeam" then
				for i = 2, #effects do
					local params = string.splitToNumber(effects[i], ",")

					if params[1] == fromId then
						return true, true
					end
				end
			end
		end

		return false, ToastEnum.AutoChessPenguinMix
	elseif not toIndex and not fromIndex then
		local config = toChess.config

		if toId == fromId or AutoChessHelper.universalMix(config.race, config.subRace, fromChess.buffContainer.buffs) then
			return true
		end
	end

	return false, ToastEnum.AutoChessBuyTargetError
end

function AutoChessHelper.getLeaderSkillEffect(skillId)
	local skillCo = AutoChessConfig.instance:getLeaderSkillCfg(skillId)
	local skillIndex = skillCo and skillCo.skillIndex

	if skillIndex == 3 then
		return string.split(skillCo.abilities, "#")
	else
		local chessSkillId

		if skillIndex == 1 then
			chessSkillId = tonumber(skillCo.passiveChessSkills)
		elseif skillIndex == 2 then
			chessSkillId = tonumber(skillCo.activeChessSkill)
		end

		if chessSkillId then
			local chessSkillCo = AutoChessConfig.instance:getChessSkillCfg(chessSkillId)

			if chessSkillCo then
				return string.split(chessSkillCo.effect1, "#")
			end
		end
	end
end

function AutoChessHelper.getBuyChessCnt(buyInfos, chessId)
	local cnt = 0

	for _, info in ipairs(buyInfos) do
		if info.chessId == chessId then
			return info.num
		end
	end

	return cnt
end

function AutoChessHelper.getBuyChessCntByType(buyInfos, type)
	local cnt = 0

	for _, info in ipairs(buyInfos) do
		local config = AutoChessConfig.instance:getChessCfgAnyway(info.chessId)

		if config and config.race == type then
			cnt = cnt + info.num
		end
	end

	return cnt
end

function AutoChessHelper.lockScreen(key, lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(key)
	else
		UIBlockMgr.instance:endBlock(key)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function AutoChessHelper.getPlayerPrefs(key, defaultValue)
	local userId = PlayerModel.instance:getMyUserId()
	local actId = Activity182Model.instance:getCurActId()
	local prefsKey = userId .. actId .. key

	return PlayerPrefsHelper.getNumber(prefsKey, defaultValue)
end

function AutoChessHelper.setPlayerPrefs(key, value)
	local userId = PlayerModel.instance:getMyUserId()
	local actId = Activity182Model.instance:getCurActId()
	local prefsKey = userId .. actId .. key

	PlayerPrefsHelper.setNumber(prefsKey, value)
end

function AutoChessHelper.buildSkillDesc(desc)
	desc = string.gsub(desc, "【(.-)】", AutoChessHelper._replaceDescTagFunc)

	return desc
end

function AutoChessHelper._replaceDescTagFunc(skillName)
	local co = AutoChessConfig.instance:getSkillEffectDescCoByName(skillName)

	if not co then
		return string.format("<b>%s</b>", skillName)
	end

	return string.format("<b><u><link=%s>%s</link></u></b>", co.id, skillName)
end

function AutoChessHelper.buildEmptyChess()
	local mo = AutoChessMo.New()

	mo:initEmpty()

	return mo
end

function AutoChessHelper.getUnlockReddot(key, id)
	local prefsKey = string.format("%s_%s", key, id)
	local value = AutoChessHelper.getPlayerPrefs(prefsKey, 0)

	return value == 0
end

function AutoChessHelper.setUnlockReddot(key, id)
	local prefsKey = string.format("%s_%s", key, id)

	AutoChessHelper.setPlayerPrefs(prefsKey, 1)
end

function AutoChessHelper.buildFlowSequence(effectMoList)
	local flow = FlowSequence.New()

	for _, effect in ipairs(effectMoList) do
		if effect.effectType == AutoChessEnum.EffectType.NextFightStep then
			AutoChessHelper.recursion(flow, effect.nextFightStep)
		else
			local work = AutoChessHelper.getEffectWork(effect)

			if work then
				flow:addWork(work)
			end
		end
	end

	return flow
end

function AutoChessHelper.recursion(flow, fightStep)
	if fightStep.actionType == AutoChessEnum.ActionType.ChessMove then
		local parFlow = FlowParallel.New()

		for _, effect in ipairs(fightStep.effect) do
			if effect.effectType == AutoChessEnum.EffectType.Move then
				local work = AutoChessHelper.getEffectWork(effect)

				if work then
					parFlow:addWork(work)
				end
			else
				logError("异常:棋子移动Action下面不该有其他类型Effect")
			end
		end

		flow:addWork(parFlow)
	else
		local skillEffectParams

		if fightStep.actionType == AutoChessEnum.ActionType.ChessSkill then
			local skillWork = AutoChessSkillWork.New(fightStep.fromId, fightStep.reasonId)

			flow:addWork(skillWork)

			local skillCo = AutoChessConfig.instance:getChessSkillCfg(tonumber(fightStep.reasonId), true)

			if skillCo then
				local skillEffectStr = skillCo.skilleffID

				if not string.nilorempty(skillEffectStr) then
					skillEffectParams = string.splitToNumber(skillEffectStr, "#")
				end
			end
		end

		for _, effect in ipairs(fightStep.effect) do
			if effect.effectType == AutoChessEnum.EffectType.NextFightStep then
				AutoChessHelper.recursion(flow, effect.nextFightStep)
			else
				local work = AutoChessHelper.getEffectWork(effect)

				if work then
					if skillEffectParams and effect.effectType == skillEffectParams[2] then
						work:markSkillEffect(fightStep.fromId, skillEffectParams[1])
					end

					flow:addWork(work)
				end
			end
		end
	end
end

function AutoChessHelper.getEffectWork(mo)
	if not AutoChessEnum.EffectTypeToName[mo.effectType] then
		local workName = ""
		local cls = _G[string.format("AutoChess%sWork", workName)]

		if cls then
			return cls.New(mo)
		else
			logError("自走棋缺少Effect处理Work EffectType: " .. mo.effectType)
		end
	end
end

function AutoChessHelper.getChessExtraRaceList(race)
	local raceList = {
		race
	}
	local sceneMo = AutoChessModel.instance:getSceneMo(true)

	if sceneMo then
		local masterMo = sceneMo.fight.mySideMaster
		local buffMos = masterMo and masterMo.buffContainer.buffs

		for i = #buffMos, 1, -1 do
			local mo = buffMos[i]

			if mo.config then
				local effect = mo.config.effect
				local effects = string.split(effect, "#")

				if effects[1] == AutoChessStrEnum.BuffEffect.RaceTagAlias then
					local raceFilter = effects[2]

					if effects[3] ~= AutoChessStrEnum.ChessRace.None and (raceFilter == AutoChessStrEnum.ChessRace.All or tabletool.indexOf(string.split(effects[2], ","), race)) then
						local addRaces

						for _, v in ipairs(effects[3] == AutoChessStrEnum.ChessRace.All and AutoChessConfig.instance:getAllRaceList() or string.split(effects[3], ",")) do
							if v ~= race then
								raceList[#raceList + 1] = v
							end
						end

						break
					end
				end
			end
		end
	end

	return raceList
end

function AutoChessHelper.getSellPrice(race)
	local sellPrice = AutoChessConfig.instance:getConstValue(AutoChessEnum.ConstKey.ChessSellPrice)
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		local masterMo = sceneMo.fight.mySideMaster
		local buffMos = masterMo and masterMo.buffContainer.buffs

		for i = #buffMos, 1, -1 do
			local mo = buffMos[i]

			if mo.config then
				local effect = mo.config.effect
				local effects = string.split(effect, "#")

				if effects[1] == AutoChessStrEnum.BuffEffect.SellIncomeFix then
					local raceFilter = effects[2]

					if raceFilter == AutoChessStrEnum.ChessRace.All or tabletool.indexOf(string.split(effects[2], ","), race) then
						local fixValue = tonumber(effects[4])
						local minValue = tonumber(effects[5])

						if effects[3] == AutoChessStrEnum.BuffFixType.Add then
							sellPrice = sellPrice + fixValue
						elseif effects[3] == AutoChessStrEnum.BuffFixType.Override then
							sellPrice = fixValue
						end

						sellPrice = minValue < sellPrice and sellPrice or minValue

						break
					end
				end
			end
		end
	end

	return sellPrice
end

return AutoChessHelper
