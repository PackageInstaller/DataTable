-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/config/NumberPuzzleGameConfig.lua

module("logic.extensions.numberpuzzlegame.config.NumberPuzzleGameConfig", package.seeall)

local NumberPuzzleGameConfig = class("NumberPuzzleGameConfig", BaseConfig)

function NumberPuzzleGameConfig:onInit()
	NumberPuzzleGameConfig.super.onInit(self)
end

function NumberPuzzleGameConfig:getNames()
	return {
		"game_2048_activity",
		"game_2048_rank_prize",
		"game_2048_stage",
		"game_2048_ext_stage",
		"game_2048_sup_stage",
		"game_2048_map",
		"game_2048_grid",
		"game_2048_grid_lib",
		"game_2048_hanging_prize",
		"game_2048_extreme_rank_prize"
	}
end

function NumberPuzzleGameConfig:handleConfig(name, content)
	if name == "game_2048_activity" then
		self._npgActCfg = content
	elseif name == "game_2048_rank_prize" then
		self._npgRankPrizeCfgs = content
	elseif name == "game_2048_stage" then
		self._npgNorStageCfgs = content
	elseif name == "game_2048_ext_stage" then
		self._npgExtStageCfg = content
	elseif name == "game_2048_sup_stage" then
		self._game_2048_sup_stage = content
	elseif name == "game_2048_map" then
		self._npgMapCfg = content
	elseif name == "game_2048_grid" then
		self._npgGridCfgs = content
	elseif name == "game_2048_grid_lib" then
		self._npgGridLibCfg = content
	elseif name == "game_2048_hanging_prize" then
		self._game_2048_hanging_prize = content
	elseif name == "game_2048_extreme_rank_prize" then
		self._game_2048_extreme_rank_prize = content
	end
end

function NumberPuzzleGameConfig:getNpgActData(activityId)
	return self._npgActCfg[activityId]
end

function NumberPuzzleGameConfig:getNpgActValue(activityId, key)
	local data = self:getNpgActData(activityId)

	if data then
		return data[key]
	end
end

function NumberPuzzleGameConfig:getNpgExtremeEnergy(activityId)
	local value = self:getNpgActValue(activityId, "extremeEnergy")

	return checknumber(value)
end

function NumberPuzzleGameConfig:getNpgRankPrizeCfg(activityId)
	return self._npgRankPrizeCfgs[activityId]
end

function NumberPuzzleGameConfig:getNpgRankPrizeData(activityId, index)
	if self._npgRankPrizeCfgs[activityId] then
		return self._npgRankPrizeCfgs[activityId][index]
	end
end

function NumberPuzzleGameConfig:getNpgRankPrizeDataByRank(activityId, rank)
	local result
	local cfg = self:getNpgRankPrizeCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if rank >= data.rankRange[1] and rank <= data.rankRange[2] then
				result = data

				break
			end
		end
	end

	return result
end

function NumberPuzzleGameConfig:getNpgNorStageCfg(activityId)
	return self._npgNorStageCfgs[activityId]
end

function NumberPuzzleGameConfig:getNpgNorStageData(activityId, stageId)
	if self._npgNorStageCfgs[activityId] then
		return self._npgNorStageCfgs[activityId][stageId]
	end
end

function NumberPuzzleGameConfig:getNpgExtStageData(activityId)
	return self._npgExtStageCfg[activityId]
end

function NumberPuzzleGameConfig:getNpgSupStageCfg(activityId)
	return self._game_2048_sup_stage[activityId]
end

function NumberPuzzleGameConfig:getNpgSupStageData(activityId, gbId)
	local data
	local cfg = self._game_2048_sup_stage[activityId]

	if cfg then
		for _, v in ipairs(cfg) do
			if gbId < v.gbId then
				data = v

				break
			end
		end
	end

	return data
end

function NumberPuzzleGameConfig:getNpgMaxGbId(activityId)
	local gbId = 0
	local cfg = self._game_2048_sup_stage[activityId]

	if cfg then
		local maxData = cfg[#cfg]

		gbId = maxData and maxData.gbId or 0
	end

	return gbId
end

function NumberPuzzleGameConfig:getNpgMapDataList()
	return self._npgMapCfg.dataList
end

function NumberPuzzleGameConfig:getNpgMapData(mapId)
	return self._npgMapCfg[mapId]
end

function NumberPuzzleGameConfig:getNpgGridCfg(mapId)
	local mapData = self:getNpgMapData(mapId)

	if mapData then
		return self._npgGridCfgs[mapData.gridPlanId]
	end
end

function NumberPuzzleGameConfig:getNpgGridData(mapId, gridId)
	local cfg = self:getNpgGridCfg(mapId)

	if cfg then
		return cfg[gridId]
	end
end

function NumberPuzzleGameConfig:getGbId(mapId, gridId)
	local data = self:getNpgGridData(mapId, gridId)

	if data then
		return data.gbId
	end

	return 0
end

function NumberPuzzleGameConfig:getNpgGridLibData(mapId, gridId)
	local data = self:getNpgGridData(mapId, gridId)

	if data then
		return self._npgGridLibCfg[data.gbId]
	end
end

function NumberPuzzleGameConfig:getNpgGridLibDataById(gbId)
	return self._npgGridLibCfg[gbId]
end

function NumberPuzzleGameConfig:getHangingEfficiency(gbId)
	local data = self:getNpgGridLibDataById(gbId)

	return (data or nil) and (data.hangingEfficiency or 0)
end

function NumberPuzzleGameConfig:getHangingPrizeCfg(activityId)
	return self._game_2048_hanging_prize[activityId]
end

function NumberPuzzleGameConfig:getHangingPrizeData(activityId, prizeId)
	if self._game_2048_hanging_prize[activityId] then
		return self._game_2048_hanging_prize[activityId][prizeId]
	end
end

function NumberPuzzleGameConfig:getExtRankPrizeCfg(activityId)
	return self._game_2048_extreme_rank_prize[activityId]
end

function NumberPuzzleGameConfig:getExtRankPrizeData(activityId, rank)
	local data
	local cfg = self:getExtRankPrizeCfg(activityId)

	if cfg then
		for _, v in ipairs(cfg) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				data = v

				break
			end
		end
	end

	return data
end

NumberPuzzleGameConfig.instance = NumberPuzzleGameConfig.New()

return NumberPuzzleGameConfig
