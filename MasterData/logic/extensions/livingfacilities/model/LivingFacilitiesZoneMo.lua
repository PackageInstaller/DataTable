-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/LivingFacilitiesZoneMo.lua

module("logic.extensions.livingfacilities.model.LivingFacilitiesZoneMo", package.seeall)

local M = class("LivingFacilitiesZoneMo")

M.StoreCost = 1

function M:ctor(id)
	self.id = id
	self._name = false
	self._type = false
	self._atmosphere = false
	self._atmosphereSpecial = false
	self._atmosphereTotal = false
	self._atmosphereLevel = false
	self._isDataGet = false
	self._facilitiesName = false
	self._size = false
	self._heroCount = false
	self._activeCost = false
	self._facilitiesDesc = false
	self._bgIcon = false
	self._ftCount = false
	self._atmosphereType = false
	self._defaultName = false
	self._isActive = false
	self._isUnlock = false
	self._productivity = false
	self._productSpeed = false
	self._productCostSec = false
	self._productCostTime = false
	self._nextProductTimeStamp = false
	self._productList = {}

	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self.id)

	self._activeCost = roomCO.activeCost
	self._size = roomCO.size
	self._defaultName = roomCO.defaultName
end

function M:refreshByData(data)
	self._name = data.name
	self._type = data.type
	self._atmosphere = data.atmosphere
	self._atmosphereSpecial = data.atmosphereSpecial
	self._atmosphereTotal = data.atmosphereTotal

	local dataList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosDorm)

	for i, v in ipairs(dataList) do
		if self._atmosphere >= v.rankNum then
			self._atmosphereLevel = i
		end
	end

	self:updateProductByAgent(data.product, false)

	local livingFacilitiesCo = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, self._type)

	if livingFacilitiesCo then
		self._facilitiesName = livingFacilitiesCo.name
		self._heroCount = livingFacilitiesCo.heroCount
		self._facilitiesDesc = livingFacilitiesCo.desc
		self._bgIcon = livingFacilitiesCo.bgIcon
		self._ftCount = livingFacilitiesCo.ftCount
		self._atmosphereType = livingFacilitiesCo.atmosphere
	end

	self._isDataGet = true
end

function M:getId()
	return self.id
end

function M:getName()
	return self._name or ""
end

function M:setName(name)
	self._name = name

	HouseDispatcher:dispatchEvent(HouseEventType.LIVING_ZONE_NAME_CHANGE)
end

function M:getType()
	return self._type
end

function M:getAtmosType()
	return self._atmosphereType
end

function M:getTypeName()
	if self._atmosphereType then
		local coList = LivingFacilitiesConfig.instance:getConfig(ConfigName.HouseAtmosType)

		return coList and coList[self._atmosphereType] and coList[self._atmosphereType].name or false
	end

	return false
end

function M:getAtmosphere()
	return self._atmosphere or 0
end

function M:getAtmosphereSpecial()
	return self._atmosphereSpecial or 0
end

function M:getAtmosphereLevel()
	return self._atmosphereLevel or 0
end

function M:getFacilitiesName()
	return self._facilitiesName
end

function M:getFacilitiesDesc()
	return self._facilitiesDesc or ""
end

function M:getBgIcon()
	return self._bgIcon
end

function M:getFtCount()
	return self._ftCount
end

function M:getSize()
	return self._size or 0
end

function M:getDefaultName()
	return self._defaultName
end

function M:getSizeName()
	return HouseEnum.LivingFacilitiesSizeText[self._size]
end

function M:getHeroCount()
	return self._heroCount or 0
end

function M:getActiveCost()
	return self._activeCost or {}
end

function M:getActiveCostString()
	local str = ""

	for i, item in ipairs(self:getActiveCost()) do
		local co = BackpackConfig.instance:getItemInfoByItemId(item.id)

		if i == 1 then
			str = str .. string.format("%d个%s", item.num, co.name)
		else
			str = str .. string.format("、%d个%s", item.num, co.name)
		end
	end

	return str
end

function M:getIsActive()
	return self._isActive
end

function M:setIsActive(isActive)
	self._isActive = isActive
end

function M:getIsUnlock()
	return self._isUnlock
end

function M:setIsUnlock(isUnlock)
	self._isUnlock = isUnlock
end

function M:setZoneStatus(isActive, isUnlock)
	self:setIsActive(isActive)
	self:setIsUnlock(isUnlock)

	if self._isActive and self._isUnlock then
		LivingFacilitiesAgent.instance:sendGetLiveZoneInfoRequest(self.id)
	end
end

function M:getCanLive()
	return self._isActive and self._isUnlock
end

function M:getBunkList()
	return HouseFurnitureModel.instance:getAllBunkInfo(self.id)
end

function M:getIsDataGet()
	return self._isDataGet
end

function M:getRoomMember()
	local member = {}
	local bunkList = self:getBunkList()

	for i, bunkInfo in ipairs(bunkList) do
		if bunkInfo.heroId > 0 then
			table.insert(member, bunkInfo.heroId)
		end
	end

	return member
end

function M:getInRoomHeroCount()
	return #self:getRoomMember()
end

function M:getCurrentZoneFurniture()
	local furnitureList = {}
	local tempList = HouseFurnitureModel.instance:getRoomFurnitures(self.id)

	if tempList then
		for i, furnitureMo in ipairs(tempList) do
			local id = furnitureMo:getId()

			table.insert(furnitureList, id)
		end
	end

	return furnitureList
end

function M:getCurrentZoneFurnitureTheme()
	local themeList = {}
	local tempList = HouseFurnitureModel.instance:getRoomFurnitures(self.id)

	if tempList then
		for i, furnitureMo in ipairs(tempList) do
			local co = BackpackConfig.instance:getItemInfoByItemId(furnitureMo:getId())
			local theme = co.theme

			if theme > 0 and not table.indexof(themeList, theme) then
				table.insert(themeList, theme)
			end
		end
	end

	return themeList
end

function M:updateProductByAgent(NO, isPush)
	if self._type == HouseEnum.LivingRoomType.SpecialDormitory then
		self._productivity = NO.productivity
		self._productSpeed = NO.productSpeed
		self._productList = {}

		for _, store in ipairs(NO.stores or {}) do
			local product = {}

			product.heroId = store.key
			product.count = store.value or 0

			local fragmentCfg = CharacterConfig.instance:getFragmentCfgByHeroId(product.heroId)

			product.fragmentId = fragmentCfg.id

			table.insert(self._productList, product)
		end

		self:_updateProductCostTime()
		self:updateNextProductTimeStamp(isPush)
	end
end

function M:_updateProductCostTime()
	self._productCostSec = 60
	self._productCostTime = 60

	local member = self:getRoomMember()

	if #member > 0 then
		local heroId = member[1]
		local fragmentCfg = CharacterConfig.instance:getFragmentCfgByHeroId(heroId)
		local needNum = HouseConfig.instance:getSpRoomProductivityNeed(fragmentCfg.quality)
		local minCount = needNum / self._productSpeed

		self._productCostSec = minCount * 60
		self._productCostTime = math.ceil(minCount) * 60
	end
end

function M:updateNextProductTimeStamp(isPush)
	self._nextProductTimeStamp = 0

	local member = self:getRoomMember()

	if #member > 0 then
		local heroId = member[1]
		local fragmentCfg = CharacterConfig.instance:getFragmentCfgByHeroId(heroId)
		local needNum = HouseConfig.instance:getSpRoomProductivityNeed(fragmentCfg.quality)
		local minCount = math.ceil((needNum - self._productivity) / self._productSpeed)
		local serverDate = ServerTime.nowDate()
		local currSecond = isPush and 0 or serverDate.sec

		self._nextProductTimeStamp = ServerTime.now() - currSecond + minCount * 60
	end
end

function M:clearProduct()
	table.clear(self._productList)
end

function M:getProductList()
	return self._productList
end

function M:getShowFragmentId()
	local heroId
	local member = self:getRoomMember()

	if #member > 0 then
		heroId = member[1]
	elseif self:getCurrStore() > 0 then
		local product = self._productList[#self._productList]

		heroId = product.heroId
	end

	if heroId then
		local fragmentCfg = CharacterConfig.instance:getFragmentCfgByHeroId(heroId)

		return fragmentCfg.id
	end
end

function M:getCurrStore()
	local storeNum = 0

	for _, product in ipairs(self._productList) do
		storeNum = storeNum + product.count * self.StoreCost
	end

	return storeNum
end

function M:getLimitStore()
	return HouseConfig.instance:getSpRoomTotalStore()
end

function M:isStoreFulled()
	local currStore = self:getCurrStore()
	local limitStore = self:getLimitStore()

	return limitStore < self.StoreCost + currStore
end

function M:getProductCostTime()
	return self._productCostTime
end

function M:getProductCostSec()
	return self._productCostSec
end

function M:getNextProductTimeStamp()
	return self._nextProductTimeStamp
end

function M:getNextProductProgress()
	local remainTime = self._nextProductTimeStamp - ServerTime.now()
	local progress = remainTime > 0 and (self._productCostTime - remainTime) / self._productCostTime or 1

	progress = math.max(0, progress)

	return progress
end

function M:getRemainTimeToFull()
	local remainTime = 0

	if not self:isStoreFulled() then
		local currStore = self:getCurrStore()
		local limitStore = self:getLimitStore()
		local remainCount = math.floor((limitStore - currStore) / self.StoreCost)

		remainCount = math.max(0, remainCount - 1)
		remainTime = self._nextProductTimeStamp - ServerTime.now() + remainCount * self._productCostSec
		remainTime = math.max(0, remainTime)
	end

	return remainTime
end

return M
