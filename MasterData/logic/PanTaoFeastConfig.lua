-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/config/PanTaoFeastConfig.lua

module("logic.extensions.pantaofeast.config.PanTaoFeastConfig", package.seeall)

local PanTaoFeastConfig = class("PanTaoFeastConfig", BaseConfig)

function PanTaoFeastConfig:onInit()
	PanTaoFeastConfig.super.onInit(self)
end

function PanTaoFeastConfig:getNames()
	return {
		"pan_tao_feast_activity",
		"pan_tao_feast_book_prize",
		"pan_tao_feast_building",
		"pan_tao_feast_daily_gift",
		"pan_tao_feast_element",
		"pan_tao_feast_order",
		"pan_tao_feast_produce_drop",
		"pan_tao_feast_rank_prize",
		"pan_tao_feast_recipe",
		"pan_tao_feast_round",
		"pan_tao_feast_stash",
		"pan_tao_feast_spine_model"
	}
end

function PanTaoFeastConfig:handleConfig(name, content)
	if name == "pan_tao_feast_order" then
		self._pan_tao_feast_order = content

		self:_handleOrderCfgs()
	elseif name == "pan_tao_feast_daily_gift" then
		self._pan_tao_feast_daily_gift = content
	elseif name == "pan_tao_feast_produce_drop" then
		self._pan_tao_feast_produce_drop = content

		self:_handleProduceDropCfgs()
	elseif name == "pan_tao_feast_rank_prize" then
		self._pan_tao_feast_rank_prize = content
	elseif name == "pan_tao_feast_recipe" then
		self._pan_tao_feast_recipe = content

		self:_handleRecipeCfgs()
	elseif name == "pan_tao_feast_round" then
		self._pan_tao_feast_round = content
	elseif name == "pan_tao_feast_stash" then
		self._pan_tao_feast_stash = content

		self:_handleStashCfgs()
	elseif name == "pan_tao_feast_activity" then
		self._pan_tao_feast_activity = content
	elseif name == "pan_tao_feast_book_prize" then
		self._pan_tao_feast_book_prize = content

		self:_handleBookPrizeCfgs()
	elseif name == "pan_tao_feast_element" then
		self._pan_tao_feast_element = content

		self:_handleElementCfgs()
	elseif name == "pan_tao_feast_building" then
		self._pan_tao_feast_building = content
	elseif name == "pan_tao_feast_spine_model" then
		self._pan_tao_feast_spine_model = content
	end
end

function PanTaoFeastConfig:_safeGet(data, ...)
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

function PanTaoFeastConfig:getActivityCfg(activityId)
	return self:_safeGet(self._pan_tao_feast_activity, activityId)
end

function PanTaoFeastConfig:getBuildingCfgs(activityId)
	return self:_safeGet(self._pan_tao_feast_building, activityId)
end

function PanTaoFeastConfig:getRankPrizeCfgs(activityId)
	return self:_safeGet(self._pan_tao_feast_rank_prize, activityId)
end

function PanTaoFeastConfig:getRankPrizeCfgByRank(activityId, rank)
	local rankPrizeCfgs = self:getRankPrizeCfgs(activityId)

	if not rankPrizeCfgs then
		return nil
	end

	for _, cfg in pairs(rankPrizeCfgs) do
		local rankRange = cfg.rankRange

		if rankRange and #rankRange == 2 then
			local minRank, maxRank = rankRange[1], rankRange[2]

			if minRank <= rank and rank <= maxRank then
				return cfg
			end
		end
	end

	return nil
end

function PanTaoFeastConfig:getProduceDropCfgsByWorkshop(activityId, toolElementId)
	return self:_safeGet(self._pan_tao_feast_produce_drop, activityId, toolElementId)
end

function PanTaoFeastConfig:_handleProduceDropCfgs()
	local datalist = self._pan_tao_feast_produce_drop.dataList

	self._toolIdsByActIdAndElementId = {}

	for _, cfg in ipairs(datalist) do
		local activityId = cfg.activityId
		local dropElementId = cfg.dropElementId
		local toolElementId = cfg.toolElementId

		if not self._toolIdsByActIdAndElementId[activityId] then
			if not self._toolIdsByActIdAndElementId[activityId][dropElementId] then
				local toolIds = {}

				table.insert(toolIds, toolElementId)

				self._toolIdsByActIdAndElementId[activityId][dropElementId] = toolIds
				self._toolIdsByActIdAndElementId[activityId] = self._toolIdsByActIdAndElementId[activityId]
			end
		end
	end

	for activityId, elementMap in pairs(self._toolIdsByActIdAndElementId) do
		for elementId, toolIds in pairs(elementMap) do
			table.sort(toolIds, function(a, b)
				local aCfg = self:getElementCfgByElementId(activityId, a)
				local bCfg = self:getElementCfgByElementId(activityId, b)

				if aCfg and bCfg then
					return aCfg.level < bCfg.level
				end

				return false
			end)
		end
	end
end

function PanTaoFeastConfig:getProduceDropToolIdsByElementId(activityId, elementId)
	return self:_safeGet(self._toolIdsByActIdAndElementId, activityId, elementId)
end

function PanTaoFeastConfig:getElementCfgs(activityId)
	return self:_safeGet(self._pan_tao_feast_element, activityId)
end

function PanTaoFeastConfig:getRecipeCfgs(activityId)
	return self:_safeGet(self._pan_tao_feast_recipe, activityId)
end

function PanTaoFeastConfig:_handleRecipeCfgs()
	self._recipesByToolId = {}
	self._recipeMapByDishId = {}
	self._recipeMapByCombination = {}
	self._toolIsUseMapByElementId = {}

	for _, cfg in ipairs(self._pan_tao_feast_recipe.dataList) do
		local activityId = cfg.activityId
		local cookToolId = cfg.cookToolId
		local dishElementId = cfg.dishElementId

		if not cfg.materialElementIds then
			if not self._recipesByToolId[activityId] then
				local recipesByToolId = {}

				if not self._recipeMapByDishId[activityId] then
					local dishMap = {}
					local combinationKey = self:getSortedListKeyStr(cfg.materialElementIds)

					if not self._recipeMapByCombination[activityId] then
						if not recipesByToolId[cookToolId] then
							local toolRecipeList = {}

							table.insert(toolRecipeList, cfg)

							recipesByToolId[cookToolId] = toolRecipeList
							dishMap[dishElementId] = cfg
							self._recipeMapByCombination[activityId][combinationKey] = cfg
							self._recipesByToolId[activityId] = recipesByToolId
							self._recipeMapByDishId[activityId] = dishMap
							self._recipeMapByCombination[activityId] = self._recipeMapByCombination[activityId]

							if not self._toolIsUseMapByElementId[activityId] then
								if not self._toolIsUseMapByElementId[activityId][cookToolId] then
									local toolIsUseMap = {}

									for _, materialId in ipairs(cfg.materialElementIds) do
										toolIsUseMap[materialId] = true
									end

									self._toolIsUseMapByElementId[activityId][cookToolId] = toolIsUseMap
									self._toolIsUseMapByElementId[activityId] = self._toolIsUseMapByElementId[activityId]
								end
							end
						end
					end
				end
			end
		end
	end
end

function PanTaoFeastConfig:getSortedListKeyStr(list)
	if not list or #list == 0 then
		return ""
	end

	local sortedList = {}

	for _, v in ipairs(list) do
		table.insert(sortedList, v)
	end

	table.sort(sortedList)

	return (table.concat(sortedList, "_"))
end

function PanTaoFeastConfig:getRecipeCfgsByTool(activityId, cookToolId)
	return self:_safeGet(self._recipesByToolId, activityId, cookToolId)
end

function PanTaoFeastConfig:getRecipeCfgByDishId(activityId, dishElementId)
	return self:_safeGet(self._recipeMapByDishId, activityId, dishElementId)
end

function PanTaoFeastConfig:getRecipeCfgByCombination(activityId, combination)
	combination = combination or {}

	local combinationKey = self:getSortedListKeyStr(combination)

	if not combinationKey or combinationKey == "" then
		return nil
	end

	return self:_safeGet(self._recipeMapByCombination, activityId, combinationKey)
end

function PanTaoFeastConfig:isToolCanUseMaterial(activityId, cookToolId, materialElementId)
	local toolIsUseMap = self:_safeGet(self._toolIsUseMapByElementId, activityId, cookToolId)

	if toolIsUseMap then
		return toolIsUseMap[materialElementId] == true
	end

	return false
end

function PanTaoFeastConfig:getElementCfgByElementId(activityId, elementId)
	return self:_safeGet(self._pan_tao_feast_element, activityId, elementId)
end

function PanTaoFeastConfig:_handleElementCfgs()
	self._elementChainNodeByActId = {}

	for _, cfg in pairs(self._pan_tao_feast_element.dataList) do
		local activityId = cfg.activityId
		local elementId = cfg.elementId
		local nextElementId = cfg.nextElementId

		if not self._elementChainNodeByActId[activityId] then
			local chainNodeMap = {}
			local chainNode = chainNodeMap[elementId]

			if not chainNode then
				chainNode = {
					cfg = cfg
				}
				chainNode.prev = nil
				chainNode.next = nil
				chainNode.root = nil
			end

			chainNodeMap[elementId] = chainNode

			if nextElementId and nextElementId ~= 0 then
				local nextChainNode = chainNodeMap[nextElementId]

				if not nextChainNode then
					nextChainNode = {
						cfg = self:getElementCfgByElementId(activityId, nextElementId)
					}
					nextChainNode.prev = nil
					nextChainNode.next = nil
					nextChainNode.root = nil
				end

				nextChainNode.prev = chainNode
				chainNode.next = nextChainNode
				chainNodeMap[nextElementId] = nextChainNode
			end

			self._elementChainNodeByActId[activityId] = chainNodeMap
		end
	end

	for activityId, chainNodeMap in pairs(self._elementChainNodeByActId) do
		for _, chainNode in pairs(chainNodeMap) do
			if not chainNode.root then
				local current = chainNode

				while current.prev do
					current = current.prev
				end

				local rootNode = current

				current = chainNode

				while current do
					current.root = rootNode
					current = current.next
				end
			end
		end
	end

	for activityId, chainNodeMap in pairs(self._elementChainNodeByActId) do
		for _, chainNode in pairs(chainNodeMap) do
			if chainNode.root then
				local rootNode = chainNode.root

				if not rootNode.chainList then
					rootNode.chainList = {}

					local current = rootNode

					while current do
						table.insert(rootNode.chainList, current)

						current = current.next
					end
				end
			end
		end
	end
end

function PanTaoFeastConfig:getElementChainNodeByElementId(activityId, elementId)
	return self:_safeGet(self._elementChainNodeByActId, activityId, elementId)
end

function PanTaoFeastConfig:getNextElementCfgByElementId(activityId, elementId)
	local chainNode = self:getElementChainNodeByElementId(activityId, elementId)

	if chainNode and chainNode.next then
		return chainNode.next.cfg
	end

	return nil
end

function PanTaoFeastConfig:getElementChainListByElementId(activityId, elementId)
	local chainNode = self:getElementChainNodeByElementId(activityId, elementId)

	if chainNode and chainNode.root then
		return chainNode.root.chainList
	end

	return nil
end

function PanTaoFeastConfig:getRootElementIdByElementId(activityId, elementId)
	local chainNode = self:getElementChainNodeByElementId(activityId, elementId)

	if chainNode and chainNode.root then
		return chainNode.root.cfg.elementId
	end

	return nil
end

function PanTaoFeastConfig:getBookPrizeCfgByElementId(activityId, elementId)
	return self:_safeGet(self._pan_tao_feast_book_prize, activityId, elementId)
end

function PanTaoFeastConfig:_handleBookPrizeCfgs()
	self._bookPrizeDataByActIdAndSubType = {}

	for _, cfg in ipairs(self._pan_tao_feast_book_prize.dataList) do
		local activityId = cfg.activityId
		local subType = cfg.subType

		if not self._bookPrizeDataByActIdAndSubType[activityId] then
			local subTypeMap = {}
			local bookPrizeData = subTypeMap[subType]

			if not bookPrizeData then
				bookPrizeData = {
					subType = subType,
					prizeList = {},
					subTitle = cfg.subTitle
				}
				subTypeMap[subType] = bookPrizeData
			end

			local prizeList = bookPrizeData.prizeList

			table.insert(prizeList, cfg)

			subTypeMap[subType] = bookPrizeData
			self._bookPrizeDataByActIdAndSubType[activityId] = subTypeMap
		end
	end
end

function PanTaoFeastConfig:getAllBookPrizeDataByActId(activityId)
	local list = {}
	local subTypeMap = self:_safeGet(self._bookPrizeDataByActIdAndSubType, activityId)

	if subTypeMap then
		for _, data in pairs(subTypeMap) do
			table.insert(list, data)
		end

		table.sort(list, function(a, b)
			return tonumber(a.subType) < tonumber(b.subType)
		end)
	end

	return list
end

function PanTaoFeastConfig:getStashCfg(activityId, stashId)
	return self:_safeGet(self._pan_tao_feast_stash, activityId, stashId)
end

function PanTaoFeastConfig:_handleStashCfgs()
	local datalist = self._pan_tao_feast_stash.dataList

	self._toolTypeStashCfgsByActId = {}
	self._backpackStashCfgsByActId = {}

	for _, cfg in ipairs(datalist) do
		local activityId = cfg.activityId
		local dealType = cfg.dealType

		if dealType == PanTaoFeastEnum.StashType.Tool then
			if not self._toolTypeStashCfgsByActId[activityId] then
				local toolStashs = {}

				table.insert(toolStashs, cfg)

				self._toolTypeStashCfgsByActId[activityId] = toolStashs
			end
		elseif dealType == PanTaoFeastEnum.StashType.Backpack then
			if not self._backpackStashCfgsByActId[activityId] then
				local backpackStashs = {}

				table.insert(backpackStashs, cfg)

				self._backpackStashCfgsByActId[activityId] = backpackStashs
			end
		end
	end
end

function PanTaoFeastConfig:getToolStashCfgs(activityId)
	return self:_safeGet(self._toolTypeStashCfgsByActId, activityId)
end

function PanTaoFeastConfig:getDailyGiftCfg(activityId, giftId)
	return self:_safeGet(self._pan_tao_feast_daily_gift, activityId, giftId)
end

function PanTaoFeastConfig:getOrderCfg(activityId, orderId)
	return self:_safeGet(self._pan_tao_feast_order, activityId, orderId)
end

function PanTaoFeastConfig:_handleOrderCfgs()
	local datalist = self._pan_tao_feast_order.dataList

	self._orderCfgsByActIdAndRoundId = {}

	for _, cfg in ipairs(datalist) do
		local activityId = cfg.activityId
		local roundId = cfg.roundId

		if not self._orderCfgsByActIdAndRoundId[activityId] then
			if not self._orderCfgsByActIdAndRoundId[activityId][roundId] then
				local orderList = {}

				table.insert(orderList, cfg)

				self._orderCfgsByActIdAndRoundId[activityId][roundId] = orderList
				self._orderCfgsByActIdAndRoundId[activityId] = self._orderCfgsByActIdAndRoundId[activityId]
			end
		end
	end
end

function PanTaoFeastConfig:getRoundCfgs(activityId)
	return self:_safeGet(self._orderCfgsByActIdAndRoundId, activityId)
end

function PanTaoFeastConfig:getOrderCfgsByRound(activityId, roundId)
	return self:_safeGet(self._orderCfgsByActIdAndRoundId, activityId, roundId)
end

function PanTaoFeastConfig:getAllSpineModelCfgsByPlanId(planId)
	return self:_safeGet(self._pan_tao_feast_spine_model, planId)
end

function PanTaoFeastConfig:getRoundPrizeCfg(activityId, roundId)
	return self:_safeGet(self._pan_tao_feast_round, activityId, roundId)
end

PanTaoFeastConfig.instance = PanTaoFeastConfig.New()

return PanTaoFeastConfig
