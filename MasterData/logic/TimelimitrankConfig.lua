-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/config/TimelimitrankConfig.lua

module("logic.extensions.timelimitrank.config.TimelimitrankConfig", package.seeall)

local TimelimitrankConfig = class("TimelimitrankConfig", BaseConfig)

function TimelimitrankConfig:onInit()
	TimelimitrankConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function TimelimitrankConfig:getNames()
	return {
		"time_limit_rank_define",
		"time_limit_rank_top_prize",
		"time_limit_rank_progress_prize",
		"time_limit_rank_common"
	}
end

function TimelimitrankConfig:handleConfig(name, content)
	if name == "time_limit_rank_define" then
		self._define = content
	elseif name == "time_limit_rank_top_prize" then
		self._topPrize = content
	elseif name == "time_limit_rank_progress_prize" then
		self._progressPrize = content
	elseif name == "time_limit_rank_common" then
		self._common = content
	end
end

function TimelimitrankConfig:getDefineById(id)
	if id then
		return self._define[id]
	else
		return nil
	end
end

function TimelimitrankConfig:getDefine()
	return self._define
end

function TimelimitrankConfig:getTopPrizeById(typeId)
	return self._topPrize[typeId]
end

function TimelimitrankConfig:getTopPrize()
	return self._topPrize
end

function TimelimitrankConfig:getProgressPrizeById(typeId)
	return self._progressPrize[typeId]
end

function TimelimitrankConfig:getProgressPrize()
	return self._progressPrize
end

function TimelimitrankConfig:getCommonValue(key)
	return self._common[key].value
end

TimelimitrankConfig.instance = TimelimitrankConfig.New()

return TimelimitrankConfig
