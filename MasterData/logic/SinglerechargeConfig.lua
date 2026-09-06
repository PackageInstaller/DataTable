-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/singlerecharge/config/SinglerechargeConfig.lua

module("logic.extensions.singlerecharge.config.SinglerechargeConfig", package.seeall)

local SinglerechargeConfig = class("SinglerechargeConfig", BaseConfig)

function SinglerechargeConfig:onInit()
	return
end

function SinglerechargeConfig:getNames()
	return {
		"single_recharge",
		"single_recharge_common"
	}
end

function SinglerechargeConfig:handleConfig(name, content)
	if name == "single_recharge" then
		self._single_recharge = content
	elseif name == "single_recharge_common" then
		self._single_recharge_common = content
	end
end

function SinglerechargeConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._single_recharge_common and self._single_recharge_common[key] then
		str = self._single_recharge_common[key].value
	end

	if isToNumber then
		return checknumber(str)
	else
		return str
	end
end

function SinglerechargeConfig:getActCfgs(activityId)
	return self._single_recharge[activityId]
end

SinglerechargeConfig.instance = SinglerechargeConfig.New()

return SinglerechargeConfig
