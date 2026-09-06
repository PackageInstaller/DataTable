-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signinbuff/config/SignInBuffConfig.lua

module("logic.extensions.signinbuff.config.SignInBuffConfig", package.seeall)

local SignInBuffConfig = class("SignInBuffConfig", BaseConfig)

function SignInBuffConfig:getNames()
	return {
		"sign_in_buff",
		"sign_in_buff_activity"
	}
end

function SignInBuffConfig:handleConfig(name, content)
	if name == "sign_in_buff" then
		self._sign_in_buff = content
	elseif name == "sign_in_buff_activity" then
		self._sign_in_buff_activity = content
	end
end

function SignInBuffConfig:getBuffCfgsByActId(activityId)
	local cfg = self._sign_in_buff_activity[activityId]

	if cfg then
		return self:getBuffCfgsByPlanId(cfg.buffPlanId)
	end
end

function SignInBuffConfig:getBuffPlanId(activityId)
	return self._sign_in_buff_activity[activityId].buffPlanId
end

function SignInBuffConfig:getBuffCfgsByPlanId(planId)
	return self._sign_in_buff[planId]
end

function SignInBuffConfig:getBuffByActIdAndDay(activityId, signInDay)
	local cfgs = self:getBuffCfgsByActId(activityId)

	if cfgs then
		return cfgs[signInDay]
	end
end

function SignInBuffConfig:getBuffCfgByDay(planId, signInDay)
	local cfgs = self._sign_in_buff[planId]

	if cfgs then
		local activeCfg

		for _, cfg in ipairs(cfgs) do
			if signInDay >= cfg.signInDays then
				activeCfg = cfg
			else
				return activeCfg
			end
		end

		return activeCfg
	end
end

SignInBuffConfig.instance = SignInBuffConfig.New()

return SignInBuffConfig
