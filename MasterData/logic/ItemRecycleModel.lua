-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/model/ItemRecycleModel.lua

module("logic.extensions.itembag.model.ItemRecycleModel", package.seeall)

local ItemRecycleModel = class("ItemRecycleModel", BaseModel)

function ItemRecycleModel:onInit()
	self:onReset()
end

function ItemRecycleModel:onReset()
	self._convertTimesList = {}
	self._convertTimesMap = {}

	local expStr = EquipmentConfig.instance:getCommonValue("UPGRADE_MATERIAL_EXPS")
	local itemIdsStr = EquipmentConfig.instance:getCommonValue("UPGRADE_MATERIAL_IDS")

	self.equipExpArr = string.splitToNumber(expStr, ",")
	self.equipItems = string.splitToNumber(itemIdsStr, ",")
end

function ItemRecycleModel:updateTodayTimes(list)
	self._convertTimesList = GameUtil.pbToTable(list) or {}
	self._convertTimesMap = {}

	for i, v in ipairs(self._convertTimesList) do
		local materialType = v.materialType
		local realCostQuality = v.realCostQuality

		self._convertTimesMap[materialType] = self._convertTimesMap[materialType] or {}
		self._convertTimesMap[materialType][realCostQuality] = v.times
	end
end

function ItemRecycleModel:getTotalTimes(type, quality)
	if self._convertTimesMap[type] then
		return checknumber(self._convertTimesMap[type][quality])
	end

	return 0
end

function ItemRecycleModel:getCurQualityMap()
	local map = {}
	local baseList = ItemRecycleConfig.instance:getQualityBaseList()

	for i, v in ipairs(baseList) do
		local materialType = v.materialType
		local realCostQuality = v.realCostQuality

		map[materialType] = map[materialType] or {}
		map[materialType][realCostQuality] = v
	end

	local activityList = ItemRecycleConfig.instance:getQualityActivityList()

	for i, v in ipairs(activityList) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			local materialType = v.materialType
			local realCostQuality = v.realCostQuality

			map[materialType] = map[materialType] or {}
			map[materialType][realCostQuality] = v
		end
	end

	return map
end

function ItemRecycleModel:getCurBaseMap()
	local map = {}
	local baseList = ItemRecycleConfig.instance:getBaseList()

	for i, v in ipairs(baseList) do
		local materialType = v.materialType
		local defineId = v.defineId

		map[materialType] = map[materialType] or {}
		map[materialType][defineId] = v
	end

	local activityList = ItemRecycleConfig.instance:getActivityList()

	for i, v in ipairs(activityList) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			local materialType = v.materialType
			local defineId = v.defineId

			map[materialType] = map[materialType] or {}
			map[materialType][defineId] = v
		end
	end

	return map
end

function ItemRecycleModel:GetRecycleEquipList(attrs)
	local map = self:getCurQualityMap()

	if not map[MatType.Equipment] then
		local allEquipInfoList = MaterialMgr.getModelList(MatType.Equipment) or {}
		local idxMap = {}
		local resultList = {}
		local index = 0

		for _, item in pairs(allEquipInfoList) do
			index = index + 1

			if PetEquipModel.instance:_isConformEquipSifter(item, attrs) and item and not item.isWear and map[MatType.Equipment][item.quality] and item:GetEquipExclRaceId() == 0 then
				if item.haveAllExp == 0 then
					local idx = idxMap[item.baseId]

					if idx == nil then
						local data = {}

						data.key = item.quality
						data.item = item
						data.itemList = {}

						table.insert(data.itemList, item)
						table.insert(resultList, data)

						data.index = index
						data.totalCount = #data.itemList
						idxMap[item.baseId] = #resultList
					else
						local data = resultList[idx]

						table.insert(data.itemList, item)

						data.totalCount = #data.itemList
					end
				else
					local data = {}

					data.key = item.quality
					data.item = item
					data.itemList = {}

					table.insert(data.itemList, item)
					table.insert(resultList, data)

					data.totalCount = #data.itemList
					data.index = index
				end
			end
		end

		ArraySort.sortOn(resultList, {
			function(data)
				return data.item.quality
			end,
			function(data)
				return data.item.baseId
			end,
			function(data)
				return data.item.onlyId
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		return resultList, map
	end
end

function ItemRecycleModel:GetRecycleThroneList()
	local map = self:getCurQualityMap()

	if not map[MatType.Throne] then
		local allInfoList = MaterialMgr.getModelList(MatType.Throne) or {}
		local resultList = {}
		local index = 0

		for _, throneMo in ipairs(allInfoList) do
			index = index + 1

			if throneMo then
				local cfg = ThroneConfig.instance:getThroneCfg(throneMo:getDefineId())

				if cfg and map[MatType.Throne][cfg.quality] and throneMo:GetCount() >= 1 then
					local allCfgs = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)

					if allCfgs and #allCfgs <= throneMo:getLevel() then
						local data = {}

						data.key = throneMo.quality
						data.item = throneMo
						data.itemList = {}

						table.insert(data.itemList, throneMo)

						data.totalCount = throneMo:GetCount()

						table.insert(resultList, data)

						data.index = index
					end
				end
			end
		end

		ArraySort.sortOn(resultList, {
			function(data)
				return data.item.quality
			end,
			function(data)
				return data.item.id
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		return resultList, map
	end
end

function ItemRecycleModel:GetRecycleHolyStripeList(selectList)
	local map = self:getCurQualityMap()

	if not map[MatType.HolyStripe] then
		local qualityMap = {}
		local allInfoList = HolyStripeModel.instance:getAllHolyStripeMo() or {}
		local resultList = {}
		local index = 0

		if selectList then
			if not selectList[GameEnum.HolyStripeSelectType.Pos] then
				local posFilterId

				if selectList then
					if not selectList[GameEnum.HolyStripeSelectType.Suit] then
						local suitFilterId

						if selectList then
							if not selectList[GameEnum.HolyStripeSelectType.AttrType] then
								local attrFilterIds

								if selectList then
									if not selectList[GameEnum.HolyStripeSelectType.Status] then
										local statusFilterIds

										for _, mo in ipairs(allInfoList) do
											index = index + 1

											local isMatch, isMatchPos, isMatchSuit, isMatchAttr, isMatchStatus = false, false, false, false, false

											if checknumber(mo:getEquipPetId()) <= 0 and checknumber(mo:getExp()) <= 0 then
												if posFilterId or suitFilterId or attrFilterIds or statusFilterIds then
													isMatchPos = posFilterId and mo:getPosType() == posFilterId or true
													isMatchSuit = suitFilterId and mo:getSuitType() == suitFilterId or true

													if not TableUtil.isTableEmpty(attrFilterIds) then
														local attrParams = mo:getAttrsToCommon()
														local matchCount = 0

														for i, filterId in ipairs(attrFilterIds) do
															for _, attr in ipairs(attrParams) do
																if filterId == attr.id then
																	matchCount = matchCount + 1

																	break
																end
															end
														end

														isMatchAttr = matchCount == #attrFilterIds
													else
														isMatchAttr = true
													end

													if not TableUtil.isTableEmpty(statusFilterIds) then
														local matchStatusCount = 0

														for _, statusFilterId in ipairs(statusFilterIds) do
															if statusFilterId == GameEnum.HolyStripeStatusFilterType.Discard and mo:getIsReadyToDiscard() == true then
																matchStatusCount = matchStatusCount + 1
															end
														end

														isMatchStatus = matchStatusCount == #statusFilterIds
													else
														isMatchStatus = true
													end

													isMatch = isMatchPos and isMatchSuit and isMatchAttr and isMatchStatus
												else
													isMatch = true
												end

												if isMatch then
													local quality = mo:getQuality()

													if qualityMap[quality] then
														local data = {}

														data.key = mo.quality
														data.item = mo
														data.itemList = {}
														data.index = index

														table.insert(data.itemList, mo)
														table.insert(resultList, data)

														data.totalCount = #data.itemList
													end
												end
											end
										end

										ArraySort.sortOn(resultList, {
											function(data)
												return data.item:getQuality()
											end,
											function(data)
												return data.item.id
											end,
											function(data)
												return data.item:getIsLock()
											end
										}, {
											ArraySort.NUMERIC,
											ArraySort.NUMERIC,
											ArraySort.NUMERIC
										})

										return resultList, map
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

function ItemRecycleModel:GetRecycleItemsList()
	local map = self:getCurBaseMap()

	if not map[MatType.Item] then
		local allInfoList = MaterialMgr.getModelList(MatType.Item) or {}
		local resultList = {}
		local index = 0

		for _, mo in ipairs(allInfoList) do
			index = index + 1

			if map[MatType.Item][mo.id] then
				local data = {}

				data.key = mo.id
				data.item = mo
				data.itemList = {}

				table.insert(data.itemList, mo)

				data.totalCount = mo:GetCount()

				table.insert(resultList, data)

				data.index = index
			end
		end

		ArraySort.sortOn(resultList, {
			function(data)
				return data.item.quality
			end,
			function(data)
				return data.item.id
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		return resultList, map
	end
end

ItemRecycleModel.instance = ItemRecycleModel.New()

return ItemRecycleModel
