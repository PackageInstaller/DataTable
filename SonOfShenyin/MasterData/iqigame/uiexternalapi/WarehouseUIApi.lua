-- chunkname: @IQIGame\\UIExternalApi\\WarehouseUIApi.lua

WarehouseUIApi = BaseLangApi:Extend()

function WarehouseUIApi:GetTitleText()
	return self:GetCfgText(1300011)
end

function WarehouseUIApi:GetTabTexts()
	return {
		self:GetCfgText(1000005),
		self:GetCfgText(1000006),
		self:GetCfgText(1000007),
		self:GetCfgText(1000008)
	}
end

function WarehouseUIApi:GetTypeTabTexts(index)
	if index == 1 then
		return {}
	elseif index == 2 then
		return {
			"头",
			"胸",
			"武器",
			"腿",
			"鞋"
		}
	elseif index == 3 then
		return {
			self:GetCfgText(1000009),
			self:GetCfgText(1000010),
			self:GetCfgText(1000011)
		}
	elseif index == 4 then
		return {}
	end
end

function WarehouseUIApi:GetTypeDropdownList()
	return {
		self:GetCfgText(1600003),
		self:GetCfgText(1000003)
	}
end

function WarehouseUIApi:GetNoticeUseCDText()
	return self:GetCfgText(12)
end

function WarehouseUIApi:GetNoticeUseNotActiveText()
	return self:GetCfgText(13)
end

function WarehouseUIApi:GetNoticeExpiredText()
	return self:GetCfgText(14)
end

function WarehouseUIApi:GetIsHasSecondTab(type)
	if type == 2 or type == 3 then
		return true
	end

	return false
end

function WarehouseUIApi:GetBagSortTexts(tipsId)
	return self:GetCfgText(tipsId)
end
