-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/config/OriMatGameConfig.lua

module("logic.extensions.orimatgame.config.OriMatGameConfig", package.seeall)

local OriMatGameConfig = class("OriMatGameConfig", BaseConfig)

function OriMatGameConfig:getNames()
	return {
		"origin_material_game_monster",
		"origin_material_game_map_buff",
		"origin_material_game_map_cell",
		"origin_material_game_plan",
		"origin_material_game_buff",
		"origin_material_game_weapon_level",
		"origin_material_game_weapon_show_desc",
		"origin_material_game_bullet",
		"origin_material_game_monster_wave_plan",
		"origin_material_game_monster_group_plan",
		"origin_material_game_season",
		"origin_material_game_stage",
		"origin_material_game_weapon",
		"origin_material_game_common",
		"origin_material_game_talent",
		"origin_material_game_prize",
		"origin_material_game_blessing",
		"origin_material_game_weapon_plan"
	}
end

function OriMatGameConfig:handleConfig(name, content)
	if name == "origin_material_game_monster" then
		self._origin_material_game_monster = content
	elseif name == "origin_material_game_map_buff" then
		self._origin_material_game_map_buff = content
	elseif name == "origin_material_game_map_cell" then
		self._origin_material_game_map_cell = content
	elseif name == "origin_material_game_plan" then
		self._origin_material_game_plan = content
	elseif name == "origin_material_game_buff" then
		self._origin_material_game_buff = content
	elseif name == "origin_material_game_weapon_level" then
		self._origin_material_game_weapon_level = content
	elseif name == "origin_material_game_weapon_show_desc" then
		self._origin_material_game_weapon_show_desc = content
	elseif name == "origin_material_game_bullet" then
		self._origin_material_game_bullet = content
	elseif name == "origin_material_game_monster_wave_plan" then
		self._origin_material_game_monster_wave_plan = content
	elseif name == "origin_material_game_monster_group_plan" then
		self._origin_material_game_monster_group_plan = content
	elseif name == "origin_material_game_season" then
		self._origin_material_game_season = content
	elseif name == "origin_material_game_stage" then
		self._origin_material_game_stage = content
	elseif name == "origin_material_game_weapon" then
		self._origin_material_game_weapon = content
	elseif name == "origin_material_game_common" then
		self._origin_material_game_common = content
	elseif name == "origin_material_game_talent" then
		self._origin_material_game_talent = content
	elseif name == "origin_material_game_prize" then
		self._origin_material_game_prize = content
	elseif name == "origin_material_game_blessing" then
		self._origin_material_game_blessing = content
	elseif name == "origin_material_game_weapon_plan" then
		self._origin_material_game_weapon_plan = content
	end
end

function OriMatGameConfig:getMonsterCfg(monsterId)
	return self._origin_material_game_monster[monsterId]
end

function OriMatGameConfig:getAllMapBuffCfgs()
	return self._origin_material_game_map_buff.dataList
end

function OriMatGameConfig:getMapBuffCfg(buffId)
	return self._origin_material_game_map_buff[buffId]
end

function OriMatGameConfig:getMapCellCfg(cellId)
	return self._origin_material_game_map_cell[cellId]
end

function OriMatGameConfig:getGamePlanCfg(gamePlanId)
	return self._origin_material_game_plan[gamePlanId]
end

function OriMatGameConfig:getMapBuffIdListInMapData(gamePlanId)
	local result = {}
	local data = self:getGamePlanCfg(gamePlanId)

	if data then
		::label_8_0::

		local var_8_0 = data.mapData

		if data.mapData then
			local addParamTypeList = data.mapData.addParamTypeList

			if addParamTypeList then
				for i, v in ipairs(addParamTypeList) do
					table.insert(result, checknumber(v))
				end
			end

			return result
		end
	end
end

function OriMatGameConfig:getBuffCfg(buffId)
	return self._origin_material_game_buff[buffId]
end

function OriMatGameConfig:getWeaponLevelCfgs(weaponId)
	return self._origin_material_game_weapon_level[weaponId]
end

function OriMatGameConfig:getWeaponLevelCfgByWeapon(weaponId, level)
	local cfgs = self:getWeaponLevelCfgs(weaponId)

	if cfgs then
		return cfgs[level]
	end
end

function OriMatGameConfig:getWeaponMaxLevel(weaponId)
	local cfgs = self:getWeaponLevelCfgs(weaponId)
	local data = cfgs and cfgs[#cfgs]

	return (data or nil) and (data.level or 0)
end

function OriMatGameConfig:getWeaponShowCfgs(weapDescPlanId)
	return self._origin_material_game_weapon_show_desc[weapDescPlanId]
end

function OriMatGameConfig:getBulletCfg(bulletId)
	return self._origin_material_game_bullet[bulletId]
end

function OriMatGameConfig:getMonsterWaveCfgs(planId)
	return self._origin_material_game_monster_wave_plan[planId]
end

function OriMatGameConfig:getMonsterGroupCfgs(planId)
	return self._origin_material_game_monster_group_plan[planId]
end

function OriMatGameConfig:getMonsterWaveCfgsByWaveId(planId, waveId)
	local cfgs = self:getMonsterWaveCfgs(planId)

	if cfgs then
		return cfgs[waveId]
	end
end

function OriMatGameConfig:getSeasonData(seasonId)
	return self._origin_material_game_season[seasonId]
end

function OriMatGameConfig:getSeasonDataList()
	return self._origin_material_game_season.dataList
end

function OriMatGameConfig:getMaxReOpenNum(seasonId)
	local data = self:getSeasonData(seasonId)

	return (data or nil) and (data.reOpenNum or 0)
end

function OriMatGameConfig:getStageCfgs(stagePlanId)
	return self._origin_material_game_stage[stagePlanId]
end

function OriMatGameConfig:getStageCfgByStageId(stagePlanId, stageId)
	if self._origin_material_game_stage[stagePlanId] then
		return self._origin_material_game_stage[stagePlanId][stageId]
	end
end

function OriMatGameConfig:getWeaponCfg(weaponId)
	return self._origin_material_game_weapon[weaponId]
end

function OriMatGameConfig:getWeaponDataList()
	return self._origin_material_game_weapon.dataList
end

function OriMatGameConfig:getCommonValue(key, isToNumber)
	local data = self._origin_material_game_common[key]
	local value = data and data.value

	if isToNumber then
		return checknumber(value)
	end

	return value
end

function OriMatGameConfig:getTalentCfg(talentId)
	return self._origin_material_game_talent[talentId]
end

function OriMatGameConfig:getTalentDataList()
	return self._origin_material_game_talent.dataList
end

function OriMatGameConfig:getPrizeCfg(prizePlanId, prizeId)
	if self._origin_material_game_prize[prizePlanId] then
		return self._origin_material_game_prize[prizePlanId][prizeId]
	end
end

function OriMatGameConfig:getPrizeCfgs(prizePlanId)
	return self._origin_material_game_prize[prizePlanId]
end

function OriMatGameConfig:getBlessingCfg(blessingId)
	return self._origin_material_game_blessing[blessingId]
end

function OriMatGameConfig:getBlessingDataList(weaponId)
	if self._blessingDatasByWeapon == nil then
		self._blessingDatasByWeapon = {}

		for _, data in ipairs(self._origin_material_game_blessing.dataList) do
			self._blessingDatasByWeapon[data.weaponId] = self._blessingDatasByWeapon[data.weaponId] or {}

			table.insert(self._blessingDatasByWeapon[data.weaponId], data)
		end
	end

	return self._blessingDatasByWeapon[weaponId]
end

function OriMatGameConfig:getWeaponPlanCfg(weaponPlanId)
	return self._origin_material_game_weapon_plan[weaponPlanId]
end

OriMatGameConfig.instance = OriMatGameConfig.New()

return OriMatGameConfig
