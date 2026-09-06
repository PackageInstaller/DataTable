-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/config/FormationValidatorConfig.lua

module("logic.extensions.mission.config.FormationValidatorConfig", package.seeall)

local FormationValidatorConfig = class("FormationValidatorConfig", BaseConfig)

function FormationValidatorConfig:onInit()
	FormationValidatorConfig.super.onInit(self)

	self._formationValidatorCfg = nil
	self._formationPosValidatorCfg = nil
	self._formationAllValidatorCfg = nil
end

function FormationValidatorConfig:getNames()
	return {
		"formation_validator",
		"formation_pos_validator",
		"formation_all_validator"
	}
end

function FormationValidatorConfig:handleConfig(name, content)
	if name == "formation_validator" then
		self._formationValidatorCfg = content
	elseif name == "formation_pos_validator" then
		self._formationPosValidatorCfg = content
	elseif name == "formation_all_validator" then
		self._formationAllValidatorCfg = content
	end
end

function FormationValidatorConfig:getFormationValidatorCfg(id)
	return self._formationValidatorCfg[id]
end

function FormationValidatorConfig:getFormationPosValidatorCfg(id)
	return self._formationPosValidatorCfg[id]
end

function FormationValidatorConfig:getFormationAllValidatorCfg(id)
	return self._formationAllValidatorCfg[id]
end

FormationValidatorConfig.instance = FormationValidatorConfig.New()

return FormationValidatorConfig
