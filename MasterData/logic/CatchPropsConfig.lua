-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/config/CatchPropsConfig.lua

module("logic.extensions.catchprops.config.CatchPropsConfig", package.seeall)

local CatchPropsConfig = class("CatchPropsConfig", BaseConfig)
local json = require("cjson")

function CatchPropsConfig:getNames()
	return {
		"moyan_preheat_unlock",
		"moyan_preheat_prize",
		"moyan_preheat",
		"moyan_preheat_params_define"
	}
end

function CatchPropsConfig:handleConfig(name, content)
	if name == "moyan_preheat_unlock" then
		self._unlockCfgs = content
	elseif name == "moyan_preheat_prize" then
		self._prizeCfgs = content
	elseif name == "moyan_preheat" then
		self._activitiesCfgs = content
	elseif name == "moyan_preheat_params_define" then
		self._paramsCfgs = content
	end
end

function CatchPropsConfig:getActivities()
	return self._activitiesCfgs.dataList
end

function CatchPropsConfig:getActivityCo(id)
	return self._activitiesCfgs[id]
end

function CatchPropsConfig:getPrizeCo(prizePlan, integral)
	if self._prizeCfgs[prizePlan] then
		local prizeCo
		local lastIntegral = 0

		for k, v in pairs(self._prizeCfgs[prizePlan]) do
			if integral > v.integral and lastIntegral < v.integral then
				lastIntegral = v.integral
				prizeCo = v
			end
		end

		return prizeCo
	end
end

function CatchPropsConfig:getAllPrizeCos(prizePlan)
	return self._prizeCfgs[prizePlan]
end

function CatchPropsConfig:getParamString(key)
	if self._paramsCfgs[key] then
		return self._paramsCfgs[key].value
	end
end

function CatchPropsConfig:getParamInt(key)
	return checknumber(self:getParamString(key))
end

function CatchPropsConfig:getUnlockFamgmentsCo(id)
	return self._unlockCfgs[id]
end

function CatchPropsConfig:getDailyGameTimes()
	return self:getParamInt("FREE_GAME_TIMES")
end

function CatchPropsConfig:getDailyBuyTimes()
	return self:getParamInt("DAILY_BUY_TIMES")
end

function CatchPropsConfig:getBuyTimesCost()
	return self:getParamString("BUY_TIMES_COST")
end

function CatchPropsConfig:getOneGamePlayTime()
	return self:getParamInt("GAME_PLAY_TIME")
end

function CatchPropsConfig:getSpecialPropsMaxNum()
	return self:getParamInt("SPECIAL_PROPS_MAX_NUM")
end

function CatchPropsConfig:getSpecialPropsAddTime()
	return self:getParamInt("SPECIAL_PROPS_ADD_TIME")
end

function CatchPropsConfig:getPropScoreUnit()
	return self:getParamInt("PROP_SCORE_UNIT")
end

function CatchPropsConfig:getPropFallSpeed()
	return json.decode(self:getParamString("PROP_FALL_SPEED"))
end

function CatchPropsConfig:getPropAppearSpeed()
	return json.decode(self:getParamString("PROP_APPEAR_SPEED"))
end

function CatchPropsConfig:getCrazyPropAppearSpeed()
	return json.decode(self:getParamString("CRAZY_PROP_APPEAR_SPEED"))
end

function CatchPropsConfig:getPropSpace()
	return json.decode(self:getParamString("PROP_SPACE"))
end

function CatchPropsConfig:getGameMaxScores()
	return self:getParamInt("MAX_SCORE")
end

function CatchPropsConfig:getSpecialAppearRate()
	return json.decode(self:getParamInt("SPECIAL_PROPS_RATE"))
end

function CatchPropsConfig:getCrazyModel()
	return self:getParamInt("CRAZY_MODEL")
end

function CatchPropsConfig:getCrazyTime()
	return self:getParamInt("CRAZY_TIME")
end

function CatchPropsConfig:getCrazyTipTime()
	return self:getParamInt("CRAZY_TIP_TIME")
end

function CatchPropsConfig:getPropSpecialScoreUnit()
	return self:getParamInt("PROP_SPECIAL_SCORE")
end

function CatchPropsConfig:getPetIconRaceId()
	return json.decode(self:getParamString("PET_ICON_RACEID"))
end

CatchPropsConfig.instance = CatchPropsConfig.New()

return CatchPropsConfig
