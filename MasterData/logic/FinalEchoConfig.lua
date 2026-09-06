-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/config/FinalEchoConfig.lua

module("logic.extensions.finalecho.config.FinalEchoConfig", package.seeall)

local FinalEchoConfig = class("FinalEchoConfig", BaseConfig)

function FinalEchoConfig:getNames()
	return {
		"final_echo_rank_prize",
		"final_echo_boss",
		"final_echo_buff",
		"final_echo_creeps",
		"final_echo_creeps_master",
		"final_echo_activity"
	}
end

function FinalEchoConfig:handleConfig(name, content)
	if name == "final_echo_rank_prize" then
		self._final_echo_rank_prize = content

		self:_handlerRankPrizeCfgs()
	elseif name == "final_echo_boss" then
		self._final_echo_boss = content
	elseif name == "final_echo_buff" then
		self._final_echo_buff = content
	elseif name == "final_echo_creeps" then
		self._final_echo_creeps = content
	elseif name == "final_echo_creeps_master" then
		self._final_echo_creeps_master = content
	elseif name == "final_echo_activity" then
		self._final_echo_activity = content
	end
end

function FinalEchoConfig:getActCfgById(actId)
	return self._final_echo_activity[actId]
end

function FinalEchoConfig:getBossCfgsById(actId)
	return self._final_echo_boss[actId]
end

function FinalEchoConfig:getBuffCfgsById(actId)
	return self._final_echo_buff[actId]
end

function FinalEchoConfig:_handlerRankPrizeCfgs()
	self._final_echo_rank_prizelist = {}

	for i, v in ipairs(self._final_echo_rank_prize.dataList) do
		if not self._final_echo_rank_prizelist[v.activityId] then
			table.insert(self._final_echo_rank_prizelist[v.activityId], v)

			self._final_echo_rank_prizelist[v.activityId] = self._final_echo_rank_prizelist[v.activityId]
		end
	end
end

function FinalEchoConfig:getRankPrizeDataByRank(actId, rank)
	local prizeCfgs = self._final_echo_rank_prizelist[actId]

	if prizeCfgs then
		return MmUtil.binarySearchInArrayKey(prizeCfgs, "rankRange", rank)
	end
end

function FinalEchoConfig:getCreepCfgs(creepsMasterId)
	return self._final_echo_creeps[creepsMasterId]
end

function FinalEchoConfig:getTeamCfg(creepsMasterId)
	return self._final_echo_creeps_master[creepsMasterId]
end

FinalEchoConfig.instance = FinalEchoConfig.New()

return FinalEchoConfig
