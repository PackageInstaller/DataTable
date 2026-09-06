-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/config/SaintKnightTianConfig.lua

module("logic.extensions.saintknighttian.config.SaintKnightTianConfig", package.seeall)

local SaintKnightTianConfig = class("SaintKnightTianConfig", BaseConfig)

function SaintKnightTianConfig:onInit()
	SaintKnightTianConfig.super.onInit(self)
end

function SaintKnightTianConfig:getNames()
	return {
		"saintknight_tian_activity",
		"saintknight_tian_game_prize",
		"saintknight_tian_teambuff",
		"saintknight_tian_serverbuff",
		"saintknight_tian_prize",
		"saintknight_tian_monster",
		"saintknight_tian_creeps",
		"saintknight_tian_help_pet",
		"saintknight_tian_common",
		"saintknight_tian_game_put_common",
		"saintknight_tian_game_plan",
		"saintknight_tian_game_put_model",
		"saintknight_tian_game_put_pet"
	}
end

function SaintKnightTianConfig:handleConfig(name, content)
	if name == "saintknight_tian_activity" then
		self._actCfg = content
	elseif name == "saintknight_tian_game_prize" then
		self._gamePrzieCfgs = content
	elseif name == "saintknight_tian_teambuff" then
		self._teamBuffCfgs = content
	elseif name == "saintknight_tian_serverbuff" then
		self._areaBuffCfgs = content
	elseif name == "saintknight_tian_prize" then
		self._prizeCfgs = content
	elseif name == "saintknight_tian_monster" then
		self._stageCfgs = content
	elseif name == "saintknight_tian_creeps" then
		self._monsterCfgs = content
	elseif name == "saintknight_tian_help_pet" then
		self._supportPetCfgs = content
	elseif name == "saintknight_tian_common" then
		self._commonValueCfgs = content
	elseif name == "saintknight_tian_game_put_common" then
		self._itemSlotItemCfgs = content
	elseif name == "saintknight_tian_game_plan" then
		self._gamePlanCfgs = content
	elseif name == "saintknight_tian_game_put_model" then
		self._gameTemplateCfgs = content
	elseif name == "saintknight_tian_game_put_pet" then
		self._gameStageCfgs = content
	end
end

function SaintKnightTianConfig:getActCfg(actId)
	return self._actCfg[actId]
end

function SaintKnightTianConfig:getGamePrizeCfgs(planId)
	return self._gamePrzieCfgs[planId]
end

function SaintKnightTianConfig:getAreaBuffCfg(planId)
	return self._areaBuffCfgs[planId]
end

function SaintKnightTianConfig:getTeamBuffCfgs(planId)
	return self._teamBuffCfgs[planId]
end

function SaintKnightTianConfig:getPrizeCfgs(planId)
	return self._prizeCfgs[planId]
end

function SaintKnightTianConfig:getStageCfgs(planId)
	return self._stageCfgs[planId]
end

function SaintKnightTianConfig:getCreepMonsterCfgs(creepId)
	return self._monsterCfgs[creepId]
end

function SaintKnightTianConfig:getSupportPetCfg(petId)
	return self._supportPetCfgs[petId]
end

function SaintKnightTianConfig:getDefineValue(key, need2number)
	if need2number then
		return checknumber(self._commonValueCfgs[key].value)
	else
		return self._commonValueCfgs[key].value
	end
end

function SaintKnightTianConfig:getGameSlotCfg(slotId)
	return self._itemSlotItemCfgs[slotId]
end

function SaintKnightTianConfig:getGamePlanCfgs(planId)
	return self._gamePlanCfgs[planId]
end

function SaintKnightTianConfig:getGameTemplateCfgs(templateId)
	return self._gameTemplateCfgs[templateId]
end

function SaintKnightTianConfig:getPetTemplateCfgs(stageId)
	return self._gameStageCfgs[stageId]
end

SaintKnightTianConfig.instance = SaintKnightTianConfig.New()

return SaintKnightTianConfig
