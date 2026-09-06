-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/controller/MahjongBattleGameController.lua

module("logic.extensions.mahjongbattle.controller.MahjongBattleGameController", package.seeall)

local MahjongBattleGameController = class("MahjongBattleGameController", BaseController)

function MahjongBattleGameController:onInit()
	self:onReset()
end

function MahjongBattleGameController:onReset()
	self._canHuResultCache = {}
end

function MahjongBattleGameController:getCountMap(mjDatas)
	local countMap = {}

	for _, mahjongData in ipairs(mjDatas) do
		local uniqueKey = mahjongData:getUniqueKey()

		countMap[uniqueKey] = (countMap[uniqueKey] or 0) + 1
	end

	return countMap
end

function MahjongBattleGameController:parseTileKey(tileKey)
	local type_value = {}

	for part in string.gmatch(tileKey, "[^_]+") do
		table.insert(type_value, part)
	end

	local typeId = tonumber(type_value[1]) or -1
	local value = tonumber(type_value[2]) or -1

	return typeId, value
end

function MahjongBattleGameController:getSortedActiveKeys(hand_count)
	local sortedKeys = {}

	for key, count in pairs(hand_count) do
		if count > 0 then
			local typeId, value = self:parseTileKey(key)

			table.insert(sortedKeys, {
				key = key,
				typeId = typeId,
				value = value
			})
		end
	end

	table.sort(sortedKeys, function(a, b)
		if a.typeId == b.typeId then
			return a.value < b.value
		end

		return a.typeId < b.typeId
	end)

	return sortedKeys
end

function MahjongBattleGameController:buildHandStateKey(hand_count, need_group_count)
	local sortedKeys = self:getSortedActiveKeys(hand_count)
	local parts = {
		tostring(need_group_count)
	}

	for _, tile in ipairs(sortedKeys) do
		if not hand_count[tile.key] then
			table.insert(parts, tile.key .. ":" .. tostring(hand_count[tile.key]))
		end
	end

	return table.concat(parts, "|")
end

function MahjongBattleGameController:buildCanHuCacheKey(hand_count, fuluCount)
	local sortedKeys = self:getSortedActiveKeys(hand_count)
	local parts = {
		"f=" .. tostring(fuluCount)
	}

	for _, tile in ipairs(sortedKeys) do
		if not hand_count[tile.key] then
			table.insert(parts, tile.key .. ":" .. tostring(hand_count[tile.key]))
		end
	end

	return table.concat(parts, "|")
end

function MahjongBattleGameController:canFormShunZi(mjDatas, targetMJ)
	if not mjDatas or not targetMJ then
		return false
	end

	local targetType = targetMJ:getTileType()
	local targetValue = targetMJ:getTileValue()

	if targetValue < 1 or targetValue > 9 then
		return false
	end

	local handCount = self:getCountMap(mjDatas)

	if targetValue <= 7 then
		local id1 = targetType .. "_" .. targetValue + 1
		local id2 = targetType .. "_" .. targetValue + 2

		if not handCount[id1] then
			local countId1 = 0

			if not handCount[id2] then
				local countId2 = 0

				if countId1 > 0 and countId2 > 0 then
					return true
				end
			end
		end
	end

	if targetValue >= 3 then
		local id1 = targetType .. "_" .. targetValue - 1
		local id2 = targetType .. "_" .. targetValue - 2

		if not handCount[id1] then
			local countId1 = 0

			if not handCount[id2] then
				local countId2 = 0

				if countId1 > 0 and countId2 > 0 then
					return true
				end
			end
		end
	end

	if targetValue >= 2 and targetValue <= 8 then
		local id1 = targetType .. "_" .. targetValue - 1
		local id2 = targetType .. "_" .. targetValue + 1

		if not handCount[id1] then
			local countId1 = 0

			if not handCount[id2] then
				local countId2 = 0

				if countId1 > 0 and countId2 > 0 then
					return true
				end
			end
		end
	end

	return false
end

function MahjongBattleGameController:canFormKeZi(mjDatas, targetMJ)
	if not mjDatas or not targetMJ then
		return false
	end

	local handCount = self:getCountMap(mjDatas)
	local targetKey = targetMJ:getUniqueKey()

	if not handCount[targetKey] then
		if handCount[targetKey] >= 2 then
			return true
		end

		return false
	end
end

function MahjongBattleGameController:canFormGang(mjDatas, targetMJ)
	if not mjDatas or not targetMJ then
		return false
	end

	local handCount = self:getCountMap(mjDatas)
	local targetKey = targetMJ:getUniqueKey()

	if not handCount[targetKey] then
		if handCount[targetKey] >= 3 then
			return true
		end

		return false
	end
end

function MahjongBattleGameController:findGangInList(mjDatas)
	if not mjDatas then
		return nil
	end

	local handCount = self:getCountMap(mjDatas)

	for key, count in pairs(handCount) do
		if count >= 4 then
			local gangList = {}
			local typeId, value = self:parseTileKey(key)

			for _, mahjongData in ipairs(mjDatas) do
				if mahjongData:getTileType() == typeId and mahjongData:getTileValue() == value then
					table.insert(gangList, mahjongData)

					if #gangList == 4 then
						return gangList
					end
				end
			end
		end
	end

	return nil
end

function MahjongBattleGameController:findKeZiInList(mjDatas)
	if not mjDatas then
		return nil
	end

	local handCount = self:getCountMap(mjDatas)

	for key, count in pairs(handCount) do
		if count >= 3 then
			local keziList = {}
			local typeId, value = self:parseTileKey(key)

			for _, mahjongData in ipairs(mjDatas) do
				if mahjongData:getTileType() == typeId and mahjongData:getTileValue() == value then
					table.insert(keziList, mahjongData)

					if #keziList == 3 then
						return keziList
					end
				end
			end
		end
	end

	return nil
end

function MahjongBattleGameController:findShunZiInList(mjDatas)
	if not mjDatas then
		return nil
	end

	local handCount = self:getCountMap(mjDatas)
	local handList = {}

	for key, count in pairs(handCount) do
		local typeId, value = self:parseTileKey(key)

		table.insert(handList, {
			key = key,
			typeId = typeId,
			value = value,
			count = count
		})
	end

	table.sort(handList, function(a, b)
		if a.typeId == b.typeId then
			return a.value < b.value
		else
			return a.typeId < b.typeId
		end
	end)

	for _, hand in ipairs(handList) do
		if hand.count > 0 then
			if not hand.typeId then
				local typeId = -1

				if not hand.value then
					local value = -1
					local id1 = typeId .. "_" .. value + 1
					local id2 = typeId .. "_" .. value + 2

					if not handCount[id1] then
						if not handCount[id2] then
							local countId2 = 0

							if handCount[id1] > 0 and countId2 > 0 then
								local shunziList = {}
								local needValueMap = {
									[value] = 1,
									[value + 1] = 1,
									[value + 2] = 1
								}

								for _, mahjongData in ipairs(mjDatas) do
									if mahjongData:getTileType() == typeId then
										local tileValue = mahjongData:getTileValue()

										if not needValueMap[tileValue] then
											if needValueMap[tileValue] > 0 then
												table.insert(shunziList, mahjongData)

												needValueMap[tileValue] = needValueMap[tileValue] - 1

												if #shunziList == 3 then
													return shunziList
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return nil
end

function MahjongBattleGameController:canHuWithFuluCount(mjDatas, fuluCount)
	local fuluCount = checknumber(fuluCount) or 0

	if fuluCount < 0 or fuluCount > 4 or not mjDatas or #mjDatas == 0 then
		return false
	end

	local total_count = #mjDatas + fuluCount * 3

	if total_count % 3 ~= 2 then
		return false
	end

	local hand_count = self:getCountMap(mjDatas)

	if not self._canHuResultCache then
		local canHuResultCache = {}

		self._canHuResultCache = canHuResultCache

		local cacheKey = self:buildCanHuCacheKey(hand_count, fuluCount)
		local cachedResult = canHuResultCache[cacheKey]

		if cachedResult ~= nil then
			return cachedResult
		end

		local need_group_count = 4 - fuluCount

		if need_group_count < 0 then
			canHuResultCache[cacheKey] = false

			return false
		end

		local sortedKeys = self:getSortedActiveKeys(hand_count)
		local memo = {}

		for _, tile in ipairs(sortedKeys) do
			local key = tile.key

			if (hand_count[key] or 0) >= 2 then
				hand_count[key] = hand_count[key] - 2

				if self:can_form_groups(hand_count, need_group_count, memo) then
					hand_count[key] = hand_count[key] + 2
					canHuResultCache[cacheKey] = true

					return true
				end

				hand_count[key] = hand_count[key] + 2
			end
		end

		canHuResultCache[cacheKey] = false

		return false
	end
end

function MahjongBattleGameController:can_form_groups(hand_count, need_group_count, memo)
	memo = memo or {}

	if need_group_count == 0 then
		return true
	end

	local stateKey = self:buildHandStateKey(hand_count, need_group_count)
	local cachedResult = memo[stateKey]

	if cachedResult ~= nil then
		return cachedResult
	end

	local sortedKeys = self:getSortedActiveKeys(hand_count)
	local firstTile = sortedKeys[1]

	if not firstTile then
		memo[stateKey] = false

		return false
	end

	local key = firstTile.key
	local typeId = firstTile.typeId
	local value = firstTile.value

	if not hand_count[key] then
		if hand_count[key] >= 3 then
			hand_count[key] = hand_count[key] - 3

			if self:can_form_groups(hand_count, need_group_count - 1, memo) then
				hand_count[key] = hand_count[key] + 3
				memo[stateKey] = true

				return true
			end

			hand_count[key] = hand_count[key] + 3
		end

		local id1 = typeId .. "_" .. value + 1
		local id2 = typeId .. "_" .. value + 2

		if not hand_count[id1] then
			if not hand_count[id2] then
				local countId2 = 0

				if hand_count[key] > 0 and hand_count[id1] > 0 and countId2 > 0 then
					hand_count[key] = hand_count[key] - 1
					hand_count[id1] = hand_count[id1] - 1
					hand_count[id2] = hand_count[id2] - 1

					if self:can_form_groups(hand_count, need_group_count - 1, memo) then
						hand_count[key] = hand_count[key] + 1
						hand_count[id1] = hand_count[id1] + 1
						hand_count[id2] = hand_count[id2] + 1
						memo[stateKey] = true

						return true
					end

					hand_count[key] = hand_count[key] + 1
					hand_count[id1] = hand_count[id1] + 1
					hand_count[id2] = hand_count[id2] + 1
				end

				memo[stateKey] = false

				return false
			end
		end
	end
end

function MahjongBattleGameController:canHu(mjDatas, targetMJ, fuluCount)
	if not mjDatas or not targetMJ then
		return false
	end

	local extendedMjDatas = {}

	for _, mahjongData in ipairs(mjDatas) do
		table.insert(extendedMjDatas, mahjongData)
	end

	table.insert(extendedMjDatas, targetMJ)

	return self:canHuWithFuluCount(extendedMjDatas, fuluCount)
end

function MahjongBattleGameController:isKeZi(mjDatas)
	if not mjDatas or #mjDatas ~= 3 then
		return false
	end

	local firstMJ = mjDatas[1]

	for i = 2, #mjDatas do
		local mj = mjDatas[i]

		if mj:getTileType() ~= firstMJ:getTileType() or mj:getTileValue() ~= firstMJ:getTileValue() then
			return false
		end
	end

	return true
end

function MahjongBattleGameController:isGang(mjDatas)
	if not mjDatas or #mjDatas ~= 4 then
		return false
	end

	local firstMJ = mjDatas[1]

	for i = 2, #mjDatas do
		local mj = mjDatas[i]

		if mj:getTileType() ~= firstMJ:getTileType() or mj:getTileValue() ~= firstMJ:getTileValue() then
			return false
		end
	end

	return true
end

function MahjongBattleGameController:isShunZi(mjDatas)
	if not mjDatas or #mjDatas ~= 3 then
		return false
	end

	table.sort(mjDatas, function(a, b)
		if a:getTileType() == b:getTileType() then
			return a:getTileValue() < b:getTileValue()
		else
			return a:getTileType() < b:getTileType()
		end
	end)

	local firstMJ = mjDatas[1]

	for i = 2, #mjDatas do
		local mj = mjDatas[i]

		if mj:getTileType() ~= firstMJ:getTileType() or mj:getTileValue() ~= firstMJ:getTileValue() + (i - 1) then
			return false
		end
	end

	return true
end

MahjongBattleGameController.instance = MahjongBattleGameController.New()

return MahjongBattleGameController
