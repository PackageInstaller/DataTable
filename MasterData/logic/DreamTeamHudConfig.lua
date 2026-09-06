-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/config/DreamTeamHudConfig.lua

module("logic.extensions.operationsummary.config.DreamTeamHudConfig", package.seeall)

local DreamTeamHudConfig = class("DreamTeamHudConfig", BaseConfig)

function DreamTeamHudConfig:onInit()
	DreamTeamHudConfig.super.onInit(self)

	self._mainViewCfgs = nil
	self._skinViewCfgs = nil
	self._equipmentCfgs = nil
end

function DreamTeamHudConfig:getNames()
	return {
		"dream_team_hud_main",
		"dream_team_hud_skin",
		"dream_team_hud_equipment"
	}
end

function DreamTeamHudConfig:handleConfig(name, content)
	if name == "dream_team_hud_main" then
		self._mainViewCfgs = content
	elseif name == "dream_team_hud_skin" then
		self._skinViewCfgs = content
	elseif name == "dream_team_hud_equipment" then
		self._equipmentCfgs = content
	end
end

function DreamTeamHudConfig:getMainViewCfgs()
	return self._mainViewCfgs
end

function DreamTeamHudConfig:getSkinViewCfgs()
	return self._skinViewCfgs
end

function DreamTeamHudConfig:getEquipmentViewCfgs()
	return self._equipmentCfgs
end

DreamTeamHudConfig.instance = DreamTeamHudConfig.New()

return DreamTeamHudConfig
