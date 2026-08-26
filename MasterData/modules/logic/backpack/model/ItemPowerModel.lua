-- chunkname: @modules/logic/backpack/model/ItemPowerModel.lua

module("modules.logic.backpack.model.ItemPowerModel", package.seeall)

local ItemPowerModel = class("ItemPowerModel", BaseModel)

function ItemPowerModel:onInit()
	self._powerItemList = {}
	self._latestPushItemUids = {}
	self._powerMakerInfo = {}
	self._cacheFirstPowerMakerInfo = nil
end

function ItemPowerModel:reInit()
	self._powerItemList = {}
	self._latestPushItemUids = {}
	self._powerMakerInfo = {}
	self._cacheFirstPowerMakerInfo = nil
end

function ItemPowerModel:getPowerItem(uid)
	return self._powerItemList[tonumber(uid)]
end

function ItemPowerModel:getPowerItemList()
	return self._powerItemList
end

function ItemPowerModel:setPowerItemList(powerList)
	self._powerItemList = {}

	for _, v in ipairs(powerList) do
		local itemMo = ItemPowerMo.New()

		itemMo:init(v)

		self._powerItemList[tonumber(v.uid)] = itemMo
	end

	self:setPowerMakerItemsList()
	CurrencyController.instance:checkToUseExpirePowerItem()
end

function ItemPowerModel:setPowerMakerItemsList()
	local ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if ofMakerInfo and ofMakerInfo.powerMakerItems then
		self._powerMakerItems = self._powerMakerItems or {}

		local itemList = {}

		for k, v in pairs(self._powerItemList) do
			if v.id ~= MaterialEnum.PowerId.OverflowPowerId then
				itemList[k] = v
			end
		end

		for i = 1, #ofMakerInfo.powerMakerItems do
			local v = ofMakerInfo.powerMakerItems[i]
			local uid = tonumber(v.uid)

			if not self._powerMakerItems[uid] then
				local itemMo = ItemPowerMo.New()

				self._powerMakerItems[uid]:init(v)

				itemList[uid] = self._powerMakerItems[uid]
			end
		end

		self._powerItemList = itemList
	end
end

function ItemPowerModel:changePowerItemList(powerList)
	if not powerList or #powerList < 1 then
		return
	end

	for _, v in ipairs(powerList) do
		local uid = tonumber(v.uid)
		local o = {}

		o.itemid = v.itemId
		o.uid = uid

		table.insert(self._latestPushItemUids, o)

		if not self._powerItemList[uid] then
			local itemMo = ItemPowerMo.New()

			itemMo:init(v)

			self._powerItemList[uid] = itemMo
		else
			self._powerItemList[uid]:reset(v)
		end
	end
end

function ItemPowerModel:getLatestPowerChange()
	return self._latestPushItemUids
end

function ItemPowerModel:getPowerItemCount(uid)
	return (self._powerItemList[uid] or nil) and (self._powerItemList[uid].quantity or 0)
end

function ItemPowerModel:getPowerItemCountById(id)
	local count = 0

	for _, itemMO in pairs(self._powerItemList) do
		if itemMO.id == id then
			count = count + itemMO.quantity
		end
	end

	return count
end

function ItemPowerModel:getPowerItemDeadline(uid)
	local item = self._powerItemList[uid]

	return item and tonumber(item.expireTime) or 0
end

function ItemPowerModel:getPowerItemCo(uid)
	return self._powerItemList[uid] and ItemConfig.instance:getPowerItemCo(self._powerItemList[uid].id) or nil
end

function ItemPowerModel:getPowerCount(powerId)
	local count = 0

	for _, powerMo in pairs(self._powerItemList) do
		if powerMo.id == powerId and (powerMo.expireTime == 0 or powerMo.expireTime > ServerTime.now()) then
			count = count + powerMo.quantity
		end
	end

	return count
end

function ItemPowerModel:getPowerMinExpireTimeOffset(powerId)
	local minOffset
	local isFind = false
	local now = ServerTime.now()

	for _, powerMo in pairs(self._powerItemList) do
		if powerMo.id == powerId and powerMo.expireTime ~= 0 and powerMo.quantity > 0 then
			local offset = powerMo.expireTime - now

			if offset > 0 then
				if isFind then
					if offset < minOffset then
						minOffset = offset
					end
				else
					minOffset = offset
				end

				isFind = true
			end
		end
	end

	return isFind and minOffset or 0
end

function ItemPowerModel:getPowerByType(powerType)
	if powerType == MaterialEnum.PowerType.Small then
		local powerMo = self:getExpirePower(MaterialEnum.PowerId.SmallPower_Expire)

		if not powerMo or powerMo.quantity == 0 then
			powerMo = self:getNoExpirePower(MaterialEnum.PowerId.SmallPower)
		end

		return powerMo
	elseif powerType == MaterialEnum.PowerType.Big then
		local powerMo = self:getExpirePower(MaterialEnum.PowerId.BigPower_Expire)

		if not powerMo or powerMo.quantity == 0 then
			powerMo = self:getNoExpirePower(MaterialEnum.PowerId.BigPower)
		end

		return powerMo
	elseif powerType == MaterialEnum.PowerType.Overflow then
		local powerMo = self:getExpirePower(MaterialEnum.PowerId.OverflowPowerId)

		if not powerMo or powerMo.quantity == 0 then
			powerMo = self:getNoExpirePower(MaterialEnum.PowerId.OverflowPowerId)
		end

		return powerMo
	else
		return self:getExpirePower(MaterialEnum.PowerId.ActPowerId)
	end
end

function ItemPowerModel:getNoExpirePower(powerId)
	for _, powerMo in pairs(self._powerItemList) do
		if powerMo.id == powerId and powerMo.quantity > 0 and powerMo.expireTime == 0 then
			return powerMo
		end
	end

	return nil
end

function ItemPowerModel:getExpirePower(powerId)
	local tempPower
	local now = ServerTime.now()

	for _, powerMo in pairs(self._powerItemList) do
		if powerMo.id == powerId and powerMo.quantity > 0 and powerMo.expireTime ~= 0 and now < powerMo.expireTime then
			if tempPower then
				if tempPower.expireTime > powerMo.expireTime then
					tempPower = powerMo
				end
			else
				tempPower = powerMo
			end
		end
	end

	return tempPower
end

function ItemPowerModel:getUsePower(powerId, count)
	local now = ServerTime.now()
	local moList = {}
	local powerCount = 0

	for _, powerMo in pairs(self._powerItemList) do
		if powerMo.id == powerId and powerMo.quantity > 0 then
			if powerMo.expireTime == 0 then
				table.insert(moList, powerMo)

				powerCount = powerCount + powerMo.quantity
			elseif now < powerMo.expireTime then
				table.insert(moList, powerMo)

				powerCount = powerCount + powerMo.quantity
			end
		end
	end

	local result = {}

	if powerCount <= count then
		for _, powerMo in pairs(moList) do
			table.insert(result, {
				uid = powerMo.uid,
				num = powerMo.quantity
			})
		end

		return result
	end

	powerCount = 0

	table.sort(moList, ItemPowerModel.sortPowerMoFunc)

	for _, powerMo in pairs(moList) do
		local quantity = powerMo.quantity

		if count < powerCount + powerMo.quantity then
			quantity = count - powerCount
		end

		powerCount = powerCount + quantity

		table.insert(result, {
			uid = powerMo.uid,
			num = quantity
		})

		if count <= powerCount then
			break
		end
	end

	return result
end

function ItemPowerModel.sortPowerMoFunc(powerMoA, powerMoB)
	if powerMoA.expireTime == 0 and powerMoB.expireTime == 0 then
		return false
	end

	if powerMoA.expireTime == 0 then
		return false
	end

	if powerMoB.expireTime == 0 then
		return true
	end

	return powerMoA.expireTime < powerMoB.expireTime
end

function ItemPowerModel:onGetPowerMakerInfo(msg)
	local itemTotalCount = 0

	if msg.powerMakerItems then
		for i = 1, #msg.powerMakerItems do
			itemTotalCount = itemTotalCount + msg.powerMakerItems[i].quantity
		end
	end

	local var_20_0 = {}

	var_20_0.status = msg.status or 0
	var_20_0.nextRemainSecond = msg.nextRemainSecond or 0
	var_20_0.makeCount = msg.makeCount or 0
	var_20_0.logoutSecond = msg.logoutSecond or 0
	var_20_0.powerMakerItems = msg.powerMakerItems or {}
	var_20_0.itemTotalCount = itemTotalCount or 0
	var_20_0.nowTime = ServerTime.now() or 0
	self._powerMakerInfo = var_20_0

	self:setPowerMakerItemsList()

	self._cacheFirstPowerMakerInfo = self._cacheFirstPowerMakerInfo or tabletool.copy(self._powerMakerInfo)
end

function ItemPowerModel:getPowerMakerInfo()
	return self._powerMakerInfo
end

function ItemPowerModel:getCacheFirstPowerMakerInfo()
	return self._cacheFirstPowerMakerInfo
end

ItemPowerModel.instance = ItemPowerModel.New()

return ItemPowerModel
