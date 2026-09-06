-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/config/IdiomChainConfig.lua

module("logic.extensions.idiomchain.config.IdiomChainConfig", package.seeall)

local IdiomChainConfig = class("IdiomChainConfig", BaseConfig)

function IdiomChainConfig:getNames()
	return {
		"idiom_chain_activity",
		"idiom_chain_difficult",
		"idiom_chain_game",
		"idiom_chain_prize",
		"idiom_chain_score",
		"idiom_chain_word"
	}
end

function IdiomChainConfig:handleConfig(name, content)
	if name == "idiom_chain_activity" then
		self._idiom_chain_activity = content
	elseif name == "idiom_chain_difficult" then
		self._idiom_chain_difficult = content
	elseif name == "idiom_chain_game" then
		self._idiom_chain_game = content
	elseif name == "idiom_chain_prize" then
		self._idiom_chain_prize = content
	elseif name == "idiom_chain_score" then
		self._idiom_chain_score = content
	elseif name == "idiom_chain_word" then
		self._idiom_chain_word = content
	end
end

function IdiomChainConfig:_safeGet(data, ...)
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

function IdiomChainConfig:getActData(activityId)
	return self:_safeGet(self._idiom_chain_activity, activityId)
end

function IdiomChainConfig:getDifficultDatas(activityId)
	return self:_safeGet(self._idiom_chain_difficult, activityId)
end

function IdiomChainConfig:getDifficultData(activityId, difficultId)
	return self:_safeGet(self._idiom_chain_difficult, activityId, difficultId)
end

function IdiomChainConfig:getGameData(gamePlanId)
	return self:_safeGet(self._idiom_chain_game, gamePlanId)
end

function IdiomChainConfig:getPrizeDatas(activityId)
	return self:_safeGet(self._idiom_chain_prize, activityId)
end

function IdiomChainConfig:getPrizeData(activityId, prizeId)
	return self:_safeGet(self._idiom_chain_prize, activityId, prizeId)
end

function IdiomChainConfig:getScoreDatass(activityId)
	return self:_safeGet(self._idiom_chain_score, activityId)
end

function IdiomChainConfig:getScoreDatas(activityId, difficultId)
	return self:_safeGet(self._idiom_chain_score, activityId, difficultId)
end

function IdiomChainConfig:getScoreDataListOfSort(activityId, difficultId)
	local var_12_0 = self._scoreDataListOfSort

	if self._scoreDataListOfSort then
		var_12_0 = self._scoreDataListOfSort[activityId]

		if self._scoreDataListOfSort[activityId] then
			local dataList = self._scoreDataListOfSort[activityId][difficultId]

			if dataList == nil then
				dataList = {}

				local datas = self:getScoreDatas(activityId, difficultId)

				for _, data in pairs(datas) do
					table.insert(dataList, data)
				end

				table.sort(dataList, function(a, b)
					return a.sec > b.sec
				end)

				self._scoreDataListOfSort = MmUtil.checkTable(self._scoreDataListOfSort, activityId, difficultId)
				self._scoreDataListOfSort[activityId][difficultId] = dataList
			end

			return dataList
		end
	end
end

function IdiomChainConfig:getScoreDataBySec(activityId, difficultId, sec)
	local result
	local dataList = self:getScoreDataListOfSort(activityId, difficultId)

	if dataList then
		for i = #dataList, 1, -1 do
			local data = dataList[i]

			result = data

			if sec < data.sec then
				break
			end
		end
	end

	return result
end

function IdiomChainConfig:getWordDataList()
	return self._idiom_chain_word.dataList
end

function IdiomChainConfig:getWordData(wordId)
	return self:_safeGet(self._idiom_chain_word, wordId)
end

IdiomChainConfig.instance = IdiomChainConfig.New()

return IdiomChainConfig
