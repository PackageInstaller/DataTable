-- chunkname: @modules/logic/room/utils/RoomProductionHelper.lua

module("modules.logic.room.utils.RoomProductionHelper", package.seeall)

local RoomProductionHelper = {}

function RoomProductionHelper.getCanGainLineIdList(partId)
	local requestLineIdList = {}
	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)

	if not partConfig then
		return requestLineIdList
	end

	local lineIdList = partConfig.productionLines

	for i, lineId in ipairs(lineIdList) do
		local lineMO = RoomProductionModel.instance:getLineMO(lineId)

		if lineMO and lineMO:isCanGain() then
			table.insert(requestLineIdList, lineId)
		end
	end

	return requestLineIdList
end

function RoomProductionHelper.hasUnlockLine(partId, roomLevel)
	return RoomProductionHelper.getUnlockLineCount(partId, roomLevel) > 0
end

function RoomProductionHelper.getUnlockLineCount(partId, roomLevel)
	local count = 0

	roomLevel = roomLevel or RoomModel.instance:getRoomLevel()

	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)
	local lineIdList = partConfig.productionLines

	for i, lineId in ipairs(lineIdList) do
		if RoomProductionHelper.isLineUnlock(lineId, roomLevel) then
			count = count + 1
		end
	end

	return count
end

function RoomProductionHelper.isLineUnlock(lineId, roomLevel)
	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)

	return lineConfig and roomLevel >= lineConfig.needRoomLevel
end

function RoomProductionHelper.getFormulaMaxCount(formulaId)
	local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)
	local maxCount = RoomBuildingEnum.MachineSlotMaxCount

	if string.nilorempty(formulaConfig.costMaterial) then
		return RoomBuildingEnum.MachineSlotMaxCount
	end

	local itemParams = RoomProductionHelper.getFormulaItemParamList(formulaConfig.costMaterial)
	local extraParams = RoomProductionHelper.getFormulaItemParamList(formulaConfig.costScore)
	local mergedItemDict = {}

	for i = 1, #itemParams do
		local item = itemParams[i]

		mergedItemDict[item.type] = mergedItemDict[item.type] or {}
		mergedItemDict[item.type][item.id] = (mergedItemDict[item.type][item.id] or 0) + item.quantity
	end

	for i = 1, #extraParams do
		local item = extraParams[i]

		mergedItemDict[item.type] = mergedItemDict[item.type] or {}
		mergedItemDict[item.type][item.id] = (mergedItemDict[item.type][item.id] or 0) + item.quantity
	end

	for type, dict in pairs(mergedItemDict) do
		for id, quantity in pairs(dict) do
			local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

			if quantity ~= 0 then
				local count = math.floor(hasQuantity / quantity)

				if count < maxCount then
					maxCount = count
				end
			end
		end
	end

	return maxCount
end

function RoomProductionHelper.isChangeFormulaUnlock(itemType, itemId)
	local itemConfig = ItemModel.instance:getItemConfig(itemType, itemId)

	if not itemConfig then
		return false
	end

	local minNeedProductionLevel

	for i, formulaConfig in ipairs(lua_formula.configList) do
		if not string.nilorempty(formulaConfig.produce) then
			local formulaItemParamList = RoomProductionHelper.getFormulaItemParamList(formulaConfig.produce)

			for j, formulaItemParam in ipairs(formulaItemParamList) do
				if formulaItemParam.type == itemType and formulaItemParam.id == itemId and (not minNeedProductionLevel or minNeedProductionLevel > formulaConfig.needProductionLevel) then
					minNeedProductionLevel = formulaConfig.needProductionLevel
				end
			end
		end
	end

	local maxLevel = 0
	local lineMOList = RoomProductionModel.instance:getList()

	if LuaUtil.tableNotEmpty(lineMOList) then
		for i, lineMO in ipairs(lineMOList) do
			if lineMO.config.logic == RoomProductLineEnum.ProductType.Change and maxLevel < lineMO.level then
				maxLevel = lineMO.level
			end
		end
	end

	if maxLevel <= 0 then
		return false, RoomEnum.Toast.RoomProductionLevelLock
	end

	if maxLevel < minNeedProductionLevel then
		return false, RoomEnum.Toast.RoomNeedProductionLevel, minNeedProductionLevel
	end

	if RoomController.instance:isEditMode() and RoomController.instance:isRoomScene() then
		return false, RoomEnum.Toast.RoomEditCanNotOpenProductionLevel
	end

	return true
end

function RoomProductionHelper.isFormulaShowTypeUnlock(formulaShowType)
	local minLevel
	local allFormulaMOList = RoomFormulaModel.instance:getAllTopTreeLevelFormulaMoList()

	for i, formulaMO in ipairs(allFormulaMOList) do
		if formulaMO.config.showType == formulaShowType then
			local needProductionLevel = formulaMO.config.needProductionLevel

			if not minLevel or needProductionLevel < minLevel then
				minLevel = needProductionLevel
			end
		end
	end

	return minLevel or 0
end

function RoomProductionHelper.isFormulaUnlock(formulaId, level)
	local unlock = true
	local needRoomLevel, needProductionLevel, needEpisodeId
	local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)

	if not formulaConfig then
		return
	end

	local roomLevel = RoomModel.instance:getRoomLevel()

	if roomLevel < formulaConfig.needRoomLevel then
		unlock = false
		needRoomLevel = formulaConfig.needRoomLevel
	end

	if not level or level < formulaConfig.needProductionLevel then
		unlock = false
		needProductionLevel = formulaConfig.needProductionLevel
	end

	if formulaConfig.needEpisodeId ~= 0 and not DungeonModel.instance:hasPassLevelAndStory(formulaConfig.needEpisodeId) then
		unlock = false
		needEpisodeId = formulaConfig.needEpisodeId
	end

	return unlock, needRoomLevel, needProductionLevel, needEpisodeId
end

function RoomProductionHelper.getFormulaCostTime(formulaId, lineMO)
	local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)

	if not formulaConfig then
		return 0
	end

	local costTime = formulaConfig.costTime

	if not lineMO then
		return costTime
	end

	local totalDecRate = 0

	if lineMO.levelCO then
		local arr = GameUtil.splitString2(lineMO.levelCO.effect, true)

		if arr then
			for i, v in ipairs(arr) do
				if v[1] == RoomBuildingEnum.EffectType.Time then
					totalDecRate = totalDecRate + v[2]
				end
			end
		end
	end

	local remainRate = math.max(0, 1000 - totalDecRate)

	return math.floor(costTime * remainRate / 1000)
end

function RoomProductionHelper.isPartWorking(partId)
	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)
	local productType = RoomProductionHelper.getPartType(partId)

	if productType == RoomProductLineEnum.ProductType.Change then
		return true
	end

	local lineIdList = partConfig.productionLines

	for i, lineId in ipairs(lineIdList) do
		if RoomController.instance:isDebugMode() then
			return false
		elseif RoomController.instance:isVisitMode() then
			return false
		else
			local lineMO = RoomProductionModel.instance:getLineMO(lineId)

			if lineMO and not lineMO:isLock() and not lineMO:isFull() and not lineMO:isPause() then
				return true
			end
		end
	end

	return false
end

function RoomProductionHelper.canLevelUp(mo)
	if mo.level == mo.maxConfigLevel or mo:isLock() then
		return false
	end

	if mo.level >= mo.maxLevel then
		return false
	end

	local tarLv = math.min(mo.maxConfigLevel, mo.level + 1)
	local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(mo.config.levelGroup, tarLv)
	local cost = levelGroupConfig.cost
	local costParam = GameUtil.splitString2(cost, true)

	for i, param in ipairs(costParam) do
		local costType = param[1]
		local costId = param[2]
		local costCount = param[3]
		local ownCount = ItemModel.instance:getItemQuantity(costType, costId)

		if ownCount < costCount then
			return false
		end
	end

	return true
end

function RoomProductionHelper.getPartType(partId)
	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)
	local lineIdList = partConfig.productionLines
	local lineId = lineIdList[1]
	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)

	return lineConfig.logic, lineConfig.type
end

function RoomProductionHelper.getPartMaxLineLevel(partId)
	local config = RoomConfig.instance:getProductionPartConfig(partId)
	local lineLevel = 0
	local lineIdList = config.productionLines

	for _, lineId in ipairs(lineIdList) do
		local lineMO = RoomProductionModel.instance:getLineMO(lineId)

		if lineMO then
			if not lineMO.level then
				local level = 0

				if lineLevel < level then
					lineLevel = level
				end
			end
		end
	end

	return lineLevel
end

function RoomProductionHelper.getChangePartLineMO(partId)
	local config = RoomConfig.instance:getProductionPartConfig(partId)
	local lineIdList = config.productionLines

	for _, lineId in ipairs(lineIdList) do
		return (RoomProductionModel.instance:getLineMO(lineId))
	end
end

function RoomProductionHelper.getFormulaRewardInfo(formulaId)
	local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)

	if not formulaConfig then
		return nil
	end

	local rewardList = RoomProductionHelper.getFormulaItemParamList(formulaConfig.produce)
	local reward = rewardList[1]

	if not reward then
		return
	end

	reward.quantity = ItemModel.instance:getItemQuantity(reward.type, reward.id)

	return reward
end

function RoomProductionHelper.getSkinLevel(partId, level)
	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)

	if not partConfig then
		return 0
	end

	local lineIds = partConfig.productionLines
	local lineId = lineIds[1]

	if not lineId then
		return 0
	end

	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)

	if not lineConfig then
		return 0
	end

	local skinLevel = 0
	local currentModulePart
	local levelConfigList = RoomConfig.instance:getProductionLineLevelConfigList(lineConfig.levelGroup)

	for i, levelConfig in ipairs(levelConfigList) do
		if level < levelConfig.id then
			break
		end

		if not string.nilorempty(levelConfig.modulePart) and levelConfig.modulePart ~= currentModulePart then
			skinLevel = skinLevel + 1
			currentModulePart = levelConfig.modulePart
		end
	end

	return skinLevel
end

function RoomProductionHelper.getRoomLevelUpParams(roomLevel, nextRoomLevel, isResult)
	local params = {}
	local roomLevelConfig = RoomConfig.instance:getRoomLevelConfig(roomLevel)
	local nextRoomLevelConfig = RoomConfig.instance:getRoomLevelConfig(nextRoomLevel)

	if not isResult then
		table.insert(params, {
			desc = luaLang("room_levelup_init_title"),
			currentDesc = string.format("Lv.%d", roomLevel),
			nextDesc = string.format("Lv.%d", nextRoomLevel)
		})
	end

	local nameList = {}

	for i, partConfig in ipairs(lua_production_part.configList) do
		local partId = partConfig.id

		if RoomProductionHelper.hasUnlockLine(partId, nextRoomLevel) and not RoomProductionHelper.hasUnlockLine(partId, roomLevel) then
			table.insert(nameList, string.format(luaLang("room_levelup_init_name1"), partConfig.name))
		end
	end

	if #nameList > 0 then
		local names = RoomProductionHelper.combineNames(nameList, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
		local param = {}

		if isResult then
			param.desc = string.format(luaLang("room_levelup_init_unlock"), names)
		else
			param.desc = string.format(luaLang("room_levelupresult_init_unlock"), names)
			param.currentDesc = tostring(0)
			param.nextDesc = tostring(1)
		end

		table.insert(params, param)
	end

	local countDict = {}
	local maxLevelIndexList = {}

	for i, partConfig in ipairs(lua_production_part.configList) do
		local partId = partConfig.id
		local curCount = RoomProductionHelper.getUnlockLineCount(partId, roomLevel)
		local nextCount = RoomProductionHelper.getUnlockLineCount(partId, nextRoomLevel)

		if curCount < 1 then
			curCount = 1
		end

		if curCount < nextCount and curCount > 0 then
			countDict[curCount] = countDict[curCount] or {}

			if not countDict[curCount][nextCount] then
				countDict[curCount][nextCount] = {}

				table.insert(maxLevelIndexList, {
					curCount = curCount,
					nextCount = nextCount
				})
			end

			table.insert(countDict[curCount][nextCount], string.format(luaLang("room_levelup_init_name2"), partConfig.name))
		end
	end

	if #maxLevelIndexList > 0 then
		for i, indexParam in ipairs(maxLevelIndexList) do
			local curCount = indexParam.curCount
			local nextCount = indexParam.nextCount
			local nameList = countDict[curCount][nextCount]
			local names = RoomProductionHelper.combineNames(nameList, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
			local param = {}

			if isResult then
				local countList = {}

				for j = curCount + 1, nextCount do
					table.insert(countList, string.format(luaLang("room_levelupresult_init_count_number"), j))
				end

				local counts = RoomProductionHelper.combineNames(countList, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
				local tag = {
					names,
					counts
				}

				param.desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_levelupresult_init_count"), tag)
			else
				param.desc = string.format(luaLang("room_levelup_init_count"), names)
				param.currentDesc = tostring(curCount)
				param.nextDesc = tostring(nextCount)
			end

			table.insert(params, param)
		end
	end

	local maxLevelDict = {}
	local maxLevelIndexList = {}
	local maxLevelIndexNextList = {}

	for i, partConfig in ipairs(lua_production_part.configList) do
		local partId = partConfig.id
		local curMaxLevel = RoomProductionHelper.getLineMaxLevel(partId, roomLevel)
		local nextMaxLevel = RoomProductionHelper.getLineMaxLevel(partId, nextRoomLevel)

		if nextMaxLevel > 0 and curMaxLevel == 0 then
			curMaxLevel = 1
		end

		if curMaxLevel < nextMaxLevel and curMaxLevel > 0 then
			if not maxLevelDict[nextMaxLevel] then
				maxLevelDict[nextMaxLevel] = {}

				table.insert(maxLevelIndexNextList, nextMaxLevel)
			end

			if not maxLevelDict[nextMaxLevel][curMaxLevel] then
				maxLevelDict[nextMaxLevel][curMaxLevel] = {}

				table.insert(maxLevelIndexList, {
					curMaxLevel = curMaxLevel,
					nextMaxLevel = nextMaxLevel
				})
			end

			table.insert(maxLevelDict[nextMaxLevel][curMaxLevel], string.format(luaLang("room_levelup_init_name2"), partConfig.name))
		end
	end

	if isResult then
		if #maxLevelIndexNextList > 0 then
			for i, nextMaxLevel in ipairs(maxLevelIndexNextList) do
				local dict = maxLevelDict[nextMaxLevel]
				local totalNameList = {}

				for curMaxLevel, nameList in pairs(dict) do
					tabletool.addValues(totalNameList, nameList)
				end

				local names = RoomProductionHelper.combineNames(totalNameList, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
				local tag = {
					names,
					nextMaxLevel
				}
				local param = {}

				param.desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_levelupresult_init_maxlevel"), tag)

				table.insert(params, param)
			end
		end
	elseif #maxLevelIndexList > 0 then
		for i, indexParam in ipairs(maxLevelIndexList) do
			local nextMaxLevel = indexParam.nextMaxLevel
			local curMaxLevel = indexParam.curMaxLevel
			local nameList = maxLevelDict[nextMaxLevel][curMaxLevel]
			local names = RoomProductionHelper.combineNames(nameList, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
			local param = {}

			param.desc = string.format(luaLang("room_levelup_init_maxlevel"), names)
			param.currentDesc = tostring(curMaxLevel)
			param.nextDesc = tostring(nextMaxLevel)

			table.insert(params, param)
		end
	end

	local curBlockCount = RoomMapBlockModel.instance:getMaxBlockCount(roomLevel)
	local nextBlockCount = RoomMapBlockModel.instance:getMaxBlockCount(nextRoomLevel)

	if curBlockCount < nextBlockCount then
		local param = {}

		if isResult then
			param.desc = string.format(luaLang("room_levelupresult_init_block"), nextBlockCount - curBlockCount)
		else
			param.desc = luaLang("room_levelup_init_block")
			param.currentDesc = tostring(curBlockCount)
			param.nextDesc = tostring(nextBlockCount)
		end

		table.insert(params, param)
	end

	local curCharacterCount = roomLevelConfig.characterLimit
	local nextCharacterCount = nextRoomLevelConfig.characterLimit

	if curCharacterCount < nextCharacterCount then
		local param = {}

		if isResult then
			param.desc = string.format(luaLang("room_levelupresult_init_character"), nextCharacterCount - curCharacterCount)
		else
			param.desc = luaLang("room_levelup_init_character")
			param.currentDesc = tostring(curCharacterCount)
			param.nextDesc = tostring(nextCharacterCount)
		end

		table.insert(params, param)
	end

	if isResult and nextRoomLevel and CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) == nextRoomLevel then
		table.insert(params, {
			desc = luaLang("room_levelupresult_init_layoutplan_open")
		})
	end

	return params
end

function RoomProductionHelper.combineNames(nameList, and1, and2)
	local names = ""

	for i, name in ipairs(nameList) do
		if i > 1 then
			names = i == #nameList and names .. and2 or names .. and1
		end

		names = names .. name
	end

	return names
end

function RoomProductionHelper.getLineMaxLevel(partId, roomLevel)
	if not roomLevel then
		::label_19_0::

		local roomLevel = RoomModel.instance:getRoomLevel()
		local partConfig = RoomConfig.instance:getProductionPartConfig(partId)
		local lineIdList = partConfig.productionLines
		local lineId = lineIdList[1]
		local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)

		if lineConfig then
			::label_19_1::

			local levelGroupConfigList = RoomConfig.instance:getProductionLineLevelGroupIdConfig(lineConfig.levelGroup)
			local maxLevel = 0

			if levelGroupConfigList then
				for i, levelGroupConfig in ipairs(levelGroupConfigList) do
					if roomLevel >= levelGroupConfig.needRoomLevel then
						maxLevel = math.max(levelGroupConfig.id, maxLevel)
					end
				end
			end

			return maxLevel
		end
	end
end

function RoomProductionHelper.getProductLineLevelUpParams(lineId, level, nextLevel, isResult)
	local params = {}
	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)

	if not isResult then
		table.insert(params, {
			desc = luaLang("roomproductlinelevelup_level"),
			currentDesc = string.format("Lv.%d", level),
			nextDesc = string.format("Lv.%d", nextLevel)
		})
	end

	if lineConfig.logic == RoomProductLineEnum.ProductType.Change then
		for i = 1, 4 do
			local formulaType = 300 + i
			local levelUpCount = RoomProductionHelper.getFormulaLevelUpCount(formulaType, nextLevel)

			if levelUpCount == 1 then
				local param = {}

				if isResult then
					param.desc = luaLang("room_levelupresult_line_change" .. i)
				else
					param.desc = luaLang("room_levelup_line_change" .. i)
					param.currentDesc = tostring("0")
					param.nextDesc = tostring("1")
				end

				table.insert(params, param)
			end
		end

		for i = 1, 4 do
			local formulaType = 300 + i
			local levelUpCount = RoomProductionHelper.getFormulaLevelUpCount(formulaType, nextLevel)

			if levelUpCount > 1 then
				local param = {}

				if isResult then
					param.desc = levelUpCount > 2 and string.format(luaLang("room_levelupresult_line_formula" .. i), luaLang("room_levelup_line_formula_high")) or string.format(luaLang("room_levelupresult_line_formula" .. i), luaLang("room_levelup_line_formula_middle"))
				else
					param.desc = luaLang("room_levelup_line_formula" .. i)

					if levelUpCount > 2 then
						param.currentDesc = luaLang("room_levelup_line_formula_middle")
						param.nextDesc = luaLang("room_levelup_line_formula_high")
					else
						param.currentDesc = luaLang("room_levelup_line_formula_low")
						param.nextDesc = luaLang("room_levelup_line_formula_middle")
					end
				end

				table.insert(params, param)
			end
		end
	elseif lineConfig.logic == RoomProductLineEnum.ProductType.Product then
		local curReserve = RoomProductionHelper.getProductLineReserve(lineId, level)
		local nextReserve = RoomProductionHelper.getProductLineReserve(lineId, nextLevel)

		if curReserve < nextReserve then
			local param = {}

			if isResult then
				param.desc = string.format(luaLang("room_levelupresult_line_reserve"), nextReserve)
			else
				param.desc = luaLang("room_levelup_line_reserve")
				param.currentDesc = tostring(curReserve)
				param.nextDesc = tostring(nextReserve)
			end

			table.insert(params, param)
		end

		local curReduceRate, curReduceSec = RoomProductionHelper.getProductLineCostTimeReduceRate(lineId, level)
		local nextReduceRate, nextReduceSec = RoomProductionHelper.getProductLineCostTimeReduceRate(lineId, nextLevel)

		if curReduceRate < nextReduceRate then
			local param = {}

			if isResult then
				param.desc = string.format(luaLang("room_levelupresult_line_costtime"), math.floor(nextReduceSec / 60))
			else
				param.desc = luaLang("room_levelup_line_costtime")
				param.currentDesc = string.format("%d%%", math.floor((1 - curReduceRate) * 100 + 0.5))
				param.nextDesc = string.format("%d%%", math.floor((1 - nextReduceRate) * 100 + 0.5))
			end

			table.insert(params, param)
		end

		local curAddRate = RoomProductionHelper.getProductLineProductionAddRate(lineId, level)
		local nextAddRate = RoomProductionHelper.getProductLineProductionAddRate(lineId, nextLevel)

		if curAddRate < nextAddRate then
			local param = {}

			if isResult then
				param.desc = string.format(luaLang("room_levelupresult_line_product"), math.floor((nextAddRate - 1) * 100 + 0.5))
			else
				param.desc = luaLang("room_levelup_line_product")
				param.currentDesc = string.format("%d%%", math.floor(curAddRate * 100 + 0.5))
				param.nextDesc = string.format("%d%%", math.floor(nextAddRate * 100 + 0.5))
			end

			table.insert(params, param)
		end
	end

	return params
end

function RoomProductionHelper.getProductLineReserve(lineId, level)
	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)
	local reserve = lineConfig.reserve

	if lineConfig.levelGroup > 0 then
		local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(lineConfig.levelGroup, level)
		local arr = GameUtil.splitString2(levelGroupConfig.effect, true)

		if arr then
			for i, v in ipairs(arr) do
				if v[1] == RoomBuildingEnum.EffectType.Reserve then
					reserve = reserve + v[2]
				end
			end
		end
	end

	return reserve
end

function RoomProductionHelper.getProductLineCostTimeReduceRate(lineId, level)
	if level <= 1 then
		return 0, 0
	end

	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)
	local initFormulaId = lineConfig.initFormula
	local initFormulaConfig = RoomConfig.instance:getFormulaConfig(initFormulaId)
	local formulaId = initFormulaId

	if lineConfig.levelGroup > 0 then
		for i = level, 1, -1 do
			local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(lineConfig.levelGroup, level)

			if not string.nilorempty(levelGroupConfig.changeFormulaId) then
				formulaId = tonumber(levelGroupConfig.changeFormulaId)

				break
			end
		end
	end

	local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)

	if initFormulaConfig.costTime <= 0 then
		return 0, 0
	end

	return 1 - formulaConfig.costTime / initFormulaConfig.costTime, initFormulaConfig.costTime - formulaConfig.costTime
end

function RoomProductionHelper.getProductLineProductionAddRate(lineId, level)
	if level <= 1 then
		return 1
	end

	local lineConfig = RoomConfig.instance:getProductionLineConfig(lineId)
	local initFormulaId = lineConfig.initFormula
	local initFormulaConfig = RoomConfig.instance:getFormulaConfig(initFormulaId)
	local formulaId = initFormulaId

	if lineConfig.levelGroup > 0 then
		for i = level, 1, -1 do
			local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(lineConfig.levelGroup, level)

			if not string.nilorempty(levelGroupConfig.changeFormulaId) then
				formulaId = tonumber(levelGroupConfig.changeFormulaId)

				break
			end
		end
	end

	local formulaConfig = RoomConfig.instance:getFormulaConfig(formulaId)
	local item = RoomProductionHelper.getFormulaItemParamList(formulaConfig.produce)[1]
	local initItem = RoomProductionHelper.getFormulaItemParamList(initFormulaConfig.produce)[1]

	if initItem.quantity <= 0 then
		return 1
	end

	return item.quantity / initItem.quantity
end

function RoomProductionHelper.getFormulaLevelUpCount(formulaType, level)
	local info = RoomProductionHelper._formulaLevelUpInfo

	if not info then
		info = {}
		RoomProductionHelper._formulaLevelUpInfo = info

		local counterTemp = {}

		for lv = 0, 4 do
			for _, formulaConfig in ipairs(lua_formula.configList) do
				if formulaConfig.needProductionLevel == lv then
					local showType = formulaConfig.showType

					info[showType] = info[showType] or {}

					if not info[showType][lv] then
						local prev = counterTemp[showType]

						if prev then
							if not (prev + 1) then
								local now = 1

								counterTemp[showType] = now
								info[showType][lv] = now
							end
						end
					end
				end
			end
		end
	end

	return (info[formulaType] or nil) and (info[formulaType][level] or 0)
end

function RoomProductionHelper.getPartIdByLineId(lineId)
	for _, partConfig in ipairs(lua_production_part.configList) do
		local lineIdList = partConfig.productionLines

		for _, one in ipairs(lineIdList) do
			if one == lineId then
				return partConfig.id
			end
		end
	end
end

function RoomProductionHelper.getFormulaItemParamList(param)
	local itemList = {}

	if string.nilorempty(param) then
		return itemList
	end

	local itemParams = GameUtil.splitString2(param, true)

	for _, itemParam in ipairs(itemParams) do
		table.insert(itemList, {
			type = itemParam[1],
			id = itemParam[2],
			quantity = itemParam[3]
		})
	end

	return itemList
end

function RoomProductionHelper.getFormulaStrUID(formulaId, treeLevel)
	return string.format("%s#%s", formulaId, treeLevel)
end

function RoomProductionHelper.getFormulaConfig(formulaId)
	local config = RoomConfig.instance:getFormulaConfig(formulaId)

	if not config then
		logError("RoomProductionHelper:getFormulaConfig Error! config not found: " .. (formulaId or nil))
	end

	return config
end

function RoomProductionHelper.getCostCoinItemList(formulaId)
	local result = {}
	local config = RoomProductionHelper.getFormulaConfig(formulaId)

	if config then
		if string.nilorempty(config.costScore) then
			logWarn("RoomProductionHelper.getCostCoinItemList Warn, formulaConfig.costScore is empty")
		end

		result = RoomProductionHelper.getFormulaItemParamList(config.costScore)
	end

	return result
end

function RoomProductionHelper.getCostMaterialItemList(formulaId)
	local result = {}
	local config = RoomProductionHelper.getFormulaConfig(formulaId)

	if config then
		local strCostMaterial = config.costMaterial

		if not string.nilorempty(config.costMaterial) then
			result = RoomProductionHelper.getFormulaItemParamList(strCostMaterial)
		end
	end

	return result
end

function RoomProductionHelper.getCostMaterialFormulaList(formulaId)
	local result = {}
	local costMaterialItemList = RoomProductionHelper.getCostMaterialItemList(formulaId)

	for _, costItemParam in ipairs(costMaterialItemList) do
		local costItemFormulaId = RoomConfig.instance:getItemFormulaId(costItemParam.type, costItemParam.id)

		table.insert(result, costItemFormulaId)
	end

	return result
end

function RoomProductionHelper.getCostItemListWithFormulaId(formulaId, isIncludeCoin)
	local result = {}
	local costItemList = RoomProductionHelper.getCostMaterialItemList(formulaId)

	if isIncludeCoin then
		local costCoinItemList = RoomProductionHelper.getCostCoinItemList(formulaId)

		for _, costCoinItem in pairs(costCoinItemList) do
			table.insert(costItemList, costCoinItem)
		end
	end

	for _, costItem in ipairs(costItemList) do
		local costItemFormulaId = RoomConfig.instance:getItemFormulaId(costItem.type, costItem.id)
		local costItemData = {
			formulaId = costItemFormulaId,
			type = costItem.type,
			id = costItem.id,
			quantity = costItem.quantity
		}

		table.insert(result, costItemData)
	end

	return result
end

function RoomProductionHelper.isEnoughCoin(formulaId, count)
	local result = true

	if not count or count <= 0 then
		count = 1
	end

	local costCoinItemList = RoomProductionHelper.getCostCoinItemList(formulaId)

	for _, costCoinItem in ipairs(costCoinItemList) do
		local costScore = (costCoinItem.quantity or 0) * count
		local ownQuantity = ItemModel.instance:getItemQuantity(costCoinItem.type, costCoinItem.id)

		if ownQuantity < costScore then
			result = false

			break
		end
	end

	return result
end

function RoomProductionHelper.isEnoughMaterial(formulaId, count)
	local result = true

	if not count or count <= 0 then
		count = 1
	end

	local costMaterialItemList = RoomProductionHelper.getCostMaterialItemList(formulaId)

	for _, costMaterialItem in ipairs(costMaterialItemList) do
		local costCount = costMaterialItem.quantity * count
		local ownQuantity = ItemModel.instance:getItemQuantity(costMaterialItem.type, costMaterialItem.id)

		if ownQuantity < costCount then
			result = false

			break
		end
	end

	return result
end

function RoomProductionHelper.getTopLevelFormulaStrId(formulaStrId)
	local formulaId, treeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(formulaStrId)

	if formulaId and formulaId ~= 0 and treeLevel then
		if treeLevel == RoomFormulaModel.DEFAULT_TREE_LEVEL then
			return formulaStrId
		else
			return (RoomProductionHelper.getFormulaStrUID(formulaId, RoomFormulaModel.DEFAULT_TREE_LEVEL))
		end
	end
end

function RoomProductionHelper.getFormulaProduceItem(formulaId, argsConfig)
	local config = argsConfig or RoomProductionHelper.getFormulaConfig(formulaId)

	if config then
		local produceItemParamList = RoomProductionHelper.getFormulaItemParamList(config.produce)

		if produceItemParamList[1] then
			return produceItemParamList[1]
		else
			logError("RoomProductionHelper.getFormulaProduceItem error, can't find produce")
		end
	end
end

function RoomProductionHelper.getFormulaNeedQuantity(formulaStrId)
	local needQuantity = 0
	local formulaMo = RoomFormulaModel.instance:getFormulaMo(formulaStrId)

	if not formulaMo then
		return needQuantity
	end

	local formulaId = formulaMo:getFormulaId()
	local produceItem = RoomProductionHelper.getFormulaProduceItem(formulaId)

	if not produceItem then
		return needQuantity
	end

	local isTreeFormula = formulaMo:isTreeFormula()

	if isTreeFormula then
		local parentStrId = formulaMo:getParentStrId()
		local parentFormulaMo = RoomFormulaModel.instance:getFormulaMo(parentStrId)

		if parentFormulaMo then
			local oneParentCombineNeedQuantity = 0
			local parentFormulaId = parentFormulaMo:getFormulaId()
			local costMaterialItemList = RoomProductionHelper.getCostMaterialItemList(parentFormulaId)

			for _, costMaterialItem in ipairs(costMaterialItemList) do
				if costMaterialItem.id == produceItem.id then
					oneParentCombineNeedQuantity = costMaterialItem.quantity

					break
				end
			end

			local parentCombineCount = parentFormulaMo:getFormulaCombineCount()

			needQuantity = parentCombineCount * oneParentCombineNeedQuantity
		end
	else
		local recordFarmItem = JumpModel.instance:getRecordFarmItem()

		if recordFarmItem and recordFarmItem.quantity and recordFarmItem.id == produceItem.id then
			needQuantity = recordFarmItem.quantity
		end
	end

	return needQuantity
end

function RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(lineMo)
	local needShowType, needFormulaStrId
	local recordFarmItem = JumpModel.instance:getRecordFarmItem()

	if not recordFarmItem or not recordFarmItem.type or not recordFarmItem.id then
		return needShowType, needFormulaStrId
	end

	local recordFarmItemFormulaId = RoomConfig.instance:getItemFormulaId(recordFarmItem.type, recordFarmItem.id)

	if not recordFarmItemFormulaId or recordFarmItemFormulaId == 0 then
		return needShowType, needFormulaStrId
	end

	local formulaConfig = RoomConfig.instance:getFormulaConfig(recordFarmItemFormulaId)
	local showType = formulaConfig.showType

	if showType and showType ~= 0 then
		local showTypeUnlockLevel = RoomProductionHelper.isFormulaShowTypeUnlock(showType)

		if showTypeUnlockLevel > lineMo.level then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, lineMo.config.name, showTypeUnlockLevel)
		else
			needShowType = showType
		end
	end

	if needShowType then
		local isUnlock, needRoomLevel, needProductionLevel, needEpisodeId = RoomProductionHelper.isFormulaUnlock(recordFarmItemFormulaId, lineMo.level)

		if isUnlock then
			needFormulaStrId = RoomProductionHelper.getFormulaStrUID(recordFarmItemFormulaId, RoomFormulaModel.DEFAULT_TREE_LEVEL)
		elseif needRoomLevel then
			GameFacade.showToast(ToastEnum.ClickRoomFormulaEpisode, needRoomLevel)
		elseif needProductionLevel then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, lineMo.config.name, needProductionLevel)
		elseif needEpisodeId then
			GameFacade.showToast(ToastEnum.ClickRoomFormula)
		end
	end

	if not needFormulaStrId then
		needShowType = nil
	end

	return needShowType, needFormulaStrId
end

function RoomProductionHelper.getTotalCanCombineNum(formulaId)
	local right = 1

	while RoomProductionHelper._canCombineQuantityTimeFormula(nil, formulaId, right) do
		right = right * 2
	end

	local left = 0

	while left <= right do
		local mid = math.floor(left + (right - left) / 2)
		local midCanCombine = RoomProductionHelper._canCombineQuantityTimeFormula(nil, formulaId, mid)
		local addCanCombine = RoomProductionHelper._canCombineQuantityTimeFormula(nil, formulaId, mid + 1)

		if midCanCombine and not addCanCombine then
			return mid
		elseif midCanCombine then
			left = mid + 1
		else
			right = mid - 1
		end
	end

	logError("RoomProductionHelper.getTotalCanCombineNum verify error, result:" .. right .. " formulaId:" .. formulaId)

	return 0
end

function RoomProductionHelper.getEasyCombineFormulaAndCostItemList(formulaId, combineCount, occupyItemDic)
	local produceItemParam = RoomProductionHelper.getFormulaProduceItem(formulaId)

	if not produceItemParam then
		return false
	end

	local resultTable = {
		formulaIdList = {},
		itemTypeDic = {}
	}
	local result = RoomProductionHelper._canCombineQuantityTimeFormula(resultTable, formulaId, combineCount, occupyItemDic)

	table.insert(resultTable.formulaIdList, {
		formulaId = formulaId,
		count = combineCount
	})

	return result, resultTable
end

local function dicAddValueFunc(dic, type, id, value)
	if not dic then
		return
	end

	dic[type] = dic[type] or {}
	dic[type][id] = (dic[type][id] or 0) + (value or 0)
end

function RoomProductionHelper._canCombineQuantityTimeFormula(refTable, formulaId, combineCount, occupyItemDic)
	occupyItemDic = occupyItemDic or {}

	local lineMO = RoomProductionModel.instance:getLineMO(RoomProductLineEnum.Line.Spring)
	local isUnlock = RoomProductionHelper.isFormulaUnlock(formulaId, lineMO and lineMO.level)

	if not isUnlock then
		return false
	end

	local costItemList = RoomProductionHelper.getCostItemListWithFormulaId(formulaId, true)

	if #costItemList <= 0 then
		return false
	end

	local itemTypeDic, formulaIdList

	if refTable then
		itemTypeDic = refTable.itemTypeDic
		formulaIdList = refTable.formulaIdList
	end

	for _, costItem in ipairs(costItemList) do
		local costItemId = costItem.id
		local costItemType = costItem.type

		dicAddValueFunc(occupyItemDic, costItemType, costItemId)

		local ownQuantity = ItemModel.instance:getItemQuantity(costItemType, costItemId)
		local remainOwnQuantity = ownQuantity - occupyItemDic[costItemType][costItemId]

		if remainOwnQuantity < 0 then
			logError("RoomProductionHelper._canCombineQuantityTimeFormula error, remainOwnQuantity is negative:" .. remainOwnQuantity)

			remainOwnQuantity = 0
		end

		local useCount = 0
		local totalNeedCostItemQuantity = costItem.quantity * combineCount
		local leftCount = remainOwnQuantity - totalNeedCostItemQuantity

		if leftCount < 0 then
			local costItemFormulaId = costItem.formulaId

			if not costItemFormulaId or costItemFormulaId == 0 then
				return false
			end

			local costItemNeedCount = math.abs(leftCount)
			local costItemCombineResult = RoomProductionHelper._canCombineQuantityTimeFormula(refTable, costItem.formulaId, costItemNeedCount, occupyItemDic)

			if not costItemCombineResult then
				return false
			end

			if formulaIdList then
				table.insert(formulaIdList, {
					formulaId = costItemFormulaId,
					count = costItemNeedCount
				})
			end

			useCount = remainOwnQuantity
		else
			useCount = totalNeedCostItemQuantity
		end

		dicAddValueFunc(itemTypeDic, costItemType, costItemId, useCount)
		dicAddValueFunc(occupyItemDic, costItemType, costItemId, useCount)
	end

	return true
end

function RoomProductionHelper.canEasyCombineItems(itemDataList, occupyItemDic)
	if not itemDataList then
		return false
	end

	local isOpenRoom = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	if not isOpenRoom then
		return false
	end

	local isUnlockLine = RoomProductionHelper.hasUnlockLine(RoomProductLineEnum.ProductItemType.Change)

	if not isUnlockLine then
		return false
	end

	local result = false
	local resultTable
	local targetFormulaList = {}
	local lineMO = RoomProductionModel.instance:getLineMO(RoomProductLineEnum.Line.Spring)
	local lineLevel = lineMO.level

	for _, itemData in ipairs(itemDataList) do
		local formulaId = RoomConfig.instance:getItemFormulaId(itemData.type, itemData.id)
		local isUnlock = RoomProductionHelper.isFormulaUnlock(formulaId, lineLevel)

		if not isUnlock then
			return result
		end

		targetFormulaList[#targetFormulaList + 1] = {
			formulaId = formulaId,
			count = itemData.quantity
		}
	end

	local var_43_0, var_43_1 = RoomProductionHelper.getEasyCombineFormulaListAndCostItemList(targetFormulaList, occupyItemDic)

	result = var_43_0

	return var_43_0, var_43_1
end

function RoomProductionHelper.getEasyCombineFormulaListAndCostItemList(targetFormulaList, occupyItemDic)
	if not targetFormulaList or #targetFormulaList <= 0 then
		return false
	end

	local result = true
	local formulaIdDic = {}
	local formulaIndexDict = {}
	local itemTypeDic = {}

	occupyItemDic = occupyItemDic or {}

	for _, formulaData in ipairs(targetFormulaList) do
		local formulaId = formulaData.formulaId
		local combineCount = formulaData.count
		local tmpResult, tmpResultTable = RoomProductionHelper.getEasyCombineFormulaAndCostItemList(formulaId, combineCount, occupyItemDic)

		if not tmpResult then
			result = false

			break
		end

		for i, needFormula in ipairs(tmpResultTable.formulaIdList) do
			local needChildFormulaId = needFormula.formulaId
			local needChildFormulaCount = needFormula.count

			formulaIdDic[needChildFormulaId] = (formulaIdDic[needChildFormulaId] or 0) + (needChildFormulaCount or 0)

			if not formulaIndexDict[needChildFormulaId] or i < formulaIndexDict[needChildFormulaId] then
				formulaIndexDict[needChildFormulaId] = i
			end
		end

		for costItemType, itemDict in pairs(tmpResultTable.itemTypeDic) do
			for costItemId, useCount in pairs(itemDict) do
				dicAddValueFunc(itemTypeDic, costItemType, costItemId, useCount)
			end
		end
	end

	local resultTable

	if result then
		local formulaIdList = {}

		for needFormulaId, needCount in pairs(formulaIdDic) do
			formulaIdList[#formulaIdList + 1] = {
				formulaId = needFormulaId,
				count = needCount
			}
		end

		table.sort(formulaIdList, function(a, b)
			local aCfg = RoomConfig.instance:getFormulaConfig(a.formulaId)
			local bCfg = RoomConfig.instance:getFormulaConfig(b.formulaId)
			local aRare = aCfg and aCfg.rare
			local bRare = bCfg and bCfg.rare

			if aRare ~= bRare then
				return aRare < bRare
			end

			local aIndex = formulaIndexDict[a.formulaId]
			local bIndex = formulaIndexDict[b.formulaId]

			return aIndex < bIndex
		end)

		resultTable = {
			formulaIdList = formulaIdList,
			itemTypeDic = itemTypeDic
		}
	end

	return result, resultTable
end

function RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(strUID)
	local formulaId = 0
	local treeLevel = RoomFormulaModel.DEFAULT_TREE_LEVEL

	if not strUID then
		logError("RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel error, strId nil")

		return formulaId, treeLevel
	end

	local formulaIdAndTreeLevel = string.splitToNumber(strUID, "#")

	if not formulaIdAndTreeLevel[1] or not formulaIdAndTreeLevel[2] then
		logError("RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel format error,id:" .. strUID .. " must be formulaId#treeLevel")

		return formulaId, treeLevel
	end

	formulaId = formulaIdAndTreeLevel[1]
	treeLevel = formulaIdAndTreeLevel[2]

	return formulaIdAndTreeLevel[1], formulaIdAndTreeLevel[2]
end

function RoomProductionHelper.formatItemNum(num)
	return num > 99 and "99+" or tostring(num)
end

function RoomProductionHelper.openRoomFormulaMsgBoxView(costItemAndFormulaIdList, produceDataList, lineId, cb, cbObj, combineCb, combineCbObj)
	local param = {}

	param.costItemAndFormulaIdList = costItemAndFormulaIdList
	param.produceDataList = produceDataList
	param.lineId = lineId
	param.callback = cb
	param.callbackObj = cbObj
	param.combineCb = combineCb
	param.combineCbObj = combineCbObj

	ViewMgr.instance:openView(ViewName.RoomFormulaMsgBoxView, param)
end

return RoomProductionHelper
