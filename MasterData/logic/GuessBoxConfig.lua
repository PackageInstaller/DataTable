-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/config/GuessBoxConfig.lua

module("logic.extensions.guessbox.config.GuessBoxConfig", package.seeall)

local GuessBoxConfig = class("GuessBoxConfig", BaseConfig)

function GuessBoxConfig:onInit()
	GuessBoxConfig.super.onInit(self)
end

function GuessBoxConfig:getNames()
	return {
		"guess_box_game",
		"guess_box_game_score_prize",
		"guess_box_game_box",
		"guess_box_game_flower",
		"guess_box_game_rule",
		"guess_box_game_setting",
		"guess_box_game_level"
	}
end

function GuessBoxConfig:handleConfig(name, content)
	if name == "guess_box_game" then
		self._gbCfgs = content
	elseif name == "guess_box_game_score_prize" then
		self._gbScorePrizeCfgs = content
	elseif name == "guess_box_game_box" then
		self._gbBoxCfgs = content
	elseif name == "guess_box_game_flower" then
		self._gbFlowerCfgs = content
	elseif name == "guess_box_game_rule" then
		self._gbRuleCfgs = content
	elseif name == "guess_box_game_setting" then
		self._gbSettingCfgs = content
	elseif name == "guess_box_game_level" then
		self._gbLevelCgfs = content
	end
end

function GuessBoxConfig:getGbCfg(actId)
	if not self._gbCfgs[actId] then
		return self._gbCfgs[actId]
	end
end

function GuessBoxConfig:getGbBoxCfg(actId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.boxPlanId then
		if not self._gbBoxCfgs[gbCfg.boxPlanId] then
			return {}
		end
	end
end

function GuessBoxConfig:getGbBoxCfgByLevel(actId, levelId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.levelPlanId then
		if not self._gbLevelCgfs[gbCfg.levelPlanId][levelId] then
			local gbLevleCgf = {}

			if not gbLevleCgf.boxPlanId then
				local boxPlanId = 0

				if not self._gbBoxCfgs[boxPlanId] then
					return {}
				end
			end
		end
	end
end

function GuessBoxConfig:getGbFlowerCfg(actId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.flowerPlanId then
		if not self._gbFlowerCfgs[gbCfg.flowerPlanId] then
			return {}
		end
	end
end

function GuessBoxConfig:getGbRuleCfg(actId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.rulePlanId then
		if not self._gbRuleCfgs[gbCfg.rulePlanId] then
			return {}
		end
	end
end

function GuessBoxConfig:getGbSettingValue(key)
	if not self._gbSettingCfgs[key] then
		return self._gbSettingCfgs[key].value
	end
end

function GuessBoxConfig:getGbLevelCfg(actId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.levelPlanId then
		if not self._gbLevelCgfs[gbCfg.levelPlanId] then
			return {}
		end
	end
end

function GuessBoxConfig:getLevelInfo(actId, levelId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.levelPlanId then
		if not self._gbLevelCgfs[gbCfg.levelPlanId] then
			return self._gbLevelCgfs[gbCfg.levelPlanId][levelId]
		end
	end
end

function GuessBoxConfig:getRewardProgressListCfgs(actId)
	local gbCfg = self:getGbCfg(actId)

	if not gbCfg.scorePrizePlanId then
		return self._gbScorePrizeCfgs[gbCfg.scorePrizePlanId] or {}
	end
end

function GuessBoxConfig:getRewardProgressListCfg(actId, prizeId)
	local prizeCfg = self:getRewardProgressListCfgs(actId)

	if prizeCfg then
		return prizeCfg[prizeId]
	else
		return nil
	end
end

GuessBoxConfig.instance = GuessBoxConfig.New()

return GuessBoxConfig
