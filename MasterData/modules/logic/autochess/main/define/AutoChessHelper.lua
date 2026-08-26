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
		local bossCfg = lua_auto_chess_boss.configDict[bossId]

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

function AutoChessHelper.getMallRegionByType(regions, type)
	for _, region in ipairs(regions) do
		local mallCo = lua_auto_chess_mall.configDict[region.mallId]

		if mallCo.type == type then
			return region
		end
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
			local buffCo = lua_auto_chess_buff.configDict[buff.id]
			local effects = string.split(buffCo.effect, "#")

			if buffCo.type == 1015 and effects[1] == "UniversalBabyRace" and (effects[2] == "None" or effects[2] == race) and (effects[3] == "None" or effects[3] == subRace) then
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
			local buffCo = lua_auto_chess_buff.configDict[buff.id]
			local effects = string.split(buffCo.effect, "#")

			if buffCo.type == 1015 and effects[1] == "PenguinTeam" then
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
		local toCo = AutoChessConfig.instance:getChessCfgById(toId, toChess.star)

		if toId == fromId or AutoChessHelper.universalMix(toCo.race, toCo.subRace, fromChess.buffContainer.buffs) then
			return true
		end
	end

	return false, ToastEnum.AutoChessBuyTargetError
end

function AutoChessHelper.getLeaderSkillEffect(skillId)
	local skillCo = lua_auto_chess_master_skill.configDict[skillId]
	local skillIndex = skillCo.skillIndex

	if skillIndex == 3 then
		return string.split(skillCo.abilities, "#")
	else
		local chessSkillId

		if skillIndex == 1 then
			chessSkillId = tonumber(skillCo.passiveChessSkills)
		elseif skillIndex == 2 then
			chessSkillId = tonumber(skillCo.activeChessSkill)
		end

		local chessSkillCo = lua_auto_chess_skill.configDict[chessSkillId]

		if chessSkillCo then
			return string.split(chessSkillCo.effect1, "#")
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
		local config = AutoChessConfig.instance:getChessCfg(info.chessId)

		if config and config.race == type then
			cnt = cnt + info.num
		end
	end

	return cnt
end

function AutoChessHelper.isPrimeNumber(number)
	number = tonumber(number)

	if number == 2 then
		return true
	elseif number == 1 or number % 2 == 0 then
		return false
	else
		local right = math.floor(math.sqrt(number)) + 1

		for i = 3, right, 2 do
			if number % i == 0 then
				return false
			end
		end
	end

	return true
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
	local tbl = {}

	tbl.uid = 0
	tbl.id = 0

	return tbl
end

function AutoChessHelper.copyChess(chess)
	if tonumber(chess.uid) == 0 then
		return AutoChessHelper.buildEmptyChess()
	end

	local copyTbl = {}

	copyTbl.uid = chess.uid
	copyTbl.id = chess.id
	copyTbl.star = chess.star
	copyTbl.exp = chess.exp
	copyTbl.maxExpLimit = chess.maxExpLimit
	copyTbl.teamType = chess.teamType
	copyTbl.status = chess.status
	copyTbl.battle = tonumber(chess.battle)
	copyTbl.hp = tonumber(chess.hp)
	copyTbl.skillContainer = chess.skillContainer
	copyTbl.buffContainer = chess.buffContainer
	copyTbl.durability = chess.durability
	copyTbl.cd = chess.cd

	local skillIds = {}

	for k, id in ipairs(chess.replaceSkillChessIds) do
		skillIds[k] = id
	end

	copyTbl.replaceSkillChessIds = skillIds

	return copyTbl
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

return AutoChessHelper
