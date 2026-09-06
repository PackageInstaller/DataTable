-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/config/PsychicImproveConfig.lua

module("logic.extensions.psychicimprove.config.PsychicImproveConfig", package.seeall)

local PsychicImproveConfig = class("PsychicImproveConfig", BaseConfig)

function PsychicImproveConfig:onInit()
	PsychicImproveConfig.super.onInit(self)
end

function PsychicImproveConfig:getNames()
	return {
		"psychic_improve",
		"psychic_improve_hire",
		"psychic_improve_hud"
	}
end

function PsychicImproveConfig:handleConfig(name, content)
	if name == "psychic_improve" then
		self._actCfgs = content
	elseif name == "psychic_improve_hire" then
		self._hideCfgs = content
	elseif name == "psychic_improve_hud" then
		self._hudCfgs = content
	end
end

function PsychicImproveConfig:getActCfgById(actId)
	return self._actCfgs[actId]
end

function PsychicImproveConfig:getHideCfgsById(planId)
	return self._hideCfgs[planId]
end

function PsychicImproveConfig:getHudCfgs()
	return self._hudCfgs
end

PsychicImproveConfig.instance = PsychicImproveConfig.New()

return PsychicImproveConfig
