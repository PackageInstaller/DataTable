-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/config/WeeklyBigBoxConfig.lua

module("logic.extensions.weeklybigbox.config.WeeklyBigBoxConfig", package.seeall)

local WeeklyBigBoxConfig = class("WeeklyBigBoxConfig", BaseConfig)

function WeeklyBigBoxConfig:onInit()
	WeeklyBigBoxConfig.super.onInit(self)

	self._weekly_big_box_params = nil
	self._weekly_big_box_pool_prize = nil
	self._weekly_big_box_client_params = nil
end

function WeeklyBigBoxConfig:getNames()
	return {
		"weekly_big_box_params",
		"weekly_big_box_pool_prize",
		"weekly_big_box_client_params"
	}
end

function WeeklyBigBoxConfig:handleConfig(name, content)
	if name == "weekly_big_box_params" then
		self._weekly_big_box_params = content
	elseif name == "weekly_big_box_pool_prize" then
		self._weekly_big_box_pool_prize = content
	elseif name == "weekly_big_box_client_params" then
		self._weekly_big_box_client_params = content
	end
end

function WeeklyBigBoxConfig:getCommonValue(key, bToNumber)
	if bToNumber then
		return checknumber(self._weekly_big_box_params[key].value)
	else
		return self._weekly_big_box_params[key].value
	end
end

function WeeklyBigBoxConfig:getClientCommonValue(key, bToNumber)
	if bToNumber then
		return checknumber(self._weekly_big_box_client_params[key].value)
	else
		return self._weekly_big_box_client_params[key].value
	end
end

function WeeklyBigBoxConfig:getPrizeConf(prizeId)
	return self._weekly_big_box_pool_prize[prizeId]
end

WeeklyBigBoxConfig.instance = WeeklyBigBoxConfig.New()

return WeeklyBigBoxConfig
