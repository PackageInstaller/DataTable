-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/config/HexLineupConfig.lua

module("logic.extensions.hexlineup.config.HexLineupConfig", package.seeall)

local HexLineupConfig = class("HexLineupConfig", BaseConfig)

function HexLineupConfig:getNames()
	return {
		"hex_lineup_activity",
		"hex_lineup_combo",
		"hex_lineup_endless_rank_prize",
		"hex_lineup_game",
		"hex_lineup_piece",
		"hex_lineup_progress_prize",
		"hex_lineup_rhythm"
	}
end

function HexLineupConfig:handleConfig(name, content)
	if name == "hex_lineup_activity" then
		self._hex_lineup_activity = content
	elseif name == "hex_lineup_combo" then
		self._hex_lineup_combo = content
	elseif name == "hex_lineup_endless_rank_prize" then
		self._hex_lineup_endless_rank_prize = content
	elseif name == "hex_lineup_game" then
		self._hex_lineup_game = content
	elseif name == "hex_lineup_piece" then
		self._hex_lineup_piece = content
	elseif name == "hex_lineup_progress_prize" then
		self._hex_lineup_progress_prize = content
	elseif name == "hex_lineup_rhythm" then
		self._hex_lineup_rhythm = content
	end
end

function HexLineupConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function HexLineupConfig:getActivityData(activityId)
	return self:_safeGet(self._hex_lineup_activity, activityId)
end

function HexLineupConfig:getComboDataList()
	return self._hex_lineup_combo.dataList
end

function HexLineupConfig:getComboData(comboId)
	return self:_safeGet(self._hex_lineup_combo, comboId)
end

function HexLineupConfig:getComboDataByCount(count)
	return MmUtil.unorderedSearchInSingleKey(self._hex_lineup_combo, "count", count)
end

function HexLineupConfig:getEndlessRankPrizeDatas(activityId)
	return self:_safeGet(self._hex_lineup_endless_rank_prize, activityId)
end

function HexLineupConfig:getEndlessRankPrizeData(activityId, rankRange)
	return self:_safeGet(self._hex_lineup_endless_rank_prize, activityId, rankRange)
end

function HexLineupConfig:getEndlessRankPrizeDataByRank(activityId, rank)
	local datas = self:getEndlessRankPrizeDatas(activityId)

	return MmUtil.unorderedSearchInArrayKey(datas, "rankRange", rank)
end

function HexLineupConfig:getGameData(gamePlanId)
	return self:_safeGet(self._hex_lineup_game, gamePlanId)
end

function HexLineupConfig:getPieceDataList()
	return self._hex_lineup_piece.dataList
end

function HexLineupConfig:getPieceData(pieceId)
	return self:_safeGet(self._hex_lineup_piece, pieceId)
end

function HexLineupConfig:getProgressPrizeDatas(activityId)
	return self:_safeGet(self._hex_lineup_progress_prize, activityId)
end

function HexLineupConfig:getProgressPrizeData(activityId, prizeId)
	return self:_safeGet(self._hex_lineup_progress_prize, activityId, prizeId)
end

function HexLineupConfig:getRhythmDatas(rhythmPlanId)
	return self:_safeGet(self._hex_lineup_rhythm, rhythmPlanId)
end

function HexLineupConfig:getRhythmData(rhythmPlanId, index)
	return self:_safeGet(self._hex_lineup_rhythm, rhythmPlanId, index)
end

HexLineupConfig.instance = HexLineupConfig.New()

return HexLineupConfig
