-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/Bag.lua

require("dm.gameplay.develop.model.bag.item.Fragment")
require("dm.gameplay.develop.model.bag.item.Material")
require("dm.gameplay.develop.model.bag.item.Goods")
require("dm.gameplay.develop.model.bag.item.Equipment")
require("dm.gameplay.develop.model.bag.item.Currency")
require("dm.gameplay.develop.model.bag.item.MapItem")
require("dm.gameplay.develop.model.bag.item.EquipItem")
require("dm.gameplay.develop.model.bag.item.TsouItem")

function IS_SERVER_DELETE_FLAG(value)
	return value == "$nil"
end

local function newBagEntry(item, count, pointTag)
	return {
		item = item,
		count = count,
		redPoint = pointTag
	}
end

Bag = class("Bag", objectlua.Object, _M)

Bag:has("_lastSyncTime", {
	is = "r"
})

function Bag:initialize(data)
	super.initialize(self)

	self._entryList = {}
	self._lastSyncTime = 0
	self._timeRecords = {}
	self._lastCount = 0
	self._tabRedPoints = {}
end

function Bag:synchronize(bagData, isFirst)
	if bagData == nil then
		return
	end

	self:recordLastCount(bagData)
	self:_createEntryList(bagData, isFirst)
end

function Bag:recordLastCount(bagData)
	for k, v in pairs(bagData) do
		self._lastCount = v.count
	end
end

function Bag:getLastSyncCount()
	return self._lastCount
end

function Bag:removeItem(itemId)
	local objectRegistry = RemoteObjectRegistry:getInstance()

	objectRegistry:unregisterObject(itemId)

	self._entryList[itemId] = nil
end

function Bag:_createEntryList(mapData, isDiff)
	local objectRegistry = RemoteObjectRegistry:getInstance()

	for id, itemData in pairs(mapData) do
		if not IS_SERVER_DELETE_FLAG(itemData) then
			local item = objectRegistry:getObjectById(id)

			if item == nil then
				item = self:_createItem(itemData, id)

				if item then
					objectRegistry:registerObject(id, item)
				end
			end

			if item then
				local entry = self._entryList[id]
				local pageType = item:getType()

				if entry == nil then
					local hasRed = isDiff and item:getIsVisible() and item:getRedVisible()

					entry = newBagEntry(item, itemData.count or 1, hasRed)

					if hasRed then
						self:_setBagTabRedTag(pageType, id)
					end

					entry.unlock = true
					self._entryList[id] = entry
				else
					item:synchronize(itemData, id)

					local hasRed = entry.count < itemData.count and item:getIsVisible() and item:getRedVisible()

					if hasRed then
						entry.redPoint = hasRed

						self:_setBagTabRedTag(pageType, id)
					end

					entry.count = itemData.count or 1
				end

				assert(entry.item == item)
			end
		else
			objectRegistry:unregisterObject(id)
			self:_removeBagRedByID(id)

			self._entryList[id] = nil
		end
	end
end

function Bag:synchronizeLockItems(lockItem)
	if self._lockItems == nil then
		self._lockItems = {}
	end

	local checkItems = {}

	for id, itemId in pairs(lockItem) do
		local entry = self._entryList[itemId]

		if entry then
			entry.unlock = false
		end

		checkItems[itemId] = 1

		if self._lockItems[itemId] then
			self._lockItems[itemId] = 0
		end
	end

	for itemId, value in pairs(self._lockItems) do
		if value > 0 then
			local entry = self._entryList[itemId]

			if entry then
				entry.unlock = true
			end
		end
	end

	self._lockItems = checkItems
end

function Bag:_setBagTabRedTag(type, id)
	if self._tabRedPoints[type] == nil then
		self._tabRedPoints[type] = {}
	end

	for key, value in ipairs(self._tabRedPoints[type]) do
		if value == id then
			return
		end
	end

	table.insert(self._tabRedPoints[type], id)
end

function Bag:_removeBagTabRedTag(type, id)
	local index

	if self._tabRedPoints[type] then
		for key, value in ipairs(self._tabRedPoints[type]) do
			if value == id then
				index = key

				break
			end
		end
	end

	if index then
		self:getEntryById(id).redPoint = false

		table.remove(self._tabRedPoints[type], index)
	end
end

function Bag:_clearBagTabRedTag(type)
	if self._tabRedPoints[type] and #self._tabRedPoints[type] > 0 then
		for _, v in ipairs(self._tabRedPoints[type]) do
			local entry = self:getEntryById(v)

			if entry then
				entry.redPoint = false
			end
		end
	end

	self._tabRedPoints[type] = {}
end

function Bag:_removeBagRedByID(id)
	for k, v in pairs(self._tabRedPoints) do
		local index

		for _, tmp in pairs(v) do
			if tmp == id then
				index = key

				break
			end
		end

		if index then
			self:getEntryById(id).redPoint = false

			table.remove(self._tabRedPoints[k], index)

			break
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

		if ItemTypes.K_EQUIP_F == prototype:getSubType() then
			return nil
		end

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
	end,
	[ItemPages.kCompose] = function(configId)
		local prototype = MapItemPrototype:new(configId)

		return MapItem:new(prototype)
	end
}

function Bag:_createItem(itemData, id)
	if not itemData.tag then
		local configId = id
		local config = ConfigReader:getRecordById("ItemConfig", configId)

		if config and config.Id then
			local itemType = config.Page
			local func = itemMap[itemType]

			if not CommonUtils.GetSwitch("fn_bag_mijuan_btn") and itemType == ItemPages.kCompose then
				return
			end

			if func then
				local item = func(configId)

				if item then
					item:synchronize(itemData, id)
				end

				return item
			end
		end
	end
end

function Bag:getEntries(filter)
	local entries = {}
	local index = 1

	if filter ~= nil then
		for id, entry in pairs(self._entryList) do
			if filter(entry) then
				entries[index] = entry
				index = index + 1
			end
		end
	end

	return entries
end

function Bag:getEntryIds(filter)
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

function Bag:test(filter)
	if filter ~= nil then
		for id, entry in pairs(self._entryList) do
			if filter(entry) then
				return true, id
			end
		end
	end

	return false
end

function Bag:getEntryById(entryId)
	if entryId then
		return self._entryList[tostring(entryId)]
	end
end

function Bag:getTimeRecordById(id)
	return self._timeRecords[id]
end

function Bag:synTimeRecords(records)
	if not records then
		return
	end

	for id, data in pairs(records) do
		self._timeRecords[id] = self._timeRecords[id] or TimeRecord:new(id)

		self._timeRecords[id]:synchronize(data)
	end
end

local NEW_EQUIP_ID_HEAD = "NewEquip_"

function Bag:synEquipList(equipMap)
	for key, itemData in pairs(equipMap) do
		local id = NEW_EQUIP_ID_HEAD .. key
		local entry = self._entryList[id]

		if entry == nil then
			local item = EquipItem:new(id, itemData)

			if item then
				entry = newBagEntry(item, itemData.count or 1)
				self._entryList[id] = entry
			end
		else
			entry.item:synchronize(itemData)

			entry.count = itemData.count or 1
		end
	end
end

function Bag:delEquipList(data)
	for key, v in pairs(data) do
		local id = NEW_EQUIP_ID_HEAD .. key

		if self._entryList[id] then
			self._entryList[id] = nil
		end
	end
end

function Bag:synTSoulList(tsoulMap)
	for key, itemData in pairs(tsoulMap) do
		local id = key
		local entry = self._entryList[id]

		if entry == nil then
			local item = TsouItem:new(id, itemData)

			if item then
				entry = newBagEntry(item, itemData.count or 1)
				self._entryList[id] = entry
			end
		else
			entry.item:synchronize(itemData)

			entry.count = itemData.count or 1
		end
	end
end

function Bag:delTSoulList(data)
	for key, v in pairs(data) do
		local id = key

		if self._entryList[id] then
			self._entryList[id] = nil
		end
	end
end

function Bag:hideEntryRedById(entryId)
	if entryId then
		local obj = self._entryList[tostring(entryId)]
		local type = obj.item:getType()

		self:_removeBagTabRedTag(type, entryId)
	end
end

function Bag:getBagTabRedByType(type)
	if self._tabRedPoints[type] then
		return #self._tabRedPoints[type] > 0
	end

	return false
end

function Bag:clearBagTabRedByType(type)
	if type == nil or type == "" then
		return
	end

	self:_clearBagTabRedTag(type)
end

TimeRecord = class("TimeRecord", objectlua.Object, _M)

TimeRecord:has("_id", {
	is = "r"
})
TimeRecord:has("_time", {
	is = "r"
})

function TimeRecord:initialize(id)
	self._id = id
	self._time = 0

	super.initialize(self)
end

function TimeRecord:synchronize(data)
	if type(data) == "table" and data.value then
		self._time = data.value
	elseif type(data) == "number" then
		self._time = data
	end
end
