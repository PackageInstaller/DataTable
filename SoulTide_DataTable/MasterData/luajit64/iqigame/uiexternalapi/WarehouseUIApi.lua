-- chunkname: @IQIGame\\UIExternalApi\\WarehouseUIApi.lua

WarehouseUIApi = BaseLangApi:Extend()

function WarehouseUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TabTexts", self.GetTabTexts)
	self:RegisterApi("NoticeUseCDText", self.GetNoticeUseCDText)
	self:RegisterApi("NoticeUseNotActiveText", self.GetNoticeUseNotActiveText)
	self:RegisterApi("NoticeExpiredText", self.GetNoticeExpiredText)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
	self:RegisterApi("UseItemCheckConditionFailText", self.GetUseItemCheckConditionFailText)
end

function WarehouseUIApi:GetTitleText()
	return self:GetCfgText(1240001)
end

function WarehouseUIApi:GetTabTexts()
	return {
		self:GetCfgText(1240002),
		self:GetCfgText(1240003),
		self:GetCfgText(1240004),
		self:GetCfgText(1240005),
		self:GetCfgText(1229119),
		self:GetCfgText(1240006)
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

function WarehouseUIApi:GetEmptyViewText()
	return self:GetCfgText(1160020)
end

function WarehouseUIApi:GetUseItemCheckConditionFailText(conditionName)
	return string.format(self:GetCfgText(246) .. "%s", conditionName)
end

WarehouseUIApi:Init()
