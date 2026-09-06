-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalkingsignin/config/SurvivalKingSignInConfig.lua

module("logic.extensions.survivalkingsignin.config.SurvivalKingSignInConfig", package.seeall)

local SurvivalKingSignInConfig = class("SurvivalKingSignInConfig", BaseConfig)

function SurvivalKingSignInConfig:getNames()
	return {
		"survival_king_sign_in_activity",
		"survival_king_sign_in_zone"
	}
end

function SurvivalKingSignInConfig:handleConfig(name, content)
	if name == "survival_king_sign_in_activity" then
		self._survival_king_sign_in_activity = content
	elseif name == "survival_king_sign_in_zone" then
		self._survival_king_sign_in_zone = content
	end
end

function SurvivalKingSignInConfig:getSignInActivityCfg(activityId)
	return self._survival_king_sign_in_activity[activityId]
end

function SurvivalKingSignInConfig:getAllZoneCfgs(activityId)
	return self._survival_king_sign_in_zone[activityId]
end

SurvivalKingSignInConfig.instance = SurvivalKingSignInConfig.New()

return SurvivalKingSignInConfig
