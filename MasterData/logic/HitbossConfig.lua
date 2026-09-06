-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/config/HitbossConfig.lua

module("logic.extensions.hitboss.config.HitbossConfig", package.seeall)

local HitbossConfig = class("HitbossConfig", BaseConfig)

function HitbossConfig:onInit()
	return
end

function HitbossConfig:getNames()
	return {
		"hit_boss_activity",
		"hit_boss_client_common",
		"hit_boss_progress_prize",
		"hit_boss_daily_buff",
		"hit_boss_rank_prize",
		"hit_boss_monster",
		"hit_boss_creeps"
	}
end

function HitbossConfig:handleConfig(name, content)
	if name == "hit_boss_activity" then
		self._hit_boss_activity = content
	elseif name == "hit_boss_client_common" then
		self._hit_boss_client_common = content
	elseif name == "hit_boss_progress_prize" then
		self._hit_boss_progress_prize = content
	elseif name == "hit_boss_daily_buff" then
		self._hit_boss_daily_buff = content
	elseif name == "hit_boss_rank_prize" then
		self._hit_boss_rank_prize = content
	elseif name == "hit_boss_monster" then
		self._hit_boss_monster = content
	elseif name == "hit_boss_creeps" then
		self._hit_boss_creeps = content
	end
end

function HitbossConfig:getActivityCfg(activityId)
	return self._hit_boss_activity[activityId]
end

function HitbossConfig:getCommonValue(activityId, key, isToNumber)
	local result
	local data = self:getActivityCfg(activityId)

	if data then
		if not data.comPlanId then
			local comPlanId = 0
			local comData = self._hit_boss_client_common[comPlanId]

			if comData then
				result = comData[key]
			end

			if isToNumber then
				return checknumber(result)
			else
				return result
			end
		end
	end
end

function HitbossConfig:getPrizeCfgs(activityId)
	return self._hit_boss_progress_prize[activityId]
end

function HitbossConfig:getPrizeCfg(activityId, prizeId)
	return self._hit_boss_progress_prize[activityId][prizeId]
end

function HitbossConfig:getBossId(activityId)
	return self:getActivityCfg(activityId).bossId
end

function HitbossConfig:getCreepsList(creepsMasterId)
	return self._hit_boss_creeps[creepsMasterId] or {}
end

function HitbossConfig:getMonsterCfg(creepsMasterId)
	return self._hit_boss_monster[creepsMasterId]
end

function HitbossConfig:getPrizeProgressList(activityId)
	local list = {}
	local cfgs = self:getPrizeCfgs(activityId)

	for i, v in ipairs(cfgs) do
		table.insert(list, checknumber(v.progress))
	end

	return list
end

function HitbossConfig:getDailyBuffCfg(activityId, day)
	return self._hit_boss_daily_buff[activityId][day]
end

function HitbossConfig:getDailyBuffCfgs(activityId)
	return self._hit_boss_daily_buff[activityId]
end

function HitbossConfig:getPrizeList(activityId, rank)
	local cfgs = self._hit_boss_rank_prize[activityId]

	if cfgs then
		for i, v in ipairs(cfgs) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				return string.split(v.prize, "#")
			end
		end
	end

	return nil
end

function HitbossConfig:getBossRankPrizeCfg(activityId)
	return self._hit_boss_rank_prize[activityId]
end

HitbossConfig.instance = HitbossConfig.New()

return HitbossConfig
