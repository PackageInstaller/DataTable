-- chunkname: @IQIGame\\Module\\Warehouse\\ItemData.lua

ItemData = {
	classType = "ItemData",
	usedNum = 0,
	num = 0,
	SubType = 0,
	cid = 0,
	IsMazeItem = false,
	Type = 0,
	id = 0,
	createTime = 0
}

local PlaceGameEquipData = require("IQIGame.Module.CommonActivity.PlaceGame.PlaceGameEquipData")
local JewelryData = require("IQIGame.Module.Jewelry.JewelryData")
local EquipData = {
	isWore = false,
	lv = 1,
	star = 1,
	exp = 0,
	lock = false,
	upCostGold = 0,
	soulPrefabIds = {}
}

function EquipData.New()
	return Clone(EquipData)
end

function EquipData:Update(itemEquipmentPOD)
	self.lv = itemEquipmentPOD.lv
	self.exp = itemEquipmentPOD.exp
	self.lock = itemEquipmentPOD.lock
	self.soulPrefabIds = {}

	for i, v in pairs(itemEquipmentPOD.soulPrefabIds) do
		self.soulPrefabIds[#self.soulPrefabIds + 1] = i
	end

	self.star = itemEquipmentPOD.star
	self.upCostGold = itemEquipmentPOD.upCostGold

	if self.upCostGold == nil then
		self.upCostGold = 0
	end

	self.isWore = #self.soulPrefabIds > 0
end

function ItemData.New(itemPOD)
	local o = Clone(ItemData)

	if itemPOD == nil then
		return o
	end

	if itemPOD.classType ~= nil then
		logError("ItemPOD contains a property named \"classType\", which conflicted with the property of ItemData, try another name.")
	end

	if itemPOD.Type ~= nil then
		logError("ItemPOD contains a property named \"Type\", which conflicted with the property of ItemData, try another name.")
	end

	o:Update(itemPOD)

	if o:GetCfg() ~= nil then
		o.Type = o:GetCfg().Type
		o.SubType = o:GetCfg().SubType
	end

	return o
end

function ItemData:CreateFromMazeItemData(mazeItemData)
	local o = Clone(self)

	o.id = mazeItemData.ID
	o.cid = mazeItemData.cid
	o.num = mazeItemData.num
	o.usedNum = mazeItemData.usedNum

	local cfgItemData = CfgItemTable[mazeItemData.cid]

	o.Type = cfgItemData.Type
	o.SubType = cfgItemData.SubType
	o.IsMazeItem = true

	if mazeItemData.equipmentData ~= nil then
		o.equipData = EquipData.New()
		o.equipData.exp = mazeItemData.equipmentData.exp
		o.equipData.star = mazeItemData.equipmentData.star
		o.equipData.lv = mazeItemData.equipmentData.lv
		o.equipData.lock = mazeItemData.equipmentData.lock
		o.equipData.isWore = false
	end

	return o
end

function ItemData.CreateFromMazeEquipPOD(mazeEquipPOD)
	local cfgItemData = CfgItemTable[mazeEquipPOD.cid]
	local itemData = Clone(ItemData)

	itemData.id = mazeEquipPOD.ID
	itemData.cid = mazeEquipPOD.cid
	itemData.num = 1
	itemData.Type = cfgItemData.Type
	itemData.SubType = cfgItemData.SubType
	itemData.IsMazeItem = true

	local equipData = EquipData.New()

	equipData.exp = mazeEquipPOD.exp
	equipData.star = mazeEquipPOD.star
	equipData.lv = mazeEquipPOD.lv
	equipData.lock = mazeEquipPOD.lock
	equipData.isWore = true
	itemData.equipData = equipData

	return itemData
end

function ItemData.CreateByCIDAndNumber(cid, num, isMazeItem)
	local cfgItemData = CfgItemTable[cid]
	local itemData = Clone(ItemData)

	itemData.id = 0
	itemData.cid = cid
	itemData.num = num
	itemData.usedNum = 0
	itemData.Type = cfgItemData.Type
	itemData.SubType = cfgItemData.SubType

	if isMazeItem then
		itemData.IsMazeItem = isMazeItem
	end

	if itemData.Type == Constant.ItemType.Equip or itemData.Type == Constant.ItemType.EvilErosionEquip then
		itemData.equipData = EquipData.New()
		itemData.equipData.lv = cfgItemData.InitialLevel
		itemData.equipData.star = cfgItemData.Star
	elseif itemData.Type == Constant.ItemType.JewelryEquip then
		itemData.jewelryData = JewelryData.New(itemData.cid, num, itemData.cid, {
			star = 1,
			soul = {}
		})
	end

	return itemData
end

function ItemData:Update(itemPOD)
	for key, value in pairs(itemPOD) do
		if key == "equipmentData" then
			self.equipData = EquipData.New()

			self.equipData:Update(value)
		elseif key == "placeGameEquipPOD" then
			self.placeGameEquipData = PlaceGameEquipData.New(itemPOD.id, itemPOD.cid, value)
		elseif key == "newJewelryEquipmentVoPOD" then
			self.jewelryData = JewelryData.New(itemPOD.cid, itemPOD.num, itemPOD.id, value)
		else
			self[key] = value
		end
	end
end

function ItemData:GetCfg()
	return CfgItemTable[self.cid]
end

function ItemData:GetAvailableTimeText()
	local cfgItemData = self:GetCfg()
	local expirationTime = cfgDateTimeToTimeStamp(cfgItemData.ExpirationTime, PlayerModule.TimeZone)
	local startTime = cfgDateTimeToTimeStamp(cfgItemData.StartTime, PlayerModule.TimeZone)

	if self.id == 0 then
		if cfgItemData.EffectiveDuration == 0 and startTime == 0 and expirationTime == 0 then
			return ""
		end

		if cfgItemData.EffectiveDuration ~= 0 then
			return self:EffectiveDurationTime2(cfgItemData.EffectiveDuration)
		elseif startTime ~= 0 then
			return self:StartTime(startTime)
		elseif expirationTime ~= 0 then
			return self:ExpirationTime(expirationTime)
		end
	elseif cfgItemData.EffectiveDuration ~= 0 then
		return self:EffectiveDurationTime(cfgItemData.EffectiveDuration, self.createTime)
	elseif startTime ~= 0 and startTime > PlayerModule.GetServerTime() then
		return self:StartTime(startTime)
	elseif expirationTime ~= 0 then
		return self:ExpirationTime(expirationTime)
	end
end

function ItemData:GetCD()
	local cd = 0

	if self.id == 0 then
		local cfgItemData = self:GetCfg()

		if cfgItemData.UseCoolDownType == 1 then
			cd = cfgItemData.UseCoolDownValue
		end
	else
		cd = PlayerModule.GetItemCD(self.cid)
	end

	return cd
end

function ItemData:IsExpired()
	local cfgItemData = self:GetCfg()
	local expirationTime = cfgDateTimeToTimeStamp(cfgItemData.ExpirationTime, PlayerModule.TimeZone)

	return expirationTime ~= 0 and expirationTime < PlayerModule.GetServerTime() or cfgItemData.EffectiveDuration ~= 0 and self.createTime + cfgItemData.EffectiveDuration < PlayerModule.GetServerTime()
end

function ItemData:GetLeftUseCount()
	if self.id == 0 then
		return self:GetCfg().UseNum
	else
		return self:GetCfg().UseNum - self.usedNum
	end
end

function ItemData:EffectiveDurationTime(cfgDuration, getTime)
	return api_text_process(getTipText(Constant.TipConst.TIP_ITEM_EXPIRE), api_datetime_text(getTime + cfgDuration))
end

function ItemData:EffectiveDurationTime2(cfgDuration)
	return api_text_process(getTipText(Constant.TipConst.TIP_ITEM_DURATION), api_duration_text(cfgDuration))
end

function ItemData:StartTime(startTime)
	return api_text_process(getTipText(Constant.TipConst.TIP_ITEM_START), api_datetime_text(startTime))
end

function ItemData:ExpirationTime(expirationTime)
	return api_text_process(getTipText(Constant.TipConst.TIP_ITEM_EXPIRE), api_datetime_text(expirationTime))
end
