-- chunkname: @IQIGame\\UIExternalApi\\CommonSlotUIApi.lua

CommonSlotUIApi = BaseLangApi:Extend()

function CommonSlotUIApi:Init()
	self:RegisterApi("ItemCell2OwnCount", self.GetItemCell2OwnNum)
	self:RegisterApi("ItemCell2CostCount", self.GetItemCell2CostNum)
	self:RegisterApi("ItemNumText", self.GetNum)
	self:RegisterApi("ItemNumText2", self.GetRequireNum)
	self:RegisterApi("QualityFramePath", self.GetQualityFramePath)
	self:RegisterApi("QualityBackgroundPath", self.GetQualityBackgroundPath)
	self:RegisterApi("WearTag1Txt", self.GetWearTag1Txt)
	self:RegisterApi("WearTag2Txt", self.GetWearTag2Txt)
	self:RegisterApi("SelectedTag2Txt", self.GetSelectedTag2Txt)
	self:RegisterApi("goEquipLv", self.GetEquipLiv)
end

function CommonSlotUIApi:GetItemCell2OwnNum(num, costNum)
	if num < costNum then
		return self.TextColor[203] .. num .. self.TextColor[0]
	end

	return self.TextColor[207] .. num .. self.TextColor[0]
end

function CommonSlotUIApi:GetItemCell2CostNum(ownNum, costNum)
	return self.TextColor[12] .. "/" .. tostring(costNum) .. self.TextColor[0]
end

function CommonSlotUIApi:GetEquipLiv(lv, isSpecial)
	return tostring(lv)
end

function CommonSlotUIApi:GetSelectedTag2Txt()
	return self:GetCfgText(1001029)
end

function CommonSlotUIApi:GetNum(num)
	if type(num) == "string" then
		return num
	end

	if num > 0 then
		return num
	end

	return self.TextColor[203] .. num .. self.TextColor[0]
end

function CommonSlotUIApi:GetRequireNum(ownCount, needCount, ignoreCost)
	if ownCount < needCount then
		if ignoreCost then
			return self.TextColor[28] .. ownCount .. self.TextColor[0]
		else
			return self.TextColor[28] .. ownCount .. self.TextColor[0] .. "/" .. needCount
		end
	elseif ignoreCost then
		return ownCount
	else
		return ownCount .. "/" .. needCount
	end
end

function CommonSlotUIApi:GetQualityFramePath(quality, isSpecial)
	if isSpecial then
		return self:GetResUrl(2400001)
	else
		return self:GetResUrl(2400002)
	end
end

function CommonSlotUIApi:GetQualityBackgroundPath(quality)
	if quality == 0 then
		return self:GetResUrl(2400010)
	elseif quality == 1 then
		return self:GetResUrl(2400011)
	elseif quality == 2 then
		return self:GetResUrl(2400012)
	elseif quality == 3 then
		return self:GetResUrl(2400013)
	elseif quality == 4 then
		return self:GetResUrl(2400014)
	elseif quality == 5 then
		return self:GetResUrl(2400015)
	end
end

function CommonSlotUIApi:GetWearTag1Txt(isInFormationSystem)
	if isInFormationSystem then
		return self:GetCfgText(1001028)
	else
		return self:GetCfgText(1001015)
	end
end

function CommonSlotUIApi:GetWearTag2Txt()
	return self:GetCfgText(1001015)
end

CommonSlotUIApi:Init()
