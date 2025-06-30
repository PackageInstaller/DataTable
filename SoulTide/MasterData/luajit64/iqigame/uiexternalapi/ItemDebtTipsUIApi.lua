-- chunkname: @IQIGame\\UIExternalApi\\ItemDebtTipsUIApi.lua

ItemDebtTipsUIApi = BaseLangApi:Extend()

function ItemDebtTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CellDebtNumText", self.GetCellDebtNumText)
end

function ItemDebtTipsUIApi:GetTitleText()
	return self:GetCfgText(3200001)
end

function ItemDebtTipsUIApi:GetCellDebtNumText(num)
	return "-" .. num
end

ItemDebtTipsUIApi:Init()
