-- chunkname: @modules/logic/seasonver/act123/model/Season123CardPackageModel.lua

module("modules.logic.seasonver.act123.model.Season123CardPackageModel", package.seeall)

local Season123CardPackageModel = class("Season123CardPackageModel", ListScrollModel)

function Season123CardPackageModel:onInit()
	self:reInit()

	self.packageMap = {}
end

function Season123CardPackageModel:release()
	self:clear()

	self.cardItemList = {}
	self.cardItemMap = {}
	self.curActId = nil
end

function Season123CardPackageModel:reInit()
	self.curActId = nil
	self.packageConfigMap = {}
	self.cardItemList = {}
	self.cardItemMap = {}
	self.packageCount = 0
	self.packageMap = {}
end

function Season123CardPackageModel:initData(curActId)
	self.curActId = curActId

	self:initOpenPackageMO(curActId)
	self:initPackageCount()
end

function Season123CardPackageModel:getOpenPackageMO()
	if self.packageCount > 0 then
		for index, itemMO in pairs(self.packageMap) do
			local itemCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, itemMO.id)

			if itemCount > 0 then
				return itemMO
			end
		end
	end
end

function Season123CardPackageModel:initOpenPackageMO(curActId)
	local itemDict = ItemModel.instance:getDict()

	if GameUtil.getTabLen(self.packageConfigMap) == 0 then
		self:initCurActCardPackageConfigMap(curActId)
	end

	for index, config in pairs(self.packageConfigMap) do
		local itemMO = itemDict[config.id]
		local itemCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, config.id)

		if itemMO and itemCount > 0 then
			self.packageMap[itemMO.id] = itemMO
		end
	end
end

function Season123CardPackageModel:initCurActCardPackageConfigMap(curActId)
	local packageItemList = ItemConfig.instance:getItemListBySubType(Activity123Enum.CardPackageSubType) or {}

	for index, config in ipairs(packageItemList) do
		if config.activityId == curActId then
			self.packageConfigMap[config.id] = config
		end
	end
end

function Season123CardPackageModel:initPackageCount()
	self.packageCount = 0

	if GameUtil.getTabLen(self.packageMap) == 0 then
		self:initOpenPackageMO(self.curActId)
	end

	for index, itemMO in pairs(self.packageMap) do
		local itemCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, itemMO.id)

		self.packageCount = self.packageCount + itemCount
	end

	return self.packageCount
end

function Season123CardPackageModel:setCardItemList(cardItems)
	self.cardItemList = {}
	self.cardItemMap = {}

	for index, itemId in ipairs(cardItems) do
		local itemMO = self.cardItemMap[itemId]

		if not itemMO then
			itemMO = Season123CardPackageItemMO.New()

			itemMO:init(itemId)

			self.cardItemMap[itemId] = itemMO

			table.insert(self.cardItemList, itemMO)
		else
			itemMO.count = itemMO.count + 1
		end
	end

	table.sort(self.cardItemList, self.sortCardItemList)
	self:setList(self.cardItemList)
end

function Season123CardPackageModel.sortCardItemList(a, b)
	local configA = a.config
	local configB = b.config

	if configA ~= nil and configB ~= nil then
		if configA.rare ~= configB.rare then
			return configA.rare > configB.rare
		else
			return configA.equipId > configB.equipId
		end
	else
		return a.itemId < b.itemId
	end
end

function Season123CardPackageModel:getCardMaxRare()
	local maxRare = 0

	for index, itemMO in pairs(self.cardItemList) do
		if itemMO.config and maxRare < itemMO.config.rare then
			maxRare = itemMO.config.rare
		elseif not itemMO.config then
			logError("activity123_equip config id is not exit: " .. tostring(itemMO.itemId))
		end
	end

	return maxRare
end

Season123CardPackageModel.instance = Season123CardPackageModel.New()

return Season123CardPackageModel
