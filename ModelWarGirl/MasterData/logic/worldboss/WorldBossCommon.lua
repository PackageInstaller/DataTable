-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\WorldBoss\\WorldBossCommon.lua

local ResWorldBossGrade = require("ClientData/ResWorldBossGrade")
local ResWorldBossDuan = require("ClientData/ResWorldBossDuan")
local ResWorldBossModeTwoGrade = require("ClientData/ResWorldBossModeTwoGrade")
local ResWorldBoss = require("ClientData/ResWorldBoss")
local ResWorldBossMisc = require("ClientData/ResWorldBossMisc")
local ResMonster = require("ClientData/ResMonster")
local Monster = require("Common/Object/Monster")
local PVPCommon = require("Logic/PVP/PVPCommon")
local ResRandClient = require("ClientData/ResRandClient")
local WorldBossCommon = {}
local self = WorldBossCommon

function WorldBossCommon.setCurBossActId(actId)
	self.actId = actId
end

function WorldBossCommon.getCurBossActId(...)
	return self.actId
end

function WorldBossCommon._getActData(...)
	if self.actId then
		local actObj = CurAvatar:getActivityObj(self.actId)

		if actObj then
			return actObj.actData
		end
	end
end

function WorldBossCommon.refreshWorldBossActData(...)
	local actData = self._getActData()

	if actData then
		actData:refreshState()
	end
end

function WorldBossCommon.getCurBossActObj(...)
	return self._getActData()
end

function WorldBossCommon.getWeekIndex(...)
	local actData = self._getActData()

	if actData then
		return actData.serverData.week_index or 1
	end
end

function WorldBossCommon.getCurBossLeftTime(...)
	local actData = self._getActData()

	if actData then
		return math.max(0, (actData.serverData.close_tick or 0) - ClientUtils.getServerTime())
	end

	return 0
end

function WorldBossCommon.getNextBossLeftTime(...)
	return self.getCurBossLeftTime()
end

local function _sortScore(v1, v2)
	return v1.score > v2.score
end

function WorldBossCommon.getPartAwardInfos(...)
	local bossId = 1
	local actData = self._getActData()

	if actData and actData.serverData.boss_type then
		bossId = actData.serverData.boss_type
	end

	local data = ResWorldBossGrade[bossId]
	local infos = {}

	for point, info in pairs(data) do
		table.insert(infos, info)
	end

	table.sort(infos, _sortScore)

	return infos
end

function WorldBossCommon.getLevelAwardInfos(...)
	local bossId = 1
	local actData = self._getActData()

	if actData and actData.serverData.boss_type then
		bossId = actData.serverData.boss_type
	end

	local data = ResWorldBossDuan[bossId]
	local infos = {}

	for point, info in pairs(data) do
		table.insert(infos, info)
	end

	table.sort(infos, _sortScore)

	return infos
end

function WorldBossCommon.getEliteAwardInfos(...)
	local bossId = 1
	local actData = self._getActData()

	if actData and actData.serverData.boss_type then
		bossId = actData.serverData.boss_type
	end

	local data = ResWorldBossModeTwoGrade[bossId]
	local infos = {}

	for point, info in pairs(data) do
		table.insert(infos, info)
	end

	table.sort(infos, _sortScore)

	return infos
end

function WorldBossCommon.canShowOnRank(nowScore)
	if CurAvatar.onShowWorldBossRankIndex and CurAvatar.onShowWorldBossRankIndex ~= 1 then
		return true
	end

	local actData = self.getCurBossActObj()

	if actData then
		local bossId = actData.serverData.boss_type
		local limitScore = ResWorldBossMisc[1].rank_score[bossId]

		return limitScore <= nowScore
	end

	return false
end

function WorldBossCommon.getCurBossInfo(bossId)
	if bossId == nil then
		local actData = self._getActData()

		if actData then
			bossId = actData.serverData.boss_type
		end
	end

	if bossId == nil or bossId <= 0 then
		bossId = 1
	end

	local hard = self.getHardLevel(bossId)

	if hard <= 0 then
		hard = 1
	end

	return ResWorldBoss[bossId][hard]
end

function WorldBossCommon.getHardLevel(bossId)
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		return actData:getHardLevel(bossId)
	end

	return 1
end

function WorldBossCommon.getCurBossBattleInfo(...)
	local bossInfo = self.getCurBossInfo()

	return Monster(bossInfo.boss_id)
end

function WorldBossCommon.getNextBossInfo(...)
	local actData = self._getActData()

	if actData then
		local bossId = actData.serverData.next_boss_type

		if bossId then
			local hard = self.getHardLevel(bossId)

			return ResWorldBoss[bossId][hard]
		end
	end
end

function WorldBossCommon.getNextBossBattleInfo(...)
	local bossInfo = self.getNextBossInfo()

	return Monster(bossInfo.boss_id)
end

function WorldBossCommon.getDifficultIconPath(hard)
	return {
		"Atlas/WorldBossAtlas/WorldBossAtlas",
		"IconDiff" .. hard
	}
end

function WorldBossCommon.getLeftBattleTimes(...)
	local times = 0
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		times = actData:getDayTimes()
	end

	return times, self:getTotalBattleTimes()
end

function WorldBossCommon.getLeftEliteBattleTimes(...)
	local times = 0
	local totalTimes = 0
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		times = actData:getEliteTimes()
		totalTimes = actData:getEliteTotalTimes()
	end

	return times, totalTimes
end

function WorldBossCommon.getAddDailyTimes(oriTimes)
	return math.min(self:getTotalBattleTimes(), oriTimes + ResWorldBossMisc[1].day_free_times)
end

function WorldBossCommon.getTotalBattleTimes(...)
	local total = ResWorldBossMisc[1].times_limit

	return CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_WORLD_BOSS, total)
end

function WorldBossCommon.setRankUI(uiData, rankInfo)
	PVPCommon.setRankUI(uiData, rankInfo)
end

function WorldBossCommon.getCurRankInfo(score)
	return self.getRankInfo(self.getSumScore())
end

function WorldBossCommon.getSumScore(...)
	local sumScore = 0
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		sumScore = actData:getSumScore()
	end

	return sumScore
end

function WorldBossCommon.getRankInfo(score)
	score = score or self.getSumScore()

	local info = self.getLevelAwardInfos()

	for i = #info, 1, -1 do
		if score < info[i].score then
			return info[i], info[math.min(#info, i + 1)], false
		end
	end

	return info[1], info[1], true
end

function WorldBossCommon.getPartInfosByScoreBlock(score1, score2)
	local info = self.getPartAwardInfos()

	return self._getInfosByScoreBlock(score1, score2, info)
end

function WorldBossCommon.getRankInfosByScoreBlock(score1, score2)
	local info = self.getLevelAwardInfos()

	return self._getInfosByScoreBlock(score1, score2, info)
end

function WorldBossCommon._getInfosByScoreBlock(score1, score2, info)
	local continue = false
	local flag1, flag2 = false, false
	local preScore = 0
	local infos = {}

	for i = #info, 1, -1 do
		preScore = 0

		if i + 1 <= #info then
			preScore = info[i + 1].score
		end

		continue = false

		if flag1 == false and score1 < info[i].score then
			table.insert(infos, {
				gap = info[i].score - preScore,
				info = info[i]
			})

			flag1 = true
			continue = true
		end

		if flag2 == false then
			if score2 < info[i].score then
				if continue == true then
					break
				else
					table.insert(infos, {
						gap = info[i].score - preScore,
						info = info[i]
					})

					break
				end
			elseif continue == false and flag1 == true then
				table.insert(infos, {
					gap = info[i].score - preScore,
					info = info[i]
				})
			end
		end
	end

	return infos
end

function WorldBossCommon.isInFrozenTime(...)
	local leftTime = self.getCurBossLeftTime()

	if leftTime <= 0 then
		return true
	end

	return leftTime <= self.getConfigFrozenTime()
end

function WorldBossCommon.getFrozenTime(...)
	local leftTime = self.getCurBossLeftTime()

	return leftTime - self.getConfigFrozenTime()
end

function WorldBossCommon.getConfigFrozenTime(...)
	return ResWorldBossMisc[1].freeze_time * 60
end

function WorldBossCommon.getBattleAward(...)
	local info = self.getCurBossInfo()

	if info then
		return ClientUtils.getObjectByRandId(info.awardid)
	end
end

function WorldBossCommon.isAwardUp(bossId)
	local awardId = ResWorldBossMisc[1].rank_score[bossId]

	if awardId then
		local gradeInfo = ResWorldBossGrade[bossId]

		if gradeInfo and gradeInfo[awardId] then
			return gradeInfo[awardId].up_ratio ~= nil
		end
	end
end

function WorldBossCommon:getworldBossEliteOpen()
	local key = CurAvatar.uid .. "_" .. "worldBossElite"
	local value = UnityEngine.PlayerPrefs.GetInt(key) or 0

	return value
end

function WorldBossCommon:setworldBossEliteOpen()
	local key = CurAvatar.uid .. "_" .. "worldBossElite"

	UnityEngine.PlayerPrefs.SetInt(key, 1)
end

return WorldBossCommon
