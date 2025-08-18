-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\PVP\\PVPCommon.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResPVP = require("ClientData/ResAsyncPVPMisc")
local ResMultiPVPMisc = require("ClientData/ResMultiPVPMisc")
local ResMultiPVPRank = require("ClientData/ResMultiPVPRank")
local ResMultiPVPRobot = require("ClientData/ResMultiPVPRobot")
local ResMultiPVPRobotFormation = require("ClientData/ResMultiPVPRobotFormation")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local ResColor = require("ClientData/ResColor")
local ResRobotName = require("ClientData/ResRobotName")
local ResArenaMisc = require("ClientData/ResArenaMisc")
local ResArenaLeague = require("ClientData/ResArenaLeague")
local ResArenaDan = require("ClientData/ResArenaDan")
local PVPCommon = {}
local self = PVPCommon

function PVPCommon.getAsyncPvpLeftTime(...)
	return CurAvatar:getAsyncPvpLeftTime()
end

function PVPCommon.getSeniorPvpLeftTime(...)
	local dayOffset = ResMultiPVPMisc[1].day_offset
	local refreshDay = ResMultiPVPMisc[1].refresh_day

	return ClientUtils.getNextResetTime(dayOffset, refreshDay) - ClientUtils.getServerTime()
end

function PVPCommon.getAwardLimit(...)
	return ResMultiPVPMisc[1].award_limit
end

function PVPCommon.getAwardId(...)
	return ResMultiPVPMisc[1].award_id
end

function PVPCommon.getRankPartInfo(rankIndex)
	local total = #ResMultiPVPRank

	if rankIndex <= 0 or rankIndex > ResMultiPVPRank[total].rank_index then
		return ResMultiPVPRank[total]
	end

	local info

	for i = 1, total do
		info = ResMultiPVPRank[i]

		if rankIndex < info.rank_index and i > 1 then
			return ResMultiPVPRank[i - 1]
		end

		info = ResMultiPVPRank[total - i + 1]

		if rankIndex >= info.rank_index then
			return info
		end
	end
end

function PVPCommon.getTicketNum(...)
	return CurAvatar:getItemNumById(ResMultiPVPMisc[1].item_id)
end

function PVPCommon.getSpeedStr(speed, showAdd)
	local preStr = ""

	if showAdd == true and speed >= 0 then
		preStr = "+"
	end

	return utils.format(Lang.get(29959), preStr, math.floor(speed * 6))
end

local ICON_PATH = "Atlas/CommonAtlas/IconRankAtlas"
local ICON_PATH1 = "Atlas/CommonAtlas/IconRankAtlas01"

function PVPCommon.setRankUI(uiData, rankInfo)
	if rankInfo then
		if tonumber(rankInfo.big_rank_idx) > 6 then
			uiData[1]:setImage(ICON_PATH1, "IconRank" .. rankInfo.big_rank_idx)
			uiData[2]:setImage(ICON_PATH1, "TxtRank" .. rankInfo.big_rank_idx)
		else
			uiData[1]:setImage(ICON_PATH, "IconRank" .. rankInfo.big_rank_idx)
			uiData[2]:setImage(ICON_PATH, "TxtRank" .. rankInfo.big_rank_idx)
		end

		uiData[3]:setImage(ICON_PATH, "Bg" .. rankInfo.small_rank_idx)
		uiData[4]:setImage(ICON_PATH, "Txt" .. rankInfo.small_rank_idx)

		local color = ResColor["COLORBGRANK" .. rankInfo.big_rank_idx]

		uiData[3]:setColorByRGBA(color.r, color.g, color.b, color.a)

		color = ResColor["COLORRANK" .. rankInfo.big_rank_idx]

		uiData[4]:setColorByRGBA(color.r, color.g, color.b, color.a)
	end
end

function PVPCommon.setRankIconBig(img, rankInfo)
	if rankInfo then
		if tonumber(rankInfo.big_rank_idx) > 6 then
			img:setImage(ICON_PATH1, "IconRank" .. rankInfo.big_rank_idx)
		else
			img:setImage(ICON_PATH, "IconRank" .. rankInfo.big_rank_idx)
		end
	end
end

function PVPCommon.getMultiPvpTicketIconPath(...)
	return ClientUtils.getMoneyIcon(ResMultiPVPMisc[1].item_id)
end

function PVPCommon.getPointIconPath(...)
	return ClientUtils.getMoneyIcon(ResMultiPVPMisc[1].item_id)
end

function PVPCommon.getSeniorPvpAwardIcon(...)
	return ClientUtils.getMoneyIcon(self.getAwardId())
end

function PVPCommon.isMultiPvpFormationEmpty(...)
	for i = 1, 3 do
		local formation = CurAvatar:getNowFormation(Const["FORMATION_MULTIPVP_DEFEND_" .. i])

		if next(formation) == nil then
			return true
		end
	end

	return false
end

function PVPCommon.getSeniorPvpDailyFreeTimes(...)
	return ResMultiPVPMisc[1].free_times or 0
end

function PVPCommon.getAsyncPvpRobotInfo(uid)
	uid = tonumber(uid)

	if uid > 0 then
		local info = ResRobotName[uid]

		return info or ResRobotName[#ResRobotName]
	end

	return ResRobotName[#ResRobotName]
end

function PVPCommon.getRobotInfo(uid)
	uid = tonumber(uid)

	if uid > 0 then
		local robotInfo

		for i = #ResMultiPVPRobot, 1, -1 do
			local info = ResMultiPVPRobot[i]

			if uid >= info.rank_index then
				robotInfo = info

				break
			end
		end

		return robotInfo
	end

	return ResMultiPVPRobot[#ResMultiPVPRobot]
end

function PVPCommon.getRobotFormation(uid)
	local info = self.getRobotInfo(uid)
	local formation = {}

	if info and info.team_index then
		for i, team in ipairs(info.team_index) do
			if ResMultiPVPRobotFormation[team] then
				local heros = utils.getRobotHeroInfo(ResMultiPVPRobotFormation[team].hero_data, ResMultiPVPRobotFormation[team].formation)

				formation[i] = heros or {}
			end
		end
	end

	return formation
end

function PVPCommon.getMultiPvpRobotFormationConfig(teamIdx)
	return ResMultiPVPRobotFormation[teamIdx]
end

function PVPCommon.getRobotCommInfoByType(uid, robotType)
	if robotType == Const.ROLEINFO_ROBOT_TYPE_MULTIPVP then
		return self.getMultiPvpRobotCommInfo(uid)
	elseif robotType == Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP then
		return self.getAsyncPvpRobotCommInfo(uid)
	end
end

function PVPCommon.getRobotPersonalInfoByType(uid, robotType)
	if robotType == Const.ROLEINFO_ROBOT_TYPE_MULTIPVP then
		return self.getMultiPvpRobotPersonalInfo(uid)
	elseif robotType == Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP then
		return self.getAsyncPvpRobotPersonalInfo(uid)
	end
end

function PVPCommon.getAsyncPvpRobotCommInfo(uid)
	local info = self.getAsyncPvpRobotInfo(uid)
	local comm = {}

	if info then
		comm.name = info.name or Lang.get(29960)
		comm.uid = uid
		comm.gender = info.gender or 0
		comm.head = info.head or 1
		comm.level = info.level or 1
	end

	return comm
end

function PVPCommon.getMultiPvpRobotCommInfo(uid)
	local info = self.getRobotInfo(uid)
	local comm = {}

	if info then
		comm.name = info.name or Lang.get(29960)
		comm.uid = uid
		comm.gender = info.gender or 0
		comm.head = info.head_id or 1
		comm.level = info.level or 1
	end

	return comm
end

function PVPCommon.getAsyncPvpRobotPersonalInfo(uid)
	local info = self.getAsyncPvpRobotInfo(uid)
	local heroData

	if info and info.hero_data then
		heroData = utils.getRobotServerFormation(info.hero_data)

		local personnalInfo = {
			openid = 25226,
			clanname = "",
			signature = "",
			edit_hero = 0,
			power = CapacityHelper.getFormationCapacity({
				item = heroData
			}),
			phero = {
				crystal_type = 1,
				crystal_step = 1
			},
			stage = info.stage
		}

		for _, heroInfo in ipairs(heroData or {}) do
			local data = {}

			data.hero = heroInfo.hero.base
			data.artifact = heroInfo.artifact

			table.insert(personnalInfo.phero, data)
		end

		return personnalInfo
	end
end

function PVPCommon.getMultiPvpRobotPersonalInfo(uid)
	local info = self.getRobotInfo(uid)
	local heroData

	if info and info.team_index then
		local team = info.team_index[1]
		local config = ResMultiPVPRobotFormation[team]

		if config then
			heroData = utils.getRobotServerFormation(config.hero_data, config.formation)
		end

		local personnalInfo = {
			openid = 25226,
			clanname = "",
			signature = "",
			edit_hero = 0,
			power = self.getRobotFormationPower(uid),
			phero = {
				crystal_type = 1,
				crystal_step = 1
			},
			stage = info.stage
		}

		for _, heroInfo in ipairs(heroData or {}) do
			local data = {}

			data.hero = heroInfo.hero.base
			data.artifact = heroInfo.artifact

			table.insert(personnalInfo.phero, data)
		end

		return personnalInfo
	end
end

function PVPCommon.getRobotPower(heros)
	local power = 0

	for i, _heros in ipairs(heros) do
		for j, hero in ipairs(_heros) do
			power = power + hero:getCapacity()
		end
	end

	return power
end

function PVPCommon.getMultiPvpRobotServerFormation(uid)
	local formations = self.getMultiPvpReplayRobotFormation(uid)
	local data = {}

	for i, formation in ipairs(formations) do
		table.insert(data, {
			data = formation
		})
	end

	return data
end

function PVPCommon.getMultiPvpReplayRobotFormation(uid)
	local info = self.getRobotInfo(uid)
	local serverFormation = {}

	if info and info.team_index then
		for i, team in ipairs(info.team_index) do
			local data = {}
			local config = ResMultiPVPRobotFormation[team]

			if config then
				local heroData = utils.getRobotServerFormation(config.hero_data, config.formation)

				data.camp = BattleConst.CAMP_MONSTER
				data.index = i
				data.item = heroData

				table.insert(serverFormation, data)
			end
		end
	end

	return serverFormation
end

function PVPCommon.getFormationPower(formations)
	local power = 0

	for i, formation in ipairs(formations) do
		power = power + CapacityHelper.getFormationCapacity(formation.data)
	end

	return power
end

function PVPCommon.getRobotFormationPower(uid)
	local formations = self.getMultiPvpRobotServerFormation(uid)

	return self.getFormationPower(formations)
end

function PVPCommon.checkAndChangeRobotCommInfo(comm, robotType)
	if utils.isRobot(comm.uid) then
		local rcomm = self.getRobotCommInfoByType(comm.uid, robotType)

		if rcomm then
			comm.level = rcomm.level
			comm.name = rcomm.name
			comm.head = rcomm.head
		end
	end
end

function PVPCommon.getMySeniorPvpPower(...)
	local power = 0

	if CurAvatar:isFormationSnapShot(Const.FORMATION_MULTIPVP_DEFEND_1) then
		local formation = CurAvatar:getFormationSnapShotFullData(Const.FORMATION_MULTIPVP_DEFEND_1)

		if formation and formation then
			for i, info in ipairs(formation.item) do
				power = power + CapacityHelper.getFormationCapacity(info.data)
			end
		end
	else
		for i = 1, 3 do
			power = power + CurAvatar:getNowFormationCapacity(Const["FORMATION_MULTIPVP_DEFEND_" .. i])
		end
	end

	return power
end

function PVPCommon.getMyAsyncPvpPower(...)
	local totalPower = 0

	if CurAvatar:isFormationSnapShot(Const.FORMATION_ASYNC_DEFEND) then
		local formation = CurAvatar:getFormationSnapShotFullData(Const.FORMATION_ASYNC_DEFEND)

		if formation then
			for i, info in ipairs(formation.item) do
				totalPower = totalPower + CapacityHelper.getFormationCapacity(info.data)
			end
		end
	else
		for gid, _ in pairs(CurAvatar.asyncPVPDefendFormation or {}) do
			if CurAvatar.heroDic[gid] then
				totalPower = totalPower + CurAvatar.heroDic[gid]:getCapacity()
			end
		end

		local pet = CurAvatar:getFormationPet(Const.FORMATION_ASYNC_DEFEND)

		if pet then
			totalPower = totalPower + pet:getCapacity()
		end
	end

	return totalPower
end

function PVPCommon.getZoneInfo(league)
	return ResArenaLeague[league]
end

function PVPCommon.getZoneInfoByDan(dan)
	for i, info in ipairs(ResArenaLeague) do
		if dan >= info.dan_low_limit and dan <= info.dan_high_limit then
			return info
		end
	end
end

function PVPCommon.getNextActPvpMatchTime(refreshTime)
	return refreshTime + ResArenaMisc[1].match_cd
end

function PVPCommon.getTotalChallengeTimes(...)
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData == nil then
		return -1
	end

	local zoneInfo = self.getZoneInfo(actData.league)

	if zoneInfo then
		return zoneInfo.challenge_limit
	end

	return -1
end

function PVPCommon.getLeftChallengeTimes(...)
	local arenaData = CurAvatar:getPVPArenaActivityData()

	if arenaData == nil then
		return -1
	end

	return arenaData.challenge_times
end

function PVPCommon.getTotalMatchTimes()
	return ResArenaMisc[1].match_times
end

function PVPCommon.getPartInfoByScore(score, league)
	local arenaData = CurAvatar:getPVPArenaActData()

	if arenaData then
		return arenaData:getPartInfoByScore(score, league)
	end
end

function PVPCommon.isOpactPvpChallenged(uid)
	if CurAvatar.opactPvpChallengedInfo then
		return CurAvatar.opactPvpChallengedInfo[uid] ~= nil
	else
		ClientUtils.trySendException("stiger opactpvp", "CurAvatar.opactPvpChallengedInfo is nil!!!!!")
	end

	return true
end

function PVPCommon.getScoreChange(myScore, otherScore)
	local e = 1 / (1 + math.pow(10, (otherScore - myScore) / 200))
	local partInfo = self.getPartInfoByScore(myScore)
	local offset = math.floor(partInfo.attack_k * (1 - e))

	return offset + math.floor(offset * ResArenaMisc[1].win_revise / 10000)
end

function PVPCommon.isOpactPvpValid(...)
	local actData = CurAvatar:getPVPArenaActData()

	if actData and actData.state == Const.OPACT_STATE_FREEZE then
		return false, Lang.get(29961)
	elseif not actData then
		return false, Lang.get(29962)
	end

	return true
end

function PVPCommon.isOpactPvpEnd(...)
	local actData = CurAvatar:getPVPArenaActData()

	if not actData then
		return true, Lang.get(29962)
	end

	return false
end

function PVPCommon.getOpactPvpDefendPower(...)
	local actData = CurAvatar:getPVPArenaActData()

	if actData then
		return actData:getOpactPvpDefendPower()
	end

	return 0
end

function PVPCommon.isTopPvpEnd()
	local actData = CurAvatar:getTopPVPActivityData()

	if not actData then
		return true, Lang.get(32785)
	end

	return false
end

return PVPCommon
