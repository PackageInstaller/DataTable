-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signindaily/config/SigninDailyConfig.lua

module("logic.extensions.signindaily.config.SigninDailyConfig", package.seeall)

local SigninDailyConfig = class("SigninDailyConfig", BaseConfig)

function SigninDailyConfig:onInit()
	SigninDailyConfig.super.onInit(self)

	self._activityDefineCfg = nil
end

function SigninDailyConfig:getNames()
	return {
		"month_sign_in_prize",
		"month_signin_kanban"
	}
end

function SigninDailyConfig:handleConfig(name, content)
	if name == "month_sign_in_prize" then
		self._sign_in_Cfg = content
	elseif name == "month_signin_kanban" then
		self._signin_kanban_Cfg = content
	end
end

function SigninDailyConfig:getSignInCfgById(roundSid)
	return self._sign_in_Cfg[roundSid]
end

function SigninDailyConfig:getKanbanNiangCfg(roundSid)
	return self._signin_kanban_Cfg[roundSid]
end

SigninDailyConfig.instance = SigninDailyConfig.New()

return SigninDailyConfig
