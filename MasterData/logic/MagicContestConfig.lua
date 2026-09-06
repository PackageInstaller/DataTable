-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/config/MagicContestConfig.lua

module("logic.extensions.magiccontest.config.MagicContestConfig", package.seeall)

local MagicContestConfig = class("MagicContestConfig", BaseConfig)

function MagicContestConfig:getNames()
	return {
		"magic_contest_activity",
		"magic_contest_creeps",
		"magic_contest_monster",
		"magic_contest_rank_prize"
	}
end

function MagicContestConfig:handleConfig(name, content)
	if name == "magic_contest_activity" then
		self._magic_contest_activity = content
	elseif name == "magic_contest_creeps" then
		self._magic_contest_creeps = content
	elseif name == "magic_contest_monster" then
		self._magic_contest_monster = content
	elseif name == "magic_contest_rank_prize" then
		self._magic_contest_rank_prize = content
	end
end

function MagicContestConfig:getActivityData(activityId)
	return self:_safeGet(self._magic_contest_activity, activityId)
end

function MagicContestConfig:getRankPrizeDatass(activityId)
	return self:_safeGet(self._magic_contest_rank_prize, activityId)
end

function MagicContestConfig:getRankPrizeDatas(activityId, type)
	return self:_safeGet(self._magic_contest_rank_prize, activityId, type)
end

function MagicContestConfig:getRankPrizeData(activityId, type, index)
	return self:_safeGet(self._magic_contest_rank_prize, activityId, type, index)
end

function MagicContestConfig:getRankPrizeDataByRank(activityId, type, rank)
	local datas = self:getRankPrizeDatas(activityId, type)

	return MmUtil.binarySearchInArrayKey(datas, "rankRange", rank)
end

function MagicContestConfig:getMonsterDatas(systemPlanId)
	return self:_safeGet(self._magic_contest_monster, systemPlanId)
end

function MagicContestConfig:getMonsterData(systemPlanId, creepsMasterId)
	return self:_safeGet(self._magic_contest_monster, systemPlanId, creepsMasterId)
end

function MagicContestConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._magic_contest_creeps, creepsMasterId)
end

function MagicContestConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._magic_contest_creeps, creepsMasterId, creepsId)
end

function MagicContestConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

MagicContestConfig.instance = MagicContestConfig.New()

return MagicContestConfig
