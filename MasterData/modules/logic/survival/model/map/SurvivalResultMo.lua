-- chunkname: @modules/logic/survival/model/map/SurvivalResultMo.lua

module("modules.logic.survival.model.map.SurvivalResultMo", package.seeall)

local SurvivalResultMo = pureTable("SurvivalResultMo")

function SurvivalResultMo:init(data)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	self.isWin = data.isWin
	self.copyId = sceneMo.groupId
	self.mapId = sceneMo.mapId
	self.percentageLoss = data.percentageLoss / 10
	self.totalGameTime = data.totalGameTime
	self.reason = data.reason
	self.teamInfo = SurvivalTeamInfoMo.New()

	self.teamInfo:init(data.teamInfo)

	self.npcDropTips = data.npcDropTips

	local bag = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Map)

	self.firstItems = {}
	self.firstNpcs = {}
	self.firstNpcMos = nil

	local uidToItemIndex = {}
	local uidToNpcIndex = {}

	for _, itemMo in ipairs(bag.items) do
		if itemMo.co.isDestroy ~= 1 or not string.nilorempty(itemMo.co.exchange) then
			itemMo.source = SurvivalEnum.ItemSource.None

			if itemMo:isNPC() then
				table.insert(self.firstNpcs, itemMo)
			elseif itemMo:isCurrency() then
				-- block empty
			else
				table.insert(self.firstItems, itemMo)
			end
		end
	end

	SurvivalBagSortHelper.sortItems(self.firstItems, SurvivalEnum.ItemSortType.Result, true)

	for index, itemMo in ipairs(self.firstItems) do
		uidToItemIndex[itemMo.uid] = index
	end

	for index, itemMo in ipairs(self.firstNpcs) do
		uidToNpcIndex[itemMo.uid] = index
	end

	self.beforeChanges = {}
	self.beforeCurrencyItems = {}

	for _, v in ipairs(data.beforeChangeItem) do
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init(v)

		if itemMo:isNPC() then
			if uidToNpcIndex[itemMo.uid] then
				uidToNpcIndex[itemMo.uid] = nil
			else
				logError("结算的时候，多出来一个NPC:" .. itemMo.co.name)
				table.insert(self.firstNpcs, itemMo)
			end
		elseif itemMo:isCurrency() then
			self.beforeCurrencyItems[itemMo.id] = itemMo.count
		else
			local index = uidToItemIndex[itemMo.uid]

			if index then
				local preItemMo = self.firstItems[index]

				if preItemMo.count ~= itemMo.count then
					self.beforeChanges[preItemMo.uid] = itemMo
				end

				uidToItemIndex[itemMo.uid] = nil
			else
				logError("结算的时候，多出来一个道具:" .. itemMo.co.name)
				table.insert(self.firstItems, itemMo)
			end
		end
	end

	for uid, index in pairs(uidToNpcIndex) do
		self.beforeChanges[uid] = SurvivalBagItemMo.Empty
	end

	for uid, index in pairs(uidToItemIndex) do
		self.beforeChanges[uid] = SurvivalBagItemMo.Empty
	end

	self.haveChange1 = not not next(self.beforeChanges)
	self.beforeItems = self.firstItems
	self.beforeNpcs = self.firstNpcs

	if self.haveChange1 then
		self.beforeItems = {}
		self.beforeNpcs = {}

		for _, itemMo in ipairs(self.firstItems) do
			local changeTo = self.beforeChanges[itemMo.uid]

			if not changeTo then
				table.insert(self.beforeItems, itemMo)
			elseif not changeTo:isEmpty() then
				table.insert(self.beforeItems, changeTo)
			end
		end

		for _, itemMo in ipairs(self.firstNpcs) do
			local changeTo = self.beforeChanges[itemMo.uid]

			if not changeTo then
				table.insert(self.beforeNpcs, itemMo)
			elseif not changeTo:isEmpty() then
				table.insert(self.beforeNpcs, changeTo)
			end
		end
	end

	uidToNpcIndex = {}
	uidToItemIndex = {}

	for index, itemMo in ipairs(self.beforeItems) do
		uidToItemIndex[itemMo.uid] = index
	end

	for index, itemMo in ipairs(self.beforeNpcs) do
		uidToNpcIndex[itemMo.uid] = index
	end

	self.afterChanges = {}
	self.afterItems = {}
	self.afterNpcs = {}
	self.afterCurrencyItems = {}
	self.afterItemWorth = 0

	local afterItems = {}

	for _, v in ipairs(data.afterChangeItem) do
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init(v)

		if itemMo:isNPC() then
			if uidToNpcIndex[itemMo.uid] then
				uidToNpcIndex[itemMo.uid] = nil
			else
				logError("转换货币的时候，多出来一个NPC:" .. itemMo.co.name)
			end
		elseif itemMo:isCurrency() then
			self.afterCurrencyItems[itemMo.id] = not self.afterCurrencyItems[itemMo.id] and itemMo.count or self.afterCurrencyItems[itemMo.id] + itemMo.count
		else
			local index = uidToItemIndex[itemMo.uid]

			if index then
				local preItemMo = self.beforeItems[index]

				if preItemMo.count ~= itemMo.count then
					self.afterChanges[preItemMo.uid] = itemMo
				end

				uidToItemIndex[itemMo.uid] = nil
			else
				logError("转换货币的时候，多出来一个道具:" .. itemMo.co.name)
				table.insert(afterItems, itemMo)
			end

			self.afterItemWorth = self.afterItemWorth + itemMo.count * itemMo.co.worth
		end
	end

	for uid, index in pairs(uidToNpcIndex) do
		self.afterChanges[uid] = SurvivalBagItemMo.Empty
	end

	for uid, index in pairs(uidToItemIndex) do
		self.afterChanges[uid] = SurvivalBagItemMo.Empty
	end

	self.haveChange2 = not not next(self.afterChanges)
	self.afterItems = self.beforeItems
	self.afterNpcs = self.beforeNpcs

	if self.haveChange2 then
		self.afterItems = {}
		self.afterNpcs = {}

		for _, itemMo in ipairs(self.beforeItems) do
			local changeTo = self.afterChanges[itemMo.uid]

			if not changeTo then
				table.insert(self.afterItems, itemMo)
			elseif not changeTo:isEmpty() then
				table.insert(self.afterItems, changeTo)
			end
		end

		for _, itemMo in ipairs(self.beforeNpcs) do
			local changeTo = self.afterChanges[itemMo.uid]

			if not changeTo then
				table.insert(self.afterNpcs, itemMo)
			elseif not changeTo:isEmpty() then
				table.insert(self.afterNpcs, changeTo)
			end
		end
	end

	tabletool.addValues(self.afterItems, afterItems)
	SurvivalHelper.instance:makeArrFull(self.firstItems, SurvivalBagItemMo.Empty, #self.firstNpcs > 0 and 4 or 5, 6)
	SurvivalHelper.instance:makeArrFull(self.beforeItems, SurvivalBagItemMo.Empty, #self.firstNpcs > 0 and 4 or 5, 6)
	SurvivalHelper.instance:makeArrFull(self.afterItems, SurvivalBagItemMo.Empty, #self.firstNpcs > 0 and 4 or 5, 6)
end

function SurvivalResultMo:getFirstNpcMos()
	if not self.firstNpcMos then
		self.firstNpcMos = {}

		for i, itemMo in ipairs(self.afterNpcs) do
			local npcMo = SurvivalShelterNpcMo.New()

			npcMo:init({
				id = itemMo.id
			})
			table.insert(self.firstNpcMos, npcMo)
		end
	end

	return self.firstNpcMos
end

return SurvivalResultMo
