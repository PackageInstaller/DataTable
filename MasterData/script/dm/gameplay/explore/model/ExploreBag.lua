-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreBag.lua

require("dm.gameplay.explore.model.ExploreEquipItem")

ExploreBag = class("ExploreBag", objectlua.Object)

local function newBagEntry(item, count)
	return {
		item = item,
		count = count
	}
end

function ExploreBag:initialize()
	super.initialize(self)

	self._entryList = {}
	self._equipList = {}
end

function ExploreBag:synchronize(bagData)
	if bagData == nil then
		return
	end

	self:_createEntryList(bagData)
end

function ExploreBag:_createEntryList(mapData)
	for id, itemData in pairs(mapData) do
		local entry = self._entryList[id]

		if entry == nil then
			local var_4_0 = self:_createItem(itemData, id)

			entry = newBagEntry(item, itemData.count or 1)
			self._entryList[id] = entry
		else
			entry.item:synchronize(itemData, id)

			entry.count = itemData.count or 1
		end
	end
end

local itemMap = {
	[ItemPages.kEquip] = function(configId)
		local prototype = EquipPrototype:new(configId)

		return Equipment:new(prototype)
	end,
	[ItemPages.kConsumable] = function(configId)
		local prototype = GoodsPrototype:new(configId)

		return Goods:new(prototype)
	end,
	[ItemPages.kStuff] = function(configId)
		local prototype = MaterialPrototype:new(configId)

		return Material:new(prototype)
	end,
	[ItemPages.kFragament] = function(configId)
		local prototype = FragmentPrototype:new(configId)

		return Fragment:new(prototype)
	end,
	[ItemPages.kCurrency] = function(configId)
		local prototype = CurrencyPrototype:new(configId)

		return Currency:new(prototype)
	end,
	[ItemTypes.K_HERO_F] = function(configId)
		local prototype = FragmentPrototype:new(configId)

		return Fragment:new(prototype)
	end,
	[ItemTypes.K_MASTER_F] = function(configId)
		local prototype = FragmentPrototype:new(configId)

		return Fragment:new(prototype)
	end,
	[ItemPages.kOther] = function(configId)
		local prototype = MapItemPrototype:new(configId)

		return MapItem:new(prototype)
	end
}

function ExploreBag:_createItem(itemData, id)
	if not itemData.tag then
		local configId = id
		local config = ConfigReader:getRecordById("ItemConfig", configId)

		if config and config.Id then
			local itemType = config.Page
			local func = itemMap[itemType]

			if func then
				local item = func(configId)

				item:synchronize(itemData, id)

				return item
			end
		end
	end
end

local NEW_EQUIP_ID_HEAD = "NewEquip_"

function ExploreBag:synEquipList(equipMap)
	for key, count in pairs(equipMap) do
		local id = NEW_EQUIP_ID_HEAD .. key

		self._equipList[id] = count

		for i = 1, count do
			id = NEW_EQUIP_ID_HEAD .. key .. i

			local entry = self._entryList[NEW_EQUIP_ID_HEAD .. key .. i]

			if entry == nil then
				local item = ExploreEquipItem:new(id, key)

				if item then
					entry = newBagEntry(item, 1)
					self._entryList[id] = entry
				end
			end
		end
	end
end

function ExploreBag:getEquipCount(key)
	local id = NEW_EQUIP_ID_HEAD .. key

	return self._equipList[id] or 0
end

function ExploreBag:removeEquip()
	for key, count in pairs(self._equipList) do
		for i = 1, count do
			local id = key .. i

			self:removeItem(id)
		end
	end
end

function ExploreBag:removeItem(itemId)
	self._entryList[itemId] = nil
end

function ExploreBag:getEntryIds(filter)
	local entryIds = {}
	local index = 1

	if filter ~= nil then
		for id, entry in pairs(self._entryList) do
			if filter(entry) then
				entryIds[index] = id
				index = index + 1
			end
		end
	end

	return entryIds
end

function ExploreBag:getEntryById(entryId)
	if entryId then
		return self._entryList[tostring(entryId)]
	end
end
