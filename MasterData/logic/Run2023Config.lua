-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/config/Run2023Config.lua

module("logic.extensions.run2023.config.Run2023Config", package.seeall)

local Run2023Config = class("Run2023Config", BaseConfig)

function Run2023Config:onInit()
	Run2023Config.super.onInit(self)
end

function Run2023Config:getNames()
	return {
		"run_game",
		"run_game_state",
		"run_game_blessword",
		"run_game_reward",
		"run_game_common",
		"run_game_label"
	}
end

function Run2023Config:handleConfig(name, content)
	if name == "run_game" then
		self._run_game = content
	elseif name == "run_game_state" then
		self._run_game_state = content
	elseif name == "run_game_blessword" then
		self._run_game_blessword = content
	elseif name == "run_game_reward" then
		self._run_game_reward = content
	elseif name == "run_game_common" then
		self._run_game_common = content
	elseif name == "run_game_label" then
		self._run_game_label = content
	end
end

function Run2023Config:getGameCfgsByActId(actId)
	return self._run_game[actId]
end

function Run2023Config:getGameStateCfgsById(planId, stateId)
	local configs = self._run_game_state[planId]

	if configs then
		return configs[stateId]
	end
end

function Run2023Config:getGameBlessWordCfgs(planId)
	return self._run_game_blessword[planId]
end

function Run2023Config:getGameBlessWordCfgsById(planId, id)
	local configs = self._run_game_blessword[planId]

	if configs then
		return configs[id]
	end
end

function Run2023Config:getGameRewardCfgsById(planId, time)
	local configs = self._run_game_reward[planId]
	local result = {}

	for i, v in ipairs(configs or {}) do
		if time <= v.gameTime then
			local prizeStr = string.split(v.reward, "#")

			for _, prize in ipairs(prizeStr) do
				table.insert(result, prize)
			end

			break
		end
	end

	return result
end

function Run2023Config:getGameCommonByKey(key)
	return self._run_game_common[key].value
end

function Run2023Config:getGameLabelCfgsByActId(activityId)
	local actData = self:getGameCfgsByActId(activityId)

	if actData then
		if not actData.labelPlanId then
			local labelPlanId = 0

			return self._run_game_label[labelPlanId]
		end
	end
end

function Run2023Config:getGameLabelCfgs(key)
	return self._run_game_label[key]
end

function Run2023Config:getGameDailyTimesByActId(activityId)
	local cfg = self:getGameCfgsByActId(activityId)

	return (cfg or nil) and (cfg.dailyTimes or 3)
end

Run2023Config.instance = Run2023Config.New()

return Run2023Config
