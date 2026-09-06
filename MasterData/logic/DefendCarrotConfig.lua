-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/config/DefendCarrotConfig.lua

module("logic.extensions.defendcarrot.config.DefendCarrotConfig", package.seeall)

local DefendCarrotConfig = class("DefendCarrotConfig", BaseConfig)

function DefendCarrotConfig:getNames()
	return {
		"defend_carrot_monster",
		"defend_carrot_map_buff",
		"defend_carrot_map_cell",
		"defend_carrot_stage_plan",
		"defend_carrot_buff",
		"defend_carrot_weapon_level",
		"defend_carrot_weapon_show_desc",
		"defend_carrot_bullet",
		"defend_carrot_stage_progress",
		"defend_carrot_monster_wave_plan",
		"defend_carrot_monster_group_plan",
		"defend_carrot_activity",
		"defend_carrot_stage",
		"defend_carrot_material_clg",
		"defend_carrot_material_clg_prize",
		"defend_carrot_stage_task",
		"defend_carrot_weapon",
		"defend_carrot_rank_prize"
	}
end

function DefendCarrotConfig:handleConfig(name, content)
	if name == "defend_carrot_monster" then
		self._defend_carrot_monster = content
	elseif name == "defend_carrot_map_buff" then
		self._defend_carrot_map_buff = content
	elseif name == "defend_carrot_map_cell" then
		self._defend_carrot_map_cell = content
	elseif name == "defend_carrot_stage_plan" then
		self._defend_carrot_stage_plan = content
	elseif name == "defend_carrot_buff" then
		self._defend_carrot_buff = content
	elseif name == "defend_carrot_weapon_level" then
		self._defend_carrot_weapon_level = content
	elseif name == "defend_carrot_weapon_show_desc" then
		self._defend_carrot_weapon_show_desc = content
	elseif name == "defend_carrot_bullet" then
		self._defend_carrot_bullet = content
	elseif name == "defend_carrot_stage_progress" then
		self._defend_carrot_stage_progress = content
	elseif name == "defend_carrot_monster_wave_plan" then
		self._defend_carrot_monster_wave_plan = content
	elseif name == "defend_carrot_monster_group_plan" then
		self._defend_carrot_monster_group_plan = content
	elseif name == "defend_carrot_activity" then
		self._defend_carrot_activity = content
	elseif name == "defend_carrot_stage" then
		self._defend_carrot_stage = content
	elseif name == "defend_carrot_material_clg" then
		self._defend_carrot_material_clg = content
	elseif name == "defend_carrot_material_clg_prize" then
		self._defend_carrot_material_clg_prize = content

		self:_handleMaterialClgPrizeCfg()
	elseif name == "defend_carrot_stage_task" then
		self._defend_carrot_stage_task = content
	elseif name == "defend_carrot_weapon" then
		self._defend_carrot_weapon = content
	elseif name == "defend_carrot_rank_prize" then
		self._defend_carrot_rank_prize = content

		self:_handlerRankPrizeCfgs()
	end
end

function DefendCarrotConfig:getMonsterCfg(monsterId)
	return self._defend_carrot_monster[monsterId]
end

function DefendCarrotConfig:getAllMapBuffCfgs()
	return self._defend_carrot_map_buff
end

function DefendCarrotConfig:getMapBuffCfg(buffId)
	return self._defend_carrot_map_buff[buffId]
end

function DefendCarrotConfig:getMapCellCfg(cellId)
	return self._defend_carrot_map_cell[cellId]
end

function DefendCarrotConfig:getStagePlanCfg(planId)
	return self._defend_carrot_stage_plan[planId]
end

function DefendCarrotConfig:getBuffCfg(buffId)
	return self._defend_carrot_buff[buffId]
end

function DefendCarrotConfig:getWeaponLevelCfgs(activityId, weaponId)
	if self._defend_carrot_weapon_level[activityId] then
		return self._defend_carrot_weapon_level[activityId][weaponId]
	end
end

function DefendCarrotConfig:getWeaponLevelCfgByWeapon(activityId, weaponId, level)
	local cfgs = self:getWeaponLevelCfgs(activityId, weaponId)

	if cfgs then
		return cfgs[level]
	end
end

function DefendCarrotConfig:getWeaponShowCfgs(planId)
	return self._defend_carrot_weapon_show_desc[planId]
end

function DefendCarrotConfig:getBulletCfg(bulletId)
	return self._defend_carrot_bullet[bulletId]
end

function DefendCarrotConfig:getProgressCfgs(activityId)
	return self._defend_carrot_stage_progress[activityId]
end

function DefendCarrotConfig:getMonsterWaveCfgs(planId)
	return self._defend_carrot_monster_wave_plan[planId]
end

function DefendCarrotConfig:getMonsterGroupCfgs(planId)
	return self._defend_carrot_monster_group_plan[planId]
end

function DefendCarrotConfig:getMonsterWaveCfgsByWaveId(planId, waveId)
	local cfgs = self:getMonsterWaveCfgs(planId)

	if cfgs then
		return cfgs[waveId]
	end
end

function DefendCarrotConfig:getActivityCfg(activityId)
	return self._defend_carrot_activity[activityId]
end

function DefendCarrotConfig:getStageCfgs(activityId)
	return self._defend_carrot_stage[activityId]
end

function DefendCarrotConfig:getStageCfgByStageId(activityId, stageId)
	if self._defend_carrot_stage[activityId] then
		return self._defend_carrot_stage[activityId][stageId]
	end
end

function DefendCarrotConfig:getMaterialClgs(activityId)
	return self._defend_carrot_material_clg[activityId]
end

function DefendCarrotConfig:getMaterialClgByStageId(activityId, stageId)
	if self._defend_carrot_material_clg[activityId] then
		return self._defend_carrot_material_clg[activityId][stageId]
	end
end

function DefendCarrotConfig:_handleMaterialClgPrizeCfg()
	self._materialClgPrizeCfgs = {}

	for i, v in ipairs(self._defend_carrot_material_clg_prize.dataList) do
		self._materialClgPrizeCfgs[v.activityId] = self._materialClgPrizeCfgs[v.activityId] or {}
		self._materialClgPrizeCfgs[v.activityId][v.stageId] = self._materialClgPrizeCfgs[v.activityId][v.stageId] or {}

		table.insert(self._materialClgPrizeCfgs[v.activityId][v.stageId], v)
	end
end

function DefendCarrotConfig:getMaterialClgPrizeList(activityId, stageId)
	if self._materialClgPrizeCfgs[activityId] then
		return self._materialClgPrizeCfgs[activityId][stageId] or {}
	end
end

function DefendCarrotConfig:getMaterialClgPrizeParams(activityId, stageId, waveNum)
	local num = 0
	local curPrizeType = 0
	local curPrizeId = 0
	local prizeCfgs = self:getMaterialClgPrizeList(activityId, stageId)
	local checkId = 1
	local curCfg = prizeCfgs[checkId]
	local checkWaveNum = 0
	local addNum = 0

	if curCfg then
		local curPrize = curCfg.prize
		local matType, matId, matNum = MaterialMgr.getMatParams(curPrize)

		addNum = matNum
		curPrizeType = matType
		curPrizeId = matId

		local nextCfg = prizeCfgs[checkId + 1]

		checkWaveNum = nextCfg and nextCfg.waveNum or math.huge
	end

	for i = 1, waveNum do
		if checkWaveNum <= i then
			checkId = 1 + checkId
			curCfg = prizeCfgs[checkId]

			if prizeCfgs[checkId] then
				local curPrize = curCfg.prize
				local matType, matId, matNum = MaterialMgr.getMatParams(curPrize)

				curPrizeType = matType
				curPrizeId = matId
				addNum = matNum

				local nextCfg = prizeCfgs[checkId + 1]

				checkWaveNum = nextCfg and nextCfg.waveNum or math.huge
			end
		end

		num = num + addNum
	end

	return curPrizeType, curPrizeId, num
end

function DefendCarrotConfig:getMaterialClgPrize(activityId, stageId, waveNum)
	local matchCfg

	if self._materialClgPrizeCfgs[activityId] then
		if not self._materialClgPrizeCfgs[activityId][stageId] then
			for _, cfg in ipairs(self._materialClgPrizeCfgs[activityId][stageId]) do
				if waveNum < cfg.waveNum then
					break
				else
					matchCfg = cfg
				end
			end
		end
	end

	return matchCfg
end

function DefendCarrotConfig:getStageTaskCfgs(activityId, stageId)
	if self._defend_carrot_stage_task[activityId] then
		return self._defend_carrot_stage_task[activityId][stageId]
	end
end

function DefendCarrotConfig:getStageTaskCfgByTaskId(activityId, stageId, taskId)
	if self._defend_carrot_stage_task[activityId] and self._defend_carrot_stage_task[activityId][stageId] then
		return self._defend_carrot_stage_task[activityId][stageId][taskId]
	end
end

function DefendCarrotConfig:getWeaponCfg(activityId, weaponId)
	if self._defend_carrot_weapon[activityId] then
		return self._defend_carrot_weapon[activityId][weaponId]
	end
end

function DefendCarrotConfig:_handlerRankPrizeCfgs()
	self._defend_carrot_rank_prizelist = {}

	for i, v in ipairs(self._defend_carrot_rank_prize.dataList) do
		if not self._defend_carrot_rank_prizelist[v.activityId] then
			table.insert(self._defend_carrot_rank_prizelist[v.activityId], v)

			self._defend_carrot_rank_prizelist[v.activityId] = self._defend_carrot_rank_prizelist[v.activityId]
		end
	end
end

function DefendCarrotConfig:getRankPrizeDataByRank(activityId, rank)
	local cfgs = self._defend_carrot_rank_prizelist[activityId]

	if cfgs then
		return MmUtil.binarySearchInArrayKey(cfgs, "rankRange", rank)
	end
end

function DefendCarrotConfig:getAllWeaponCfgs(activityId)
	return self._defend_carrot_weapon[activityId]
end

DefendCarrotConfig.instance = DefendCarrotConfig.New()

return DefendCarrotConfig
