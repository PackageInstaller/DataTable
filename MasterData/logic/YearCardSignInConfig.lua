-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/config/YearCardSignInConfig.lua

module("logic.extensions.yearcardsignin.config.YearCardSignInConfig", package.seeall)

local YearCardSignInConfig = class("YearCardSignInConfig", BaseConfig)

function YearCardSignInConfig:onInit()
	YearCardSignInConfig.super.onInit(self)

	self._prizeCfgs = nil
end

function YearCardSignInConfig:getNames()
	return {
		"annuity_sign_in",
		"annuity_sign_in_gift"
	}
end

function YearCardSignInConfig:handleConfig(name, content)
	if name == "annuity_sign_in" then
		self._prizeCfgs = content
	elseif name == "annuity_sign_in_gift" then
		self._annuity_sign_in_gift = content
	end
end

function YearCardSignInConfig:getPrizeCfgs(actId)
	return self._prizeCfgs[actId]
end

function YearCardSignInConfig:getGiftCfgs(actId)
	return self._annuity_sign_in_gift[actId]
end

function YearCardSignInConfig:getGiftCfg(actId, id)
	return self._annuity_sign_in_gift[actId][id]
end

YearCardSignInConfig.instance = YearCardSignInConfig.New()

return YearCardSignInConfig
