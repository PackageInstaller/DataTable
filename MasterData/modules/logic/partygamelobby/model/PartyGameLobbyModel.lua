-- chunkname: @modules/logic/partygamelobby/model/PartyGameLobbyModel.lua

module("modules.logic.partygamelobby.model.PartyGameLobbyModel", package.seeall)

local PartyGameLobbyModel = class("PartyGameLobbyModel", BaseModel)

function PartyGameLobbyModel:onInit()
	return
end

function PartyGameLobbyModel:reInit()
	self._allOnLineGame = nil
	self._groupByPlayerCount = nil
	self._lastSelectedGameIdsByPlayerCount = nil
end

function PartyGameLobbyModel:getAllOnLineGameConfig()
	if self._allOnLineGame == nil then
		local allOnLineGame = {}

		for i = 1, #lua_partygame_param.configList do
			local gameConfig = lua_partygame_param.configList[i]

			if gameConfig.online then
				table.insert(allOnLineGame, gameConfig)
			end
		end

		self._allOnLineGame = allOnLineGame
	end

	return self._allOnLineGame
end

function PartyGameLobbyModel:getOnLineGameConfigByPlayerCount(playerCount)
	local groupByPlayerCount = self:getGroupByPlayerCount()

	return groupByPlayerCount[playerCount] or {}
end

function PartyGameLobbyModel:getGroupByPlayerCount()
	if self._groupByPlayerCount == nil then
		local allOnLineGame = self:getAllOnLineGameConfig()
		local groupByPlayerCount = {}

		for i = 1, #allOnLineGame do
			local gameConfig = allOnLineGame[i]
			local weightStr = gameConfig.weight

			if not string.nilorempty(weightStr) then
				local weightParts = string.split(weightStr, "|")

				for j = 1, #weightParts do
					local parts = string.splitToNumber(weightParts[j], "#")
					local playerCount = parts[1]
					local weight = parts[2]

					if playerCount and weight then
						groupByPlayerCount[playerCount] = groupByPlayerCount[playerCount] or {}

						table.insert(groupByPlayerCount[playerCount], {
							gameConfig = gameConfig,
							weight = weight
						})
					end
				end
			end
		end

		self._groupByPlayerCount = groupByPlayerCount
	end

	return self._groupByPlayerCount
end

function PartyGameLobbyModel:getRandomPartyFullLineGames()
	local groupByPlayerCount = self:getGroupByPlayerCount()
	local result = {}
	local selectedIds = {}

	if self._lastSelectedGameIdsByPlayerCount == nil then
		self._lastSelectedGameIdsByPlayerCount = {}
	end

	for _, playerCount in ipairs(PartyGameTrialPlayEnum.trialPlayerNumStep) do
		local count = PartyGameTrialPlayEnum.selectCountMap[playerCount]
		local group = groupByPlayerCount[playerCount]

		if group and #group > 0 then
			if not self._lastSelectedGameIdsByPlayerCount[playerCount] then
				local available = {}

				for i = 1, #group do
					local item = group[i]

					if not selectedIds[item.gameConfig.id] and not self._lastSelectedGameIdsByPlayerCount[playerCount][item.gameConfig.id] then
						table.insert(available, item)
					end
				end

				if count > #available then
					available = {}

					for i = 1, #group do
						local item = group[i]

						if not selectedIds[item.gameConfig.id] then
							table.insert(available, item)
						end
					end
				end

				local currentSelectedIds = {}

				for _ = 1, count do
					if #available == 0 then
						break
					end

					local selectedIndex = self:_weightedRandomIndex(available)

					if selectedIndex then
						local selected = available[selectedIndex]

						table.insert(result, selected.gameConfig)

						selectedIds[selected.gameConfig.id] = true
						currentSelectedIds[selected.gameConfig.id] = true

						table.remove(available, selectedIndex)
					end
				end

				self._lastSelectedGameIdsByPlayerCount[playerCount] = currentSelectedIds
			end
		end
	end

	return result
end

function PartyGameLobbyModel:_weightedRandomIndex(list)
	if #list == 0 then
		return nil
	end

	local total = 0

	for i = 1, #list do
		total = total + list[i].weight
	end

	local rand = math.random(1, total)
	local acc = 0

	for i = 1, #list do
		acc = acc + list[i].weight

		if rand <= acc then
			return i
		end
	end

	return #list
end

function PartyGameLobbyModel:getOneTrialMaxPlayerCount(gameId)
	local groupByPlayerCount = self:getGroupByPlayerCount()
	local maxPlayerCount = 0

	for playerCount, group in pairs(groupByPlayerCount) do
		for i = 1, #group do
			if group[i].gameConfig.id == gameId and maxPlayerCount < playerCount then
				maxPlayerCount = playerCount
			end
		end
	end

	return maxPlayerCount
end

PartyGameLobbyModel.instance = PartyGameLobbyModel.New()

return PartyGameLobbyModel
