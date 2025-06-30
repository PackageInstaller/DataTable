-- chunkname: @IQIGame\\Module\\Warehouse\\ItemData.lua

ItemData = {
	classType = "ItemData",
	flag = false,
	usedNum = 0,
	num = 0,
	SubType = 0,
	cid = 0,
	IsMazeItem = false,
	Type = 0,
	id = 0,
	createTime = 0
}

function ItemData.New(itemPOD)
	if itemPOD.classType ~= nil then
		logError("ItemPOD contains a property named \"classType\", which conflicted with the property of ItemData, try another name.")
	end

	if itemPOD.Type ~= nil then
		logError("ItemPOD contains a property named \"Type\", which conflicted with the property of ItemData, try another name.")
	end

	local o = Clone(ItemData)

	o:Update(itemPOD)

	if o:GetCfg() ~= nil then
		o.Type = o:GetCfg().ItemTypes
		o.SubType = o:GetCfg().ItemSubTypes
	end

	return o
end

function ItemData.CreateItemShowDataByItemShowPOD(pod)
	local cfgItemData = CfgItemTable[pod.cid]

	if cfgItemData.ItemTypes == Constant.ItemType.Equip and pod.id ~= 0 then
		local itemData = WarehouseModule.GetItemDataById(pod.id)

		if itemData ~= nil then
			return Clone(itemData)
		else
			logError("ItemData.GetItemDataByItemShowPOD 找不到背包中id={0} 的道具 cid={1}", pod.id, pod.cid)
		end
	end

	return ItemData.CreateByCIDAndNumber(pod.cid, pod.num)
end

function ItemData.CreateByCIDAndNumber(cid, num)
	local cfgItemData = CfgItemTable[cid]
	local itemData = Clone(ItemData)

	itemData.id = 0
	itemData.cid = cid
	itemData.num = num
	itemData.usedNum = 0
	itemData.Type = cfgItemData.ItemTypes
	itemData.SubType = cfgItemData.ItemSubTypes

	if cfgItemData.ItemTypes == Constant.ItemType.Skill then
		itemData.skillData = SkillData.New()
		itemData.skillData.skillCid = itemData:GetCfg().LikeId
		itemData.skillData.strengLv = 0
	end

	if cfgItemData.ItemTypes == Constant.ItemType.Equip then
		itemData.equipData = EquipData.New()
		itemData.equipData.equipCid = itemData:GetCfg().LikeId
	end

	return itemData
end

function ItemData:Update(itemPOD)
	for key, value in pairs(itemPOD) do
		if key == "equip" then
			self.equipData = EquipModule.CreateEquipData(value, itemPOD)
		elseif key == "skill" then
			self.skillData = SkillData.New()

			self.skillData:UpdateData(value, self:GetCfg().LikeId)
		else
			self[key] = value
		end
	end
end

function ItemData:GetCfg()
	return CfgItemTable[self.cid]
end

function ItemData:GetNum()
	return self.num
end

function ItemData:GetGiftAwardList()
	local awardList = {}
	local Cfg = self:GetCfg()

	for i = 1, getCfgTableLength(Cfg.ActionParams), 2 do
		local award = {}

		award.CfgData = CfgItemTable[Cfg.ActionParams[i]]
		award.Number = Cfg.ActionParams[i + 1]

		table.insert(awardList, award)
	end

	return awardList
end

function ItemData:GetAvailableTimeText()
	local cfgItemData = self:GetCfg()
	local startTime = self:ConversionTime(cfgItemData.StartTime)
	local expirationTime = self:ConversionTime(cfgItemData.ExpirationTime)

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
	local expirationTime = self:ConversionTime(cfgItemData.ExpirationTime)

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

function ItemData:ConversionTime(time)
	return cfgDateTimeToTimeStamp(time, PlayerModule.TimeZone, "/")
end

function ItemData:SortById(target, ascending)
	return sortByValue(self:GetCfg().Id, target:GetCfg().Id, ascending)
end

function ItemData:SortByOnlyId(target, ascending)
	return sortByValue(self.id, target.id, ascending)
end

function ItemData:SortByQuality(target, ascending)
	return sortByValue(self:GetCfg().Quality, target:GetCfg().Quality, ascending)
end

function ItemData:SortByNum(target, ascending)
	return sortByValue(self.num, target.num, ascending)
end

function ItemData:SortByTime(target, ascending)
	return sortByValue(self.createTime, target.createTime, ascending)
end

function ItemData:SortByLv(target, ascending)
	return sortByValue(self.skillData.lv, target.skillData.lv, ascending)
end

function ItemData:SortByPurify(target, ascending)
	return sortByValue(self.skillData.purifyLv, target.skillData.purifyLv, ascending)
end
