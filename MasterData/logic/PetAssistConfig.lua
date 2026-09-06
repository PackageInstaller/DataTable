-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/config/PetAssistConfig.lua

module("logic.extensions.petassist.config.PetAssistConfig", package.seeall)

local PetAssistConfig = class("PetAssistConfig", BaseConfig)

function PetAssistConfig:onInit()
	PetAssistConfig.super.onInit(self)

	self.petTeamCfgs = nil
	self.teamUpCfgs = nil
	self.teamUnlockCfgs = nil
	self.petStarCfgs = nil
	self.petLevelCfgs = nil
end

function PetAssistConfig:getNames()
	return {
		"assist_team",
		"assist_team_upgrade",
		"assist_team_position",
		"assist_team_pet_star_prop",
		"assist_team_pet_level_prop"
	}
end

function PetAssistConfig:handleConfig(name, content)
	if name == "assist_team" then
		self.petTeamCfgs = content
	elseif name == "assist_team_upgrade" then
		self.teamUpCfgs = content
	elseif name == "assist_team_position" then
		self.teamUnlockCfgs = content
	elseif name == "assist_team_pet_star_prop" then
		self.petStarCfgs = content
	elseif name == "assist_team_pet_level_prop" then
		self.petLevelCfgs = content
	end
end

function PetAssistConfig:GetPetTeamCfg(teamType)
	if checknumber(teamType) < 1 or self.petTeamCfgs == nil then
		return
	end

	return self.petTeamCfgs[teamType]
end

function PetAssistConfig:getPetTeamCfgs()
	return self.petTeamCfgs.dataList
end

function PetAssistConfig:GetTeamUpgradeAllCfgs(teamType)
	if checknumber(teamType) < 1 or self.teamUpCfgs == nil then
		return
	end

	return self.teamUpCfgs[teamType]
end

function PetAssistConfig:GetTeamUpgradeCfg(teamType, lv)
	if checknumber(teamType) < 1 or self.teamUpCfgs == nil then
		return
	end

	local list = self.teamUpCfgs[teamType]

	if list == nil or list[lv] == nil then
		return
	end

	return list[lv]
end

function PetAssistConfig:GetTeamUnlockAllCfgs(teamType)
	if checknumber(teamType) < 1 or self.teamUnlockCfgs == nil then
		return
	end

	return self.teamUnlockCfgs[teamType]
end

function PetAssistConfig:GetTeamUnlockCfg(teamType, pos)
	if checknumber(teamType) < 1 or self.teamUnlockCfgs == nil then
		return
	end

	local list = self.teamUnlockCfgs[teamType]

	if list == nil or list[pos] == nil then
		return
	end

	return list[pos]
end

function PetAssistConfig:GetPetStarAllCfgs(lvType)
	if checknumber(lvType) < 1 or self.petStarCfgs == nil then
		return
	end

	return self.petStarCfgs[lvType]
end

function PetAssistConfig:GetPetStarCfg(lvType, star)
	if checknumber(lvType) < 0 or self.petStarCfgs == nil then
		return
	end

	local list = self.petStarCfgs[lvType]

	if list == nil or list[star] == nil then
		return
	end

	return list[star]
end

function PetAssistConfig:GetPetLevelCfg(lv)
	if checknumber(lv) < 1 or self.petLevelCfgs == nil then
		return
	end

	return self.petLevelCfgs[lv]
end

PetAssistConfig.instance = PetAssistConfig.New()

return PetAssistConfig
